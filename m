From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v6] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 16:11:42 +0300
Message-ID: <1397135502-9666-1-git-send-email-yiannis.marangos@gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 15:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYEmL-0007V3-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 15:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbaDJNMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 09:12:24 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:62422 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030661AbaDJNMX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 09:12:23 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so2987328eek.26
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kzEooSgA9dyOmg1IkLM9JcW+bDzQyk0VbtFFTXTzskE=;
        b=g1KWwo6gxWA/yTa7rSEysYJkAieiVUvD5neW32vPndh2qC93MilBQ+oUC+8NsxLYGh
         uaFfjDWNrGf3NQqzzIIpy7PXGkR/gnSvKb8E0TmXPuSvXsBloHSt9w+XrjHN1ORJEpIB
         l089Iu16MDjNtP199hHS7255ROyxKecZwFbdyw0A2IvKd6zJOOXbhhckUqpzV/b354rp
         hk4Qf/hpyiZr/tsuw8tOB9divPUCTK6sW7JJ0/m/42zQK7Ph/9+RCvsqV11I5K+EF1mf
         PL/F6CPdRNtbuqWrsm7K6BdupY6BQ7Ue4U+m9BfJj5dKqx81kmtTKOPu+VWZJ+uE2YGm
         jPow==
X-Received: by 10.15.43.77 with SMTP id w53mr20854060eev.10.1397135542528;
        Thu, 10 Apr 2014 06:12:22 -0700 (PDT)
Received: from abyss.utx.wifi ([212.50.123.194])
        by mx.google.com with ESMTPSA id q41sm9887519eez.7.2014.04.10.06.12.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 06:12:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246017>

Before we proceed to "opportunistic update" we must verify that the
current index file is the same as the one that we read before. There
is a possible race if we don't do this. In the example below git-status
does "opportunistic update" and git-rebase updates the index, but the
race can happen in general.

  1. process A calls git-rebase (or does anything that uses the index)

  2. process A applies 1st commit

  3. process B calls git-status (or does anything that updates the index)

  4. process B reads index

  5. process A applies 2nd commit

  6. process B takes the lock, then overwrites process A's changes.

  7. process A applies 3rd commit

As an end result the 3rd commit will have a revert of the 2nd commit.
When process B takes the lock, it needs to make sure that the index
hasn't changed since step 4.

Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
---

Version 4 contains fixes based on Junio's comments.
Version 5 fixs a typo in commit message (git-show -> git-status)
Version 6 removes verify_hdr() and use pread() instead of mmap().

 cache.h      |  1 +
 read-cache.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 107ac61..0460f06 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ struct index_state {
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
+	unsigned char sha1[20];
 };
 
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index ba13353..034865d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1477,6 +1477,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
+	hashcpy(istate->sha1, (unsigned char *)hdr + mmap_size - 20);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
@@ -1760,6 +1761,50 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 	return result;
 }
 
+/*
+ * This function verifies if index_state has the correct sha1 of an index file.
+ * Don't die if we have any other failure, just return 0.
+ */
+static int verify_index_from(const struct index_state *istate, const char *path)
+{
+	int fd;
+	ssize_t n;
+	struct stat st;
+	unsigned char sha1[20];
+
+	if (!istate->initialized)
+		return 0;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	if (fstat(fd, &st))
+		goto out;
+
+	if (st.st_size < sizeof(struct cache_header) + 20)
+		goto out;
+
+	n = pread(fd, sha1, 20, st.st_size - 20);
+	if (n != 20)
+		goto out;
+
+	if (hashcmp(istate->sha1, sha1))
+		goto out;
+
+	close(fd);
+	return 1;
+
+out:
+	close(fd);
+	return 0;
+}
+
+static int verify_index(const struct index_state *istate)
+{
+	return verify_index_from(istate, get_index_file());
+}
+
 static int has_racy_timestamp(struct index_state *istate)
 {
 	int entries = istate->cache_nr;
@@ -1779,7 +1824,7 @@ static int has_racy_timestamp(struct index_state *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    !write_index(istate, lockfile->fd))
+	    verify_index(istate) && !write_index(istate, lockfile->fd))
 		commit_locked_index(lockfile);
 	else
 		rollback_lock_file(lockfile);
-- 
1.9.1

From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v4] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 08:22:47 +0300
Message-ID: <1397107367-29974-1-git-send-email-yiannis.marangos@gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 07:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY7Sj-0003f8-MP
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 07:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353AbaDJFXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 01:23:03 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:47289 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaDJFXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 01:23:02 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so2563091eek.11
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yvTXxazu6ReEkraIHmEm1m9/wNMHqy8Oj+qix012pqc=;
        b=NmmyHXxKP+gAzlsuQbSzJpzHUUcffIWM3JdzR1Ejvida2F4RVw/4Y4RUTErPiQF1WS
         IoUpYQmmiwZuWEwIHL75WMaCCZh2cC+TSlVWie0jZGh2PG8un7xSXFK5kGgyRs5EEeSS
         gP2kSNiNHgZACy8SM6ld110Mh/gud3Rj+3Niena4M0eLp1Q33Coou7UWU0noDhn7LLlf
         iC3efqaP40xt+FH/nJiDf9HTRxQjlRKsN1jrGqwSq1Zeof7PcRA1kHX9RRedsVpY5PR8
         CU1uoI+6AT5RNu4fIcMDNbsTY9bAXk+MX+ASl2oEWmbZQDCscWtESDYGRl9NmpVukHkB
         S/ZA==
X-Received: by 10.15.48.129 with SMTP id h1mr543655eew.57.1397107380246;
        Wed, 09 Apr 2014 22:23:00 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id x46sm6570730een.17.2014.04.09.22.22.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Apr 2014 22:22:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246008>

Before we proceed to "opportunistic update" we must verify that the
current index file is the same as the one that we read before. There
is a possible race if we don't do this. In the example below git-show
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

 cache.h      |  1 +
 read-cache.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

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
index ba13353..73a15b1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1477,6 +1477,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
+	hashcpy(istate->sha1, (unsigned char *)hdr + mmap_size - 20);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
@@ -1760,6 +1761,61 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 	return result;
 }
 
+/*
+ * This function verifies if index_state has the correct sha1 of an index file.
+ * Don't die if we have any other failure, just return 0.
+ */
+static int verify_index_from(const struct index_state *istate, const char *path)
+{
+	int fd;
+	struct stat st;
+	struct cache_header *hdr;
+	void *mmap_addr;
+	size_t mmap_size;
+
+	if (!istate->initialized)
+		return 0;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	if (fstat(fd, &st))
+		return 0;
+
+	/* file is too big */
+	if (st.st_size > (size_t)st.st_size)
+		return 0;
+
+	mmap_size = (size_t)st.st_size;
+	if (mmap_size < sizeof(struct cache_header) + 20)
+		return 0;
+
+	mmap_addr = mmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (mmap_addr == MAP_FAILED)
+		return 0;
+
+	hdr = mmap_addr;
+	if (verify_hdr(hdr, mmap_size) < 0)
+		goto unmap;
+
+	if (hashcmp(istate->sha1, (unsigned char *)hdr + mmap_size - 20))
+		goto unmap;
+
+	munmap(mmap_addr, mmap_size);
+	return 1;
+
+unmap:
+	munmap(mmap_addr, mmap_size);
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
@@ -1779,7 +1835,7 @@ static int has_racy_timestamp(struct index_state *istate)
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

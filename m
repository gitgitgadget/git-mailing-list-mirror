From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 12:28:53 -0700
Message-ID: <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:29:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKek-0001KF-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075AbaDJT26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:28:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759070AbaDJT24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50E077A773;
	Thu, 10 Apr 2014 15:28:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=02l/5TwMWLzFZb6kC+qyXAT1Lz4=; b=nb5koP
	/Pg+lE5z899WarLV5srYQIfPfJUyaDOcUExmRPiC+Xyhe4v/cveNvroJG9GwdMYs
	B1Mx3R751U4hkVtLsF+Rwk9aB/5Wl6bAtB7zzZLfl/5wv9EU900XtG7nrfoaUMLI
	BPwFcJp5c1NGTs9ptNV/oPH07shNt10JLU+Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fKqsGPd3zenWtVZlqEET2kfR+0AnQQPr
	tWK2X9MeCRAN9Yq5I4SeYaCWP70Ms8pof4dNlJFsm+ngKhyhvgMxv1eGmLrt4quZ
	FtIkYcEAcn53G+x2Wlwwp9KMsCV06Mk2sI4Rp4IAvLrKTtQcipASKZybQUSG8hTQ
	vJdl8+34G8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F70B7A772;
	Thu, 10 Apr 2014 15:28:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCB0C7A771;
	Thu, 10 Apr 2014 15:28:54 -0400 (EDT)
In-Reply-To: <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
	(Yiannis Marangos's message of "Thu, 10 Apr 2014 21:31:21 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5ABAFEE6-C0E6-11E3-8A9F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246050>

Yiannis Marangos <yiannis.marangos@gmail.com> writes:

> +	n = xpread(fd, sha1, 20, st.st_size - 20);
> +	if (n != 20)
> +		goto out;

I think it is possible for pread(2) to give you a short-read.

The existing callers of emulated mmap and index-pack are prepared to
handle a short-read correctly, but I do not think this code does.

I'll queue this instead in the meantime.

-- >8 --
From: Yiannis Marangos <yiannis.marangos@gmail.com>
Date: Thu, 10 Apr 2014 21:31:21 +0300
Subject: [PATCH] read-cache.c: verify index file before we opportunistically update it

Before we proceed to opportunistically update the index (often done
by an otherwise read-only operation like "git status" and "git diff"
that internally refreshes the index), we must verify that the
current index file is the same as the one that we read earlier
before we took the lock on it, in order to avoid a possible race.

In the example below git-status does "opportunistic update" and
git-rebase updates the index, but the race can happen in general.

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |  3 +++
 read-cache.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 wrapper.c    | 20 ++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index ce377e1..9244c38 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ struct index_state {
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
+	unsigned char sha1[20];
 };
 
 extern struct index_state the_index;
@@ -1199,6 +1200,8 @@ extern void fsync_or_die(int fd, const char *);
 
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
+extern ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
+
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
diff --git a/read-cache.c b/read-cache.c
index 33dd676..f4a0d61 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1464,6 +1464,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
+	hashcpy(istate->sha1, (unsigned char *)hdr + mmap_size - 20);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
@@ -1747,6 +1748,50 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 	return result;
 }
 
+/*
+ * This function verifies if index_state has the correct sha1 of the
+ * index file.  Don't die if we have any other failure, just return 0.
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
+	n = pread_in_full(fd, sha1, 20, st.st_size - 20);
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
@@ -1766,7 +1811,7 @@ static int has_racy_timestamp(struct index_state *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    !write_index(istate, lockfile->fd))
+	    verify_index(istate) && !write_index(istate, lockfile->fd))
 		commit_locked_index(lockfile);
 	else
 		rollback_lock_file(lockfile);
diff --git a/wrapper.c b/wrapper.c
index 5b3c7fc..bc1bfb8 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -232,6 +232,26 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
+{
+	char *p = buf;
+	ssize_t total = 0;
+
+	while (count > 0) {
+		ssize_t loaded = xpread(fd, p, count, offset);
+		if (loaded < 0)
+			return -1;
+		if (loaded == 0)
+			return total;
+		count -= loaded;
+		p += loaded;
+		total += loaded;
+		offset += loaded;
+	}
+
+	return total;
+}
+
 int xdup(int fd)
 {
 	int ret = dup(fd);
-- 
1.9.2-590-g468068b

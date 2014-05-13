From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] read-cache: try index data from shared memory
Date: Tue, 13 May 2014 18:15:32 +0700
Message-ID: <1399979737-8577-6-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAh2-0000Ex-H7
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760645AbaEMLQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 07:16:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41914 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760469AbaEMLQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so167599pbb.5
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7tDYPmVZYmsTbkdlYV3wX38439B/R2ui4QiqYyRneM=;
        b=Hhl19ucdlvFG/+b7XUG/p/EKR8xXQkuiMkxPsJ6VXgLM/dymp725ab0kvnk1N9Jx7n
         Sc9YWxzlwvqxXQ96Bl5u9u3jXns9dFJptsn0+S0dLwDNxIsgcHrufrKSJ1We/I/uJ26C
         w/NLC0XUWYy3Bbb9gonByYDi0J+8FwKQwtIyS9huFytQhAjgZUdRSHI7MazQDb45e+0F
         pRCr8Qu49gG7S0aD4CtejViMHeho5gmzb7CDoMP1fwsnd5ia64cdvvURWVr8KvisUhbi
         NhOCxBR2Kietd/oP8DhOJHpvXMR+JZdZpYkdKl4AqzLmzpLsvg8wvEfK5pk2bHY9xvaG
         1ziQ==
X-Received: by 10.69.20.65 with SMTP id ha1mr4466655pbd.75.1399979770748;
        Tue, 13 May 2014 04:16:10 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id xk3sm27705546pbb.65.2014.05.13.04.16.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:16:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:16 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248765>

---
 read-cache.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 9e742c7..3100a59 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1462,6 +1462,35 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+static void *try_shm(void *mmap, size_t mmap_size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	void *new_mmap;
+	struct stat st;
+	int fd;
+
+	if (mmap_size <= 20)
+		return mmap;
+
+	strbuf_addf(&sb, "/git-index-%s",
+		    sha1_to_hex((unsigned char *)mmap + mmap_size - 20));
+	fd = shm_open(sb.buf, O_RDONLY, 0777);
+	strbuf_release(&sb);
+	if (fd < 0)
+		return mmap;
+	if (fstat(fd, &st) || st.st_size != mmap_size) {
+		close(fd);
+		return mmap;
+	}
+	new_mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (new_mmap == MAP_FAILED)
+		return mmap;
+	munmap(mmap, mmap_size);
+	return new_mmap;
+}
+
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1501,6 +1530,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	}
 	close(fd);
 
+	mmap = try_shm(mmap, mmap_size);
 	hdr = mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
-- 
1.9.1.346.ga2b5940

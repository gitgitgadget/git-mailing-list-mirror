From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/20] untracked cache: load from UNTR index extension
Date: Wed,  7 May 2014 21:51:52 +0700
Message-ID: <1399474320-6840-13-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Di-00067n-Jw
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbaEGOxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:11 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56513 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaEGOxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:09 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so1165203pdi.30
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJIhRsPU2foxaDYi2eUt6yFesxB1r03gRLo8288QPCo=;
        b=CTX6B+vltX2FXmp5Gs0GylL6D9Yr1xnvu8yWRCHf0qiFV0lQWN6aGINNrupimeJDxQ
         TjAzNVkt7lXL64i98NIOsjfEuuu1ExQCh+d22HMjLIgTPRUtsBixzISBJuP9HMbLQAZa
         uisUgtK/q+o6Z9NrIliKQiP3BoNqcM/WyBs4Aoou+R5iMEpjLCtV7rUl9wP6hFqLSbfk
         Nr5mfwLVSpHf1rTflfUOnk67kEoF7MkYcfLRmNw+A4xEJxmTlWvwGVYd5S9eY/9g6zw6
         v1+5f9oh0JAWqohUATDUDCP8kYBl9PBn/CZ0SqgKJKX/emG6Wt8Tfqzi9BMJ7VDbCxfk
         6GLg==
X-Received: by 10.67.13.226 with SMTP id fb2mr20063983pad.146.1399474387354;
        Wed, 07 May 2014 07:53:07 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id bc4sm3671543pbb.2.2014.05.07.07.53.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:08 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248318>

FIXME: load check_only
---
 dir.c        | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dir.h        |   1 +
 read-cache.c |   3 ++
 3 files changed, 111 insertions(+)

diff --git a/dir.c b/dir.c
index b7d394a..3c61b42 100644
--- a/dir.c
+++ b/dir.c
@@ -2256,3 +2256,110 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	if (untracked->root)
 		write_one_dir(out, untracked->root);
 }
+
+static void stat_data_from_disk(struct stat_data *to, const struct stat_data *from)
+{
+	to->sd_ctime.sec  = get_be32(&from->sd_ctime.sec);
+	to->sd_ctime.nsec = get_be32(&from->sd_ctime.nsec);
+	to->sd_mtime.sec  = get_be32(&from->sd_mtime.sec);
+	to->sd_mtime.nsec = get_be32(&from->sd_mtime.nsec);
+	to->sd_dev	  = get_be32(&from->sd_dev);
+	to->sd_ino	  = get_be32(&from->sd_ino);
+	to->sd_uid	  = get_be32(&from->sd_uid);
+	to->sd_gid	  = get_be32(&from->sd_gid);
+	to->sd_size	  = get_be32(&from->sd_size);
+}
+
+static int read_one_dir(struct untracked_cache_dir **untracked_,
+			const unsigned char *data_, unsigned long sz)
+{
+#define NEXT(x) \
+	next = data + (x); \
+	if (next > data_ + sz) \
+		return -1;
+
+	struct untracked_cache_dir ud, *untracked;
+	const unsigned char *next, *data = data_;
+	unsigned int value;
+	int i, len;
+
+	memset(&ud, 0, sizeof(ud));
+	ud.recurse = 1;
+
+	NEXT(sizeof(struct stat_data));
+	stat_data_from_disk(&ud.stat_data, (struct stat_data *)data);
+	data = next;
+
+	NEXT(20);
+	hashcpy(ud.exclude_sha1, data);
+	data = next;
+
+	next = data;
+	value = decode_varint(&next);
+	if (next > data_ + sz)
+		return -1;
+	ud.untracked_alloc = ud.untracked_nr = value >> 2;
+	if (ud.untracked_nr)
+		ud.untracked = xmalloc(sizeof(*ud.untracked) * ud.untracked_nr);
+	if (value & 1)
+		ud.valid = 1;
+	if (value & 2)
+		ud.check_only = 1;
+	data = next;
+
+	next = data;
+	ud.dirs_alloc = ud.dirs_nr = decode_varint(&next);
+	if (next > data_ + sz)
+		return -1;
+	ud.dirs = xmalloc(sizeof(*ud.dirs) * ud.dirs_nr);
+	data = next;
+
+	len = strlen((const char *)data);
+	NEXT(len + 1);
+	*untracked_ = untracked = xmalloc(sizeof(*untracked) + len);
+	memcpy(untracked, &ud, sizeof(ud));
+	memcpy(untracked->name, data, len + 1);
+	data = next;
+
+	for (i = 0; i < untracked->untracked_nr; i++) {
+		len = strlen((const char *)data);
+		NEXT(len + 1);
+		untracked->untracked[i] = xstrdup((const char*)data);
+		data = next;
+	}
+
+	for (i = 0; i < untracked->dirs_nr; i++) {
+		len = read_one_dir(untracked->dirs + i, data, sz - (data - data_));
+		if (len < 0)
+			return -1;
+		data += len;
+	}
+	return data - data_;
+}
+
+struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
+{
+	const struct ondisk_untracked_cache *ouc = data;
+	struct untracked_cache *uc;
+	int len;
+
+	if (sz < sizeof(*ouc))
+		return NULL;
+
+	uc = xcalloc(1, sizeof(*uc));
+	stat_data_from_disk(&uc->info_exclude_stat, &ouc->info_exclude_stat);
+	stat_data_from_disk(&uc->excludes_file_stat, &ouc->excludes_file_stat);
+	hashcpy(uc->info_exclude_sha1, ouc->info_exclude_sha1);
+	hashcpy(uc->excludes_file_sha1, ouc->excludes_file_sha1);
+	uc->dir_flags = get_be32(&ouc->dir_flags);
+	uc->exclude_per_dir = xstrdup(ouc->exclude_per_dir);
+	len = sizeof(*ouc) + strlen(ouc->exclude_per_dir);
+	if (sz == len)
+		return uc;
+	if (sz > len &&
+	    read_one_dir(&uc->root, (const unsigned char *)data + len,
+			 sz - len) == sz - len)
+		return uc;
+	free(uc);
+	return NULL;
+}
diff --git a/dir.h b/dir.h
index e520d58..42a09ff 100644
--- a/dir.h
+++ b/dir.h
@@ -295,5 +295,6 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 #endif
diff --git a/read-cache.c b/read-cache.c
index a619666..c350b7b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1332,6 +1332,9 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo = resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_UNTRACKED:
+		istate->untracked = read_untracked_extension(data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
-- 
1.9.1.346.ga2b5940

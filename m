From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] finish_tmp_packfile(): a helper function
Date: Wed, 30 Nov 2011 16:27:41 -0800
Message-ID: <1322699263-14475-4-git-send-email-gitster@pobox.com>
References: <1322699263-14475-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 01:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuVW-0003xt-Ot
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab1LAA1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:27:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab1LAA1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:27:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 665EB5D88
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=D0Cm
	eKDx3CFoBVpjGrQmUxaMF8M=; b=xwEbn9rrfiiCLE3HJXgu01RJzcU2Jj758Cq1
	7CH1vj745g+h6Z2Iu08UYNRE5QknaGbNz5/8TMtVPYeDwLiSmWZz4Tr9w2pR9WgK
	39VUWZSKAqUZjFpp3HrlVx7TWHp1R0XLqOnrY7ThVzYEznQCRxFlKLGpqGSosdqK
	0HLr96c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IPUXOJ
	X+VL7C+KRUtT/5AEedq3QnEHuxaroSXV9WMkmFfGCoN27lzjPgbN9EQCAJTJXjPz
	yxukQQTo4vV6guZgergVjGVYWw1ZXdo4bfL0hlIWowdfASjKHTyBGH3GL/YWfkm5
	loVeQHjajpFmjM1LJ7MT1/BnYh/MGCwsm8Mlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5FF5D87
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A92775D86 for
 <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:50 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322699263-14475-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4D40EAC6-1BB3-11E1-B826-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186150>

Factor out a small logic out of the private write_pack_file() function
in builtin/pack-objects.c.

This changes the order of finishing multi-pack generation slightly. The
code used to

 - adjust shared perm of temporary packfile
 - rename temporary packfile to the final name
 - update mtime of the packfile under the final name
 - adjust shared perm of temporary idxfile
 - rename temporary idxfile to the final name

but because the helper does not want to do the mtime thing, the updated
code does that step first and then all the rest.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |   33 ++++++++++-----------------------
 pack-write.c           |   31 +++++++++++++++++++++++++++++++
 pack.h                 |    1 +
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3258fa9..b458b6d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -617,20 +617,8 @@ static void write_pack_file(void)
 
 		if (!pack_to_stdout) {
 			struct stat st;
-			const char *idx_tmp_name;
 			char tmpname[PATH_MAX];
 
-			idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
-						      &pack_idx_opts, sha1);
-
-			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
-				 base_name, sha1_to_hex(sha1));
-			free_pack_by_name(tmpname);
-			if (adjust_shared_perm(pack_tmp_name))
-				die_errno("unable to make temporary pack file readable");
-			if (rename(pack_tmp_name, tmpname))
-				die_errno("unable to rename temporary pack file");
-
 			/*
 			 * Packs are runtime accessed in their mtime
 			 * order since newer packs are more likely to contain
@@ -638,28 +626,27 @@ static void write_pack_file(void)
 			 * packs then we should modify the mtime of later ones
 			 * to preserve this property.
 			 */
-			if (stat(tmpname, &st) < 0) {
+			if (stat(pack_tmp_name, &st) < 0) {
 				warning("failed to stat %s: %s",
-					tmpname, strerror(errno));
+					pack_tmp_name, strerror(errno));
 			} else if (!last_mtime) {
 				last_mtime = st.st_mtime;
 			} else {
 				struct utimbuf utb;
 				utb.actime = st.st_atime;
 				utb.modtime = --last_mtime;
-				if (utime(tmpname, &utb) < 0)
+				if (utime(pack_tmp_name, &utb) < 0)
 					warning("failed utime() on %s: %s",
 						tmpname, strerror(errno));
 			}
 
-			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
-				 base_name, sha1_to_hex(sha1));
-			if (adjust_shared_perm(idx_tmp_name))
-				die_errno("unable to make temporary index file readable");
-			if (rename(idx_tmp_name, tmpname))
-				die_errno("unable to rename temporary index file");
-
-			free((void *) idx_tmp_name);
+			/* Enough space for "-<sha-1>.pack"? */
+			if (sizeof(tmpname) <= strlen(base_name) + 50)
+				die("pack base name '%s' too long", base_name);
+			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
+			finish_tmp_packfile(tmpname, pack_tmp_name,
+					    written_list, nr_written,
+					    &pack_idx_opts, sha1);
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
diff --git a/pack-write.c b/pack-write.c
index 863cce8..cadc3e1 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -338,3 +338,34 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 	*pack_tmp_name = xstrdup(tmpname);
 	return sha1fd(fd, *pack_tmp_name);
 }
+
+void finish_tmp_packfile(char *name_buffer,
+			 const char *pack_tmp_name,
+			 struct pack_idx_entry **written_list,
+			 uint32_t nr_written,
+			 struct pack_idx_option *pack_idx_opts,
+			 unsigned char sha1[])
+{
+	const char *idx_tmp_name;
+	char *end_of_name_prefix = strrchr(name_buffer, 0);
+
+	if (adjust_shared_perm(pack_tmp_name))
+		die_errno("unable to make temporary pack file readable");
+
+	idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
+				      pack_idx_opts, sha1);
+	if (adjust_shared_perm(idx_tmp_name))
+		die_errno("unable to make temporary index file readable");
+
+	sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
+	free_pack_by_name(name_buffer);
+
+	if (rename(pack_tmp_name, name_buffer))
+		die_errno("unable to rename temporary pack file");
+
+	sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
+	if (rename(idx_tmp_name, name_buffer))
+		die_errno("unable to rename temporary index file");
+
+	free((void *)idx_tmp_name);
+}
diff --git a/pack.h b/pack.h
index 0027ac6..cfb0f69 100644
--- a/pack.h
+++ b/pack.h
@@ -86,5 +86,6 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
 extern int read_pack_header(int fd, struct pack_header *);
 
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
+extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
-- 
1.7.8.rc4.177.g4d64

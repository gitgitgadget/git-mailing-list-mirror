From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use xmemdupz() to allocate copies of strings given by start
 and length
Date: Sat, 19 Jul 2014 17:35:34 +0200
Message-ID: <53CA9046.1090709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Wg9-00055f-N7
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbaGSPf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:35:56 -0400
Received: from mout.web.de ([212.227.15.4]:49736 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbaGSPfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:35:55 -0400
Received: from [192.168.178.27] ([79.253.155.202]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Ldn19-1WhkmL31Nb-00j3EA; Sat, 19 Jul 2014 17:35:50
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:DOKFVC8y6fLjDrXYAy5NKyfiipy698htV91SHRyFyjHqSvL57Ae
 61C7efHblpy5/DP030MV7dmSOUzzItJWSuTPZGC2N3nJmR08pCjuXkfKAPCw208/hFF0BPh
 RjwXYBO8nqRiMHwWtcYCT5qPXS/nf810Jzazc+LVy+t9q1BTPNl1XRE2GnXg7k6583Xf+t/
 S+PiufX2+ZnGrn0eWdzog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253883>

Use xmemdupz() to allocate the memory, copy the data and make sure to
NUL-terminate the result, all in one step.  The resulting code is
shorter, doesn't contain the constants 1 and '\0', and avoids
duplicating function parameters.

For blame, the last copied byte (o->file.ptr[o->file.size]) is always
set to NUL by fake_working_tree_commit() or read_sha1_file(), so no
information is lost by the conversion to using xmemdupz().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/apply.c     | 4 +---
 builtin/blame.c     | 5 +----
 connect.c           | 4 +---
 http-backend.c      | 4 +---
 path.c              | 4 +---
 sh-i18n--envsubst.c | 4 +---
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5fd099e..9f8f5ba 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2867,9 +2867,7 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
 	case BINARY_LITERAL_DEFLATED:
 		clear_image(img);
 		img->len = fragment->size;
-		img->buf = xmalloc(img->len+1);
-		memcpy(img->buf, fragment->patch, img->len);
-		img->buf[img->len] = '\0';
+		img->buf = xmemdupz(fragment->patch, img->len);
 		return 0;
 	}
 	return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index c59e702..32ce05f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2707,11 +2707,8 @@ parse_done:
 		die("revision walk setup failed");
 
 	if (is_null_sha1(sb.final->object.sha1)) {
-		char *buf;
 		o = sb.final->util;
-		buf = xmalloc(o->file.size + 1);
-		memcpy(buf, o->file.ptr, o->file.size + 1);
-		sb.final_buf = buf;
+		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
 		sb.final_buf_size = o->file.size;
 	}
 	else {
diff --git a/connect.c b/connect.c
index 37ff018..5047402 100644
--- a/connect.c
+++ b/connect.c
@@ -64,9 +64,7 @@ static void parse_one_symref_info(struct string_list *symref, const char *val, i
 	if (!len)
 		return; /* just "symref" */
 	/* e.g. "symref=HEAD:refs/heads/master" */
-	sym = xmalloc(len + 1);
-	memcpy(sym, val, len);
-	sym[len] = '\0';
+	sym = xmemdupz(val, len);
 	target = strchr(sym, ':');
 	if (!target)
 		/* just "symref=something" */
diff --git a/http-backend.c b/http-backend.c
index 57290d9..80790bb 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -610,9 +610,7 @@ int main(int argc, char **argv)
 
 			cmd = c;
 			n = out[0].rm_eo - out[0].rm_so;
-			cmd_arg = xmalloc(n);
-			memcpy(cmd_arg, dir + out[0].rm_so + 1, n-1);
-			cmd_arg[n-1] = '\0';
+			cmd_arg = xmemdupz(dir + out[0].rm_so + 1, n - 1);
 			dir[out[0].rm_so] = 0;
 			break;
 		}
diff --git a/path.c b/path.c
index bc804a3..25c3b8b 100644
--- a/path.c
+++ b/path.c
@@ -249,9 +249,7 @@ int validate_headref(const char *path)
 static struct passwd *getpw_str(const char *username, size_t len)
 {
 	struct passwd *pw;
-	char *username_z = xmalloc(len + 1);
-	memcpy(username_z, username, len);
-	username_z[len] = '\0';
+	char *username_z = xmemdupz(username, len);
 	pw = getpwnam(username_z);
 	free(username_z);
 	return pw;
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 855d28c..6dd03a9 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -278,9 +278,7 @@ static string_list_ty variables_set;
 static void
 note_variable (const char *var_ptr, size_t var_len)
 {
-  char *string = xmalloc (var_len + 1);
-  memcpy (string, var_ptr, var_len);
-  string[var_len] = '\0';
+  char *string = xmemdupz (var_ptr, var_len);
 
   string_list_append (&variables_set, string);
 }
-- 
2.0.2

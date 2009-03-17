From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] builtin-tag.c: remove global variable to use the callback
	data of git-config.
Date: Tue, 17 Mar 2009 15:43:51 +0100
Message-ID: <1237301031.10001.13.camel@equipo-loli>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Mar 17 15:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjaXt-0007Ym-MD
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 15:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbZCQOoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 10:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbZCQOoC
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 10:44:02 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:20245 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbZCQOoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 10:44:00 -0400
Received: by ey-out-2122.google.com with SMTP id 4so19051eyf.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=CF2VbrrlUpTR95n3JnAh8BAbCogRhRCHC6216tK/w+o=;
        b=N6xJzPaNKeicou+kZ+1w9HNm1d/tJO9p1ignMLnXP1QlwoHVOYMnx1/KYrCU/XzB9O
         htuIvJzuXt15UejxCyXTolRTzXRKTCgAd0aot8tP1vSrAnS7PAadWV6CfYLZA9kOef7W
         t5bQ19BE00pE7cDTl/bKs/J6Q6dpxgjV1hkvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=vLGbXYlUN1prFpnIc1jx4VId1Bul2UnCxIoHs4gWuhd20iAN89lqZjvT9i90s2rlry
         fVVeduKgfJr7HJI7e7Os5Q3/pqzl494zsttvkTc+HEMFBRAZVcuElKV1zOd5y4JPx98V
         rz0lrcRxZYctIvkwFqPhxj3x5g+YEEH81+Ye4=
Received: by 10.216.8.65 with SMTP id 43mr53607weq.168.1237301037355;
        Tue, 17 Mar 2009 07:43:57 -0700 (PDT)
Received: from ?192.168.0.192? ([89.7.153.138])
        by mx.google.com with ESMTPS id 5sm5949044eyf.32.2009.03.17.07.43.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Mar 2009 07:43:56 -0700 (PDT)
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113475>

By using strbuf to save the signing-key id, it also imposes no limit
to the length of the string obtained from the config or command-line.
This string is then passed to gpg to sign the tag, when appropriate.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---


QUESTION: Is it safe to remove this limit?


 builtin-tag.c |   39 ++++++++++++++++-----------------------
 1 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..ed8b24f 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -21,8 +21,6 @@ static const char * const git_tag_usage[] = {
 	NULL
 };
 
-static char signingkey[1000];
-
 struct tag_filter {
 	const char *pattern;
 	int lines;
@@ -156,7 +154,7 @@ static int verify_tag(const char *name, const char *ref,
 	return 0;
 }
 
-static int do_sign(struct strbuf *buffer)
+static int do_sign(struct strbuf *signingkey, struct strbuf *buffer)
 {
 	struct child_process gpg;
 	const char *args[4];
@@ -164,11 +162,10 @@ static int do_sign(struct strbuf *buffer)
 	int len;
 	int i, j;
 
-	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
-				sizeof(signingkey)) > sizeof(signingkey) - 1)
-			return error("committer info too long.");
-		bracket = strchr(signingkey, '>');
+	if (!signingkey->buf[0]) {
+		strbuf_addstr(signingkey,
+				git_committer_info(IDENT_ERROR_ON_NO_NAME));
+		bracket = strchr(signingkey->buf, '>');
 		if (bracket)
 			bracket[1] = '\0';
 	}
@@ -183,7 +180,7 @@ static int do_sign(struct strbuf *buffer)
 	gpg.out = -1;
 	args[0] = "gpg";
 	args[1] = "-bsau";
-	args[2] = signingkey;
+	args[2] = signingkey->buf;
 	args[3] = NULL;
 
 	if (start_command(&gpg))
@@ -220,18 +217,12 @@ static const char tag_template[] =
 	"# Write a tag message\n"
 	"#\n";
 
-static void set_signingkey(const char *value)
-{
-	if (strlcpy(signingkey, value, sizeof(signingkey)) >= sizeof(signingkey))
-		die("signing key value too long (%.10s...)", value);
-}
-
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
 			return config_error_nonbool(var);
-		set_signingkey(value);
+		strbuf_addstr((struct strbuf *) cb, value);
 		return 0;
 	}
 
@@ -266,9 +257,10 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 	free(buf);
 }
 
-static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
+static int build_tag_object(struct strbuf *buf, int sign,
+			struct strbuf *signingkey, unsigned char *result)
 {
-	if (sign && do_sign(buf) < 0)
+	if (sign && do_sign(signingkey, buf) < 0)
 		return error("unable to sign the tag");
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		return error("unable to write tag file");
@@ -277,6 +269,7 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, int message, int sign,
+		       struct strbuf *signingkey,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
@@ -331,7 +324,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (build_tag_object(buf, sign, result) < 0) {
+	if (build_tag_object(buf, sign, signingkey, result) < 0) {
 		if (path)
 			fprintf(stderr, "The tag message has been left in %s\n",
 				path);
@@ -363,7 +356,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, signingkey = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
@@ -403,14 +396,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_tag_config, NULL);
+	git_config(git_tag_config, &signingkey);
 
 	argc = parse_options(argc, argv, options, git_tag_usage, 0);
 	msgfile = parse_options_fix_filename(prefix, msgfile);
 
 	if (keyid) {
 		sign = 1;
-		set_signingkey(keyid);
+		strbuf_addstr(&signingkey, keyid);
 	}
 	if (sign)
 		annotate = 1;
@@ -474,7 +467,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+			   sign, &signingkey, prev, object);
 
 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
-- 
1.6.0.5

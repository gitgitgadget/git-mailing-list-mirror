From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] builtin-tag.c: remove global variable to use the callback
	data of git-config.
Date: Tue, 24 Mar 2009 20:54:45 +0100
Message-ID: <1237924485.9871.33.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, johannes.schindelin@gmx.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 24 20:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCjW-0006He-AG
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbZCXTys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbZCXTys
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:54:48 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:46359 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbZCXTyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:54:47 -0400
Received: by bwz17 with SMTP id 17so2383369bwz.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=uwGhAkSZJDuSQukjCFFeQOMEMJgUvMCGh4fUj5V5yQU=;
        b=doOw1bpm5hWwd0lhRYpoKoS9LS/NAZ/U1PPmtwzs6VJywl/oxvilCQWcUTuoKwMyKU
         WiQj0992QkQnIWptfANQDkqyEA1giGqVgdIWB38SqXMSyGr+JWXJetRQib0fmP5QuTRf
         QJe6gmLzQxaIgMTemDQtFGlfVUmnAH06E3N6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ZD0CJdEFDwkp5QNmOB3oSoJkneUQ1I59hrpkEGnCxin4w4VPtxzjSLfJulK2BbpTSn
         fwVtlOwg4j4+xTq9Gsu2X8EfqYu2iFGp3u67l2xL7RT993jcSNBl0SRiUCC+fYuASbHE
         Ktbu4NYQVGSAp4GGG3caMC0C529i090CHseQg=
Received: by 10.103.248.17 with SMTP id a17mr3805552mus.83.1237924482800;
        Tue, 24 Mar 2009 12:54:42 -0700 (PDT)
Received: from ?192.168.0.194? ([212.145.102.186])
        by mx.google.com with ESMTPS id s10sm12831884muh.52.2009.03.24.12.54.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 12:54:42 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114484>

By using strbuf to save the signing-key id, now there's no limit
to the length of the string obtained from the config or command-line.
This string is then passed to gpg to sign the tag, when appropriate.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---


NOTES: As Johannes Schindelin suggested, now strbuf is correctly used,
       using setlen() for chopping the end data of the committer info,
       instead of just setting '\0' and forgetting the len field.

       Although git_committer_info() seems to return always the email
       field between <angle brackets>, I left unchanged the "if (bracket)"
       condition (as in builtin-log.c) to prevent errors or future changes.

       Trying to test it, I found that gpg accepts any non-empty substring
       of the name or email to identify the signing key ID, just as it is
       stated in its manpage at end of section HOW TO SPECIFY A USER ID.


 builtin-tag.c |   41 +++++++++++++++++------------------------
 1 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..ad54e4a 100644
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
@@ -164,13 +162,12 @@ static int do_sign(struct strbuf *buffer)
 	int len;
 	int i, j;
 
-	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
-				sizeof(signingkey)) > sizeof(signingkey) - 1)
-			return error("committer info too long.");
-		bracket = strchr(signingkey, '>');
+	if (!signingkey->len) {
+		strbuf_addstr(signingkey,
+				git_committer_info(IDENT_ERROR_ON_NO_NAME));
+		bracket = strchr(signingkey->buf, '>');
 		if (bracket)
-			bracket[1] = '\0';
+			strbuf_setlen(signingkey, bracket + 1 - signingkey->buf);
 	}
 
 	/* When the username signingkey is bad, program could be terminated
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
1.5.4.3

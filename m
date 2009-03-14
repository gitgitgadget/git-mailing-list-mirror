From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] builtin-tag.c: remove global variable to use the callback
	data of git-config.
Date: Sat, 14 Mar 2009 08:17:15 +0100
Message-ID: <1237015035.9952.10.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, johannes.schindelin@gmx.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 14 08:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiO8o-0005WD-EW
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 08:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZCNHRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 03:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbZCNHRN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 03:17:13 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:64012 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZCNHRK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 03:17:10 -0400
X-Greylist: delayed 16443 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Mar 2009 03:17:10 EDT
Received: by bwz23 with SMTP id 23so354920bwz.37
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=6kzyyzGa9+t94Xc3Aq6DiYrAOtveRNnh0ZoHkwUv5xw=;
        b=XpJxnD3+IW27iedWLRJSubin45nA4w94xrOCpE0r3xE4GXT1MsdqitmaRRl47HUPsr
         osVVZvxhLRp764253Nl2tv4UystDCbnnzLOtiL7KOCQa/dw/pZ3jOkCJDtlK1kBiDV00
         0fdHIxwvsGYtA07k4WjxljUJ9u7VVAIqM3WpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=jyN2T+kKuSWuNxow3qzIqzLNB9MNwlQKuBhkfvvKmSRlR6Nocu2bPVoqny+tVPUYeZ
         rvdwQ0hSw+vQcpHW3XEQNmMLPoo6ceMiCuB/QndmAmP4nrsn6VDuQNrHbwlk7oS8/WYD
         Il6zIb7XiJUiD0LfmUaQNaQ0O5njtXae+aJXM=
Received: by 10.103.105.1 with SMTP id h1mr1016175mum.13.1237015027511;
        Sat, 14 Mar 2009 00:17:07 -0700 (PDT)
Received: from ?192.168.0.194? ([212.145.102.186])
        by mx.google.com with ESMTPS id 23sm5310616mum.7.2009.03.14.00.17.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Mar 2009 00:17:06 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113240>

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

Here I declare a struct to wrap the new local array along with its size.
QUESTION: An alternative to this is strbuf, would it be preferable?


builtin-tag.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..2b2d728 100644
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
@@ -156,7 +154,12 @@ static int verify_tag(const char *name, const char *ref,
 	return 0;
 }
 
-static int do_sign(struct strbuf *buffer)
+struct char_array {
+	char *buf;
+	size_t size;
+};
+
+static int do_sign(struct char_array *signingkey, struct strbuf *buffer)
 {
 	struct child_process gpg;
 	const char *args[4];
@@ -164,11 +167,12 @@ static int do_sign(struct strbuf *buffer)
 	int len;
 	int i, j;
 
-	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
-				sizeof(signingkey)) > sizeof(signingkey) - 1)
+	if (!signingkey->buf[0]) {
+		if (strlcpy(signingkey->buf,
+				git_committer_info(IDENT_ERROR_ON_NO_NAME),
+				signingkey->size) > signingkey->size - 1)
 			return error("committer info too long.");
-		bracket = strchr(signingkey, '>');
+		bracket = strchr(signingkey->buf, '>');
 		if (bracket)
 			bracket[1] = '\0';
 	}
@@ -183,7 +187,7 @@ static int do_sign(struct strbuf *buffer)
 	gpg.out = -1;
 	args[0] = "gpg";
 	args[1] = "-bsau";
-	args[2] = signingkey;
+	args[2] = signingkey->buf;
 	args[3] = NULL;
 
 	if (start_command(&gpg))
@@ -220,9 +224,10 @@ static const char tag_template[] =
 	"# Write a tag message\n"
 	"#\n";
 
-static void set_signingkey(const char *value)
+static void set_signingkey(struct char_array *signingkey, const char *value)
 {
-	if (strlcpy(signingkey, value, sizeof(signingkey)) >= sizeof(signingkey))
+	if (strlcpy(signingkey->buf, value, signingkey->size)
+					>= signingkey->size)
 		die("signing key value too long (%.10s...)", value);
 }
 
@@ -231,7 +236,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
 			return config_error_nonbool(var);
-		set_signingkey(value);
+		set_signingkey((struct char_array *) cb, value);
 		return 0;
 	}
 
@@ -266,9 +271,10 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 	free(buf);
 }
 
-static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
+static int build_tag_object(struct strbuf *buf, int sign,
+			struct char_array *signingkey, unsigned char *result)
 {
-	if (sign && do_sign(buf) < 0)
+	if (sign && do_sign(signingkey, buf) < 0)
 		return error("unable to sign the tag");
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		return error("unable to write tag file");
@@ -277,6 +283,7 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, int message, int sign,
+		       struct char_array *signingkey,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
@@ -331,7 +338,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (build_tag_object(buf, sign, result) < 0) {
+	if (build_tag_object(buf, sign, signingkey, result) < 0) {
 		if (path)
 			fprintf(stderr, "The tag message has been left in %s\n",
 				path);
@@ -374,6 +381,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	char keyarr[1000] = {'\0'};
+	struct char_array signingkey = { keyarr, sizeof(keyarr) };
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
@@ -403,14 +412,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_tag_config, NULL);
+	git_config(git_tag_config, &signingkey);
 
 	argc = parse_options(argc, argv, options, git_tag_usage, 0);
 	msgfile = parse_options_fix_filename(prefix, msgfile);
 
 	if (keyid) {
 		sign = 1;
-		set_signingkey(keyid);
+		set_signingkey(&signingkey, keyid);
 	}
 	if (sign)
 		annotate = 1;
@@ -474,7 +483,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+			   sign, &signingkey, prev, object);
 
 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
-- 
1.5.4.3

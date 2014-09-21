From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH] notes: Allow adding empty notes with -C
Date: Sun, 21 Sep 2014 05:00:49 +0200
Message-ID: <1411268449-14636-1-git-send-email-johan@herland.net>
References: <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
Cc: jhf@trifork.com, Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 05:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVXOm-0000wZ-Um
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 05:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbaIUDBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 23:01:06 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:42407 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaIUDBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 23:01:03 -0400
Received: by mail-la0-f42.google.com with SMTP id hz20so5074728lab.15
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 20:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHmNloe9onpsZy1d6idvvtXWAmy5X6jYvn00mer5FMs=;
        b=SAEMS1kf9Mk2dlf2EmhmV1PkKQpdKzGU2IQq7wF6MDRJwD0GtyNYZP/nG5zsJ7ehF7
         fVeqdSLE3t7JE3dhJSVhls4YOmnBz2JvHkoxu8wU4BTETlocUf//ixF25QlJYLMfWbvI
         g4D4EsGY63LZh6HcVhpTM1Ji98uNjb+GP/y/NwPDEwb+ajVbMmt1c/Sp8kQmSW+t51Jc
         z26GrjFoUxjKC8hwNP+cqtB7BgCBvVyHUpLjwM20txnvOR1cNo5nNIQ0cSeOH90MZpXU
         QGLKQTvMKtfmghon0gBHx9cYrWj8F7VLzRVVMRxLl3QPv3KNNXK8TnvCzKO0ziNumgcs
         orIQ==
X-Received: by 10.112.114.202 with SMTP id ji10mr575393lbb.92.1411268460602;
        Sat, 20 Sep 2014 20:01:00 -0700 (PDT)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id z2sm2221213laa.15.2014.09.20.20.00.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Sep 2014 20:00:59 -0700 (PDT)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257336>

Although the "git notes" man page advertises that we support binary-safe
notes addition with the -C option, we currently do not support adding the
empty note (i.e. using the empty blob to annotate an object). Instead,
an empty note is always treated as an intent to remove the note
altogether.

Introduce a flag to builtin/notes which indicates whether or not to
remove an empty note, and disable that flag for the -C option (leave it
enabled to preserve the current behavior for all other options).

Also add a test case that verifies that we can not indeed add empty notes
with "git notes add -C $empty_blob".

Reported-by: James H. Fisher <jhf@trifork.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c  | 16 +++++++++++-----
 notes.c          |  3 +--
 t/t3301-notes.sh | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 67d0bb1..f8ff590 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -95,6 +95,7 @@ static const char note_template[] =
 struct msg_arg {
 	int given;
 	int use_editor;
+	int remove_if_empty;
 	struct strbuf buf;
 };
 
@@ -202,7 +203,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		free(prev_buf);
 	}
 
-	if (!msg->buf.len) {
+	if (msg->remove_if_empty && !msg->buf.len) {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			sha1_to_hex(object));
 		hashclr(result);
@@ -233,6 +234,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	stripspace(&(msg->buf), 0);
 
 	msg->given = 1;
+	msg->remove_if_empty = 1;
 	return 0;
 }
 
@@ -250,6 +252,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 	stripspace(&(msg->buf), 0);
 
 	msg->given = 1;
+	msg->remove_if_empty = 1;
 	return 0;
 }
 
@@ -266,7 +269,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (get_sha1(arg, object))
 		die(_("Failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_sha1_file(object, &type, &len)) || !len) {
+	if (!(buf = read_sha1_file(object, &type, &len))) {
 		free(buf);
 		die(_("Failed to read object '%s'."), arg);
 	}
@@ -278,14 +281,17 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	free(buf);
 
 	msg->given = 1;
+	msg->remove_if_empty = 0;
 	return 0;
 }
 
 static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
 {
+	int ret = parse_reuse_arg(opt, arg, unset);
 	struct msg_arg *msg = opt->value;
 	msg->use_editor = 1;
-	return parse_reuse_arg(opt, arg, unset);
+	msg->remove_if_empty = 1;
+	return ret;
 }
 
 static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
@@ -403,7 +409,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	unsigned char object[20], new_note[20];
 	char logmsg[100];
 	const unsigned char *note;
-	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	struct msg_arg msg = { 0, 0, 1, STRBUF_INIT };
 	struct option options[] = {
 		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -560,7 +566,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const unsigned char *note;
 	char logmsg[100];
 	const char * const *usage;
-	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	struct msg_arg msg = { 0, 0, 1, STRBUF_INIT };
 	struct option options[] = {
 		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
diff --git a/notes.c b/notes.c
index 5fe691d..62bc6e1 100644
--- a/notes.c
+++ b/notes.c
@@ -1218,8 +1218,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!sha1)
 		return;
 
-	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
-			type != OBJ_BLOB) {
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index cfd67ff..a6c399b 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1239,4 +1239,23 @@ test_expect_success 'git notes get-ref (--ref)' '
 	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
 '
 
+cat > expect << EOF
+commit 085b0d1309902c3148feb5a136515bdb9a1cd614
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:28:13 2005 -0700
+
+    16th
+
+Notes (foo):
+EOF
+
+test_expect_success 'can create empty note with "git notes add -C $empty_blob"' '
+	test_commit 16th &&
+	blob=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+	git notes add -C $blob &&
+	git log -1 > actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$blob"
+'
+
 test_done
-- 
2.1.1.392.g062cc5d

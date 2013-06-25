From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 01/16] test: add test cases for relative_path
Date: Tue, 25 Jun 2013 23:53:42 +0800
Message-ID: <569bd5216b6a8d63c9139c20390488b93f402086.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVZY-0003hH-I4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab3FYPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:54:18 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50052 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab3FYPyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:54:15 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so12894832pad.30
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=M0cFnQL0vD+MCSh3TNljyE4yKynqupKsfdkwrYObuL8=;
        b=ReXo+M0WGnKhV0joY7TAQLs5VE9dVW0Pv3m14p8yDJoPUiR3VrMuelNF6nPDe2pxDz
         9ChlhGo6QnUsxrZ7rd56M0eNh2D6CuajCen1g/z/jInb2wCqn6MxKvLrpvNwZktWnTbb
         /6wZGnjrUZZtERTTpktlpB3q2KLNXtLk8Oh7CxqfSZkOuVf5fUNVBRkiREfcTHtzPabs
         Ohho11jtR4K/36tvhRBTBgx6hr9Tbsb9GoCbNOx6BlLQ44GE7PTAelL5rY/EABTRoNa0
         FZYwtuQsLqJz4PQuRntUfAnoiMXOVlVd/Vq2AMV1FfZBscL4N0+qIX5TfoPHgDCK8jYv
         CAGg==
X-Received: by 10.68.224.228 with SMTP id rf4mr29565961pbc.50.1372175655200;
        Tue, 25 Jun 2013 08:54:15 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:54:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228962>

Add subcommand "relative_path" in test-path-utils, and add test cases
in t0060.

Johannes tested this commit on Windows, and found that some relative_path
tests should be skipped on Windows. This is because the bash on Windows
rewrites arguments of regular Windows programs, such as git and the
test helpers, if the arguments look like absolute POSIX paths. As a
consequence, the actual tests performed are not what the tests scripts
expect.

The tests that need *not* be skipped are those where the two paths passed
to 'test-path-utils relative_path' have the same prefix and the result is
expected to be a relative path. This is because the rewriting changes
"/a/b" to "D:/Src/MSysGit/a/b", and when both inputs are extended the same
way, this just cancels out in the relative path computation.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0060-path-utils.sh | 37 +++++++++++++++++++++++++++++++++++++
 test-path-utils.c     | 25 +++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 09a42..72e89 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -12,6 +12,11 @@ norm_path() {
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
+relative_path() {
+	test_expect_success $4 "relative path: $1 $2 => $3" \
+	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$3'"
+}
+
 # On Windows, we are using MSYS's bash, which mangles the paths.
 # Absolute paths are anchored at the MSYS installation directory,
 # which means that the path / accounts for this many characters:
@@ -183,4 +188,36 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+relative_path /a/b/c/	/a/b/		c/
+relative_path /a/b/c/	/a/b		c/
+relative_path /a//b//c/	//a/b//		c/	POSIX
+relative_path /a/b	/a/b		.
+relative_path /a/b/	/a/b		.
+relative_path /a	/a/b		/a	POSIX
+relative_path /		/a/b/		/	POSIX
+relative_path /a/c	/a/b/		/a/c	POSIX
+relative_path /a/c	/a/b		/a/c	POSIX
+relative_path /x/y	/a/b/		/x/y	POSIX
+relative_path /a/b	"<empty>"	/a/b	POSIX
+relative_path /a/b 	"<null>"	/a/b	POSIX
+relative_path a/b/c/	a/b/		c/
+relative_path a/b/c/	a/b		c/
+relative_path a/b//c	a//b		c
+relative_path a/b/	a/b/		.
+relative_path a/b/	a/b		.
+relative_path a		a/b		a	# TODO: should be: ..
+relative_path x/y	a/b		x/y	# TODO: should be: ../../x/y
+relative_path a/c	a/b		a/c	# TODO: should be: ../c
+relative_path a/b	"<empty>"	a/b
+relative_path a/b 	"<null>"	a/b
+relative_path "<empty>"	/a/b		"(empty)"
+relative_path "<empty>"	"<empty>"	"(empty)"
+relative_path "<empty>"	"<null>"	"(empty)"
+relative_path "<null>"	"<empty>"	"(null)"
+relative_path "<null>"	"<null>"	"(null)"
+
+test_expect_failure 'relative path: <null> /a/b => segfault' '
+	test-path-utils relative_path "<null>" "/a/b"
+'
+
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 0092cb..8a6d2 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -28,6 +28,19 @@ static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
 	return 1;
 }
 
+static void normalize_argv_string(const char **var, const char *input)
+{
+	if (!strcmp(input, "<null>"))
+		*var = NULL;
+	else if (!strcmp(input, "<empty>"))
+		*var = "";
+	else
+		*var = input;
+
+	if (*var && (**var == '<' || **var == '('))
+		die("Bad value: %s\n", input);
+}
+
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
@@ -103,6 +116,18 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
+		const char *in, *prefix, *rel;
+		normalize_argv_string(&in, argv[2]);
+		normalize_argv_string(&prefix, argv[3]);
+		rel = relative_path(in, prefix);
+		if (!rel)
+			puts("(null)");
+		else
+			puts(strlen(rel) > 0 ? rel : "(empty)");
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.8.3.1.756.g2e9b71f

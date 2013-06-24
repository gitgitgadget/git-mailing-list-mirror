From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 01/16] test: add test cases for relative_path
Date: Mon, 24 Jun 2013 23:21:25 +0800
Message-ID: <85c9aa4d05dba4320a7cc85eae7570e0f450e58e.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8am-0006Gi-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab3FXPWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:22:04 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53800 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3FXPWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:02 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so11168230pab.39
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=rpfcJorPqfSMxMFfy4fvVhBNsX99JHSsvIo+SDTq9FY=;
        b=x2zHIA/in+Hh+DSx7ZzJTuTr5LGhanvLT9JUUkKzLfWDvnsZ51Wnrx2ahPaedh0GpL
         vMFtDcgkTUkXAWyZ6fK+vOTG+rGe4Z/ZWtN6mH9Mxmx7y+P3HxfpcQWgMXKT7EHQt/u9
         2A+MRjp5T8I94ATG5YWld8CXe1irCPkCmt72MPEKvYADL6y/NAs2Mpj3FRF22fCp+E1+
         FB9wjn0Bzn0gXB42DEBNVikmy1orreydxEyGtqZTPW0vxX+dY05snI+7NRmxWzQoHkQD
         QrVX3E3pmlq7GvM9/IbYizlSaIsKNlRyqyLyW1elJiCNviOgdA53OQUaUVo78jTKYKQ9
         IqPg==
X-Received: by 10.68.252.36 with SMTP id zp4mr24467768pbc.51.1372087321507;
        Mon, 24 Jun 2013 08:22:01 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.21.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228823>

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
 t/t0060-path-utils.sh | 26 ++++++++++++++++++++++++++
 test-path-utils.c     | 25 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 09a42..7e258 100755
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
@@ -183,4 +188,25 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
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
+relative_path /a/b	"<empty>"	/a/b	POSIX
+relative_path /a/b 	"<null>"	/a/b	POSIX
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
index 0092cb..dcc530 100644
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
+		const char *abs, *base, *rel;
+		normalize_argv_string(&abs, argv[2]);
+		normalize_argv_string(&base, argv[3]);
+		rel = relative_path(abs, base);
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
1.8.3.1.756.g41beab0

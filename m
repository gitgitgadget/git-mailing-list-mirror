From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/2] builtin/grep: add grep.fallbackToNoIndex config
Date: Tue, 12 Jan 2016 11:40:26 +0100
Message-ID: <1452595226-14616-3-git-send-email-t.gummerer@gmail.com>
References: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
 <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 11:40:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIwNS-0004zj-PC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 11:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934823AbcALKkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 05:40:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33668 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934741AbcALKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 05:40:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so30542744wmu.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 02:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D568k8K2v8rsPGsLfOrJ+ohdWrDES/wMQUSp/X6ODIU=;
        b=rEyty62hSwsrt/XJWpBjNHwjSySzWB3tSln5X8SblZMgNsQ1E6IWTYcT32z0ul5p1L
         Gr+xyuu6KTpc6+loX0oYlPBUJgEA+VgaFoA7EficPMFEi9b3kkldP+1M4F3XniQvMJ89
         J9HvWCe8Jjns8KLpUjddiHS9rKkCOWiBF7wl+xHkeEtbhCHRp+NwNGqaMr58m1CQEh9b
         nSAxVTN/mYpPwWUDas+BGNgQtBizH7Mo4b5wHtio7gAQN8nsFUh9y5kgaFuSlGnSdCbf
         tKXFVpY/XMapUQEqgpO0aApOu2kpgo5RzvqbLODYXL1iH2/mkf3q1R+x0ifEz84Jjp+4
         ah1g==
X-Received: by 10.194.113.165 with SMTP id iz5mr16613572wjb.4.1452595206436;
        Tue, 12 Jan 2016 02:40:06 -0800 (PST)
Received: from localhost (host214-63-dynamic.48-82-r.retail.telecomitalia.it. [82.48.63.214])
        by smtp.gmail.com with ESMTPSA id z127sm16931983wme.2.2016.01.12.02.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 02:40:05 -0800 (PST)
X-Mailer: git-send-email 2.7.0.2.gcdcca30.dirty
In-Reply-To: <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283787>

Currently when git grep is used outside of a git repository without the
--no-index option git simply dies.  For convenience, add a
grep.fallbackToNoIndex configuration variable.  If set to true, git grep
behaves like git grep --no-index if it is run outside of a git
repository.  It defaults to false, preserving the current behavior.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config.txt   |  4 ++++
 Documentation/git-grep.txt |  4 ++++
 builtin/grep.c             | 12 +++++++++---
 t/t7810-grep.sh            | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..8d51f80 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1450,6 +1450,10 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..15b9033 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -56,6 +56,10 @@ grep.extendedRegexp::
 grep.fullName::
 	If set to true, enable '--full-name' option by default.
 
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
+
 
 OPTIONS
 -------
diff --git a/builtin/grep.c b/builtin/grep.c
index 4229cae..6b7add6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -755,9 +755,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
-	if (use_index && !startup_info->have_repository)
-		/* die the same way as if we did it at the beginning */
-		setup_git_directory();
+	if (use_index && !startup_info->have_repository) {
+		int fallback = 0;
+		git_config_get_bool("grep.fallbacktonoindex", &fallback);
+		if (fallback)
+			use_index = 0;
+		else
+			/* die the same way as if we did it at the beginning */
+			setup_git_directory();
+	}
 
 	/*
 	 * skip a -- separator; we know it cannot be
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cc4b97d..b540944 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -821,6 +821,47 @@ test_expect_success 'outside of git repository' '
 	)
 '
 
+test_expect_success 'outside of git repository with fallbackToNoIndex' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	cat <<-\EOF >non/expect.full &&
+	file1:hello
+	sub/file2:world
+	EOF
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git -c grep.fallbackToNoIndex=false grep o &&
+		git -c grep.fallbackToNoIndex=true grep o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git -c grep.fallbackToNoIndex=false grep o &&
+		git -c grep.fallbackToNoIndex=true grep o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git -c grep.fallbackToNoIndex=false grep o &&
+		git -c grep.fallbackToNoIndex=true grep --exclude-standard o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*" &&
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git -c grep.fallbackToNoIndex grep --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
+	)
+'
+
 test_expect_success 'inside git repository but with --no-index' '
 	rm -fr is &&
 	mkdir -p is/git/sub &&
-- 
2.7.0.2.gcdcca30.dirty

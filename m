From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 14/31] Use "git check-ref-format" to validate patch names.
Date: Fri, 16 May 2014 16:46:01 +0200
Message-ID: <1400251578-17221-15-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJVF-00028p-3p
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313AbaEPOwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:52:49 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37653 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbaEPOws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:52:48 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so2013794lbi.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JEYFP8Bb/TsjonmDGjFkiq8veOtVZXtVFqEA6O0QIT8=;
        b=GesmWYAd7gt4OXehm2lmpW71Gq1ybWV3QqOZ2PZxEewGJDwogx7l6POgvHwW5Yz6Y6
         yr9RQiB+9vebLWeTXrlIhUgoVFVHpoGXoHMA0WI8aN9W/wp3A5YxPKTZbCx9vMN1L09C
         1XjKi7PkySA/t1nZjnqBJE3/fFerY75U16hp3kqgNFoSVHS9R1wawqayF03DiNipDcBd
         vEkHgvdPGO4RdjqDgc4EKmby6oHaA2AJdH7Er+1Rdu8Pd4ygXRL03MGCF4xJsma+OB9N
         eppQ4I7ie0oa6hdCvvvYuJCYy9J59pGVp3Kh9D4I9qCgdmYdmS98pX2liIvhBnLaKwh4
         HRRw==
X-Gm-Message-State: ALoCoQmB9JwQx2j3Rig/V4AoV6S1r9y9xAKg57iHE5YGJfaAhEH4gMsm0cXJRrDHDUNAwkGCtAqy
X-Received: by 10.112.180.225 with SMTP id dr1mr2200719lbc.51.1400251966370;
        Fri, 16 May 2014 07:52:46 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.52.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:52:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249322>

The valid_patchname now lets "git check-ref-format" do its job instead
of trying (and failing) to implement the same rules.  See
git-check-ref-format(1) for a list of the rules.

Refer to the git-check-ref-format(1) man page in the error messages
produced when valid_patchname indicates that the name is bad.

Added testcases that breaks most of the rules in that man-page.

Git version 1.8.5 no longer allows the single character "@" as a
branch name.  Guilt always rejects that name, for increased
compatibility.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt                |  21 ++-
 guilt-fork           |   2 +-
 guilt-import         |   2 +-
 guilt-new            |   2 +-
 regression/t-025.out | 426 +++++++++++++++++++++++++++++++++++++++++++++++++--
 regression/t-025.sh  |  12 +-
 regression/t-032.out |   4 +-
 7 files changed, 446 insertions(+), 23 deletions(-)

diff --git a/guilt b/guilt
index 3fc524e..23cc2da 100755
--- a/guilt
+++ b/guilt
@@ -132,14 +132,19 @@ fi
 # usage: valid_patchname <patchname>
 valid_patchname()
 {
-	case "$1" in
-		/*|./*|../*|*/./*|*/../*|*/.|*/..|*/|*\ *|*\	*)
-			return 1;;
-		*:*)
-			return 1;;
-		*)
-			return 0;;
-	esac
+	if git check-ref-format --allow-onelevel "$1"; then
+		# Starting with Git version 1.8.5, a branch cannot be
+		# the single character "@".  Make sure guilt rejects
+		# that name even if we are currently using an older
+		# version of Git.  This ensures that the test suite
+		# runs fine using any version of Git.
+		if [ "$1" = "@" ]; then
+			return 1
+		fi
+		return 0
+	else
+		return 1
+	fi
 }
 
 get_branch()
diff --git a/guilt-fork b/guilt-fork
index a85d391..6447e55 100755
--- a/guilt-fork
+++ b/guilt-fork
@@ -37,7 +37,7 @@ else
 fi
 
 if ! valid_patchname "$newpatch"; then
-	die "The specified patch name contains invalid characters (:)."
+	die "The specified patch name is invalid according to git-check-ref-format(1)."
 fi
 
 if [ -e "$GUILT_DIR/$branch/$newpatch" ]; then
diff --git a/guilt-import b/guilt-import
index 3e9b3bb..928e325 100755
--- a/guilt-import
+++ b/guilt-import
@@ -40,7 +40,7 @@ if [ -e "$GUILT_DIR/$branch/$newname" ]; then
 fi
 
 if ! valid_patchname "$newname"; then
-	die "The specified patch name contains invalid characters (:)."
+	die "The specified patch name is invalid according to git-check-ref-format(1)."
 fi
 
 # create any directories as needed
diff --git a/guilt-new b/guilt-new
index 9528438..9f7fa44 100755
--- a/guilt-new
+++ b/guilt-new
@@ -64,7 +64,7 @@ fi
 
 if ! valid_patchname "$patch"; then
 	disp "Patchname is invalid." >&2
-	die "it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace"
+	die "It must follow the rules in git-check-ref-format(1)."
 fi
 
 # create any directories as needed
diff --git a/regression/t-025.out b/regression/t-025.out
index 7811ab1..01bc406 100644
--- a/regression/t-025.out
+++ b/regression/t-025.out
@@ -141,7 +141,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new white space
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -211,7 +211,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new /abc
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -235,7 +235,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new ./blah
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -259,7 +259,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new ../blah
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -283,7 +283,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new abc/./blah
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -307,7 +307,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new abc/../blah
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -331,7 +331,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new abc/.
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -355,7 +355,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new abc/..
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
@@ -379,7 +379,415 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
 r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
 % guilt new abc/
 Patchname is invalid.
-it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new abc.lock
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new a/b.lock/c
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new cr
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new ctrl-a
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new formfeed
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new del
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new tilde~
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new caret^
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new colon:
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new questionmark?
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new asterisk*
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new open[bracket
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new consecutive//slashes
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new trailing-dot.
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new bad@{seq
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new @
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/patches/master/dir
+d .git/patches/master/dir/subdir
+d .git/refs/patches
+d .git/refs/patches/master
+d .git/refs/patches/master/dir
+d .git/refs/patches/master/dir/subdir
+f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
+r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
+% guilt new backslash\
+Patchname is invalid.
+It must follow the rules in git-check-ref-format(1).
 % list_files
 d .git/patches
 d .git/patches/master
diff --git a/regression/t-025.sh b/regression/t-025.sh
index 985fed4..8c439fc 100755
--- a/regression/t-025.sh
+++ b/regression/t-025.sh
@@ -43,7 +43,17 @@ shouldfail guilt new "white space"
 
 cmd list_files
 
-for pname in prepend mode /abc ./blah ../blah abc/./blah abc/../blah abc/. abc/.. abc/ ; do
+b()
+{
+    printf "%b" "$1"
+}
+
+for pname in prepend mode /abc ./blah ../blah abc/./blah abc/../blah abc/. \
+	abc/.. abc/ abc.lock a/b.lock/c `b 'cr\r'` `b 'ctrl-a\001'` \
+	`b 'formfeed\f'` `b 'del\177'` "tilde~" "caret^" "colon:" \
+	"questionmark?" "asterisk*" "open[bracket" "consecutive//slashes" \
+	"trailing-dot." "bad@{seq" "@" "backslash\\"
+do
 	shouldfail guilt new "$pname"
 
 	cmd list_files
diff --git a/regression/t-032.out b/regression/t-032.out
index 53f0370..4e65db0 100644
--- a/regression/t-032.out
+++ b/regression/t-032.out
@@ -1,7 +1,7 @@
 % setup_repo
 % touch foo foo:baz
 % guilt import -P foo:bar foo
-The specified patch name contains invalid characters (:).
+The specified patch name is invalid according to git-check-ref-format(1).
 % guilt import -P foo:bar foo2
 Specified file does not exist.
 % guilt import -P foo foo2
@@ -15,4 +15,4 @@ Already tracking a patch under that name.
 Already tracking a patch under that name.
 % guilt import -P foo,bar foo
 % guilt import foo:baz
-The specified patch name contains invalid characters (:).
+The specified patch name is invalid according to git-check-ref-format(1).
-- 
1.8.3.1

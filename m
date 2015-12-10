From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: [PATCH] rebase: add --verify-signatures
Date: Thu, 10 Dec 2015 14:03:48 +0100
Message-ID: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 13:56:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a70lz-00029o-3m
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 13:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbbLJM4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 07:56:35 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33859 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbLJM4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 07:56:33 -0500
Received: by mail-wm0-f50.google.com with SMTP id v187so31743565wmv.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 04:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=v1R4k9VbnI5L+WH5pprOCBVuReq4lM6Tzzhjszc5iyI=;
        b=tZlYzV8YeTKtGWcOyaqJVu1+IyskG/FIBuvA7qzlUWE3r4O88DbijDrr2mHEo1IvNw
         +Pd3RnZuCW0+L5B7EITmtJxAbIvoouc9H9DLD+IGXqhHPw/pDDE8HLqoPcU5wiytKYnI
         kBLJBEYJ5PZnTiN3auBZJZX/dq7To2ApZY28EpuMFyT8xjbtqJx2z6nMsP1e8PHFqfzh
         REICtsrx4YgPg8SwgbwVbECOr6Eg1xZCNRznOAxq8msAQq5ayxwciGh/cw9WXrKqkbdm
         JW/5Z/r+wYfbtDb1+94ZmKtzlCZLPxQhFUVG9BPg6UKYYE7vK7YlIQB+qNX+B0Cy8dFS
         F+cA==
X-Received: by 10.28.85.129 with SMTP id j123mr19235981wmb.77.1449752192429;
        Thu, 10 Dec 2015 04:56:32 -0800 (PST)
Received: from netblarch.tu-darmstadt.de ([2001:41b8:83c:ff04:9da7:8085:e9b4:8150])
        by smtp.gmail.com with ESMTPSA id h7sm12752203wmf.0.2015.12.10.04.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2015 04:56:31 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282216>

This option works analogous to --verify-signatures for git-merge by
checking that the commits, that are rebased onto, have good GPG
signatures.

Additionally, git-pull now forwards --verify-signatures to rebase as
well.

Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
---

I'm unsure if the opt_verify_signatures check in builtin/pull.c should
be moved up to the "/* Shared options */" now.

The output strings from the GPG check are identical to the ones in
builtin/merge.c; I am unsure about the implications for l10n.

The test is mostly copied from t7612-merge-verify-signatures.sh.

 Documentation/git-rebase.txt        |  6 ++++
 builtin/pull.c                      |  2 ++
 git-rebase.sh                       | 44 +++++++++++++++++++++++++
 t/t3427-rebase-verify-signatures.sh | 65 +++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100755 t/t3427-rebase-verify-signatures.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6cca8bb..959b12b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -292,6 +292,12 @@ which makes little sense.
 	specified, `-s recursive`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
 
+--verify-signatures::
+--no-verify-signatures::
+	Verify that the commits in the branch the rebase is onto, but not
+	present in the working branch, have good GPG signatures and abort the
+	operation in case they do not.
+
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign commits. The `keyid` argument is optional and
diff --git a/builtin/pull.c b/builtin/pull.c
index bf3fd3f..37ec0f8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -774,6 +774,8 @@ static int run_rebase(const unsigned char *curr_head,
 		argv_array_push(&args, "--preserve-merges");
 	if (opt_diffstat)
 		argv_array_push(&args, opt_diffstat);
+	if (opt_verify_signatures)
+		argv_array_push(&args, opt_verify_signatures);
 	argv_array_pushv(&args, opt_strategies.argv);
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
diff --git a/git-rebase.sh b/git-rebase.sh
index af7ba5f..dcfbc3a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -38,6 +38,7 @@ whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
 S,gpg-sign?        GPG-sign commits
+verify-signatures  verify that the commits of onto have valid GPG signatures
  Actions:
 continue!          continue
 abort!             abort and check out the original branch
@@ -88,6 +89,7 @@ autosquash=
 keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 gpg_sign_opt=
+verify_signatures=
 
 read_basic_state () {
 	test -f "$state_dir/head-name" &&
@@ -339,6 +341,12 @@ do
 	--gpg-sign=*)
 		gpg_sign_opt="-S${1#--gpg-sign=}"
 		;;
+	--verify-signatures)
+		verify_signatures=t
+		;;
+	--no-verify-signatures)
+		verify_signatures=
+		;;
 	--)
 		shift
 		break
@@ -594,6 +602,42 @@ then
 	fi
 fi
 
+if test "$verify_signatures"
+then
+	if test -n "$rebase_root"
+	then
+		foreign_revisions="$orig_head..$onto"
+	else
+		foreign_revisions="$orig_head..${restrict_revision-$upstream}"
+	fi
+
+	for cmt in $(git rev-list --reverse "$foreign_revisions")
+	do
+		if ! git log -1 --pretty=format:'%G?%n%GS' "$cmt" |
+		(
+			read cmt_sig
+			read cmt_signer
+			case "$cmt_sig" in
+			'G')
+				;;
+			'U')
+				die "$(gettext "Commit $cmt has an untrusted GPG signature, allegedly by $cmt_signer.")"
+				;;
+			'B')
+				die "$(gettext "Commit $cmt has a bad GPG signature allegedly by $cmt_signer.")"
+				;;
+			*) #'N'
+				die "$(gettext "Commit $cmt does not have a GPG signature.")"
+				;;
+			esac
+			test "$verbose" && test 'G' = "$cmt_sig" && echo "Commit $cmt has a good GPG signature by $cmt_signer."
+		)
+		then
+			exit 1
+		fi
+	done
+fi
+
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
 
diff --git a/t/t3427-rebase-verify-signatures.sh b/t/t3427-rebase-verify-signatures.sh
new file mode 100755
index 0000000..1bd0a4d
--- /dev/null
+++ b/t/t3427-rebase-verify-signatures.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='rebase signature verification tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create signed commits' '
+	echo 1 >file && git add file &&
+	test_tick && git commit -m initial &&
+	git tag initial &&
+
+	git checkout -b side-signed &&
+	echo 3 >elif && git add elif &&
+	test_tick && git commit -S -m "signed on side" &&
+	git checkout initial &&
+
+	git checkout -b side-unsigned &&
+	echo 3 >foo && git add foo &&
+	test_tick && git commit -m "unsigned on side" &&
+	git checkout initial &&
+
+	git checkout -b side-bad &&
+	echo 3 >bar && git add bar &&
+	test_tick && git commit -S -m "bad on side" &&
+	git cat-file commit side-bad >raw &&
+	sed -e "s/bad/forged bad/" raw >forged &&
+	git hash-object -w -t commit forged >forged.commit &&
+	git checkout initial &&
+
+	git checkout -b side-untrusted &&
+	echo 3 >baz && git add baz &&
+	test_tick && git commit -SB7227189 -m "untrusted on side" &&
+
+	git checkout master
+'
+
+test_expect_success GPG 'rebase unsigned commit with verification' '
+	test_must_fail git rebase --verify-signatures side-unsigned 2>rebaseerror &&
+	test_i18ngrep "does not have a GPG signature" rebaseerror
+'
+
+test_expect_success GPG 'rebase commit with bad signature with verification' '
+	test_must_fail git rebase --verify-signatures $(cat forged.commit) 2>rebaseerror &&
+	test_i18ngrep "has a bad GPG signature" rebaseerror
+'
+
+test_expect_success GPG 'rebase commit with untrusted signature with verification' '
+	test_must_fail git rebase --verify-signatures side-untrusted 2>rebaseerror &&
+	test_i18ngrep "has an untrusted GPG signature" rebaseerror
+'
+
+test_expect_success GPG 'rebase signed commit with verification' '
+	git rebase --verbose --verify-signatures side-signed >rebaseoutput &&
+	test_i18ngrep "has a good GPG signature" rebaseoutput
+'
+
+test_expect_success GPG 'rebase commit with bad signature without verification (implicit)' '
+	git rebase $(cat forged.commit)
+'
+
+test_expect_success GPG 'rebase commit with bad signature without verification (explicit)' '
+	git rebase --no-verify-signatures $(cat forged.commit)
+'
+
+test_done
-- 
2.6.3

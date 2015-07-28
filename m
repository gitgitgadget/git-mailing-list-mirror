From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] am: let command-line options override saved options
Date: Wed, 29 Jul 2015 00:43:11 +0800
Message-ID: <20150728164311.GA1948@yoshi.chippynet.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
 <20150724180921.GA17730@peff.net>
 <CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
 <xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:43:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7yX-0007Ul-PU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbbG1QnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:43:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34374 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbbG1QnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:43:19 -0400
Received: by pacan13 with SMTP id an13so73883019pac.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jKNxyHBsQfZqaoQkhLapmoqOeJ0px1ga/EG/ohFN99s=;
        b=GEUmT++QAuz62HT8DikGU+5cH/ynGSwIsbXpP3AfV/A8zCwvPBOTsXPZMLv9EccFhN
         tWedG3ziZXiuLHckGpslXKqdmRIph+QJmTSWInmrnboQtG7D5PmveCUrSsdDTHwIt5RD
         pBM+JrfLrMkWh1KfLLR0VUsFW6QXIZejwdOWTyDVJhwgzUX77ieuvqDQRvKwlcZVgr3J
         zyZ60wzKqjRrXTEtsKwOoDoigpZw49dtdpyBvqx59vU3xFLgQQq2eTDkhdyU5BSF+a+c
         NqWl7ZbaxKJl5w20askiZXMJl9/vuWFah92qrTSWHlLwCTEudfm8UoVACPJvSzroOf2w
         ioXg==
X-Received: by 10.66.221.226 with SMTP id qh2mr83919707pac.64.1438101798637;
        Tue, 28 Jul 2015 09:43:18 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id qo6sm36327527pab.23.2015.07.28.09.43.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 09:43:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274789>

When resuming, git-am ignores command-line options. For instance, when a
patch fails to apply with "git am patch", subsequently running "git am
--3way patch" would not cause git-am to fall back on attempting a
threeway merge. This occurs because by default the --3way option is
saved as "false", and the saved am options are loaded after the
command-line options are parsed, thus overwriting the command-line
options when resuming.

Fix this by moving the am_load() function call before parse_options(),
so that command-line options will override the saved am options.

Reported-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c                       |   9 ++-
 t/t4153-am-resume-override-opts.sh | 144 +++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 3 deletions(-)
 create mode 100755 t/t4153-am-resume-override-opts.sh

diff --git a/builtin/am.c b/builtin/am.c
index 1116304..8a0b0e4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2131,6 +2131,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
+	int in_progress;
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
@@ -2226,6 +2227,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	am_state_init(&state, git_path("rebase-apply"));
 
+	in_progress = am_in_progress(&state);
+	if (in_progress)
+		am_load(&state);
+
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (binary >= 0)
@@ -2238,7 +2243,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-	if (am_in_progress(&state)) {
+	if (in_progress) {
 		/*
 		 * Catch user error to feed us patches when there is a session
 		 * in progress:
@@ -2256,8 +2261,6 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 		if (resume == RESUME_FALSE)
 			resume = RESUME_APPLY;
-
-		am_load(&state);
 	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
new file mode 100755
index 0000000..c49457c
--- /dev/null
+++ b/t/t4153-am-resume-override-opts.sh
@@ -0,0 +1,144 @@
+#!/bin/sh
+
+test_description='git-am command-line options override saved options'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial file &&
+	test_commit first file &&
+
+	git checkout -b side initial &&
+	test_commit side-first file &&
+	test_commit side-second file &&
+
+	{
+		echo "Message-Id: <side-first@example.com>" &&
+		git format-patch --stdout -1 side-first | sed -e "1d"
+	} >side-first.patch &&
+	{
+		sed -ne "1,/^\$/p" side-first.patch &&
+		echo "-- >8 --" &&
+		sed -e "1,/^\$/d" side-first.patch
+	} >side-first.scissors &&
+
+	{
+		echo "Message-Id: <side-second@example.com>" &&
+		git format-patch --stdout -1 side-second | sed -e "1d"
+	} >side-second.patch &&
+	{
+		sed -ne "1,/^\$/p" side-second.patch &&
+		echo "-- >8 --" &&
+		sed -e "1,/^\$/d" side-second.patch
+	} >side-second.scissors
+'
+
+test_expect_success '--3way, --no-3way' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --3way side-first.patch side-second.patch &&
+	test -n "$(git ls-files -u)" &&
+	echo will-conflict >file &&
+	git add file &&
+	test_must_fail git am --no-3way --continue &&
+	test -z "$(git ls-files -u)"
+'
+
+test_expect_success '--no-quiet, --quiet' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --no-quiet side-first.patch side-second.patch &&
+	test_must_be_empty out &&
+	echo side-first >file &&
+	git add file &&
+	git am --quiet --continue >out &&
+	test_must_be_empty out
+'
+
+test_expect_success '--signoff, --no-signoff' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --signoff side-first.patch side-second.patch &&
+	echo side-first >file &&
+	git add file &&
+	git am --no-signoff --continue &&
+
+	# applied side-first will be signed off
+	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
+	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
+	test_cmp expected actual &&
+
+	# applied side-second will not be signed off
+	test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
+'
+
+test_expect_success '--keep, --no-keep' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --keep side-first.patch side-second.patch &&
+	echo side-first >file &&
+	git add file &&
+	git am --no-keep --continue &&
+
+	# applied side-first will keep the subject
+	git cat-file commit HEAD^ >actual &&
+	grep "^\[PATCH\] side-first" actual &&
+
+	# applied side-second will not have [PATCH]
+	git cat-file commit HEAD >actual &&
+	! grep "^\[PATCH\] side-second" actual
+'
+
+test_expect_success '--message-id, --no-message-id' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --message-id side-first.patch side-second.patch &&
+	echo side-first >file &&
+	git add file &&
+	git am --no-message-id --continue &&
+
+	# applied side-first will have Message-Id
+	test -n "$(git cat-file commit HEAD^ | grep Message-Id)" &&
+
+	# applied side-second will not have Message-Id
+	test -z "$(git cat-file commit HEAD | grep Message-Id)"
+'
+
+test_expect_success '--scissors, --no-scissors' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --scissors side-first.scissors side-second.scissors &&
+	echo side-first >file &&
+	git add file &&
+	git am --no-scissors --continue &&
+
+	# applied side-first will not have scissors line
+	git cat-file commit HEAD^ >actual &&
+	! grep "^-- >8 --" actual &&
+
+	# applied side-second will have scissors line
+	git cat-file commit HEAD >actual &&
+	grep "^-- >8 --" actual
+'
+
+test_expect_success '--reject, --no-reject' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	rm -f file.rej &&
+	test_must_fail git am --reject side-first.patch side-second.patch &&
+	test_path_is_file file.rej &&
+	rm -f file.rej &&
+	echo will-conflict >file &&
+	git add file &&
+	test_must_fail git am --no-reject --continue &&
+	test_path_is_missing file.rej
+'
+
+test_done
-- 
2.5.0.77.gd180035

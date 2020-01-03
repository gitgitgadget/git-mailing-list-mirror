Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FDC2D0CE
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 04:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F7921D7D
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 04:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgACEcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:32:20 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:46357 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgACEcU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 23:32:20 -0500
Received: by mail-qt1-f177.google.com with SMTP id g1so29204427qtr.13
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 20:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDMxBOIFXk/wT+LKSebRtq0lmt0iM1dFeHtrisswehY=;
        b=oFWZb2pmcCa/S1YwqO8sbjZ2bKi3lZ7iXvM1fAdvbmcKzn8SR9vmifS7BbPOVAci/L
         JUWs3VkXbrTRALfJeK/ukXSDevqb1dQtBu2p5/TLkABj12k/IZyV130dD7BShnv27qDX
         BJ7Juy6ZhFoG1imnKNrWHHlHugDjB7G+tlW0EW4LDekvR3vQGB9AvowzvWs4Q+2+BLSb
         wKOeUA/iAefc+GhB+E9MICWuazp2uSceuMXYaU7KpITtyqP93zB7J4GPTLknZ+Lc5H2R
         kwzzJDYotqhcE9wkVQJl6t3R91ximcsF+ZpM5MmK9LMxu4lVCImJW7SUMx4V0OTijFhI
         Eiyg==
X-Gm-Message-State: APjAAAWuTUVkdGj7Pykj7adEMZGk6//QPWvZnxa7SqTHjw29FXjGurUN
        3TBTzjhO4GhDfT2oazY+jcU9rtOVJ7EYdA==
X-Google-Smtp-Source: APXvYqycxHyTLnWQnJs10n2E06plfglxmCR7QoKINFIraOA2+aQLlpF00okoyEVdAtIcrN2qePbNmg==
X-Received: by 2002:ac8:704e:: with SMTP id y14mr62559873qtm.279.1578025938712;
        Thu, 02 Jan 2020 20:32:18 -0800 (PST)
Received: from zen.ob.lan (pool-72-94-157-225.phlapa.fios.verizon.net. [72.94.157.225])
        by smtp.googlemail.com with ESMTPSA id m10sm15756679qki.74.2020.01.02.20.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 20:32:17 -0800 (PST)
From:   Stephen Oberholtzer <stevie@qrpff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stephen Oberholtzer <stevie@qrpff.net>
Subject: [RFC PATCH] bisect run: allow inverting meaning of exit code
Date:   Thu,  2 Jan 2020 23:30:28 -0500
Message-Id: <20200103043027.4537-1-stevie@qrpff.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This is obviously not ready for merging; I just wanted to
get feedback.

In particular, I expect some bikeshedding on the specific option
names (-r, --invert, --expect).  I'm probably going to change
`--expect` to `--success`, in fact.

If we can come to a consensus on the names (and, of course, on the
feature itself), I'll clean up the tests, remove the debug output,
update the documentation, then resubmit.

>8------------------------------------------------------8<


If your automated test naturally yields zero for _old_/_good_,
1-124 or 126-127 for _new_/_bad_, then you're set.

If that logic is reversed, however, it's a bit more of a pain: you
can't just stick a `sh -c !` in front of your command, because that
doesn't account for exit codes 125 or 129-255.

This commit enhances `git bisect run` as follows:

* '--' can be used as an option list terminator,
  just as everywhere else.

* The treatment of the exit code can be selected via an option:

  - No option, of course, treats 0 as _old_/_good_
  - `-r` (for reverse) treats 0 as _new_/_bad_
  - `--invert` is the long form for `-r`
  - `--expect=<term>` treats 0 as <term>

You're not allowed to specify more than one expectation.

Note that this lets one specify `--expect=good` as an explicit
selection of the default behavior.  This is intentional.

Signed-off-by: Stephen Oberholtzer <stevie@qrpff.net>
---
 git-bisect.sh         |  33 +++++++++-
 t/t6071-bisect-run.sh | 142 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100755 t/t6071-bisect-run.sh

diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..dbeb213846 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -26,7 +26,7 @@ git bisect replay <logfile>
 	replay bisection log.
 git bisect log
 	show bisect log.
-git bisect run <cmd>...
+git bisect run [--expect=<term> | -r | --invert] [--] <cmd>...
 	use <cmd>... to automatically bisect.
 
 Please use "git help bisect" to get the full man page.'
@@ -238,6 +238,31 @@ bisect_replay () {
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
+	SUCCESS_TERM=$TERM_GOOD
+	FAIL_TERM=$TERM_BAD
+	INVERT_SET=
+	while [ "$1" != "${1#-}" ]; do
+		case "$1" in
+		--)
+			shift
+			break ;;
+		--expect=$TERM_GOOD)
+			[ -z "$INVERT_SET" ] || die "$(gettext "bisect run: multiple expect options specified")"
+			INVERT_SET=1 ;;
+		-r|--invert|--expect=$TERM_BAD)
+			[ -z "$INVERT_SET" ] || die "$(gettext "bisect run: multiple expect options specified")"
+			SUCCESS_TERM=$TERM_BAD
+			FAIL_TERM=$TERM_GOOD
+			INVERT_SET=1 ;;
+		--expect=*)
+			# how to localize part 2?
+			die "$(printf "$(gettext "bisect run: invalid --expect value, use --expect=%s or --expect=%s")" "$TERM_GOOD" "$TERM_BAD")" ;;
+		*)
+			die "$(printf "$(gettext "bisect run: invalid option: %s")" "$1")" ;;
+		esac
+		shift
+	done
+
 	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
 
 	while true
@@ -262,11 +287,13 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state='skip'
 		elif [ $res -gt 0 ]
 		then
-			state="$TERM_BAD"
+			state="$FAIL_TERM"
 		else
-			state="$TERM_GOOD"
+			state="$SUCCESS_TERM"
 		fi
 
+		echo "exit code $res means this commit is $state"
+
 		# We have to use a subshell because "bisect_state" can exit.
 		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
 		res=$?
diff --git a/t/t6071-bisect-run.sh b/t/t6071-bisect-run.sh
new file mode 100755
index 0000000000..2708e0f854
--- /dev/null
+++ b/t/t6071-bisect-run.sh
@@ -0,0 +1,142 @@
+# verify that unrecognized options are rejected by 'git bisect run'
+#!/bin/sh
+
+# the linter's not smart enough to handle set -e
+GIT_TEST_CHAIN_LINT=0
+
+test_description='Tests git bisect run'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+{ test_expect_success 'Setting up repo for "git bisect run" tests.' "$(cat)" ; } <<'SETUP'
+(
+# I don't know how they managed it, but the git test engine
+# somehow ignores the effect of 'set -e'.
+set -eu || exit 1
+# set -e canary
+false
+# hopefully, next year, we get -o pipefail!
+echo '.DEFAULT: dummy
+.PHONY: dummy
+dummy:
+	true
+' > Makefile
+make
+echo '0' >path0
+git update-index --add -- Makefile path0
+git commit -q -m 'initial commit'
+git tag working0
+# make some commits that don't cause problems
+for x in `test_seq 1 20`; do
+	echo "$x" >path0
+	git update-index --replace -- path0
+	git commit -q -m "working commit $x"
+	git tag "working$x"
+done
+# break the makefile
+sed -i.bak -e 's/true/false/' Makefile
+rm -f Makefile.bak
+! make
+git update-index --replace -- Makefile
+git commit -q -m "First broken commit"
+git tag broken0
+# make some more commits that still FTBFS
+echo "exit code was $?; flags are $-"
+for x in `test_seq 1 20`; do
+	echo "$x" >path0
+	git update-index --replace -- path0
+	git commit -q -m "broken build $x"
+	git tag "broken$x"
+done
+# repair it
+git checkout working0 -- Makefile
+make
+git update-index --replace -- Makefile
+git commit -q -m "First repaired commit"
+git tag fixed0
+# make some more commits with the bugfix
+for x in `test_seq 1 20`; do
+	echo "$x" >path0
+	git update-index --replace -- path0
+	git commit -q -m "fixed build $x"
+	git tag "fixed$x"
+done
+#sh -c 'bash -i <> /dev/tty >&0 2>&1'
+)
+
+SETUP
+
+test_expect_success 'setup first bisect' 'git bisect start && git bisect good working0 && git bisect bad broken9'
+
+test_expect_failure() {
+	shift
+	#echo arguments are "$*"
+	test_must_fail "$@"
+}
+
+# okay, let's do some negative testing
+
+OLDPATH="$PATH"
+
+PATH="$PATH:."
+
+test_expect_success 'setup this-is-not-a-valid-option' '
+ echo "#/bin/sh" > --this-is-not-a-valid-option &&
+ chmod a+x -- --this-is-not-a-valid-option &&
+ --this-is-not-a-valid-option'
+
+test_expect_failure 'git bisect run: reject unrecognized options' git bisect run --this-is-not-a-valid-option
+
+PATH="$OLDPATH"
+
+test_expect_failure 'git bisect run: reject invalid values for --expect'  git bisect run --expect=invalid make
+
+# okay, all of these settings are mutually exclusive (for sanity's sake, even with themselves)
+for a in --expect=bad --expect=good -r --invert; do
+	for b in --expect=bad --expect=good -r --invert; do
+		test_expect_failure 'git bisect run: reject multiple --expect options'  git bisect run $a $b make
+	done
+done
+
+# finally, verify that '--' is honored (note that will mess things up and require a bisect reset)
+PATH="$PATH:."
+
+test_expect_success 'git bisect run: honor --' 'git bisect run -- --this-is-not-a-valid-option'
+
+PATH="$OLDPATH"
+
+for expect_syntax in '' --expect=good; do
+
+	# now we have to undo the bisect run
+	test_expect_success 'restarting bisection' 'git bisect reset && git bisect start && git bisect good working0 && git bisect bad broken9'
+
+	test_expect_success "running bisection ($expect_syntax)" "
+git bisect run $expect_syntax make &&
+git log --oneline &&
+	# we should have determined that broken0 is the first bad version
+	test_cmp_rev broken0 refs/bisect/bad &&
+	# and that version should be the one checked out
+	test_cmp_rev broken0 HEAD
+"
+done
+
+
+# NOW, test the reverse:  find when we fixed it again
+
+for expect_syntax in -r --invert --expect=fixed; do
+
+	test_expect_success 'restarting bisection' 'git bisect reset && git bisect start --term-old=broken --term-new=fixed && git bisect broken broken20 && git bisect fixed fixed20'
+	test_expect_success "running bisection ($expect_syntax)" "
+		git bisect run $expect_syntax make &&
+		git log --oneline &&
+	test_cmp_rev fixed0 refs/bisect/fixed &&
+	test_cmp_rev fixed0 HEAD
+	"
+done
+
+test_expect_failure 'sanity check error message with custom terms' git bisect run --expect=invalid make
+
+
+test_done
-- 
2.20.1


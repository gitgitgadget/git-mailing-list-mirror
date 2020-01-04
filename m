Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745EC32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 03:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2472721D7D
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 03:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgADDqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:46:06 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:44219 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgADDqF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 22:46:05 -0500
Received: by mail-qk1-f174.google.com with SMTP id w127so35324712qkb.11
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 19:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLQshGPRsk+xRS6QxwXpEV9ykbNcKkdr+J6s0W120so=;
        b=IcHvIAKIXV64npr6N5OegClatzgIducR5qIxjRzCR16IatbAH8csE+QU+O/TTWyjlR
         PcRhJYwpJdak0M506bjNGLGSmOppJ9DS6GsMp6pZFELcSX9SCpOYVUXVH2B5G6FMUKms
         lENXGDuxRgyQAcc4twGCn+K90wEFRDQ83QKxhLFC2S73JxECEBPc6D67vhKa4LCh/NJd
         WyAmlj0VivWroW8Y9ZljqMSZlMo2XtI7u6lXBrjg3dv7IuDDNk1DiewSPI+IOaBMvloL
         4UDGgF7yNejhJvC3otPLUg8ZDih/H5icLPo0mP2W0ys3BS7uTnrce+W9PQEWuHRTIt1X
         UfTg==
X-Gm-Message-State: APjAAAX3MCgTBMDHeiyQB4vy2NiqSpPyMG7tPa+RX8dRQls1cA3OXaBI
        3XXM5cml871tddHwFklyJscjM8X9tyrhRQ==
X-Google-Smtp-Source: APXvYqzewOSoYqv+iXuPeRxD1d+yuv3CS2gmMcFeS4vE/088dNhaIeRkvzUNKH4xJuqT94zuPssBGg==
X-Received: by 2002:a37:4f8d:: with SMTP id d135mr75329958qkb.455.1578109563866;
        Fri, 03 Jan 2020 19:46:03 -0800 (PST)
Received: from zen.ob.lan (pool-72-94-157-225.phlapa.fios.verizon.net. [72.94.157.225])
        by smtp.googlemail.com with ESMTPSA id l6sm19580528qti.10.2020.01.03.19.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 19:46:02 -0800 (PST)
From:   Stephen Oberholtzer <stevie@qrpff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stephen Oberholtzer <stevie@qrpff.net>
Subject: [PATCH] bisect run: allow '--' as an options terminator
Date:   Fri,  3 Jan 2020 22:45:51 -0500
Message-Id: <20200104034551.23658-1-stevie@qrpff.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'bisect run' feature doesn't currently accept any options, but
it could, and that means a '--' option.

Additionally, this adds an actual test script for bisect run - it
creates a repository with a failed build, then attempts to bisect
the offending commit.

Signed-off-by: Stephen Oberholtzer <stevie@qrpff.net>
---
 Documentation/git-bisect.txt |  2 +-
 git-bisect.sh                | 19 ++++++-
 t/t6071-bisect-run.sh        | 96 ++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 2 deletions(-)
 create mode 100755 t/t6071-bisect-run.sh

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7586c5a843..e72353e157 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect (visualize|view)
  git bisect replay <logfile>
  git bisect log
- git bisect run <cmd>...
+ git bisect run [--] <cmd>...
  git bisect help
 
 This command uses a binary search algorithm to find which commit in
diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..46085651e1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -26,7 +26,7 @@ git bisect replay <logfile>
 	replay bisection log.
 git bisect log
 	show bisect log.
-git bisect run <cmd>...
+git bisect run [--] <cmd>...
 	use <cmd>... to automatically bisect.
 
 Please use "git help bisect" to get the full man page.'
@@ -238,6 +238,23 @@ bisect_replay () {
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
+	# check for options
+	# (there aren't any supported yet, unless you count "--")
+	while test -n "$1"
+	do
+		case "$1" in
+		--)
+			shift
+			break ;;
+		-*)
+			option="$1" # \$1 is not expanded by eval_gettext
+			die "$(eval_gettext "bisect run: invalid option: \$option")" ;;
+		*)
+			break ;;
+		esac
+		shift
+	done
+
 	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
 
 	while true
diff --git a/t/t6071-bisect-run.sh b/t/t6071-bisect-run.sh
new file mode 100755
index 0000000000..e173ca18b3
--- /dev/null
+++ b/t/t6071-bisect-run.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='Tests git bisect run'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+{ test_expect_success 'Setting up repo for "git bisect run" tests.' "$(cat)" ; } <<'SETUP'
+echo '.DEFAULT: dummy
+.PHONY: dummy
+dummy:
+	true
+' > Makefile &&
+make &&
+echo '0' >path0 &&
+git update-index --add -- Makefile path0 &&
+git commit -q -m 'initial commit' &&
+git tag working0 &&
+# make some commits that don't cause problems
+for x in `test_seq 1 20`; do
+	echo "$x" >path0 &&
+	git update-index --replace -- path0 &&
+	git commit -q -m "working commit $x" &&
+	git tag "working$x" || exit 1
+done &&
+# break the makefile
+sed -i.bak -e 's/true/false/' Makefile &&
+rm -f Makefile.bak &&
+! make &&
+git update-index --replace -- Makefile &&
+git commit -q -m "First broken commit" &&
+git tag broken0 &&
+# make some more commits that still FTBFS
+for x in `test_seq 1 20`; do
+	echo "$x" >path0 &&
+	git update-index --replace -- path0 &&
+	git commit -q -m "broken build $x" &&
+	git tag "broken$x" || exit 1
+done &&
+# repair it
+git checkout working0 -- Makefile &&
+make &&
+git update-index --replace -- Makefile &&
+git commit -q -m "First repaired commit" &&
+git tag fixed0 &&
+# make some more commits with the bugfix
+for x in `test_seq 1 20`; do
+	echo "$x" >path0 &&
+	git update-index --replace -- path0 &&
+	git commit -q -m "fixed build $x" &&
+	git tag "fixed$x" || exit 1
+done
+SETUP
+
+test_expect_success 'setup first bisect' 'git bisect start && git bisect good working0 && git bisect bad broken9'
+
+test_expect_failure() {
+	shift
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
+# finally, verify that '--' is honored (note that will mess things up and require a bisect reset)
+PATH="$PATH:."
+
+test_expect_success 'git bisect run: honor --' 'git bisect run -- --this-is-not-a-valid-option'
+
+PATH="$OLDPATH"
+
+# now we have to undo the bisect run
+test_expect_success 'restarting bisection' 'git bisect reset && git bisect start && git bisect good working0 && git bisect bad broken9'
+
+test_expect_success "running bisection" "
+	git bisect run $success_option make &&
+	# we should have determined that broken0 is the first bad version
+	test_cmp_rev broken0 refs/bisect/bad &&
+	# and that version should be the one checked out
+	test_cmp_rev broken0 HEAD
+"
+
+test_done
-- 
2.20.1


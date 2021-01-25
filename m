Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27CC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A5B20719
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbhAYVWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbhAYVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:22:26 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E7C061788
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:21:45 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10PLLgZb032193;
        Tue, 26 Jan 2021 00:21:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611609702; bh=VNjs+5R/gcjyShw0Z/qsQnH64hD1+PKwSbljhSCTeAw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uD+1yAgHmx9inRoRxXw6QjABQsVn4n3N2PUt8/FayIzVNjD26N8EXVorfiVgjbaIL
         y8Eoa/6gT+XmG6q00seapFy03vqZPjkLUNm3HGcpNecWx7LQ3SQtp82Eq+RnWkNMx+
         P8Z1qdiSlio+Rf/FjwsIQLuN0mNsCFckOE4ijAHk=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10PLLgTV032192;
        Tue, 26 Jan 2021 00:21:42 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [PATCH v3 4/4] t7800: new tests of difftool.tabbed feature
Date:   Tue, 26 Jan 2021 00:21:32 +0300
Message-Id: <20210125212132.894458-5-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125212132.894458-1-nicholas@guriev.su>
References: <20210118210003.3071205-1-nicholas@guriev.su>
 <20210125212132.894458-1-nicholas@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few helper functions were put in the script that manage faked binaries in a
temporary directory for $PATH. The helpers restore state before test finish.

Besides, two tests of rewritten prompting were added. "git difftool" now asks
again on incorrect input. Plus, fixed a typo in a test of the --extcmd option.

Signed-off-by: Nicholas Guriev <nicholas@guriev.su>
---
 t/t7800-difftool.sh | 175 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a578b35761..249d7a4821 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -270,6 +270,22 @@ test_expect_success 'difftool last flag wins' '
 	prompt_given "$prompt"
 '
 
+test_expect_success 'ignore unknown input then launch the tool' '
+	difftool_test_setup &&
+	(echo Qwerty && echo Yes) >input &&
+	git difftool branch <input >output &&
+	tail -1 output | grep -q -x -F \
+		"Launch '\''test-tool'\'' [Y/n]? Launch '\''test-tool'\'' [Y/n]? branch"
+'
+
+test_expect_success 'ignore unknown input then skip the tool' '
+	difftool_test_setup &&
+	(echo Qwerty && echo No) >input &&
+	git difftool branch <input >output &&
+	tail -1 output | grep -q -x -F \
+		"Launch '\''test-tool'\'' [Y/n]? Launch '\''test-tool'\'' [Y/n]? "
+'
+
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success 'difftool + mergetool config variables' '
@@ -319,7 +335,7 @@ test_expect_success 'difftool --extcmd=cat' '
 test_expect_success 'difftool --extcmd cat' '
 	echo branch >expect &&
 	echo master >>expect &&
-	git difftool --no-prompt --extcmd=cat branch >actual &&
+	git difftool --no-prompt --extcmd cat branch >actual &&
 	test_cmp expect actual
 '
 
@@ -390,6 +406,163 @@ test_expect_success 'ending prompt input with EOF' '
 	! grep br2 output
 '
 
+prepend_shared_path () {
+	directory="$1"
+	first="${PATH%%:*}"
+	if test "$directory" != "$first"
+	then
+		: ${clean_shared_path=$PATH}
+		PATH="$directory:$PATH"
+		test_when_finished 'PATH=$clean_shared_path'
+	fi
+}
+
+mock_binary () {
+	name="$1" body="$2"
+	prepend_shared_path "$PWD/fake-bin" &&
+	touch run-cmds &&
+	mkdir -p fake-bin &&
+	write_script "fake-bin/$name" <<-EOF &&
+	printf '%s ' $name "\$@" |
+	tr -s '[:space:]' ' ' |
+	sed 's/ \$/\\n/' >>"\$HOME/run-cmds" &&
+	${body:-true}
+	EOF
+	test_when_finished "rm -f fake-bin/$name run-cmds"
+}
+
+test_invoked () {
+	pattern="$1"
+	if ! grep -q -x -e "$pattern" run-cmds
+	then
+		set -- $pattern
+		echo "$1 does not seem to be invoked"
+		echo "entry '$pattern' was not found in the 'run-cmds' file"
+		false
+	fi
+}
+
+test_expect_success 'tabbed mode with --tabbed option' '
+	mock_binary vim &&
+	test_config_global diff.tool vimdiff &&
+	yes | git difftool --tabbed branch | tee actual &&
+	(
+		printf "Viewing 2 files:\n" &&
+		printf "  '\''file'\''\n" &&
+		printf "  '\''file2'\''\n" &&
+		printf "Launch '\''vimdiff'\'' [Y/n]? "
+	) >expect &&
+	test_cmp expect actual &&
+	test_invoked "vim -R -f -c .* file .* file2"
+'
+
+test_expect_success 'tabbed mode with GIT_DIFFTOOL_TABBED environment' '
+	mock_binary vim &&
+	test_config_global diff.tool vimdiff &&
+	yes | GIT_DIFFTOOL_TABBED=yes git difftool branch | tee actual &&
+	(
+		printf "Viewing 2 files:\n" &&
+		printf "  '\''file'\''\n" &&
+		printf "  '\''file2'\''\n" &&
+		printf "Launch '\''vimdiff'\'' [Y/n]? "
+	) >expect &&
+	test_cmp expect actual &&
+	test_invoked "vim -R -f -c .* file .* file2"
+'
+
+test_expect_success 'tabbed mode with difftool.tabbed setting' '
+	mock_binary vim &&
+	test_config_global diff.tool vimdiff &&
+	test_config_global difftool.tabbed 1 &&
+	yes | git difftool branch | tee actual &&
+	(
+		printf "Viewing 2 files:\n" &&
+		printf "  '\''file'\''\n" &&
+		printf "  '\''file2'\''\n" &&
+		printf "Launch '\''vimdiff'\'' [Y/n]? "
+	) >expect &&
+	test_cmp expect actual &&
+	test_invoked "vim -R -f -c .* file .* file2"
+'
+
+test_expect_success 'environment variable wins over config in tabbed mode' '
+	mock_binary vim &&
+	test_config_global diff.tool vimdiff &&
+	test_config_global difftool.tabbed true &&
+	GIT_DIFFTOOL_TABBED=FALSE git difftool -y branch </dev/null >output &&
+	test_must_be_empty output &&
+	test_invoked "vim -R -f -d -c .* file" &&
+	test_invoked "vim -R -f -d -c .* file2"
+'
+
+test_expect_success 'cli option wins over environment in tabbed mode' '
+	mock_binary vim &&
+	test_config_global diff.tool vimdiff &&
+	GIT_DIFFTOOL_TABBED=1 git difftool -y --no-tabbed branch </dev/null >output &&
+	test_must_be_empty output &&
+	test_invoked "vim -R -f -d -c .* file" &&
+	test_invoked "vim -R -f -d -c .* file2"
+'
+
+test_expect_success 'say no in tabbed mode' '
+	mock_binary meld &&
+	yes no | git difftool -t meld --tabbed branch &&
+	! test_invoked "meld\\>.*"
+'
+
+test_expect_success 'no tabbed mode for single file' '
+	mock_binary meld &&
+	git difftool -y -t meld --tabbed branch file &&
+	test_invoked "meld \\S\\+ file"
+'
+
+test_expect_success 'both --tabbed and --trust-exit-code options' '
+	mock_binary meld false &&
+	test_config_global diff.tool meld &&
+	test_config_global difftool.prompt false &&
+	test_must_fail git difftool --tabbed --trust-exit-code branch >output &&
+	test_must_be_empty output &&
+	test_invoked "meld --diff \\S\\+ file --diff \\S\\+ file2"
+'
+
+test_expect_success 'tempdir is still clean after successful tabbed mode' '
+	mock_binary meld &&
+	mkdir tempdir &&
+	test_when_finished "rm -r tempdir" &&
+	TMPDIR="$PWD/tempdir" git difftool -y -t meld --tabbed branch &&
+	test_dir_is_empty tempdir
+'
+
+test_expect_success 'tempdir is still clean after failed tabbed mode' '
+	mock_binary meld false &&
+	mkdir tempdir &&
+	test_when_finished "rm -r tempdir" &&
+	TMPDIR="$PWD/tempdir" git difftool -y -t meld --tabbed branch &&
+	test_dir_is_empty tempdir
+'
+
+test_background () {
+	# https://stackoverflow.com/a/45112755/5000805
+	set -m
+	"$@" &
+	set +m
+}
+
+# Create a named queue for synchronizing. Our test process will get blocked on
+# "echo line" until faked meld reaches "cat chain", and so we do not kill early.
+test_expect_success PIPE 'tempdir is still clean after SIGTERM in tabbed mode' '
+	mkfifo chan &&
+	mock_binary meld "while true; do cat chan; done" &&
+	mkdir tempdir &&
+	test_when_finished "rm -r tempdir" &&
+	test_background env TMPDIR="$PWD/tempdir" \
+		git difftool -y -t meld --tabbed branch &&
+	echo line >chan &&
+	kill -TERM -$! &&
+	wait && # for clean up
+	test_dir_is_empty tempdir
+'
+
 test_expect_success 'difftool --tool-help' '
 	git difftool --tool-help >output &&
 	grep tool output
-- 
2.27.0


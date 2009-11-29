From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] diff: flip the default diff.bwoutputonly to true
Date: Sat, 28 Nov 2009 23:25:29 -0800
Message-ID: <7viqctdc7q.fsf_-_@alter.siamese.dyndns.org>
References: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
 <7vmy25dc9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 08:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEeA9-0000X7-7R
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 08:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbZK2HZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 02:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZK2HZa
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 02:25:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZK2HZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 02:25:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EDDA4A23CE;
	Sun, 29 Nov 2009 02:25:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2a+zk4PMBXXmiFRGztvT/q0jFps=; b=GCzsZf
	LTtHZ9cKFtwLnRt1fvyAoDDppEqbtgNnGhYtVMVkUQ2+qG/UUaWCvWkjDPbWtJ41
	HdDSf4yt3nTi3wO2T3HP8sVr3a55zO0sk+R580Bg4s7L0ptSaFsIwx0V632ryUZh
	Fzm2MoM1K27srxn8o7A+nY1s3CAQc6k3EuzMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3Z1tPw5ZTTxjUEJRWlSz4dBGauWC45N
	DW5xqocDLzxbkIw0+0J2SofjMD4NxDxkcY5UmQmy8EqJpl9QS274GXPcQ6l+OUpI
	guqrsK5mKLl4IR5cbLb9VkBP7/wlmatT7QnwK//hlz+C8pn5gbutbphFDSFHr07g
	PEfTR18sdTY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD505A23CD;
	Sun, 29 Nov 2009 02:25:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B8668A23C9; Sun, 29 Nov 2009
 02:25:30 -0500 (EST)
In-Reply-To: <7vmy25dc9h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 28 Nov 2009 23\:24\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61166062-DCB8-11DE-B2A1-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133997>

This switches the default behaviour of "diff -w/-b" back to the
traditional "ignore whitespace affects only output of patch text, not
status nor diff header", and allows the planned new semantics to be asked
in advance by setting diff.bwoutputonly configuration to false.

Also a loud warning is issued when the configuration is not set at all,
so that we can flip the default later more smoothly.

Update tests to check cases where the configuration is set to true, false
and not set at all; make sure the warning is issued when and only when
necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                       |   23 ++++++++++---
 t/t4015-diff-whitespace.sh   |   70 +++++++++++++++++++++++++++++++++---------
 t/t4040-whitespace-status.sh |   48 ++++++++++++++++++----------
 3 files changed, 103 insertions(+), 38 deletions(-)

diff --git a/diff.c b/diff.c
index 6e7c47c..fb93a22 100644
--- a/diff.c
+++ b/diff.c
@@ -29,7 +29,8 @@ static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
-static int diff_b_w_output_only;
+static int diff_b_w_output_only = 1;
+static int diff_b_w_output_only_given;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -135,6 +136,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "diff.bwoutputonly")) {
+		diff_b_w_output_only_given = 1;
 		diff_b_w_output_only = git_config_bool(var, value);
 		return 0;
 	}
@@ -2521,9 +2523,15 @@ void diff_setup(struct diff_options *options)
 	}
 }
 
+static const char *bw_option_warning =
+	"ignore-whitespace options will stop showing diff headers in later\n"
+	"versions of git; set diff.bwoutputonly to true to keep the old\n"
+	"behaviour, or set.bwoutputonly to false to squelch this message.\n";
+
 int diff_setup_done(struct diff_options *options)
 {
 	int count = 0;
+	int bw_options;
 
 	if (options->output_format & DIFF_FORMAT_NAME)
 		count++;
@@ -2542,11 +2550,14 @@ int diff_setup_done(struct diff_options *options)
 	 * --ignore-whitespace* options force us to look
 	 * inside contents.
 	 */
-
-	if (!diff_b_w_output_only &&
-	    (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
-	     DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
-	     DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL)))
+	bw_options = (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
+		      DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
+		      DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL));
+	if (!diff_b_w_output_only_given && bw_options && bw_option_warning) {
+		warning("%s", bw_option_warning);
+		bw_option_warning = NULL;
+	}
+	if (!diff_b_w_output_only && bw_options)
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 90f3342..310421b 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -92,16 +92,30 @@ EOF
 git diff > out
 test_expect_success 'another test, without options' 'test_cmp expect out'
 
-cat << EOF > expect
+test_w_b () {
+	note=$1
+	for o in "-w" "-w -b" "-w --ignore-space-at-eol" "-w -b --ignore-space-at-eol"
+	do
+		test_expect_success "with $o ($note)" '
+			git diff $o >actual &&
+			test_cmp expect actual
+		'
+	done
+}
+
+git config diff.bwoutputonly false
+> expect
+test_w_b "bwoutputonly=false"
+
+git config diff.bwoutputonly true
+cat <<EOF >expect
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
 EOF
-git diff -w > out
-test_expect_success 'another test, with -w' 'test_cmp expect out'
-git diff -w -b > out
-test_expect_success 'another test, with -w -b' 'test_cmp expect out'
-git diff -w --ignore-space-at-eol > out
-test_expect_success 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
-git diff -w -b --ignore-space-at-eol > out
-test_expect_success 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'
+test_w_b "bwoutputonly=true"
+
+git config --unset diff.bwoutputonly
+test_w_b "bwoutputonly unset"
 
 tr 'Q' '\015' << EOF > expect
 diff --git a/x b/x
@@ -384,20 +398,47 @@ test_expect_success 'checkdiff allows new blank lines' '
 	git diff --check
 '
 
-cat <<EOF >expect
-EOF
-test_expect_success 'whitespace-only changes not reported' '
+test_expect_success 'whitespace-only changes shown' '
+	git config --unset diff.bwoutputonly
 	git reset --hard &&
 	echo >x "hello world" &&
 	git add x &&
 	git commit -m "hello 1" &&
 	echo >x "hello  world" &&
 	git diff -b >actual &&
-	test_cmp expect actual
+	test 2 = $(wc -l <actual)
 '
 
-test_expect_success 'combined diff with autocrlf conversion' '
+test_expect_success 'whitespace-only changes shown with diff.bwoutputonly' '
+	git config diff.bwoutputonly true &&
+	git diff -b >actual &&
+	test 2 = $(wc -l <actual)
+'
+
+test_expect_success 'whitespace-only changes hidden with !diff.bwoutputonly' '
+	git config diff.bwoutputonly false &&
+	git diff -b >actual &&
+	! test -s actual
+'
+
+test_expect_success 'no warning with diff.bwoutputonly given' '
+	git diff -b 2>errors &&
+	! grep warn errors
+'
 
+test_expect_success 'no warning without diff.bwoutputonly' '
+	git config --unset diff.bwoutputonly
+	git diff -p 2>errors &&
+	! grep "stop showing" errors
+'
+
+test_expect_success 'warning without diff.bwoutputonly' '
+	git config --unset diff.bwoutputonly
+	git diff -b 2>errors &&
+	grep "stop showing" errors
+'
+
+test_expect_success 'combined diff with autocrlf conversion' '
 	git reset --hard &&
 	echo >x hello &&
 	git commit -m "one side" x &&
@@ -409,7 +450,6 @@ test_expect_success 'combined diff with autocrlf conversion' '
 
 	git diff | sed -e "1,/^@@@/d" >actual &&
 	! grep "^-" actual
-
 '
 
 test_done
diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index a30b03b..95a93f7 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -19,45 +19,59 @@ test_expect_success setup '
 	git add a/d
 '
 
-test_expect_success 'diff-tree --exit-code' '
+test_once () {
+	note=$1 tmf=$2
+
+test_expect_success "diff-tree --exit-code ($note)" '
 	test_must_fail git diff --exit-code HEAD^ HEAD &&
 	test_must_fail git diff-tree --exit-code HEAD^ HEAD
 '
 
-test_expect_success 'diff-tree -b --exit-code' '
-	git diff -b --exit-code HEAD^ HEAD &&
-	git diff-tree -b -p --exit-code HEAD^ HEAD &&
-	git diff-tree -b --exit-code HEAD^ HEAD
+test_expect_success "diff-tree -b --exit-code ($note)" '
+	$tmf git diff -b --exit-code HEAD^ HEAD &&
+	$tmf git diff-tree -b -p --exit-code HEAD^ HEAD &&
+	$tmf git diff-tree -b --exit-code HEAD^ HEAD
 '
 
-test_expect_success 'diff-index --cached --exit-code' '
+test_expect_success "diff-index --cached --exit-code ($note)" '
 	test_must_fail git diff --cached --exit-code HEAD &&
 	test_must_fail git diff-index --cached --exit-code HEAD
 '
 
-test_expect_success 'diff-index -b -p --cached --exit-code' '
-	git diff -b --cached --exit-code HEAD &&
-	git diff-index -b -p --cached --exit-code HEAD
+test_expect_success "diff-index -b -p --cached --exit-code ($note)" '
+	$tmf git diff -b --cached --exit-code HEAD &&
+	$tmf git diff-index -b -p --cached --exit-code HEAD
 '
 
-test_expect_success 'diff-index --exit-code' '
+test_expect_success "diff-index --exit-code ($note)" '
 	test_must_fail git diff --exit-code HEAD &&
 	test_must_fail git diff-index --exit-code HEAD
 '
 
-test_expect_success 'diff-index -b -p --exit-code' '
-	git diff -b --exit-code HEAD &&
-	git diff-index -b -p --exit-code HEAD
+test_expect_success "diff-index -b -p --exit-code ($note)" '
+	$tmf git diff -b --exit-code HEAD &&
+	$tmf git diff-index -b -p --exit-code HEAD
 '
 
-test_expect_success 'diff-files --exit-code' '
+test_expect_success "diff-files --exit-code ($note)" '
 	test_must_fail git diff --exit-code &&
 	test_must_fail git diff-files --exit-code
 '
 
-test_expect_success 'diff-files -b -p --exit-code' '
-	git diff -b --exit-code &&
-	git diff-files -b -p --exit-code
+test_expect_success "diff-files -b -p --exit-code ($note)" '
+	$tmf git diff -b --exit-code &&
+	$tmf git diff-files -b -p --exit-code
 '
 
+}
+
+git config diff.bwoutputonly true
+test_once "bwoutputonly=true" "test_must_fail"
+
+git config diff.bwoutputonly false
+test_once "bwoutputonly=false" ""
+
+git config --unset diff.bwoutputonly
+test_once "bwoutputonly unset" "test_must_fail"
+
 test_done
-- 
1.6.6.rc0.61.g41d5b.dirty

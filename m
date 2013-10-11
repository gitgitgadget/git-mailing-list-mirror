From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] status: show commit sha1 in "You are currently
 cherry-picking" message
Date: Fri, 11 Oct 2013 10:42:10 -0700
Message-ID: <20131011174210.GS9464@google.com>
References: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Matthieu.Moy@imag.fr,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 19:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUgjF-0001g5-1b
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 19:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab3JKRmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 13:42:17 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:52805 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab3JKRmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 13:42:16 -0400
Received: by mail-pa0-f51.google.com with SMTP id kp14so4710031pab.38
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XgOGGkP+/rm8cUA/ggeaw9992nA+f7jmlHm6DKL6OPM=;
        b=pQmlOx0fT4NWqHoKlpGIpau0E6U1RZfPjU+VXZP5DQlsoxSfsT7xOZiLribzoAi0sD
         tUhN12rbpkUu6eXKAs0cpOVnN5MuJlp0BbcybyVVoav/9ncaBi5R8R1DHV51tToB7WHg
         pfQmkzzPISNFm6rWPqYMRQdtiDx0WhAtTQkY6lZ9vuwuBAionRqRK1yFjppqOqqltEqW
         nxXsHfSjuKRrE2RYgibicrGfFdcVkimTHJdUx94kxiJ/snBhFWl6Dg5MMJ00IH+v7iS0
         oMGxcdwBK7tXCd1r492PZfnOsDld2r/0cGf3/Wx4+JdtdrmrO1T2NujESjIbMR/pSxGU
         sJWQ==
X-Received: by 10.68.129.99 with SMTP id nv3mr21653460pbb.40.1381513334912;
        Fri, 11 Oct 2013 10:42:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sb9sm61218457pbb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 10:42:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235913>

Ralf Thielow wrote:

> Especially helpful when cherry-picking multiple commits.

Neat, thanks.

[...]
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -626,9 +626,10 @@ test_expect_success 'prepare for cherry-pick conflicts' '
>  test_expect_success 'status when cherry-picking before resolving conflicts' '
>  	test_when_finished "git cherry-pick --abort" &&
>  	test_must_fail git cherry-pick cherry_branch_second &&
> +	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
> -	cat >expected <<\EOF &&
> +	cat >expected <<EOF

Did you mean to drop the '&&'?

[...]
> @@ -648,11 +649,12 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
>  	git reset --hard cherry_branch &&
>  	test_when_finished "git cherry-pick --abort" &&
>  	test_must_fail git cherry-pick cherry_branch_second &&
> +	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
>  	echo end >main.txt &&
>  	git add main.txt &&
> -	cat >expected <<\EOF &&
> +	cat >expected <<EOF

Likewise.

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -996,7 +996,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>  					struct wt_status_state *state,
>  					const char *color)
>  {
> -	status_printf_ln(s, color, _("You are currently cherry-picking."));
> +	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
> +			find_unique_abbrev(state->cherry_pick_head_sha1, DEFAULT_ABBREV));

This function is only called when ->cherry_pick_in_progress is true, so
we know cherry_pick_head_sha1 is initialized.  Good.

I would be tempted to check anyway, so that if we ever regress in this,
the cause will be clear and users know to report a bug:

	if (is_null_sha1(state->cherry_pick_head_sha1))
		die("BUG: cherry-pick in progress but no valid CHERRY_PICK_HEAD?");
	status_printf_ln(s, color, _("You are ...

I dunno.

Applied with the && fixes mentioned above on top of the following.

-- >8 --
Subject: status test: add missing && to <<EOF blocks

When a test forgets to include && after each command, it is possible
for an early command to succeed but the test to fail, which can hide
bugs.

Checked using the following patch to the test harness:

	--- a/t/test-lib.sh
	+++ b/t/test-lib.sh
	@@ -425,7 +425,17 @@ test_eval_ () {
		eval </dev/null >&3 2>&4 "$*"
	 }

	+check_command_chaining_ () {
	+	eval >&3 2>&4 "(exit 189) && $*"
	+	eval_chain_ret=$?
	+	if test "$eval_chain_ret" != 189
	+	then
	+		error 'bug in test script: missing "&&" in test commands'
	+	fi
	+}
	+
	 test_run_ () {
	+	check_command_chaining_ "$1"
		test_cleanup=:
		expecting_failure=$2
		setup_malloc_check

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7512-status-help.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 0688d58..9905d43 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -669,7 +669,7 @@ EOF
 test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
-	cat >expected <<\EOF
+	cat >expected <<\EOF &&
 HEAD detached at atag
 nothing to commit (use -u to show untracked files)
 EOF
@@ -677,7 +677,7 @@ EOF
 	test_i18ncmp expected actual &&
 
 	git reset --hard HEAD^ &&
-	cat >expected <<\EOF
+	cat >expected <<\EOF &&
 HEAD detached from atag
 nothing to commit (use -u to show untracked files)
 EOF
@@ -695,7 +695,7 @@ test_expect_success 'status while reverting commit (conflicts)' '
 	test_commit new to-revert.txt &&
 	TO_REVERT=$(git rev-parse --short HEAD^) &&
 	test_must_fail git revert $TO_REVERT &&
-	cat >expected <<EOF
+	cat >expected <<EOF &&
 On branch master
 You are currently reverting commit $TO_REVERT.
   (fix conflicts and run "git revert --continue")
@@ -716,7 +716,7 @@ EOF
 test_expect_success 'status while reverting commit (conflicts resolved)' '
 	echo reverted >to-revert.txt &&
 	git add to-revert.txt &&
-	cat >expected <<EOF
+	cat >expected <<EOF &&
 On branch master
 You are currently reverting commit $TO_REVERT.
   (all conflicts fixed: run "git revert --continue")
@@ -735,7 +735,7 @@ EOF
 
 test_expect_success 'status after reverting commit' '
 	git revert --continue &&
-	cat >expected <<\EOF
+	cat >expected <<\EOF &&
 On branch master
 nothing to commit (use -u to show untracked files)
 EOF
-- 
1.8.4-50-g437ce60

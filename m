From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/4] git-p4: use test_when_finished in tests
Date: Sun, 31 Jul 2011 10:59:28 +0100
Message-ID: <4E352780.5040206@diamand.org>
References: <20110731003557.GA4867@arf.padd.com> <20110731003855.GB4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 12:00:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnSoY-0008Nn-PD
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 12:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab1GaJ7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 05:59:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57846 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1GaJ7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 05:59:33 -0400
Received: by wyg8 with SMTP id 8so993041wyg.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 02:59:31 -0700 (PDT)
Received: by 10.227.37.38 with SMTP id v38mr4855834wbd.46.1312106371686;
        Sun, 31 Jul 2011 02:59:31 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id u22sm2570235weq.39.2011.07.31.02.59.29
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 02:59:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <20110731003855.GB4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178233>

On 31/07/11 01:38, Pete Wyckoff wrote:
> Cleanup nicely when tests fail.  This avoids many duplicated
> lines in the tests, and adds cleanup in a couple of tests that
> did not have it.  When one fails, now all the rest will not
> fail too.

Acked.

Much tidier.

>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   t/t9800-git-p4.sh |  103 +++++++++++++++++++++++++----------------------------
>   1 files changed, 49 insertions(+), 54 deletions(-)
>
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 33b0127..aec3ba1 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -45,29 +45,33 @@ test_expect_success 'add p4 files' '
>   	cd "$TRASH_DIRECTORY"
>   '
>
> +cleanup_git() {
> +	cd "$TRASH_DIRECTORY"&&
> +	rm -rf "$git"&&
> +	mkdir "$git"
> +}
> +
>   test_expect_success 'basic git-p4 clone' '
>   	"$GITP4" clone --dest="$git" //depot&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	git log --oneline>lines&&
> -	test_line_count = 1 lines&&
> -	cd ..&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test_line_count = 1 lines
>   '
>
>   test_expect_success 'git-p4 clone @all' '
>   	"$GITP4" clone --dest="$git" //depot@all&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	git log --oneline>lines&&
> -	test_line_count = 2 lines&&
> -	cd ..&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test_line_count = 2 lines
>   '
>
>   test_expect_success 'git-p4 sync uninitialized repo' '
>   	test_create_repo "$git"&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
> -	test_must_fail "$GITP4" sync&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test_must_fail "$GITP4" sync
>   '
>
>   #
> @@ -76,19 +80,18 @@ test_expect_success 'git-p4 sync uninitialized repo' '
>   #
>   test_expect_success 'git-p4 sync new branch' '
>   	test_create_repo "$git"&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	test_commit head&&
>   	"$GITP4" sync --branch=refs/remotes/p4/depot //depot@all&&
>   	git log --oneline p4/depot>lines&&
> -	cat lines&&
> -	test_line_count = 2 lines&&
> -	cd ..&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test_line_count = 2 lines
>   '
>
>   test_expect_success 'exit when p4 fails to produce marshaled output' '
>   	badp4dir="$TRASH_DIRECTORY/badp4dir"&&
>   	mkdir -p "$badp4dir"&&
> +	test_when_finished "rm -rf $badp4dir"&&
>   	cat>"$badp4dir"/p4<<-EOF&&
>   	#!$SHELL_PATH
>   	exit 1
> @@ -106,29 +109,26 @@ test_expect_success 'add p4 files with wildcards in the names' '
>   	echo file-wild-at>file-wild@at&&
>   	echo file-wild-percent>file-wild%percent&&
>   	p4 add -f file-wild*&&
> -	p4 submit -d "file wildcards"&&
> -	cd "$TRASH_DIRECTORY"
> +	p4 submit -d "file wildcards"
>   '
>
>   test_expect_success 'wildcard files git-p4 clone' '
>   	"$GITP4" clone --dest="$git" //depot&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	test -f file-wild#hash&&
>   	test -f file-wild\*star&&
>   	test -f file-wild@at&&
> -	test -f file-wild%percent&&
> -	cd "$TRASH_DIRECTORY"&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test -f file-wild%percent
>   '
>
>   test_expect_success 'clone bare' '
>   	"$GITP4" clone --dest="$git" --bare //depot&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	test ! -d .git&&
>   	bare=`git config --get core.bare`&&
> -	test "$bare" = true&&
> -	cd "$TRASH_DIRECTORY"&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test "$bare" = true
>   '
>
>   p4_add_user() {
> @@ -173,6 +173,7 @@ test_expect_success 'preserve users' '
>   	p4_add_user bob Bob&&
>   	p4_grant_admin alice&&
>   	"$GITP4" clone --dest="$git" //depot&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	echo "username: a change by alice">>  file1&&
>   	echo "username: a change by bob">>  file2&&
> @@ -181,27 +182,25 @@ test_expect_success 'preserve users' '
>   	git config git-p4.skipSubmitEditCheck true&&
>   	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user&&
>   	p4_check_commit_author file1 alice&&
> -	p4_check_commit_author file2 bob&&
> -	cd "$TRASH_DIRECTORY"&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	p4_check_commit_author file2 bob
>   '
>
>   # Test username support, submitting as bob, who lacks admin rights. Should
>   # not submit change to p4 (git diff should show deltas).
>   test_expect_success 'refuse to preserve users without perms' '
>   	"$GITP4" clone --dest="$git" //depot&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	echo "username-noperms: a change by alice">>  file1&&
>   	git commit --author "Alice<alice@localhost>" -m "perms: a change by alice" file1&&
>   	! P4EDITOR=touch P4USER=bob P4PASSWD=secret "$GITP4" commit --preserve-user&&
> -	! git diff --exit-code HEAD..p4/master>  /dev/null&&
> -	cd "$TRASH_DIRECTORY"&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	! git diff --exit-code HEAD..p4/master>  /dev/null
>   '
>
>   # What happens with unknown author? Without allowMissingP4Users it should fail.
>   test_expect_success 'preserve user where author is unknown to p4' '
>   	"$GITP4" clone --dest="$git" //depot&&
> +	test_when_finished cleanup_git&&
>   	cd "$git"&&
>   	git config git-p4.skipSubmitEditCheck true
>   	echo "username-bob: a change by bob">>  file1&&
> @@ -215,9 +214,7 @@ test_expect_success 'preserve user where author is unknown to p4' '
>   	git config git-p4.preserveUser true&&
>   	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit&&
>   	git diff --exit-code HEAD..p4/master>  /dev/null&&
> -	p4_check_commit_author file1 alice&&
> -	cd "$TRASH_DIRECTORY"&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	p4_check_commit_author file1 alice
>   '
>
>   # If we're *not* using --preserve-user, git-p4 should warn if we're submitting
> @@ -226,31 +223,29 @@ test_expect_success 'preserve user where author is unknown to p4' '
>   # Test: warning disabled and user is the same.
>   test_expect_success 'not preserving user with mixed authorship' '
>   	"$GITP4" clone --dest="$git" //depot&&
> -	(
> -		cd "$git"&&
> -		git config git-p4.skipSubmitEditCheck true&&
> -		p4_add_user derek Derek&&
> -
> -		make_change_by_user usernamefile3 Derek derek@localhost&&
> -		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> -		grep "git author derek@localhost does not match" actual&&
> -
> -		make_change_by_user usernamefile3 Charlie charlie@localhost&&
> -		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> -		grep "git author charlie@localhost does not match" actual&&
> -
> -		make_change_by_user usernamefile3 alice alice@localhost&&
> -		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> -		! grep "git author.*does not match" actual&&
> -
> -		git config git-p4.skipUserNameCheck true&&
> -		make_change_by_user usernamefile3 Charlie charlie@localhost&&
> -		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> -		! grep "git author.*does not match" actual&&
> -
> -		p4_check_commit_author usernamefile3 alice
> -	)&&
> -	rm -rf "$git"&&  mkdir "$git"
> +	test_when_finished cleanup_git&&
> +	cd "$git"&&
> +	git config git-p4.skipSubmitEditCheck true&&
> +	p4_add_user derek Derek&&
> +
> +	make_change_by_user usernamefile3 Derek derek@localhost&&
> +	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> +	grep "git author derek@localhost does not match" actual&&
> +
> +	make_change_by_user usernamefile3 Charlie charlie@localhost&&
> +	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> +	grep "git author charlie@localhost does not match" actual&&
> +
> +	make_change_by_user usernamefile3 alice alice@localhost&&
> +	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> +	! grep "git author.*does not match" actual&&
> +
> +	git config git-p4.skipUserNameCheck true&&
> +	make_change_by_user usernamefile3 Charlie charlie@localhost&&
> +	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit>actual&&
> +	! grep "git author.*does not match" actual&&
> +
> +	p4_check_commit_author usernamefile3 alice
>   '
>
>

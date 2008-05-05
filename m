From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 09/10] Fix tests breaking when checkout path contains
 shell metacharacters
Date: Mon, 05 May 2008 09:04:08 +0200
Message-ID: <481EB168.1070206@viscovery.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-2-git-send-email-bdonlan@fushizen.net> <1209879480-16910-3-git-send-email-bdonlan@fushizen.net> <1209879480-16910-4-git-send-email-bdonlan@fushizen.net> <1209879480-16910-5-git-send-email-bdonlan@fushizen.net> <1209879480-16910-6-git-send-email-bdonlan@fushizen.net> <1209879480-16910-7-git-send-email-bdonlan@fushizen.net> <1209879480-16910-8-git-send-email-bdonlan@fushizen.net> <1209879480-16910-9-git-send-email-bdonlan@fushizen.net> <1209879480-16910-10-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Mon May 05 09:05:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsuku-0000IQ-Ey
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 09:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbYEEHEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbYEEHEM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:04:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17006 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbYEEHEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:04:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jsuk4-0003Wj-SG; Mon, 05 May 2008 09:04:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B87176D9; Mon,  5 May 2008 09:04:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1209879480-16910-10-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81236>

Bryan Donlan schrieb:
> This fixes the remainder of the issues where the test script itself is at
> fault for failing when the git checkout path contains whitespace or other
> shell metacharacters.

Maybe a note along these lines would be in order:

The majority of git svn tests used the idiom

  test_expect_success "title" "test script using $svnrepo"

These were changed to have the test script in single-quotes:

  test_expect_success "title" 'test script using "$svnrepo"'

(which makes the patch so large). One consequence of this change is that
in the verbose test output the value of $svnrepo (and in some cases other
variables, too) is no longer expanded, i.e. previously we saw

  * expecting success:
	test script using /path/to/git/t/trash/svnrepo

but now it is:

  * expecting success:
	test script using "$svnrepo"


> 
> Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>

>  test_expect_success 'push with insteadOf' '
>  	mk_empty &&
> -	TRASH=$(pwd)/ &&
> -	git config url.$TRASH.insteadOf trash/ &&
> +	TRASH="$(pwd)/" &&

This one would not be necessary, but I don't mind.

> -test_expect_success 'make sure r2 still has old file' '
> +test_expect_success 'make sure r2 still has old file' "
>  	cd x &&
> -		test -n "$(git svn find-rev r1)" &&
> -		git reset --hard $(git svn find-rev r1) &&
> +		test -n \"\$(git svn find-rev r1)\" &&
> +		git reset --hard \$(git svn find-rev r1) &&
>  		test -f README &&
>  		test ! -f FOLLOWME &&
> -		test x$(git svn find-rev r2) = x
> -'
> +		test x\$(git svn find-rev r2) = x
> +"

Why did you change the quoting from sq to dq here?

> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index 3dc261d..ae7082b 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -10,6 +10,7 @@ commandline, and checks that it would not write any errors
>  or warnings to log.'
>  
>  gitweb_init () {
> +	safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"

How portable is this? (Just asking...)

-- Hannes

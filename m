From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Quoting paths in tests
Date: Wed, 17 Oct 2007 13:32:54 +0200
Message-ID: <4715F2E6.1000708@viscovery.net>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com> <11926134961610-git-send-email-maillist@steelskies.com> <11926134961549-git-send-email-maillist@steelskies.com> <11926134961275-git-send-email-maillist@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 13:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii799-0002bL-DO
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 13:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759322AbXJQLc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 07:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759420AbXJQLc5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 07:32:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20817 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759002AbXJQLc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 07:32:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ii78k-0007yX-6a; Wed, 17 Oct 2007 13:32:42 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2ECAEA33B; Wed, 17 Oct 2007 13:32:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11926134961275-git-send-email-maillist@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61371>

Jonathan del Strother schrieb:
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -25,7 +25,7 @@ perl -w -e "
>  use SVN::Core;
>  use SVN::Repos;
>  \$SVN::Core::VERSION gt '1.1.0' or exit(42);
> -system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or exit(41);
> +system(qw/svnadmin create --fs-type fsfs/, \"$svnrepo\") == 0 or exit(41);

Here you have to work harder: The reason is that this is part of a perl 
expression (as opposed to an eval'd string), which does not have access to 
$svnrepo of the shell by which it is invoked. The original version failed if 
there were single-quotes in $svnrepo, the new version fails if it contains 
double-quotes.

>  " >&3 2>&4


> -	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
> +	svn import -m 'import for git-svn' . \"$svnrepo\" >/dev/null &&

This must be

	svn import -m 'import for git-svn' . \"\$svnrepo\" >/dev/null &&

to be safe. Your version would break with names with double-quotes, because 
$svnrepo would be expanded and then eval'd inside test_expect_*. This error 
recurs numerous times until the end of the patch.

May I recommend that you run the test suite in a directory named like this:

	$ mkdir \"\ \$GIT_DIR\ \'
	$ ls
	" $GIT_DIR '

> -		( mkdir -p $GIT_DIR/svn/\$ref/info/ &&
> -		echo $svnrepo\$path > $GIT_DIR/svn/\$ref/info/url ) || exit 1;
> +		( mkdir -p \"$GIT_DIR\"/svn/\$ref/info/ &&
> +		echo \"$svnrepo\"\$path > \"$GIT_DIR\"/svn/\$ref/info/url ) || exit 1;

I assume $path is under control of the test script, otherwise it must be 
inside the double-quotes, too.

>  test_expect_success  ".rev_db auto-converted to .rev_db.UUID" "
>  	git-svn fetch -i trunk &&
> -	expect=$GIT_DIR/svn/trunk/.rev_db.* &&
> +	expect=\"\`find \"\$GIT_DIR\"/svn/trunk/ -name '.rev_db.*'\`\" &&

Why is this trickery with find needed? Isn't it easier to put the whole test 
case in single-quotes instead?

-- Hannes

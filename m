From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH v3 09/10] Fix tests breaking when checkout path
	contains shell metacharacters
Date: Mon, 5 May 2008 03:57:59 -0400
Message-ID: <20080505075759.GA20537@shion.is.fushizen.net>
References: <1209879480-16910-2-git-send-email-bdonlan@fushizen.net> <1209879480-16910-3-git-send-email-bdonlan@fushizen.net> <1209879480-16910-4-git-send-email-bdonlan@fushizen.net> <1209879480-16910-5-git-send-email-bdonlan@fushizen.net> <1209879480-16910-6-git-send-email-bdonlan@fushizen.net> <1209879480-16910-7-git-send-email-bdonlan@fushizen.net> <1209879480-16910-8-git-send-email-bdonlan@fushizen.net> <1209879480-16910-9-git-send-email-bdonlan@fushizen.net> <1209879480-16910-10-git-send-email-bdonlan@fushizen.net> <481EB168.1070206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 05 09:59:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsvb8-0007HQ-1L
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 09:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbYEEH6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYEEH6J
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:58:09 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:55722 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYEEH6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:58:08 -0400
Received: from [130.111.233.78] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JsvaG-0004Ji-O0; Mon, 05 May 2008 07:58:04 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JsvaB-0005fj-VR; Mon, 05 May 2008 03:57:59 -0400
Content-Disposition: inline
In-Reply-To: <481EB168.1070206@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81239>

On Mon, May 05, 2008 at 09:04:08AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > This fixes the remainder of the issues where the test script itself is at
> > fault for failing when the git checkout path contains whitespace or other
> > shell metacharacters.
> 
> Maybe a note along these lines would be in order:
> 
> The majority of git svn tests used the idiom
> 
>   test_expect_success "title" "test script using $svnrepo"
> 
> These were changed to have the test script in single-quotes:
> 
>   test_expect_success "title" 'test script using "$svnrepo"'
> 
> (which makes the patch so large). One consequence of this change is that
> in the verbose test output the value of $svnrepo (and in some cases other
> variables, too) is no longer expanded, i.e. previously we saw
> 
>   * expecting success:
> 	test script using /path/to/git/t/trash/svnrepo
> 
> but now it is:
> 
>   * expecting success:
> 	test script using "$svnrepo"

Ah, good point. I don't see an easy way to make them show in expanded
form without breaking space handling, unfortunately, but if a v4 is
needed I can toss that in.

> 
> 
> > 
> > Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
> 
> >  test_expect_success 'push with insteadOf' '
> >  	mk_empty &&
> > -	TRASH=$(pwd)/ &&
> > -	git config url.$TRASH.insteadOf trash/ &&
> > +	TRASH="$(pwd)/" &&
> 
> This one would not be necessary, but I don't mind.

I wasn't sure what the rules were regarding non-copy-assignments, and
wanted to play it safe (there was a conflict in this area when rebasing
too).

> > -test_expect_success 'make sure r2 still has old file' '
> > +test_expect_success 'make sure r2 still has old file' "
> >  	cd x &&
> > -		test -n "$(git svn find-rev r1)" &&
> > -		git reset --hard $(git svn find-rev r1) &&
> > +		test -n \"\$(git svn find-rev r1)\" &&
> > +		git reset --hard \$(git svn find-rev r1) &&
> >  		test -f README &&
> >  		test ! -f FOLLOWME &&
> > -		test x$(git svn find-rev r2) = x
> > -'
> > +		test x\$(git svn find-rev r2) = x
> > +"
> 
> Why did you change the quoting from sq to dq here?

Erk, missed this in git add -i processing :) I'll drop this hunk.

> > diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> > index 3dc261d..ae7082b 100755
> > --- a/t/t9500-gitweb-standalone-no-errors.sh
> > +++ b/t/t9500-gitweb-standalone-no-errors.sh
> > @@ -10,6 +10,7 @@ commandline, and checks that it would not write any errors
> >  or warnings to log.'
> >  
> >  gitweb_init () {
> > +	safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
> 
> How portable is this? (Just asking...)

A grovel through perl-5.8.8's source indicates it has a fallback when
the platform does not have a real getcwd() function
(util.c:Perl_getcwd_sv(), called from ext/POSIX/POSIX.xs)

> 
> -- Hannes
> 
> 

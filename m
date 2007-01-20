From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Fri, 19 Jan 2007 16:19:37 -0800
Message-ID: <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
References: <200701150144.56793.jnareb@gmail.com>
	<200701191310.32417.jnareb@gmail.com>
	<Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701192344.11972.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolai Weibull <now@bitwi.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83xP-0002rN-IN
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXATATk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXATATj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:19:39 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60731 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbXATATj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:19:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120001938.TKBB20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 19:19:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DCKv1W00M1kojtg0000000; Fri, 19 Jan 2007 19:19:56 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701192344.11972.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 19 Jan 2007 23:44:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37227>

Jakub Narebski <jnareb@gmail.com> writes:

> I'm not sure how to tell that you can have [section] if you have
> [section "subsection"], but you don't need to.

s/I'm not .*that//; would be enough, I think.

> And I'm not sure if some behavior should not be changed, for example
> allowing _any_ line to be continued with `\`, or that other character
> escape sequences and perhaps also octal character sequences should be
> allowed (either that or `\b` should not be parsed).

I do not think we need continuation line for [] headers, if that
is what you mean.  I offhand do not think anybody would scream
if we start parsing full c-quote.

One thing that left me puzzled after reading the description was
what a user can do with "subsection".  It is unclear from the
description if [section "sub.section"], [section"sub.sec=ti.on"]
or worse yet, [section "sub\nsection with an embbedded LF"] are
allowed.  The rest seemed sane.

I think the current repo-config handles sane cases alright, but
it is still fragile in error cases.  For example:

	$ git repo-config 'foo.bar=bzz
          baz.boo' foobar

does not currently barf, but results in a corrupted config file.

	$ git repo-config 'foo.bar=bzz
          baz.boo'
	fatal: bad config file line 56 in .git/config

        $ sed -ne '55,$p' .git/config
        [foo "bar=bzz
        baz"]
                boo = foobar

The only way we use the subsection names for (almost arbitrary)
end user string is to store branch names, so LF is not an issue
and we could forbid it (if need arises loosening the restriction
while updating the code to behave sanely is easier than leaving
it open without properly checking).

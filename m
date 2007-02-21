From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Mechanical conversion to use prefixcmp()
Date: Tue, 20 Feb 2007 22:43:07 -0800
Message-ID: <7v7iuct3ic.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
	<7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702201243000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 21 07:43:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJlCF-0006Ux-1l
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 07:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbXBUGnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 01:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXBUGnK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 01:43:10 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63605 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbXBUGnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 01:43:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221064307.COJX21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 01:43:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S6j71W0071kojtg0000000; Wed, 21 Feb 2007 01:43:08 -0500
In-Reply-To: <Pine.LNX.4.63.0702201243000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 20 Feb 2007 12:53:32 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40284>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Ha, I did it by
>
> $ perl -pi.bup -e \
>  's/strncmp\( *("[^"]*"), *([^"]*), *[0-9]* *\)/prefixcmp\($2, $1\)/g' \
>  $(git ls-files)
>
> and
>
> $ perl -pi.bup -e \
>  's/strncmp\( *([^"]*), *("[^"]*"), *[0-9]* *\)/prefixcmp\($1, $2\)/g' \
>  $(git-ls-files)
>
> Of course, I missed the two ,ofs ones, but a git grep -n strncmp brought 
> these up.

I think you totally missed my point.  I wanted to make sure that
things like these do not go unnoticed:

        if (!strncmp(arg, "--foo==", 6))
	if (strncmp(line, "foo\nbar", 8))

Both are probably incorrectly written code in the original, but
probably would _happen_ to be working (for a certain definition
of "working" -- the former probably wanted to make sure the
parameter is of form "--foo=something", and the latter wanted to
check the line has the 7 bytes terminated with NUL).  But your
conversion would make them actually start behaving incorrectly.

And the worst part of this is that the change that caused to
expose these bugs would be literally _buried_ in 1800 lines of
"mechanical conversion" patch which is mind-numbing to audit.

That's why you are better off writing mechanical conversion
script in stricter than seemingly necessary to catch only the
safe conversion target, while accepting false negatives.

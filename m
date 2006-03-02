From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-checkout-index to use file suffixes.
Date: Wed, 01 Mar 2006 23:59:31 -0800
Message-ID: <7vbqwp6zvg.fsf@assigned-by-dhcp.cox.net>
References: <20060301044132.GF22894@spearce.org>
	<20060301150629.GB3456@spearce.org>
	<slrne0bh1p.fr9.mdw@metalzone.distorted.org.uk>
	<20060302065136.GA6377@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 09:00:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEij5-0002kJ-Vo
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 08:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWCBH7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 02:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCBH7d
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 02:59:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51103 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751148AbWCBH7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 02:59:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302075752.TTXL6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Mar 2006 02:57:52 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060302065136.GA6377@spearce.org> (Shawn Pearce's message of
	"Thu, 2 Mar 2006 01:51:36 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17058>

Shawn Pearce <spearce@spearce.org> writes:

> Why let the user choose?  '/' shouldn't be permitted as that
> (possibly) would try to create a directory also named the same as
> the file (a bad thing).  Then its just two formats, depending on
> if you want all stages or just 1 stage:
>
> 	--stage=all --suffix=#1/#2/#3
>
> or
>
> 	--stage=1 --suffix=#1

I'll later agree with "why let the user choose" in this message,
but for an entirely different reason.

I am not a great fan of extracting files from stages in the
working tree to begin with.  The git-unpack-file command tries
carefully to avoid conflicts, and its use of temporary files is
inherently, eh, temporary, and Porcelains know what names they
get and know how to clean things up afterwards.

I am sympathetic to what you are trying to achieve here.  Maybe
your Porcelain would invoke a graphical 3-way merge program in a
windowing environment, and the merge program displays the
filename(s) your Porcelain fed it to the end user, without
giving you a way to override it.  In that context, it is not
useful to the end user to show meaningless temporary filename,
and having checkout-index to derive the temporary filename from
real filename may look sensible.

However, --stage=all with --suffix would introduce name clashes
between repeated conflicted merge runs, which requires Porcelain
to be extra careful.  Your last merge run might have involved
three conflicting stages (leaving a.c~1, a.c~2, and a.c~3 in
your working tree) and this time it may be "we removed it while
they modified it" situation (needing to extract a.c~1, a.c~3 but
not a.c~2).  The Porcelain needs to make sure not to get
confused by leftover a.c~2 file in the working tree from the
previous run.

If what you are trying is to reduce the number of checkout-index
calls by your Porcelain to extract conflicted stages, it _might_
make more sense to do something like this instead (I am thinking
aloud, so take this with a big grain of salt -- it may not make
sense at all):

    checkout-index --stage=all checks out higher-order stages in
    made-up temporary filenames, just like git-merge-one-file
    does using git-unpack-file one-by-one, with a single
    invocation.

    It reports the following to its standard output, one record
    per pathname in the index:

	tmp1 <SP> tmp2 <SP> tmp3 <TAB> pathname <RS>

    Here, tmp? is the temporary file names for each stage, or a
    dot for for a nonexistent stage.  pathname is c-quoted as
    usual for non -z output and RS is '\n' (under -z flag,
    pathname is a literal string and RS is NUL).  SP = space
    (ASCII 0x20), TAB = tab (ASCII 0x09).

    Example:

        ".tmp1323 . .tmp1232\tfoo/a.c\n"

    Notice the dot between the two temporary files -- stage2 is
    empty in this example.

Then your Porcelain could run --stage=all and read the output,
and then moving the temporary files around whatever way pleases
it.  Since it needs to be careful about not overwriting the
existing working tree files *and* not getting confused by
existing garbage in the working tree anyway, I do not think it
would make your life much easier to have checkout-index derive
the temporary file names after the real working tree files.

BTW, using TAB to split metainformation and pathname and using
SP to separate metainformation pieces are in line with the
design other git tools use.  With this, you can separate the LHS
metainformation part and pathname using "cut", and you can have
shell IFS to split the metainformation part apart after that.
But that is a minor detail.

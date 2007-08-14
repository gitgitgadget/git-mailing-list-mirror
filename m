From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-apply: apply submodule changes
Date: Tue, 14 Aug 2007 13:00:36 -0700
Message-ID: <7vmywtc2e3.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
	<7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
	<20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
	<7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
	<20070813093740.GA4684@liacs.nl>
	<20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Tue Aug 14 22:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL2ZM-0007gb-DQ
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 22:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762399AbXHNUAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761525AbXHNUAm
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 16:00:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49197 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486AbXHNUAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 16:00:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814200037.DQRZ5405.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 16:00:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bw0d1X0051kojtg0000000; Tue, 14 Aug 2007 16:00:37 -0400
In-Reply-To: <20070813171349.GL999MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Mon, 13 Aug 2007 19:13:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55854>

Sven Verdoolaege <skimo@kotnet.org> writes:

> @@ -2096,8 +2142,15 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
>  				    lstat(old_name, &st))
>  					return -1;
>  			}
> -			if (!cached)
> +			if (!cached) {
>  				changed = ce_match_stat(ce, &st, 1);
> +				if (S_ISGITLINK(patch->old_mode)) {
> +					changed &= TYPE_CHANGED;
> +					if (!changed &&
> +					    verify_gitlink_clean(patch->old_name))
> +						changed |= TYPE_CHANGED;
> +				}
> +			}

In this codepath, we know the patch wants to either modify the
path at old_name or remove old_name.  If we are going to affect
the work tree, we have run lstat on it, and ran checkout_entry() 
if we did not have anything there and did lstat() again.

I think the check "S_ISGITLINK(patch->old_mode)" is wrong
(that's where my confusion while reading your patch came from).
It has to check ce's mode, not patch->old_mode, because we are
verifying if the index matches with the work tree in this
codepath.  If you fix it to S_ISGITLINK(ntohl(ce->ce_mode)),
I think I can see what you are trying to do.

When ce is not a gitlink, you keep the original behaviour, which
is assuring that you did not break things for people who do not
use gitlink.

I am still having trouble with the TYPE_CHANGED bits.  You
discard everything other than TYPE_CHANGED, and 

 - if ce_match_stat() returned TYPE_CHANGED, then that is given
   to later processing to cause us to fail "oops, path is not up
   to date";

 - if ce_match_stat() did not return TYPE_CHANGED, that means we
   found a directory at the path (ce_match_stat_basic() says
   so).  In such a case you call verify_gitlink_clean(), but it
   essentially says "make sure there is either an empty
   directory or some repository".  Maybe we do not even have to
   have this extra check?

When ce is a gitlink, ce_match_stat() says DATA_CHANGED if the
commit in the work tree of the subproject is different.  From
the earlier discussions, we do want to discard DATA_CHANGED for
this codepath.

So it looks almost Ok after spending a few days looking at this
code.  Finally.

However, if it takes _me_ three days to understand this hunk,
(admittably, the parameter to S_ISGITLINK() completely confused
me originally, and I also had other things to do, so it was not
"72 hours"), I do not think the code with your patch is
maintainable by anybody.  At least we would need to have a few
words of comment to describe what is going on there.

	if (!cached) {
        	changed = ce_match_stat(ce, &st, 1);
                if (S_ISGITLINK(ntohl(ce->ce_mode)))
                	/*
			 * ce_match_stat() reports the
			 * difference between the commit object
                         * name in the index and what is checked
			 * out in the work tree of subproject;
                         * because we do not recurse, we do not
			 * want to insist on them matching with
                         * each other.
                         */
                	changed &= ~DATA_CHANGED;
	}
        if (changed)
        	return error("%s: does not match index", old_name);

From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 12:01:25 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfGSR-0006j5-I3
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 19:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002AbZHWRBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933980AbZHWRBv
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 13:01:51 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:40577 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933974AbZHWRBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 13:01:50 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MfGRz-000219-7d; Sun, 23 Aug 2009 12:01:51 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126861>

Junio C Hamano (gitster@pobox.com) wrote on Aug 23, 2009:

> Thell Fowler <git@tbfowler.name> writes:
> 
> > @@ -191,12 +191,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
> >  	int i1, i2;
> >  
> >  	if (flags & XDF_IGNORE_WHITESPACE) {
> > -		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
> > +		for (i1 = i2 = 0; i1 < s1 || i2 < s2; ) {
> >  			if (isspace(l1[i1]))
> > -				while (isspace(l1[i1]) && i1 < s1)
> > +				while ((isspace(l1[i1]) && i1 < s1)
> > +						|| (i1 + 1 == s1 && l1[s1] != '\n'))
> 
> This is wrong.  If you ran out l1/s1/i1 but you still have remaining
> characters in l2/s2/i2, you do not want to even look at l1[i1].
> 
> You can fudge this by sprinkling more "(i1 < s1) &&" in many places (and
> reordering how your inner while() loop checks (i1 < s1) and l1[i1]), but I
> do not think that is the right direction.
> 
> The thing is, the loop control in this function is extremely hard to read
> to begin with, and now it is "if we haven't run out both", the complexity
> seeps into the inner logic.
> 

I see what you're saying here and your absolutely right.  Good thing you 
didn't write a critique of the XDF_IGNORE_WHITESPACE_CHANGE case. ;)

> How about doing it like this patch instead?  This counterproposal replaces
> your 3 patches starting from [3/6].
[...snip...]
> The basic idea of the re-written logic is this.
> 
>  - An initial loop runs while the characters from both strings we are
>    looking at match.  We declare unmatch immediately when we find
>    something that does not match and return false from the loop.  And we
>    break out of the loop if we ran out of either side of the string.
> 
>    The way we skip spaces inside this loop varies depending on the style
>    of ignoring whitespaces.
> 
>  - After the loop, the lines can match only if the remainder consists of
>    nothing but whitespaces.  This part of the logic is shared across all
>    three styles.
> 
> The new code is more obvious and should be much easier to follow.

Because the flow is much more direct it also makes the test additions to 
t4015 obsolete as they essentially tested for line end conditions instead 
of whitespace (like they should have).
[...clip...]
> +		/*
> +		 * If we do not want -b to imply --ignore-space-at-eol
> +		 * then you would need to add this:
> +		 *
> +		 * if (!(flags & XDF_IGNORE_WHITESPACE_AT_EOL))
> +		 *	return (s1 <= i1 && s2 <= i2);
> +		 *
> +		 */
> +

While it would be nice to have -b and --ignore-space-at-eol be two 
different options that could be merged together the documentation states 
that -b ignores spaces at eol, and there are scripts that depend on this 
behavior.

IMHO  it is wrong to accept that new spaces where none existed before is 
akin to having one or more existing spaces coalesced.  I seem to recall 
reading something about 1.7 having some changes in it that wouldn't be 
backward compatible; perhaps -b and --ignore-space-at-eol could be 
distinct options for that release.

On another item:
Right now the xdl_recmatch() checks three distinct flags before having the 
opportunity to do the default behavior of a straight diff.  In 
xdl_hash_record there is an initial check for whitespace flags.

...
	if (flags & XDF_WHITESPACE_FLAGS)
		return xdl_hash_record_with_whitespace(data, top, flags);
...

Perhaps a similar setup for xdl_rematch() and a 
xdl_recmatch_with_whitespace() ?

Lastly:
Since your to counter-proposals give the same results, provide safer and 
faster processing, eliminate the additional test, as well as being easier 
to read and comprehend I propose a v3 with just those two patches.  I'll 
be glad to post it, with or without a xdl_recmatch_with_whitespace, if 
need be.  And should I, or do I need to, add something to the commit (ie: 
ack, tested, ...) ?

Thank you again for taking the time to look at this change!

-- 
Thell

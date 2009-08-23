From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 15:33:58 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908231515020.29625@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS> <7vljlauxmk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:34:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJlo-0003ym-6M
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934121AbZHWUeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934118AbZHWUeW
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:34:22 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:57022 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S934117AbZHWUeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:34:22 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MfJlf-0005Jz-Db; Sun, 23 Aug 2009 15:34:23 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <7vljlauxmk.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126873>

Junio C Hamano (gitster@pobox.com) wrote on Aug 23, 2009:

> Thell Fowler <git@tbfowler.name> writes:
> 
> > Because the flow is much more direct it also makes the test additions to 
> > t4015 obsolete as they essentially tested for line end conditions instead 
> > of whitespace (like they should have).
> 
> Your patch 6/6 that added the tests were useful to find a bug I originally
> had, which is the one below that is commented out.
> 

That's good to hear!

> >> +		/*
> >> +		 * If we do not want -b to imply --ignore-space-at-eol
> >> +		 * then you would need to add this:
> >> +		 *
> >> +		 * if (!(flags & XDF_IGNORE_WHITESPACE_AT_EOL))
> >> +		 *	return (s1 <= i1 && s2 <= i2);
> >> +		 *
> >> +		 */
> >> +
> >
> > While it would be nice to have -b and --ignore-space-at-eol be two 
> > different options that could be merged together the documentation states 
> > that -b ignores spaces at eol, and there are scripts that depend on this 
> > behavior.
> 
> Also that is how "diff -b" behaves, and that is why I said your tests
> found a _bug_ in my original.  I'll drop the above large comment and
> replace it with just a "/* -b implies --ignore-space-at-eol */".
> 

In that case the only other outstanding issue to being able to use 
patch-id to validate a whitespace fixed patch is diff's -B option to catch 
the situations where the original has multiple blank newlines at the end 
of file.


> > Right now the xdl_recmatch() checks three distinct flags before having the 
> > opportunity to do the default behavior of a straight diff.  In 
> > xdl_hash_record there is an initial check for whitespace flags.
> >
> > ...
> > 	if (flags & XDF_WHITESPACE_FLAGS)
> > 		return xdl_hash_record_with_whitespace(data, top, flags);
> > ...
> >
> > Perhaps a similar setup for xdl_rematch() and a 
> > xdl_recmatch_with_whitespace() ?
> 
> Or we can just move the final else clause up and start the function like
> this:
> 
> 	int i1, i2;
> 
> 	if (!(flags & XDF_WHITESPACE_FLAGS))
>  		return s1 == s2 && !memcmp(l1, l2, s1);
> 
> 	i1 = i2 = 0;
>  	if (flags & XDF_IGNORE_WHITESPACE) {
> 		...
> 
> that would get rid of two unnecessary clearing of variables (i1 and i2,
> even though I suspect that the compiler _could_ optimize them out without
> such an change), and three flags-bit check in the most common case of not
> ignoring any whitespaces.
> 

HA!  That's a nifty way to do that with the variables.

> > Since your to counter-proposals give the same results, provide safer and 
> > faster processing, eliminate the additional test, as well as being easier 
> > to read and comprehend I propose a v3 with just those two patches.  I'll 
> > be glad to post it, with or without a xdl_recmatch_with_whitespace, if 
> > need be.  And should I, or do I need to, add something to the commit (ie: 
> > ack, tested, ...) ?
> 
> I can amend the counterproposal patches with tests from your 6/6 and add
> your "Tested-by:" and commit them myself.
> 

Excellent.

> > Thank you again for taking the time to look at this change!
> 
> Thank _you_ for bringing this issue up in the first place.

My pleasure!  It has been quite the learning experience!

-- 
Thell

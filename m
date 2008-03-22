From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Fri, 21 Mar 2008 20:36:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803212021190.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210014100.19665@iabervon.org> <7vmyosskyu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211148120.19665@iabervon.org> <7vlk4boh6v.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211840480.19665@iabervon.org> <7vy78bmxx1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 01:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcrjh-0003qQ-LA
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 01:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbYCVAgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 20:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYCVAgq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 20:36:46 -0400
Received: from iabervon.org ([66.92.72.58]:36500 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYCVAgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 20:36:45 -0400
Received: (qmail 338 invoked by uid 1000); 22 Mar 2008 00:36:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2008 00:36:42 -0000
In-Reply-To: <7vy78bmxx1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77779>

On Fri, 21 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> +		/*
> >> +		 * Do we want to validate LHS?
> >> + ...
> >> +		 * Hence we check non-empty LHS for fetch, and
> >> +		 * colonless or glob LHS for push here.
> >> +		 */
> >
> > Wouldn't this be clearer and not meaningfully harder in 
> > parse_fetch_refspec and parse_push_refspec?
> 
> Do you mean you want the callers of this internal implementation to also
> loop over the input set of refs?  I think that would be more complex code
> but I do not see much gain by doing so.

I think it's more breadth but less depth. It would make the internal 
implementation not depend on fetch, and put the checks that only apply to 
fetch out of the push code path and vice versa.

Or just have a section

	if (fetch) {
		// checks for fetch LHS
		// checks for fetch RHS
	} else {
		// checks for push LHS
		// checks for push RHS
	}

The body of the condition is only four lines, after all.

> >> +		if (fetch ? (*rs[i].src) : (!rhs || is_glob)) {
> >
> > This is an odd combination of locals and struct members.
> >                                        : (!rs[i].dst || rs[i].pattern) {
> 
> Sorry, I do not understand what's wrong about it.
> 
> 	!!rhs === (did we see a colon) === !!rs[].dst
>         is_glob === (did they both end with "/*") === rs[].pattern
> 
> They are equivalent, and local variables are primarily what the logic
> works on and bases its decisions to store what in rs[] structures.

Considering that it's already stored values into the struct, it might as 
well use those, and those are presumably more familiar to the average 
reader, because all of the git code that uses refspecs other than this 
function uses them.

> Ahh...  do you mean:
> 
> 	(*rs[i].src) === (is lhs non empty?) === !!llen
> 
> I guess using "llen" there is more consistent and is moderately cleaner.

I'd go the other way, but having them all from the same set makes more 
sense than one from one set and two from the other, regardless of which 
way. If you go this way, you should probably also include the the rhs 
checks, and the argument to check_ref_format().

	-Daniel
*This .sig left intentionally blank*

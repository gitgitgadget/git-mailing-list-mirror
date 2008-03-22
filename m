From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Sat, 22 Mar 2008 12:48:59 -0700
Message-ID: <7viqzeilp0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
 <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211148120.19665@iabervon.org>
 <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211840480.19665@iabervon.org>
 <7vy78bmxx1.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803212021190.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9jE-0004nV-HO
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbYCVTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbYCVTtP
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:49:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYCVTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:49:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F07F1311;
	Sat, 22 Mar 2008 15:49:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 07A5D1310; Sat, 22 Mar 2008 15:49:06 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803212021190.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 21 Mar 2008 20:36:42 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77843>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 21 Mar 2008, Junio C Hamano wrote:
> ...
>> Do you mean you want the callers of this internal implementation to also
>> loop over the input set of refs?  I think that would be more complex code
>> but I do not see much gain by doing so.
>
> I think it's more breadth but less depth. It would make the internal 
> implementation not depend on fetch, and put the checks that only apply to 
> fetch out of the push code path and vice versa.
>
> Or just have a section
>
> 	if (fetch) {
> 		// checks for fetch LHS
> 		// checks for fetch RHS
> 	} else {
> 		// checks for push LHS
> 		// checks for push RHS
> 	}
>
> The body of the condition is only four lines, after all.

There are two commits on jc/refspec-fix branch merged to 'pu'.  The
earlier one is my version, and the one on top is based on the above
suggestion.  I do not know which one is clearer, more readable and
maintainable.

>> Ahh...  do you mean:
>> 
>> 	(*rs[i].src) === (is lhs non empty?) === !!llen
>> 
>> I guess using "llen" there is more consistent and is moderately cleaner.
>
> I'd go the other way, but having them all from the same set makes more 
> sense than one from one set and two from the other, regardless of which 
> way. If you go this way, you should probably also include the the rhs 
> checks, and the argument to check_ref_format().

It is very much sensible to look at either the local variables it used
during the parsing and the tentative result it produced while deciding
what to check and how, and it also is very sensible to validate what it
gives back to the user and/or what it knows is equal to what it gives back
to the user.  When they are equivalent, it is mostly a matter of taste
which to use for deciding and which to use for validating.  But it makes
more sense to prefer its local variables for logic to decide what to do
and how, and validate what we are actually going to give back.

If you mean to suggest to change parameter given to check_ref_format()
from rs[i].{src,dst} to something else based on the local variables we
used, that's backwards.

But we have already agreed that our brains are wired differently when it
comes to taste; I'd prefer not pursuing bikeshedding any further.

Unless your suggestion _isn't_ bikeshedding, that is.

What I did so far was to spend time to respond with code that fixes
existing breakages, while what you did so far was to kibitz instead of
showing code.  Showing code might make me realize that the way you may
want to go is more than bikeshedding and actual improvements to
readability and maintainability, but honestly speaking I am tired of
looking at this part of the code for now, so...

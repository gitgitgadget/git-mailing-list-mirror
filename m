From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 13:32:30 -0700
Message-ID: <7vejha43oh.fsf@gitster.siamese.dyndns.org>
References: <1189115308.30308.9.camel@koto.keithp.com>
	<7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
	<1189133898.30308.58.camel@koto.keithp.com>
	<7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
	<1189181313.30308.97.camel@koto.keithp.com>
	<alpine.LFD.0.9999.0709071222270.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkVS-0001Gn-Lp
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbXIGUcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758384AbXIGUck
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:32:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758302AbXIGUcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:32:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C4B5F12E2B2;
	Fri,  7 Sep 2007 16:32:54 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.9999.0709071222270.21186@xanadu.home> (Nicolas
	Pitre's message of "Fri, 07 Sep 2007 12:29:01 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58068>

Nicolas Pitre <nico@cam.org> writes:

>> It seems to me that instead of introducing an incompatible (but probably
>> useful) change, a sensible option would be to have the ambiguous
>> reference be an error instead of a warning. One shouldn't be encouraged
>> to use names in .git that conflict with stuff in refs/heads anyway.
>
> I agree.  IMHO the sensible thing to do is to always warn, and error out 
> by default.  I see no advantage for core.warnAmbiguousRefs=false other 
> than allow the user to shoot himself in the foot someday.  Instead, we 
> should have core.allowAmbiguousRefs set to off by default.

Well, for about three weeks late November to early December
2005, we did make this an error.  Since mid December 2005, we
reverted that change to the original "take first match, without
even attempting to detect ambiguity".  I do not recall what the
discussion that led to that change was about, but it could have
been the issue Len had that confused "git merge" with a tag and
a branch named after bugzilla bug number.  In any case, this
change most likely was because some people were actually using
the same name and the change to make it an error hurted them.

We then reintroduced the ambiguity detection late March 2006,
but only as a warning, again fearing that erroring out would
break people's existing setups.  I think we also rewrote
examples in our documentation that said "create your own branch
v2.6.13 that fork from v2.6.13 tag" to read "create your own
brancy my-2.6.13..." to avoid encouraging the use of same name
to people.

I think the warning has been with us for a long time and by now
people know better not to confuse themselves.

So I am all for making an ambiguous refname an error in 1.5.4.

At the same time, I think it makes sense to forbid update-ref
outside refs/ if the refname is not special (say, with any
lowercase letters), and ignore names immediately below .git that
are not all-uppercase+underscore (e.g. "FETCH_HEAD" we read,
"description" we ignore).

Please make it so.

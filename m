From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 02 Oct 2007 12:47:59 -0700
Message-ID: <7vsl4tjo28.fsf@gitster.siamese.dyndns.org>
References: <20071002155800.GA6828@coredump.intra.peff.net>
	<200710021916.44388.andyparkins@gmail.com>
	<20071002191104.GA7901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnjT-0000ZP-Bk
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbXJBTsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXJBTsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:48:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:54604 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbXJBTsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:48:08 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 7DF3A14066E;
	Tue,  2 Oct 2007 15:48:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BEFD13FF6F;
	Tue,  2 Oct 2007 15:48:23 -0400 (EDT)
In-Reply-To: <20071002191104.GA7901@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Oct 2007 15:11:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59716>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 02, 2007 at 07:16:43PM +0100, Andy Parkins wrote:
>
>> Changed repeated use of the same constants for the ref paths to be
>> symbolic constants.  I've defined them in refs.h
>
> I've manually inspected the patch. Comments are below.
>
>> -		if (prefixcmp(head, "refs/heads/"))
>> -			die("HEAD not found below refs/heads!");
>> -		head += 11;
>> +		if (prefixcmp(head, PATH_REFS_HEADS))
>> +			die("HEAD not found below " PATH_REFS_HEADS "!");
>> +		head += STRLEN_PATH_REFS_HEADS;
>
> This slightly changes the message (extra "/"), but I don't think that is
> a big deal...

        die("HEAD not found below %.*%s!",
             PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS-1)

>> -		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
>> +		if (snprintf(ref, sizeof(ref), PATH_REFS_TAGS"%s", *p)
>
> I find the 'PATH_REFS_TAGS "%s"' (with a space) you used earlier a
> little easier to read.

Even though we all know that PATH_REFS_* do not have any '%' in
them, it is somewhat unnerving to see such an opaque string in
the format specifier part of _any_printf() function.  It just
makes you think twice, disrupting the flow of thoughts.

This applies to die() and friends as well; see my above rewrite.

To me, the valid reasons for this kind of rewrite are if:

 - it makes typo harder to make and easier to spot
   (e.g. "refs/head/");

 - it makes miscount harder to make and easier to spot (e.g.
   what is this magic constant 11? Is it strlen("refs/heads/")?);

 - it makes reviewing the resulting code, and more importantly,
   future patches on the resulting code, easier.

 - it makes it easier for us to later revamp the strings
   wholesale (e.g. "refs/heads/" => "refs/branches/").

 - it saves us repeated instances of the same string constant;
   using C literal string as values for PATH_REFS_HEADS would
   not help and you would need (const char []) strings instead,
   but the compiler may be clever enough to do so.

Unquestionably, this series helps on the first two counts.

It however actively hurts on the third count.  These long
constants in CAPITAL_LETTERS_WITH_UNDERSCORE shout too loudly to
the eye, overwhelming the surrounding code.  I wonder if we can
do anything about this point to resurrect the first two
benefits, which I like very much.

The forth is a myth we shouldn't care about.  If we later would
want to change refs/heads to refs/branches, we would want to
rename PATH_REFS_HEADS to PATH_REFS_BRANCHES at the same time as
well, so the kind of rewrite this patch does does not buy us
anything there.  More importantly, such a change would need to
be made in a backward compatible way (e.g. "if we have heads
then keep using them but in new repositories we favor
branches"), so it won't be straight token replacement anyway.

And the fifth do not apply to us.  This matters only if we were
an embedded application on memory starved machine and string
constants are far smaller matter compared to the amount of other
data we use in-core.

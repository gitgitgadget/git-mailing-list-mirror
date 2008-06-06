From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 06 Jun 2008 09:13:19 -0700
Message-ID: <7vr6bav8ww.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer>
 <alpine.DEB.1.00.0806060006370.21190@racer>
 <7vve0nw4b7.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806061441120.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ea8-0001DY-DA
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 18:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764910AbYFFQNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 12:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764397AbYFFQNa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 12:13:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764896AbYFFQN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 12:13:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 298D613D7;
	Fri,  6 Jun 2008 12:13:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0FAD013D5; Fri,  6 Jun 2008 12:13:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806061441120.1783@racer> (Johannes
 Schindelin's message of "Fri, 6 Jun 2008 14:58:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E5C8E96-33E3-11DD-8CFB-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84086>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> At this point, line points at the beginning of the line that immediately
>> follows "@@ -oldpos,oldlines +newpos,newlines @@ ...\n", right?
>
> No.  At this point, it points directly after the last "@@", but still on 
> the same line.

Ah, I personally think that is a crazy calling convention but the
function's loop consistently uses the "line at the beginning of iteration
points somewhere in the previous line to be skipped", so it would "work".
I was fooled by that.

>> > +	if (size < 1)
>> > +		return -1;
>> > +
>> > +	fragment->oldpos = 2;
>> 
>> Why do you discard oldpos information, and use magic number "2"?
>
> Because the old information should be ignored.  If the first line is a "+" 
> line, the line number needs to be set to 1, otherwise the patch will not 
> apply.

I do not think line number information should be discarded.  If you have
two blocks of lines that look alike, the line number information does get
used to see which place the hunk should apply.

Deleting the common context lines from the beginning, or adding a new
"+added line" at the very beginning of a hunk, is a user error for
somebody who edits the diff.  Because you are not calling apply with
unidiff-zero, the sanity check applies to such a hunk.  Working around the
sanity check by discarding the line number information to make the patch
application even more error prone is an unacceptable hackery.

> Maybe the easiest would be to set it to 1 regardless of the hunk.

And that is even worse, and I thought you knew a lot better than that.
Sigh...

> Then I understood you not correctly at all when you complained about the 
> "Probably a diff" part.
>
> So what do you want?  Should it be anal, or lax?  You can't have both.

I explained what I wanted to _happen_ in a separate message.  Now to _how_
you would make it happen...

The way you use the return value from here is to cause parse_fragment() to
say "The patch is corrupt".  You do _not_ detect that here.  You are only
counting number of preimage and postimage lines in this function.  If the
next line does not look like a part of the current hunk, you stop counting
(iow, the only side effect you cause is to update oldlines and newlines in
fragment structure) without including that non-patch line, and return.
You let the caller to decide what that next line you excluded from the
current hunk is, because the caller _already_ has logic to decide what is
part of the patch text (it knows not just how hunk meat looks like but
also how hunk headers and "diff " to start the next patch looks like).
You do not want that information or logic here.

So the answer to "anal or lax" is "Neither.  It's none of your business".

>> > +	if (offset > 0 && patch->recount &&
>> > +			recount_diff(line + offset, size - offset, fragment))
>> > +		return -1;
>> 
>> ... and this "return -1" is uncalled for.
>
> Again.  Lax or not lax?

Neither.  This calling site should not even decide.  The only thing
recount will tell its caller parse_fragment() is "I've recounted the
lines, so by iterating that many lines you will reach the end of the
current hunk as I determined.  Decide what the line beyond that is _your_
business, not mine".

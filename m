From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Wed, 27 Feb 2008 16:47:19 -0800
Message-ID: <7voda1nbzc.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
 <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
 <200802261438.17014.lenb@kernel.org>
 <7vir0byoc2.fsf@gitster.siamese.dyndns.org>
 <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org>
 <7vskzeruit.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271605540.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWwZ-00086p-F0
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbYB1Arj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbYB1Arj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:47:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYB1Ari (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:47:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8198126C4;
	Wed, 27 Feb 2008 19:47:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 539B326BC; Wed, 27 Feb 2008 19:47:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75336>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 27 Feb 2008, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>> > Correcting the transport code is important (and should
>> > probably be done...

I thought about discarding the cached refs upon disconnect, but didn't do
that, because presumably a caller might want to:

    transport_get_remote_refs() to find what they have
    decide what it wants
    transport_fetch_refs() to ask for them
    do stuff about the refs obtained
    transport_disconnect() to finish the transfer
    still do stuff about the refs obtained

and such a change would forbid the last step.  But the only reason I
avoided to break such a potential caller was because I did not bother to
check if such a caller exists, and not because I thought the above
sequence is sane, so if you think it is saner to clean up the stale
information upon disconnect, please do so.

> Using a single connection, either by just telling the remote that you want 
> to autofollow tags, and it should therefore include any tags that point to 
> any objects it includes, or by allowing you to list more refs that you 
> want after you've received the pack without disconnecting, would be quite 
> nice, but I agree that it's a longer-term issue.

Yes, that is what I was talking about.

>> You won't know if you need only one object, so seeing that you
>> have T^{} and asking _only_ for T is _wrong_.  Think of a tag
>> that points at another tag that points at the commit.  You need
>> to tell the other end "I have T^{}, please give me T", and that
>> is exactly what the autofollowing does.
>
> I don't see that. If the situation is:
>
>       T - tag     master
>      /           /
> O - A - O - O - B
> ...
> The issue is that our starting set for our side of the negotiation is our 
> current refs, which doesn't include A. I'm suggesting that, for the 
> purposes of autofollow, A should be included.

By telling the other end that we have B, we are implicitly telling that we
have A as well.  Under normal situation, telling the other end we have A
does not help nor hurt anything.  Under abnormal situation (e.g. DNS round
robin switching the other end in the middle), the other end may say "I
dunno about B", but the protocol is designed to negotiate and find that
both ends have A, by following the ancestry chain down, so I do not think
telling the other end that we have A helps that much.  I however think
that such a change would help sweeping potential bugs under the rug by
making them harder to trigger.

By the way, the situation I said your logic would break is this:

    ---o---A---o---o---B
            \
             T---S

Both T and S are annotated tags, pointing at A and T respectively, and
they both peel to A.  As long as you ask for both T and S you may be Ok,
but it feels still wrong.  Commit walkers may grab S, die before grabbing
T (git-native protocol is atomic with respect to objects transfer, so it
won't have such an issue).

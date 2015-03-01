From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 01 Mar 2015 00:41:54 -0800
Message-ID: <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 09:42:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRzRx-0005Li-QG
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 09:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbbCAIl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 03:41:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751513AbbCAIl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 03:41:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E20D937278;
	Sun,  1 Mar 2015 03:41:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXVD540i3Mt+2WUT2Sg3hufBRPw=; b=TiUgwF
	cneiFhURdmT4kP6shwtznNKKiz4OuUZ6hlgEV6cFdxfvyzDcFlcIhsNPtsRAxTEr
	U+rMGqAO88vl/CUNidN/lYIFo3cuk1SfXfhloLCjI5k/P3jdzF3B9ULUiohtDpox
	aPxKKEAqjKD9cSnZvB2EPkj8VKPVxUHXaZvcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGg2mS+pa8KAzjbbQrWxixX+Gfyql6Se
	MV0wVmUqvZZZZw5HpKiaPL/5HkHj98JbG6+EdcE6gASkKHLd+MzXHPivkmpwnWCr
	HQRbETvVhKcYr1sFhg7MZeIr8jYH2SZF187MmPj9x0ejPSyQ/2OXhJsJj3ZTdCz2
	r9yx5t0kzX0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9AFF37276;
	Sun,  1 Mar 2015 03:41:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48B4937275;
	Sun,  1 Mar 2015 03:41:55 -0500 (EST)
In-Reply-To: <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	(Junio C. Hamano's message of "Mon, 23 Feb 2015 22:15:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0BD2FF8-BFEE-11E4-91AD-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264553>

I earlier said:

> So if we are going to discuss a new protocol, I'd prefer to see the
> discussion without worrying too much about how to inter-operate
> with the current vintage of Git. It is no longer an interesting problem,
> as we know how to solve it with minimum risk. Instead, I'd like to
> see us design the new protocol in such a way that it is in-line
> upgradable without repeating our past mistakes.

And I am happy to see that people are interested in discussing the
design of new protocols.

But after seeing the patches Stefan sent out, I think we are risking
of losing sight of what we are trying to accomplish.  We do not want
something that is merely new.

That is why I wanted people to think about, discuss and agree on
what limitation of the current protocol has that are problematic
(limitations that are not problematic are not something we do not
need to address [*1*]), so that we can design the new thing without
reintroducing the same limitation.

To remind people, here is a reprint of the draft I sent out earlier
in $gmane/264000.

> The current protocol has the following problems that limit us:
> 
>  - It is not easy to make it resumable, because we recompute every
>    time.  This is especially problematic for the initial fetch aka
>    "clone" as we will be talking about a large transfer [*1*].
> 
>  - The protocol extension has a fairly low length limit [*2*].
> 
>  - Because the protocol exchange starts by the server side
>    advertising all its refs, even when the fetcher is interested in
>    a single ref, the initial overhead is nontrivial, especially when
>    you are doing a small incremental update.  The worst case is an
>    auto-builder that polls every five minutes, even when there is no
>    new commits to be fetched [*3*].
> 
>  - Because we recompute every time, taking into account of what the
>    fetcher has, in addition to what the fetcher obtained earlier
>    from us in order to reduce the transferred bytes, the payload for
>    incremental updates become tailor-made for each fetch and cannot
>    be easily reused [*4*].
> 
> I'd like to see a new protocol that lets us overcome the above
> limitations (did I miss others? I am sure people can help here)
> sometime this year.

Unfortunately, nobody seems to want to help us by responding to "did
I miss others?" RFH, here are a few more from me.

 - The semantics of the side-bands are unclear.

   - Is band #2 meant only for progress output (I think the current
     protocol handlers assume that and unconditionally squelch it
     under --quiet)?  Do we rather want a dedicated "progress" and
     "error message" sidebands instead?

   - Is band #2 meant for human consumption, or do we expect the
     other end to interpret and act on it?  If the former, would it
     make sense to send locale information from the client side and
     ask the server side to produce its output with _("message")?

 - The semantics of packet_flush() is suboptimal, and this
   shortcoming seeps through to the protocol mapped to the
   smart-HTTP transport.

   Originally, packet_flush() was meant as "Here is an end of one
   logical section of what I am going to speak.", hinting that it
   might be a good idea for the underlying implementation to hold
   the packets up to that point in-core and then write(2) them all
   out (i.e. "flush") to the file descriptor only when we handle
   packet_flush().  It never meant "Now I am finished speaking for
   now and it is your turn to speak."

   But because HTTP is inherently a ping-pong protocol where the
   requestor at one point stops talking and lets the responder
   speak, the code to map our protocol to the smart HTTP transport
   made the packet_flush() boundary as "Now I am done talking, it is
   my turn to listen."

   We probably need two kinds of packet_flush().  When a requestor
   needs to say two or more logical groups of things before telling
   the other side "Now I am done talking; it is your turn.", we need
   some marker (i.e. the original meaning of packet_flush()) at the
   end of these logical groups.  And in order to be able to say "Now
   I am done saying everything I need to say at this point for you
   to respond to me.  It is your turn.", we need another kind of
   marker.


[Footnote]

*1* For example, if we were working off of "what mistakes do we want
to correct?" list, I do not think we would have seen "capabilities
have to be only on the first packet" or "lets allow new daemon to
read extra cruft at the end of the first request".  I do not think I
heard why it is a problem that the daemon cannot pass extra info to
invoked program in the first place.  There might be a valid reason,
but then that needs to be explained, understood and agreed upon and
should be part of an updated "what are we fixing?" list.

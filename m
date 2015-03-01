From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 1 Mar 2015 23:06:21 -0000
Organization: OPDS
Message-ID: <9EB6341F415E41F3A07F9046056ACE13@PhilipOakley>
References: <1424747562-5446-1-git-send-email-sbeller@google.com><CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com><CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com> <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Stefan Beller" <sbeller@google.com>,
	"Duy Nguyen" <pclouds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 00:05:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSCvY-0003Sm-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 00:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbbCAXFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 18:05:32 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:53986 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781AbbCAXFb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2015 18:05:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CTFQC4mvNUPBVFFlxagwJShxJttAKLYgQCgRlOAQEBAQEBBQEBAQE4IBuECgYBBQgBAS4eAQEhCwIDBQIBAxUMDBkUAQQaBgcDFAYBCQkIAgECAwGIIsIRkjcgixKEFwYBAU8Rgw2BFAWKLoVKW4UbhGuFc4V5gxaDPoIiAxyBUD4xgQMIF4EhAQEB
X-IPAS-Result: A2CTFQC4mvNUPBVFFlxagwJShxJttAKLYgQCgRlOAQEBAQEBBQEBAQE4IBuECgYBBQgBAS4eAQEhCwIDBQIBAxUMDBkUAQQaBgcDFAYBCQkIAgECAwGIIsIRkjcgixKEFwYBAU8Rgw2BFAWKLoVKW4UbhGuFc4V5gxaDPoIiAxyBUD4xgQMIF4EhAQEB
X-IronPort-AV: E=Sophos;i="5.09,672,1418083200"; 
   d="scan'208";a="671176023"
Received: from host-92-22-69-21.as13285.net (HELO PhilipOakley) ([92.22.69.21])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 01 Mar 2015 23:05:28 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264565>

From: "Junio C Hamano" <gitster@pobox.com>
>I earlier said:
>
>> So if we are going to discuss a new protocol, I'd prefer to see the
>> discussion without worrying too much about how to inter-operate
>> with the current vintage of Git. It is no longer an interesting 
>> problem,
>> as we know how to solve it with minimum risk. Instead, I'd like to
>> see us design the new protocol in such a way that it is in-line
>> upgradable without repeating our past mistakes.
>
> And I am happy to see that people are interested in discussing the
> design of new protocols.
>
> But after seeing the patches Stefan sent out, I think we are risking
> of losing sight of what we are trying to accomplish.  We do not want
> something that is merely new.
>
> That is why I wanted people to think about, discuss and agree on
> what limitation of the current protocol has that are problematic
> (limitations that are not problematic are not something we do not
> need to address [*1*]), so that we can design the new thing without
> reintroducing the same limitation.
>
> To remind people, here is a reprint of the draft I sent out earlier
> in $gmane/264000.
>
>> The current protocol has the following problems that limit us:
>>
>>  - It is not easy to make it resumable, because we recompute every
>>    time.  This is especially problematic for the initial fetch aka
>>    "clone" as we will be talking about a large transfer [*1*].
>>
>>  - The protocol extension has a fairly low length limit [*2*].
>>
>>  - Because the protocol exchange starts by the server side
>>    advertising all its refs, even when the fetcher is interested in
>>    a single ref, the initial overhead is nontrivial, especially when
>>    you are doing a small incremental update.  The worst case is an
>>    auto-builder that polls every five minutes, even when there is no
>>    new commits to be fetched [*3*].
>>
>>  - Because we recompute every time, taking into account of what the
>>    fetcher has, in addition to what the fetcher obtained earlier
>>    from us in order to reduce the transferred bytes, the payload for
>>    incremental updates become tailor-made for each fetch and cannot
>>    be easily reused [*4*].
>>
>> I'd like to see a new protocol that lets us overcome the above
>> limitations (did I miss others? I am sure people can help here)
>> sometime this year.
>
> Unfortunately, nobody seems to want to help us by responding to "did
> I miss others?" RFH, here are a few more from me.

OK, maybe not exactly about protocol, but a possible option would be the 
ability to send the data as a bundle or multi-bundles; Or perhasps as an 
archive, zip, or tar.

Data can then be exchanged across an airgap or pigeon mail. The airgap 
scenario is likely a real case that's not directly prominent at the 
moment, just because it's not tha direct.

There has been discussion about servers having bundles available for 
clones, but with a multi-bundle, one could package up a large bundle 
(months) and an increment (weeks, and then days), before an final easy 
to pack last few hours. That would be a server work trade-off, and 
support a CDN view if needed.

If such an approach was reasonable would the protocol support it? etc.

Just a thought while reading...
>
> - The semantics of the side-bands are unclear.
>
>   - Is band #2 meant only for progress output (I think the current
>     protocol handlers assume that and unconditionally squelch it
>     under --quiet)?  Do we rather want a dedicated "progress" and
>     "error message" sidebands instead?
>
>   - Is band #2 meant for human consumption, or do we expect the
>     other end to interpret and act on it?  If the former, would it
>     make sense to send locale information from the client side and
>     ask the server side to produce its output with _("message")?
>
> - The semantics of packet_flush() is suboptimal, and this
>   shortcoming seeps through to the protocol mapped to the
>   smart-HTTP transport.
>
>   Originally, packet_flush() was meant as "Here is an end of one
>   logical section of what I am going to speak.", hinting that it
>   might be a good idea for the underlying implementation to hold
>   the packets up to that point in-core and then write(2) them all
>   out (i.e. "flush") to the file descriptor only when we handle
>   packet_flush().  It never meant "Now I am finished speaking for
>   now and it is your turn to speak."
>
>   But because HTTP is inherently a ping-pong protocol where the
>   requestor at one point stops talking and lets the responder
>   speak, the code to map our protocol to the smart HTTP transport
>   made the packet_flush() boundary as "Now I am done talking, it is
>   my turn to listen."
>
>   We probably need two kinds of packet_flush().  When a requestor
>   needs to say two or more logical groups of things before telling
>   the other side "Now I am done talking; it is your turn.", we need
>   some marker (i.e. the original meaning of packet_flush()) at the
>   end of these logical groups.  And in order to be able to say "Now
>   I am done saying everything I need to say at this point for you
>   to respond to me.  It is your turn.", we need another kind of
>   marker.
>
>
> [Footnote]
>
> *1* For example, if we were working off of "what mistakes do we want
> to correct?" list, I do not think we would have seen "capabilities
> have to be only on the first packet" or "lets allow new daemon to
> read extra cruft at the end of the first request".  I do not think I
> heard why it is a problem that the daemon cannot pass extra info to
> invoked program in the first place.  There might be a valid reason,
> but then that needs to be explained, understood and agreed upon and
> should be part of an updated "what are we fixing?" list.
>
--
Philip 

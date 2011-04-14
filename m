From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Fri, 15 Apr 2011 00:21:24 +0200
Message-ID: <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org> <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com> <20110414214230.GB7709@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAUv8-0004NP-SF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab1DNWVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 18:21:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54328 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab1DNWVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 18:21:44 -0400
Received: by pzk9 with SMTP id 9so662002pzk.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=llyepboR9DkDIPQ9WPBJh7WryFP3hiHapga98yUaa8A=;
        b=os1Y4lgtCzkdxo5ZIdJTcvd3Xj6KMAzWCQx/JBCvqab5ApSm/GMZAwDOHiNItIejll
         bh7IYBEY0Y3Nbd7TsmgeLEKaSc82GGR0JG+GUMhQDM3BPUFzbosXD7jVRNXGMTqb8Fym
         fh1SDoYqxmVfG6HcT8LPQ3K7FCk+qM4y2EiIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=fJJEae5vP7MgATXXo1UJJn+5CQJFuTnFoZouQoch8ktFQLLf000UDZhNIEVzOvmWOl
         fyR8OMVncVBxkTqpkhEffSgtmNkSR4XAhD1IitwUlMboTIEw/Nb3wHyROh2jQl822DMj
         eYFUx4MuJTHzsq5lD7cMwe3KI0rtpgSa0IMgg=
Received: by 10.68.37.72 with SMTP id w8mr822203pbj.263.1302819704082; Thu, 14
 Apr 2011 15:21:44 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Thu, 14 Apr 2011 15:21:24 -0700 (PDT)
In-Reply-To: <20110414214230.GB7709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171567>

On Thu, Apr 14, 2011 at 11:42 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 14, 2011 at 11:19:09PM +0200, Erik Faye-Lund wrote:
>> > Or we could just ignore it. AFAICS, this doesn't actually violate
>> > rfc2047, nor rfc5322. The 78-character limit is simply a SHOULD, and
>> > we have up to 998 for MUST. For a single-address header[1], this seems
>> > kind of unlikely to me.
>>
>> True. But since the fix is as simple as it is, perhaps it's worth it
>> just for the clean conscience?
>
> Fair enough. Patch to follow.
>

Thinking about it a bit more, I'm getting a bit more unsure:
- The 78-limit is about user-interfaces, not protocol robustness.
- Since send-email unwraps the line and does not re-wrap it, even if
we have a name like this it's likely that the work gets undone right
away.
- So that means that send-email should probably also be fixed. But now
I'm wondering if we've crossed the point where this will just lead to
less obvious code for very little gain.

So I think I might have over-though this.

>> > [1] For multi-address headers like "format-patch --cc=foo --cc=bar", it
>> > looks like we already break them across lines.
>>
>> Yes, but this is even worse: these fields don't get encoded at all!
>
> Ugh, you're right. That is a totally separate issue, and one I really
> don't want to get into.

Indeed. I have an itch around this area (I've been playing with
porting send-email to C), so I might look at it at some point soon.

> Because it means we have to _parse_ those
> headers and understand which part is a name and which is an address.
>

That part is surprisingly easy: If it contains a '<', then it's on the form
"Foo Bar Baz <foo@bar.baz>". If not, it's "foo@bar.baz" (assuming it's
UTF-8 encoded rfc5322 mailbox'es we assume, which would make the most
sense to me)

> People who use "--cc" or format.headers will have to deal with that
> themselves. I consider both to be somewhat useless, since you can
> post-process the mbox after format-patch is run (or in your MUA).
> Whereas quoting and encoding fields in format-patch is necessary to give
> unambiguous input to the MUA (be it send-email or whatever).
>

I agree. I'm actually a tad surprised we support it in the first place.

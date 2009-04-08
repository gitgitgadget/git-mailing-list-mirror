From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Wed,  8 Apr 2009 09:25:25 -0500
Message-ID: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 16:30:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrYmv-0006Bt-O9
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 16:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758758AbZDHO1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756775AbZDHO1x
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 10:27:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:38976 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbZDHO1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 10:27:51 -0400
Received: by wa-out-1112.google.com with SMTP id j5so69001wah.21
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc:date
         :subject;
        bh=+hRHAQ3UXmZXYauLG/qdk/792pjN+gL2oUEfj63r4Ic=;
        b=ku/XGf0w47MkU6JYMP782ZhTgetGF7r1RnAMHvWk831PS69r0NUqyI2hlQUK3RmFf2
         Ne3HvEB7ZzpZ1K1ueHmhOGplRMNrLVBI5mYTbgyAYqbjsQICwxGoHdTjg0jfh0zbb6nO
         We7qsepkcqXZobiXIS/nBQS+M1YcoAYZlsibM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:cc:date:subject;
        b=he0c6vDwuLNs+JNibBpyIb4/OcQ+2gL6kmVh/FPjdud8xVsSGGXNzJEFu8RyW1FTxo
         /tG189L8w1MqD4ZERRV8IrTLfxxReX1BIVR8SO1AoFBHGWSmZHVUiVZhhts1h27QmK+E
         oa+KcpCRZ4Uqq8AnQlUnxXOm9hl6USXQ3rdVo=
Received: by 10.114.145.17 with SMTP id s17mr782626wad.120.1239200869604;
        Wed, 08 Apr 2009 07:27:49 -0700 (PDT)
Received: from gmail.com (97-116-115-230.mpls.qwest.net [97.116.115.230])
        by mx.google.com with ESMTPS id n6sm8455614wag.32.2009.04.08.07.27.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 07:27:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116083>

On Tue, Apr 07, 2009 at 04:25:17PM -0500, Michael Witten wrote:
>> When sending a patch series, the emails often arrive at the final
>> destination out of order; though these emails should be chained
>> via the In-Reply-To headers, some mail-viewing systems display
>> by order of arrival instead.
>>
>> The --delay option provides a means for specifying that there
>> should be a certain number of seconds of delay between sending
>> emails, so that the arrival order can be controlled better.

On Tue, Apr 7, 2009 at 16:51, Jeff King wrote:
> I'm a little dubious how well this works in practice. Have you done
> any experiments?

I have indeed, and I got better results. Whether that was a fluke,
I can't say for sure.

> [Delivery delays] can be much larger than a few seconds, and this
> won't help at all there.

and

On Tue, Apr 7, 2009 at 18:17, Junio C Hamano wrote:
> I do not think giving N second interval at the sending end would
> help much in the real world. Between your submitting MUA (that's
> "git-send-email") and the client MUA, there are many hops involved...
> any single hop can batch the messages that arrive within a small time
> window before passing them to the next hop, and it can reorder the
> messages when it does so.
>
> In short, the only thing your --delay can control is the arrival
> interval at your outgoing MSA. The arrival interval and order of
> messages are outside your control for later hops.

For the most part, yes, I am operating under the assumption that email
is sent as soon as it is received by any intervening hop (no batch
accumulation). However, I'm also postulating that there always exists
an N that serves as an upperbound on the transit time, regardless of
batching.

That's where these comment comes into play:

On Tue, Apr 7, 2009 at 16:51, Jeff King wrote:
> The reason I am dubious is that you are presumably delaying only a few
> seconds (since anything more would be quite annoying to the user).

On Wed, Apr 8, 2009 at 01:03:
> A multi-second delay is downright annoying. As a sender, I don't think
> I would enable this option.

However, this sentiment doesn't make sense to me.

Firstly, I presume that someone is electing to use this option, so it is
almost by definition not annoying for that person.

Secondly, it seems reasonable to drop into another VC, screen window, or
terminal instance, and then set send-email a-running. For instance, with
a 14-patch series, one could set `--delay 60' and then let send-email
run happily for the next 14 minutes with nary a thought.

However, I think you're coming at it from a different angle:

On Wed, Apr 8, 2009 at 01:03, Jeff King wrote:
> But apparently many readers sort by date received. See this subthread:
> 
>  http://article.gmane.org/gmane.comp.version-control.git/110097
> 
> I am generally of the opinion that if it is a big problem for people,
> they should get a better mail client. But I am also open to suggestions
> for helping receivers on crappy mail clients as long as those
> suggestions do not put a burden on the sender.

and

on Tue, Apr 7, 2009 at 17:08, Nicolas Sebrecht wrote:
> If the receiver wants the patch series be in a good ordered _for
> sure_, he has to switch to a client mail supporting the In-Reply-To
> chains.

Frankly, I don't care how other people's patch series appear to me. I care
about how mine appear to others. Is this irrational? Probably, but I'm kind
of OC; I want my patch series to look like it's in order for everyone.

This has nothing to do with what the receiver wants. This has everything
to do with what the sender wants. I want my patch series to be in order
even for wrongheaded receivers.

So, I never had any intention of forcing a delay on the sending end. It is
strictly for the sending end to use if desired.

On Tue, Apr 7, 2009 at 18:17, Junio C Hamano wrote:
> I think send-email already has hacks to timestamp the messages at
> least one-second apart by shifting the Date: field, so that the
> recipient MUA can sort by the departure timestamp if it wants to (and
> if it can), instead of the arrival timestamp. Is it not working well
> for you?

I have worked with 2 major mail clients that both display by date received:

  * Mac OS X's Mail
  * Gmail

I assume that a not-insignificant number of others also use these clients.
I don't mind letting send-email run in the background for a few minutes if
it means my patch series appear in order.

As you say, Jeff:

> On Wed, Apr 08, 2009 at 12:08:54AM +0200, Nicolas Sebrecht wrote:
>> IMHO, this improvement is broken by design. We try to fix a
>> receiver-only issue by a sender side fix.
> 
> I almost said the same thing: it is really the receiver's problem.
> However, that doesn't mean the sender can't do simple things to help
> hint the right thing to the receiver. For example, we already munge the
> date fields to make sure the timestamp in each patch is increasing.

There's nothing simpler than slowing the rate of outgoing email. It doesn't
even have to be used; it is completely unintrusive and fully automated. It
even works with the confirmation. Best of all, it didn't take much code to
implement.

Sincerely,
Michael Witten

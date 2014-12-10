From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [RFC/PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Tue, 9 Dec 2014 20:36:22 -0800
Message-ID: <CAO2U3QjXvs1FsfsnW1wpgWbRAWLU3kJHYT45wJTG4S1yxxPT6Q@mail.gmail.com>
References: <20141209174958.GA26167@peff.net> <20141209180916.GA26873@peff.net>
 <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 05:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyZ17-0003qU-1y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 05:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbaLJEgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 23:36:44 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36177 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbaLJEgn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 23:36:43 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so1664815obc.34
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 20:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yMRPuQHPeLx7hV/BSD8xRm1d8J4jLNw+tlV1tBk/Zyc=;
        b=aInI9MT0odao6lIRawGCIVHJdtNxvl81GjYMzTgnywZMQ5d5QWgNeHCAiVOEV9DB4Z
         FTpcZRO19/Fi/98zofhiAANd+JyIg0/e6YW/AKlrM5BcPeN8Caw6c+L/htpM8xqVkL5e
         W3s5qOP3D7WcLGWqFUNbc63az1GC8YitX/rFn1UyCHQTB9hJW4LL576Sz+tlTdH4w2OI
         xFccuCpGQrcmIS+FwoLM/m1tRFGXLWZTURwXNx+80TEw/OcOGBEGhu9Crsz78RucK+09
         2QGKcVp3ILundPnxJb20AJAMFgGnZ7KBWSiEuNE93GteyrihVNBJfsn3TuDzhE3120r0
         Zo9w==
X-Received: by 10.202.48.82 with SMTP id w79mr1239418oiw.30.1418186202849;
 Tue, 09 Dec 2014 20:36:42 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Tue, 9 Dec 2014 20:36:22 -0800 (PST)
In-Reply-To: <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261187>

On Tue, Dec 9, 2014 at 2:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Dec 09, 2014 at 12:49:58PM -0500, Jeff King wrote:
>>
>>> Another option would be to use a static strbuf. Then we're only wasting
>>> heap, and even then only as much as we need (we'd still manually cap it
>>> at LARGE_PACKET_MAX since that's what the protocol dictates). This would
>>> also make packet_buf_write more efficient (right now it formats into a
>>> static buffer, and then copies the result into a strbuf; probably not
>>> measurably important, but silly nonetheless).
>>
>> Below is what that would look like. It's obviously a much more invasive
>> change, but I think the result is nice.
>
> Yes, indeed.  Is there any reason why we shouldn't go with this
> variant, other than "it touches a bit more lines" that I am not
> seeing?
>
>> Let's switch to using a strbuf, with a hard-limit of
>> LARGE_PACKET_MAX (which is specified by the protocol).  This
>> matches the size of the readers, as of 74543a0 (pkt-line:
>> provide a LARGE_PACKET_MAX static buffer, 2013-02-20).
>> Versions of git older than that will complain about our
>> large packets, but it's really no worse than the current
>> behavior. Right now the sender barfs with "impossibly long
>> line" trying to send the packet, and afterwards the reader
>> will barf with "protocol error: bad line length %d", which
>> is arguably better anyway.
>
> Anything older than 1.8.3 is affected by this, but only when the
> sending side has to send a large packet.  It is between failing
> because the sender cannot send a large packet and failing because
> the receiver does not expect such a large packet to come, and either
> way the whole operation will fail anyway, so there is no net loss.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm getting failures on my mac too, I assume filesystem-related.

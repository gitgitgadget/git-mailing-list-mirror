From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] transport-helper: check if the dry-run is supported
Date: Tue, 21 May 2013 22:07:06 -0500
Message-ID: <CAMP44s1Ne-+RZ5r-vNnvs+LhqL+QeMbfq9=Nmffkd9=A6RpNTw@mail.gmail.com>
References: <1369099924-13763-1-git-send-email-felipe.contreras@gmail.com>
	<7vli78p920.fsf@alter.siamese.dyndns.org>
	<CAMP44s14ZBUYhxDkSwjoi+6JPx4whfQDhiq_4QfMteALsbuQ_Q@mail.gmail.com>
	<7vip2blu1k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 05:07:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UezOn-0007rf-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 05:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab3EVDHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 23:07:09 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:60875 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab3EVDHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 23:07:08 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so1459550lab.1
        for <git@vger.kernel.org>; Tue, 21 May 2013 20:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qrq5iK95J7rWf7M3K0HTXj3stLVgzq4bVfEP8R4P/3U=;
        b=R1gugSa/fbykU9/QFRieegY3zLRlYcBqWLi6VIDqKZ1+rp5lv4x9N575lmjxI1DswD
         NVPO2rKl16EHMY3Xxy9GOat991j2dFcwexnxth8c+fZaY1zenzAbonMtM69qUVqkJVEY
         0EnAT/FwHmlpr4RYATW2uxyBJT0fU3tynnWHUE/wuQcNobdkAX3aIwevk5UsBEti+3C7
         mKPFt9neSrE5HFmfS61rvKZov+N9P0IriK33qfzdJO0aFtpPRjZ0uvJz1CLksFcdlbJ6
         z1CWffP1F+KTIJFQwkDWsvv7UbivjdjCFIFFfoaJked31gKTyymvwoYNIqTXYH6G1J3v
         FVlg==
X-Received: by 10.112.145.72 with SMTP id ss8mr3091974lbb.12.1369192026702;
 Tue, 21 May 2013 20:07:06 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 20:07:06 -0700 (PDT)
In-Reply-To: <7vip2blu1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225123>

On Tue, May 21, 2013 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, May 21, 2013 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> This sounds like a good thing to do.  Perhaps the refspec mapping
>>> can be handled the same way as a backend feature so that you do not
>>> have to unconditionally disable it in the other patch.
>>
>> With my patch the remote helper doesn't need to know about the refspec
>> handling at all, it just works magically.
>
> The consumers of "git fast-export" do not need to know how to flip
> refspecs when consuming output from "git fast-export", because you
> taught "git fast-export" to do the mapping.
>
> But doesn't that coin have a flip side?  When somebody else (not
> git) generates a fast-import stream, because these consumers are not
> prepared to flip refspecs, they cannot rename while importing.  All
> the producers have to be taught to do the ref mapping.

Not true. There can be an intermediary in between.

> I do not know if this matters in real life, and even if it did, in
> the eventual ideal world, both importers and exporters would learn
> to do so.

No. Only one side *needs* to learn that.

> So I do not think what you did in your patch is a bad
> design in that sense.  It is a half step in the right direction.

What is the other step, and how would that benefit anyone?

> I however found it somewhat ugly that the interface to specify set
> of refs to traverse history to find the set of objects to export
> stays the same as before, and the ref-mapping arguments are bolted
> on to the machinery, without having any relationship between them.
> The user is free to tell it to export only 'next', while telling it
> to map 'master' to 'trunk', for example.
>
> This is an external interface that is exposed to any users of "git
> fast-export", so if we go that route, we would have to keep that
> interface working forever, even when later somebody else wants to
> add an interface that only requires ref-mapping arguments (and infer
> what is exported from the left hand side of the refspecs).

Not true. We don't *have* to keep anything forever, we are free to
decide anything we want, and live with the consequences.

If a better approach is found, we can remove this interface in v2.0,
or v3.0, or even v10.0.

Why are we shooting ourselves in the foot in the meantime? We already
have something that works perfectly fine.

Now, I specifically asked if such an interface would make sense,
because there are too many warts, and I did not receive a satisfactory
answer in my opinion. I will explore this interface once more, but I
never received any positive feedback from yours that we indeed want to
teach 'fast-export' to parse refspecs, it's just that the interface to
do so was not ideal; you explicitly said you thought it made more
sense on the other side; the receiver.

-- 
Felipe Contreras

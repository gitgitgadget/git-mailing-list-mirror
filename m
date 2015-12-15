From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 16:09:01 -0800
Message-ID: <CAGZ79kZGjCy-o=2hO22=4=n2JqUsEG+dqOZFP4Hhf5E72B-_JA@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
	<CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
	<xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
	<20151214235736.GA26133@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:09:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8dAz-00082s-47
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 01:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841AbbLOAJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 19:09:04 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35990 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbbLOAJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 19:09:02 -0500
Received: by mail-io0-f175.google.com with SMTP id o67so1871887iof.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kQAyLgbsNKoZ/I05/qGdGyHIuGT6bQNnVVSrrO4XKDE=;
        b=f+8AEXVIo4r+QOgx6iuP5VtEiFevzyNHY+gbTLfJqxd/HsOQcS6pHbrDC3dpo4LuU9
         ZZeaZGvEa2hoiPopqSm+VSm9vYa8eca2rlgEBDXBre5t88/PYB2+SQVJEHwVih6uhZ2u
         HQ185pHccEXUlopEDogEkR8wB/PVrvxbKQiByITzNhYUvb4lYgLMLkwDXD6lPKME//nm
         icEAP8cFfwCJHwMY9mklaN2opi389a1xo71CvNg7AynPKweY1HKKQeUt81vPlFqW6OUt
         CLty+UREL+EwGzJYRLVijQ7VRxDEKMkqFbdXTKUVk521gu4EBPhai5RuuQAWqXSY7+Cw
         pQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kQAyLgbsNKoZ/I05/qGdGyHIuGT6bQNnVVSrrO4XKDE=;
        b=GETZOgm6631F3x++QLz43BOjJb33ijPZWmJ1jmHeUKhF4/lcl3ztf3s9vcaTFVDski
         rByaGA4FLQktatv7niDMIjNzFlBc77smeEeio/VmdxcV26otHIQFMHh4J4M0vaI6hwQ+
         b0rlE9QpCHi9hz2LzB0k6vfJgRF9aWF+k/ZsZwakGxkIp7miNiq0F2GnF+M5rU2seuoz
         M7hNiHARNoOcJia/VtrGLfDzIRr4WJPP9PgcCzQMQ9mzmRiF+982ocQmMBQgHCh59rMw
         l3/7CCLvOj1c+DG8sr7D7q9QlShM3DtwO5UEcWsG6Md5XVgqU08aC8b0C1S1lBjo+pal
         1jpw==
X-Gm-Message-State: ALoCoQmUgsLGBRGugDaFzTaBWDlLfjUHDSYcCzdTuCznoEJqKKlEIm5VcEHM7OL3tLNs/PwIGTySAKTsuHtpau5fGU4ZnL6vPApwBvmtwFbwqyYb2U2c8Mk=
X-Received: by 10.107.168.157 with SMTP id e29mr31591714ioj.96.1450138141430;
 Mon, 14 Dec 2015 16:09:01 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 16:09:01 -0800 (PST)
In-Reply-To: <20151214235736.GA26133@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282455>

On Mon, Dec 14, 2015 at 3:57 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 14, 2015 at 03:15:29PM -0800, Junio C Hamano wrote:
>
>> -- >8 --
>> From: Stefan Beller <sbeller@google.com>
>> Date: Mon, 14 Dec 2015 11:37:13 -0800
>> Subject: [PATCH] xread_nonblock: add functionality to read from fds without blocking
>>
>> Provide a wrapper to read(), similar to xread(), that restarts on
>> EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
>> handle polling itself, possibly polling multiple sockets or performing
>> some other action.
>
> This makes me wonder why we restart xread() on EAGAIN in the first
> place.
>
> On EINTR, sure; signals can come and we want to keep going. But if do
> not have non-blocking descriptors, it should never happen, right?

right.

>
> Are we trying to protect ourselves against somebody _else_ giving us a
> non-blocking descriptor? In that case we'll quietly spin and waste CPU.
> Which isn't great, but perhaps better than returning an error.

Yes.
This sounds like a good reasoning for 2/8 (add in the poll, so we are
more polite), though.

This patch is a prerequisite for 4/8, which explicitly doesn't want to loop
but a quick return. Maybe we could even drop this patch and just use
`read` as is in 4/8. Looking from a higher level perspective, we don't care
about strbuf_read_nonblocking to return after a signal without retry.

>
> -Peff

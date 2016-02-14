From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] remote-curl: Include curl_errorstr on SSL setup failures
Date: Sun, 14 Feb 2016 10:04:24 -0800
Message-ID: <CAJo=hJsks9h-PDxrTYWOh0xEz150-q3gjyGNz9p3qhdqqQUM2A@mail.gmail.com>
References: <1455413974-25147-1-git-send-email-spearce@spearce.org> <20160214165048.GA10219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 19:05:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV135-0004Eq-4q
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 19:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbcBNSEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 13:04:45 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35606 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbcBNSEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 13:04:44 -0500
Received: by mail-vk0-f47.google.com with SMTP id e6so92470106vkh.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V8qCOxnhzn5L59r6Q1I732wgFGiaA5g6kLv2p2N70q4=;
        b=cGJUH7cngCtHOJDd8EctD+7+f9t3+nFmfWtR7cqa38i1qDsWUurGF06/oEH0kmkFnw
         y1VJrHAFjCyTOwvHF9j5NERW6GTRHSMgHiwSOs8rA/SrcrtBZuSa+x0fnyxNVoQXE763
         O2JPPU4pYodL+Az7EAkFBxHs6oR2Bh7eeVk+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=V8qCOxnhzn5L59r6Q1I732wgFGiaA5g6kLv2p2N70q4=;
        b=S4lWB7BzLFX9CLB+3sPuHnkv0ubb8yFJTagpPsqvTc2noBwaERIt0FHymWXTHrOEYC
         qGZitgNg837w3oFEPlNJroM7yUT/YaVX8lnhBPDgKNFxlPS4wU0DgJaoZxd3MPBwBEYQ
         WSOQ70gIUU8skgdTJGvkt11d7iNcswGSRwOXGt2zOWxAehLeInuqhD0fg/Ynzo3wMtaS
         TZkUgSe46qSjo0WRNyLhUWZbwq0tUr0k4xwVpAN0ocsgkvSjLxKkdqej10c4d9O+3mqy
         7bcWui+lpAGZ4TSiH4L2gr9h3kq0/3ukp73IzsmRxuB5jGXFAoqNJ8R9lMQ/3Fb7IE5J
         pxZw==
X-Gm-Message-State: AG10YOS4GYiw2VLqUTOhOVbWvEKJ+TbrgDvI3LgeHYnB6b7UQAQaIK4S/LmLAVBZf8k80OC0jMmtSJ0jPFdTsQ==
X-Received: by 10.31.54.207 with SMTP id d198mr10220590vka.119.1455473083920;
 Sun, 14 Feb 2016 10:04:43 -0800 (PST)
Received: by 10.103.71.211 with HTTP; Sun, 14 Feb 2016 10:04:24 -0800 (PST)
In-Reply-To: <20160214165048.GA10219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286160>

On Sun, Feb 14, 2016 at 8:50 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 13, 2016 at 05:39:34PM -0800, Shawn Pearce wrote:
>
>> For curl error 35 (CURLE_SSL_CONNECT_ERROR) users need the
>> additional text stored in CURLOPT_ERRORBUFFER to debug why
>> the connection did not start. This is curl_errorstr inside
>> of http.c, so include that in the message if it is non-empty.
>
> I think this is an all-around improvement. GitHub sometimes get support
> requests for result=18 on a git-push, which is curl's code for "I dunno,
> the remote end hung up". Having a human-readable message may make things
> less confusing.

I have been trying to recreate the error 35 scenario, but after almost
a day of continuous attempts with a suspected broken Git I thus far
have not been able to reproduce it. *sigh*

What made me pick this up was I got another recent report of a Debian
system having trouble connecting to $DAY_JOB's HTTPS server, which
reminded me of [2]. I was going to revive that patch, but instead
decided to expand on the error reporting.

[2] http://article.gmane.org/gmane.comp.version-control.git/206770

> Unfortunately I cannot seem to create the problem at will to confirm
> that it kicks in in this case[1], but it seems like it should just based on
> reading your patch.
>
> -Peff
>
> [1] I tried inserting "exit(0)" in various places of receive-pack, and
>     it seems make the protocol deadlock. Yikes.

This actually doesn't surprise me. *sigh*

With all the pipes and libcurl in there, we must somewhere be ignoring
the fact that the HTTP server closed the connection.

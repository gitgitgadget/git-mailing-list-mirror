From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Sat, 13 Feb 2016 18:14:31 -0800
Message-ID: <CAJo=hJv-GWZOsv31iekW+AdNazLGQ=XYD=UXMO+RuB15baTsow@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com> <20160210214945.GA5853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 03:14:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUmDA-00083D-OS
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 03:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbcBNCOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 21:14:53 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33086 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbcBNCOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 21:14:52 -0500
Received: by mail-vk0-f49.google.com with SMTP id k196so85875953vka.0
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 18:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mxS+p8HiPWM2lu5pY4ttMnpnCp2yGQhhbz0IF6KfhsE=;
        b=Rsxaljaez4e8niV6+L5CUpLqhv+5b3HZ+WFymR/jhO+J2IVugvl65sLDsKYM5mtIWY
         7DxKmTsUsvgQaVzlqIhrK0fDG/QQ5yOd6p+/KGZdAw707w4ZY945VltJMgqz5dl36/9J
         bYq9p4HPod7qViCjX8ChapWmkr6hRJLRF93nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mxS+p8HiPWM2lu5pY4ttMnpnCp2yGQhhbz0IF6KfhsE=;
        b=gXf4aQcLysrwmk3KZqJJodb4XsvlKpUY/gUQStu/CgJPdyZX39Ur+pKPUQddlNimdZ
         zgxAJZSzKv8tRa9szVWgVkdiE31bGm/PQmIt1nauaHZ+R/+3xgYXhCJoh/95iPdt0byJ
         KLrQuzQGdDUNGRqE1OayoRgypVyyEv92Jkp8t/CNmehtG031YKDgAN+ra4nEcDbMcnTB
         8OIwSGZ9myoB1FSfGXjSYOyiOXgKSaAS9A7mLWugvorf7olQmhyxl7bmwmDkz5ALteWJ
         mze6asdHgDeiCPXYlwhclWgsI01vJ2qR8J4SwrFxstIHQYc6g2og+t0OyFXBJ2N6Gk91
         KPCQ==
X-Gm-Message-State: AG10YORQ7XmazwKF2vpOb4GVx+umFuA4vQy6knliks/6suL0iXHeS5q/DOC1tx/w/PSfOwuITJcBSNtjL7ogBQ==
X-Received: by 10.31.133.19 with SMTP id h19mr7469634vkd.127.1455416091286;
 Sat, 13 Feb 2016 18:14:51 -0800 (PST)
Received: by 10.103.71.211 with HTTP; Sat, 13 Feb 2016 18:14:31 -0800 (PST)
In-Reply-To: <20160210214945.GA5853@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286133>

On Wed, Feb 10, 2016 at 1:49 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 10, 2016 at 12:11:46PM -0800, Shawn Pearce wrote:
>
>> On Wed, Feb 10, 2016 at 10:59 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> >
>> > ... Thoughts?
>>
>> Several of us at $DAY_JOB talked about this more today and thought a
>> variation makes more sense:
>>
>> 1. Clients attempting clone ask for /info/refs?service=git-upload-pack
>> like they do today.
>>
>> 2. Servers that support resumable clone include a "resumable"
>> capability in the advertisement.
>
> Because the magic happens in the git protocol, that would mean this does
> not have to be limited to git-over-http. It could be "resumable=<url>"
> to point the client anywhere (the same server over a different protocol,
> another server, etc).
>
>> 3. Updated clients on clone request GET /info/refs?service=git-resumable-clone.
>>
>> 4. The server may return a 302 Redirect to its current "mostly whole"
>> pack file. This can be more flexible than "refs/heads/*", it just
>> needs to be a mostly complete pack file that contains a complete graph
>> from any arbitrary roots.
>
> And with "resumable=<url>", the client does not have to hit the server
> to do a redirect; it can go straight to the final URL, saving a
> round-trip.

It occurred to me today that to make the above ("resumable=<url>") as
efficient as possible, we should allow HTTP clients to include
&resumable=1 in the GET /info/refs URL as a hint to the server that if
it serves a resumable=<url> it can shrink the ref advertisement to 1
line containing the capabilities.

Clients are going to follow the returned <url> to get a bundle header,
which contains the references. And then incremental fetch from the
server after downloading the pack. So returning references with the
resumable URL during a clone is an unnecessary waste of bandwidth.

We could also consider allowing resumable=<url> to be relative to the
repository, so that on HTTP schemes a server could just reply
resumable=pack-HASH.info or something short and not worry about
overflowing the capabilities line.

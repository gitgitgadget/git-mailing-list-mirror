From: Per Cederqvist <cederp@opera.com>
Subject: Re: [PATCH 2/2] pager_in_use: make sure output is still going to pager
Date: Tue, 11 Aug 2015 09:48:50 +0200
Message-ID: <CAP=KgsSnHg_007oMXdHYQZQWwL4McUTS8ty4-MYe-=3QB8+d8Q@mail.gmail.com>
References: <20150810051901.GA9262@sigill.intra.peff.net>
	<20150810052353.GB15441@sigill.intra.peff.net>
	<98d092607588cb5c98e7a2deb2163f94@www.dscho.org>
	<20150810172448.GA20168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 09:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP4Ir-0002cU-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 09:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbbHKHsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 03:48:53 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36494 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbbHKHsw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 03:48:52 -0400
Received: by lbbpu9 with SMTP id pu9so81007756lbb.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 00:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=im7+3cGk8La9oz06JXrIxJ0NiGyMZw0lRynFJnYeAtQ=;
        b=B+dSW/WHlmRNvkqJ1ayHghBtdzYKyKyP7A8qJWBETRgJYNO0m8tvfoMjspZT7hVKJC
         r4K2BMZ4Dvj2J0AO9+vqqLPTTyyEeyVxuAa9atC+2QfvfZAGert60hPGvkDridkXsmnM
         l4fYoSKwLXbw43RU1oO1AvNP51F+IY2ocW2jdY7/qfjSR41U8RuRYHXdoZsNdLpeEhGy
         eBpoL4YFQAg8ox8e7VyZCtqdMcONShlnpE9MB23FCxIPgTrWO+GZCAQJOSkzO+ASHr3v
         WWINdMgL+CJAeoNVWl/e6sSYPKjSgM0lHTq3j0Xq96TbzNan/t8fAIQ9lIUMDwT0hGYu
         qDUQ==
X-Gm-Message-State: ALoCoQkMX4xKLbRke02NDhfCQhy9bQOt9AFND/wpZxdz6han55zMaYs8lsRxWk/MfHvx0L234fQS
X-Received: by 10.152.219.3 with SMTP id pk3mr24893146lac.114.1439279330778;
 Tue, 11 Aug 2015 00:48:50 -0700 (PDT)
Received: by 10.25.146.14 with HTTP; Tue, 11 Aug 2015 00:48:50 -0700 (PDT)
In-Reply-To: <20150810172448.GA20168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275675>

On Mon, Aug 10, 2015 at 7:24 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 10, 2015 at 06:38:10PM +0200, Johannes Schindelin wrote:
>
>> > +const char *pipe_id_get(int fd)
>> > +{
>> > +   static struct strbuf id = STRBUF_INIT;
>> > +   struct stat st;
>> > +
>> > +   if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode))
>> > +           return NULL;
>>
>> Just a quick note: it seems that this check is not really working on
>> Windows. I tested this by running this test case manually (because TTY
>> is not set on Windows):
>
> Yeah, I'm not too surprised. I'm guessing your st_ino for pipes are all
> just the same or something. Or maybe S_ISFIFO doesn't pass (we don't
> technically need it, I don't think, and could just drop that check).

If you remove the S_ISFIFO check, you probably need to include
the st_dev field in the pipe id.  Otherwise, you could be unlucky and
redirect the output to a file that just happens to have the same inode
number as the pager pipe. Remember, inode numbers are only unique
within a certain st_dev.

    /ceder

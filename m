From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 12:23:31 -0700
Message-ID: <CAGZ79kaAT1C1XscOmkN8UzeJ7cmwOhxiTu1HsoTwN+HR5H2A5Q@mail.gmail.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-5-git-send-email-sbeller@google.com>
	<20150825190329.GA11271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJon-0005KG-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 21:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbbHYTXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 15:23:33 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35279 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480AbbHYTXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 15:23:32 -0400
Received: by qgj62 with SMTP id 62so112704511qgj.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lrdAdZvqmLX3r30XBJmTSEZc/3HzwAKgwswrYGWofUI=;
        b=NT8HELqJRSMwv/oHMfe2HV/f5vG0Yaxy7UeZOYzbyJHk5tqX+yFMFh9TliIhAuxA50
         fhhmEiMR0oLrYvce1HjdPAlw2w78hNZYSm3ueKw9Ii3Dd6f5VFM2kz7Oh93QT8sPuWCW
         /dRwc7VgnxleXqas+5T1I0dWmmjXjol8MvJVyCvZGdzBKi5mfomcUZvSrsxkn0333T3L
         nA38t9aUkJkXkMmW+CWMuj7Oaix20099W7S2c1bJ0ndmNo0Op3UtLy2JU0OCOsfMXDs3
         Wb5wgcW6KlfOJ/dg3vYjTAmndm7uTyxggjkzZGV22g2U4MXBHNyznlseONNyrVU2Ov4k
         lEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lrdAdZvqmLX3r30XBJmTSEZc/3HzwAKgwswrYGWofUI=;
        b=YZONTN08X2cGGCJ3PWunzaN4Lh9d3mjlBaXv3QxiYD0m0G25oT68ef1Czc3nZ6Ek2e
         +tgNH/zQ4LGArTPmE6muBfDS9YiATtzfamP4tCt0FZRgJ/AAV1zKYPIiSD1+KSG7vXxF
         6iYjvpj2opi01ajLAEOD58nbE9Pp2oXHCht8oQozg/S5RyjaHQ//67jzlk0rU55NKHo/
         7E7zgdkBOcSDIs61raX/m1Asc14drGXVtc2jjzpm3UPMjUQRXWZdMx/J1LMoCdQVowD7
         lUcg5D74V2/1uj4smhoTdVx5my1BNAzu1xOXKMfzP/0qqjfa2qpP0gv7dGrmN9IYe/2s
         8wrQ==
X-Gm-Message-State: ALoCoQmB1CbPSyme55LCD+4+III7dYc9aqhnoYDep66q6KjILgZbTO3TGptnTAMkjW8uWRQrh4yG
X-Received: by 10.140.133.67 with SMTP id 64mr72697164qhf.52.1440530611954;
 Tue, 25 Aug 2015 12:23:31 -0700 (PDT)
Received: by 10.140.41.198 with HTTP; Tue, 25 Aug 2015 12:23:31 -0700 (PDT)
In-Reply-To: <20150825190329.GA11271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276563>

On Tue, Aug 25, 2015 at 12:03 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 25, 2015 at 10:28:25AM -0700, Stefan Beller wrote:
>
>> By treating each object as its own task the workflow is easier to follow
>> as the function used in the worker threads doesn't need any control logic
>> any more.
>
> Have you tried running t/perf/p5302 on this?
>
> I seem to get a pretty consistent 2%-ish slowdown, both against git.git
> and linux.git. That's not a lot, but I'm wondering if there is some
> low-hanging fruit in the locking, or in the pattern of work being
> dispatched. Or it may just be noise, but it seems fairly consistent.

I did not run any perf tests, just the standard tests.

Maybe the progress display can be moved out to another thread,
such that it doesn't block the threads doing actual work.
Also the progress display can be done a bit more sloppy,
we are allowed to drop old events, if we have newer information.
[Though this reasoning is not looking at the threading pool code,
because ..um.. my code is perfect]

>
> -Peff

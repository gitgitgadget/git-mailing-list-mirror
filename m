From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] error: save and restore errno
Date: Tue, 18 Nov 2014 17:41:17 -0800
Message-ID: <CAGZ79kbNatX51P3kocndyR+UVeACQR_u3OhkZiJmZrq_UBoJxg@mail.gmail.com>
References: <20141119013532.GA861@peff.net>
	<20141119013710.GA2135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:41:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquGp-0002Wj-A1
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbaKSBlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:41:19 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39339 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547AbaKSBlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:41:18 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so5986731obc.4
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 17:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=buIM6w/QpoDUCpqNGmlTTUy7kanNaBZs4jQRZK9mfz4=;
        b=Ry04ifTagXaUP9GcqZNhMMh4n1R9KyG+gN4yz5bxHsufGq/3nNSfPGKDySohR/TeUv
         jEV4KeGgXHiZC/9vuWD/OpmlvFW77z/7wi9SwwEAmqQM7jIy+lgOgxkGWsG7MKu2dm3L
         Kn7pJuWl+EMu++V54NS1uE4PvcJVv+nIoaYYaAibIjvDI73R07UhVm8tIBkBzvHCPyVz
         0bczAoGPMVGdab4+dgxV2m8deopUihLIsyP/grgaD2CEaHkUS5TSgREdEQ3VVOa0eBgJ
         9awQkSbrG5qJT/pllsZBsoHVdt+FVuI+3xh+FNqYV2rZVDkgJNWDGnoZZfna6RpdxIVG
         QG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=buIM6w/QpoDUCpqNGmlTTUy7kanNaBZs4jQRZK9mfz4=;
        b=Mva+34m0HZXJVsbVmlhoWwtXzhYIbugogSTPivE104jiZsGiZ4g/woYJSP2xmvWwj9
         /47jBw5Uy42Xvw/9MBN1z8lCSLW8qze0ZF3cm+GhXiUPGNW2fNGGkcTBP3+/G4qAVlX2
         5PTlaAjp36Je7AnDhMrUnJGuGlCXGvRNUL1YM343vhkCsqYZWY8Hz4xjE33DrVIxa7qp
         jWvipgOyUhh0N7qxMqab5e5nh8eqBt2cvyHp6aI65m07YxRoiNkx9fyi8ZN787r5r3yj
         R1LUse/s+iczaEPCFaPkYCZy240sr+xznPKx6kF6+1tfiy+HjHTvBRc8M8QhLYBFZIWA
         FGuA==
X-Gm-Message-State: ALoCoQkiELfzdFvj+KacKGdwgJOoQq+ggrCOLyvobkWj3i/u0/Sf7Gv8ZEozMPbD7miyuPZX5i/N
X-Received: by 10.182.79.10 with SMTP id f10mr33664036obx.4.1416361278037;
 Tue, 18 Nov 2014 17:41:18 -0800 (PST)
Received: by 10.76.101.203 with HTTP; Tue, 18 Nov 2014 17:41:17 -0800 (PST)
In-Reply-To: <20141119013710.GA2135@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one makes my day.
A really good fix as it minimizes maintenance burden for checking
incoming patches for that pattern.

Reviewed-by: Stefan Beller <sbeller@google.com>


On Tue, Nov 18, 2014 at 5:37 PM, Jeff King <peff@peff.net> wrote:
> It's common to use error() to return from a function, like:
>
>         if (open(...) < 0)
>                 return error("open failed");
>
> Unfortunately this may clobber the errno from the open()
> call. So we often end up with code like this:
>
>         if (open(...) < 0) {
>                 int saved_errno = errno;
>                 error("open failed");
>                 errno = saved_errno;
>                 return -1;
>         }
>
> which is less nice. Let's teach error() to save and restore
> errno in each call, so that the original errno is preserved.
> This is slightly less efficient for callers which do not
> care, but error code paths are generally not performance
> critical anyway.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It's pretty minor to just handle errno in the callers, but I feel like
> I've wanted this at least a dozen times, and it seems like it cannot
> possibly hurt (i.e., I imagine there are callers where we _should_ be
> doing the errno dance but have not realized it).
>
>  usage.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/usage.c b/usage.c
> index ed14645..ee44d57 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -142,10 +142,13 @@ void NORETURN die_errno(const char *fmt, ...)
>  int error(const char *err, ...)
>  {
>         va_list params;
> +       int saved_errno = errno;
>
>         va_start(params, err);
>         error_routine(err, params);
>         va_end(params);
> +
> +       errno = saved_errno;
>         return -1;
>  }
>
> --
> 2.1.2.596.g7379948
>

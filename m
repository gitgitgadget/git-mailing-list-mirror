From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 05/83] builtin/apply: extract line_by_line_fuzzy_match()
 from match_fragment()
Date: Mon, 25 Apr 2016 11:50:20 -0700
Message-ID: <CAGZ79kYi0seMF12+Y4VxHBJxTh9wo4LUw0A50PYRvZEBvj6SBA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-6-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:50:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulaY-0006UX-AP
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbcDYSuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 14:50:23 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37792 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152AbcDYSuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 14:50:22 -0400
Received: by mail-ig0-f182.google.com with SMTP id g8so82678119igr.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mw2yB8sJZGtL3G1RSIW0UNfFCXNalFJOjMVhY+4SVTo=;
        b=NGuhqVlYE+BFUCmXVtF9/1BVbZmRxrZIIZ3wChiI5qtXJR4v+JAjzKyD+xs6qrf+gy
         q3tSXHqXjUr49kYSlnZiMey8mcJeoZF8PkLX1X1FJZ0O6LrRn14prfwcBhm7JYsRGu1c
         QNAEEZ0tpEeNy1C+09tzfmIX3dFtT2jrA3sF9BClh5RgY+tjugdFjiVXLVt5ofLUMXbO
         GyuNHGBR9m3dIoQUG/HfqniAJ178zS7ROhhtCaaYSKgW5Mgeo6euc/tF1ITMSWr8LNyA
         vF2ZJZXKv+JxbhalXKpyxr1P1kEuplCLZmYKQ0WAvMXYZNZhb9B3ybDTmRtAblYB54Pq
         mqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mw2yB8sJZGtL3G1RSIW0UNfFCXNalFJOjMVhY+4SVTo=;
        b=hRFOMCFZCcubuppelpPbw3m2k/Cr3Ga/iFLQEBeo1i3UCSA7o+NjpHHmeKbCJeQu3s
         PCROgrZdh0GlacKVJTFDjgYWCPXRhpl9tYhyPrCdo2XQl7rol6XtqSXRfkfoyAcmGS+C
         h+TTcLGy1Ggfossh9I5H0kMaINxt89lY4c6mZM+PY02bdyinJ2npPNGbMgLSzkjjIzC/
         2voqwZX8RYePU7GmejnU64SBp3q/0ZIsU5ZgzCe0QsxFSPARdT3K51UhDuFIqJukYzFD
         4Ug6M3+9voerzPf/9hvxglxyGnRXZIleBu3ndr5Dav0GmFYCbeTc+5zISyqMxkZWaeLo
         XvUw==
X-Gm-Message-State: AOPr4FW8s9yf1OF6eaJ3tjk3ud8qdukt+GaACHjIKYZBPXD7I8NgQaZH/NNK9JhGrk0Iuu812/hk01EkygpGYDJT
X-Received: by 10.50.98.195 with SMTP id ek3mr14436108igb.85.1461610220283;
 Mon, 25 Apr 2016 11:50:20 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 11:50:20 -0700 (PDT)
In-Reply-To: <1461504863-15946-6-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292544>

> @@ -2251,7 +2319,7 @@ static int match_fragment(struct image *img,
>                           int match_beginning, int match_end)
>  {
>         int i;
> -       char *fixed_buf, *buf, *orig, *target;
> +       char *fixed_buf, *orig, *target;
>         struct strbuf fixed;
>         size_t fixed_len, postlen;
>         int preimage_limit;
> @@ -2312,6 +2380,7 @@ static int match_fragment(struct image *img,
>                  * There must be one non-blank context line that match
>                  * a line before the end of img.
>                  */
> +               char *buf;

patches 1-4 looking good, with no comment from me. Here is the first spot to
comment on.

It's not clear why we need to declare buf here? Oh wait it is. It's just
moved from the start of the function. But why do it in this patch?
It seems unrelated to the general intent of the patch. No need to reroll
for this nit alone, it just took me a while to figure out it was an unrelated
thing.


>                 char *buf_end;
>
>                 buf = preimage->buf;

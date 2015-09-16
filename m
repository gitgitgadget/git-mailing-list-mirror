From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Tue, 15 Sep 2015 23:19:21 -0400
Message-ID: <CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 05:19:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc3Fo-0006Ew-Af
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 05:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbIPDTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 23:19:23 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34196 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbIPDTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 23:19:22 -0400
Received: by vkhf67 with SMTP id f67so93037647vkh.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oId9Jw2FIv7/uJzGon3+qEVmWvIq2cqUwds6YRyCzx4=;
        b=KmLjdM5oQQQZ4XCus1oWNWQ0zPSDX6MhmveIcpKr5E0aw9oSKc0JaeOnZWzMYFfZLa
         /Pazy6vq/v2g2zRK9WhVb5V3V7VIVBC1v9KIbIEf8nNxYXEygUSVRFacx5/tQKmbC0M2
         yDTX77Ux58LGlAusJRIBZ9QZlfTMIu/SDt0Dzstrmk/an2wezCsax9xNAs4UcUrFNl7P
         qNHkseZbg8xkxbl9nCROdwXfJL+PNoXOKt/3t5EmAbLG3+isR6QQQ0DDGrKs/2cJg57y
         OkDD2wUFSSZksxXkQczXQLpLcsYmk1HGY/rNf+EiH/7QwJBBw0f2HToznv0qGPQY2UNw
         oYSQ==
X-Received: by 10.31.49.148 with SMTP id x142mr26438405vkx.117.1442373561394;
 Tue, 15 Sep 2015 20:19:21 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Tue, 15 Sep 2015 20:19:21 -0700 (PDT)
In-Reply-To: <20150915153637.GO29753@sigill.intra.peff.net>
X-Google-Sender-Auth: 0CLRagPwantv61AfVTcPbq7VTws
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277998>

On Tue, Sep 15, 2015 at 11:36 AM, Jeff King <peff@peff.net> wrote:
> We sometimes sprintf into static buffers when we know that
> the size of the buffer is large enough to fit the input
> (either because it's a constant, or because it's numeric
> input that is bounded in size). Likewise with strcpy of
> constant strings.
>
> However, these sites make it hard to audit sprintf and
> strcpy calls for buffer overflows, as a reader has to
> cross-reference the size of the array with the input. Let's
> use xsnprintf instead, which communicates to a reader that
> we don't expect this to overflow (and catches the mistake in
> case we do).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 1a1eafa..1d66111 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -23,7 +23,7 @@ static int merge_entry(int pos, const char *path)
>                         break;
>                 found++;
>                 strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
> -               sprintf(ownbuf[stage], "%o", ce->ce_mode);
> +               xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);

Interesting. I wonder if there are any (old/broken) compilers which
would barf on this. If we care, perhaps sizeof(ownbuf[0]) instead?

>                 arguments[stage] = hexbuf[stage];
>                 arguments[stage + 4] = ownbuf[stage];
>         } while (++pos < active_nr);

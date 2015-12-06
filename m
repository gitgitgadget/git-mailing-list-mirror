From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Sun, 6 Dec 2015 11:46:31 +0100
Message-ID: <CACsJy8DA2Xg9bRmudsRgwy9k=BCawTRU=7bm+rEXv2KoZgoXJw@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net> <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
 <20151204215158.GA27987@sigill.intra.peff.net> <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
 <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com> <20151206063718.GA549@sigill.intra.peff.net>
 <20151206070144.GA17902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 11:47:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5WqU-0002PT-Ps
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 11:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbbLFKrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 05:47:06 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33663 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbbLFKrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 05:47:03 -0500
Received: by lbbkw15 with SMTP id kw15so41683852lbb.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0jMpd69Yw/8+m5rFlgVxOFzI90XM/q1hcGV5D6YFCFo=;
        b=KPe9x+dN4SkraMFECIL23Kl6wvJ3Y8NRWUoRnPF055gUWFNtCc66WNzzHx+Oxoc7Yb
         Yf8hW/2wQUTYCEcldzpvvSqDy4RsjwjgZ7Ldl8TVLIxn4n1q/EXVSYLa8LV2b8qy09Di
         0FBfuXQXp1bW9qc7bwzfXMYTbkvQ2FIuhDLvvKsDu2T1MOiAMN0XUN5IqzSfiO9BzAqe
         zdy6ugv+3IwM5QsJxhe41hEhOQKmMLttroTnpNvNUI1UfJljzs3DZcyUchEDugBiMbB0
         3xzRNZn/a8XJaiQzyV0P0QDIxJTDIMqYJw/sDFE7fZZVjb1G1H4T6cOfS3hf9qr6O/R2
         bP9g==
X-Received: by 10.112.168.70 with SMTP id zu6mr11462442lbb.26.1449398821101;
 Sun, 06 Dec 2015 02:47:01 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Sun, 6 Dec 2015 02:46:31 -0800 (PST)
In-Reply-To: <20151206070144.GA17902@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282047>

On Sun, Dec 6, 2015 at 8:01 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Dec 06, 2015 at 01:37:18AM -0500, Jeff King wrote:
>
>> And indeed, replacing the logic with what I wrote does make the backfill
>> go away in my test case. But it's so far from what is there that I feel
>> like I must be missing something.
>
> I think one thing I was missing is that we need to just grab the
> _object_, but we need to realize that the ref needs updating[1]. So we
> cannot skip backfill of any tag that we do not already have, even if we
> already have the tag object.

It's probably worth adding a few comment lines about this. I did
search back commit history but did not get this.

> Which made me wonder why this:
>
>   git init parent &&
>   git -C parent commit --allow-empty -m one &&
>   git clone parent child &&
>   git -C parent commit --allow-empty -m two &&
>   git -C parent tag -m mytag foo &&
>   git -C parent commit --allow-empty -m three &&
>   git -C child fetch
>
> does not appear to need to backfill to pick up refs/tags/foo. But it
> does. It's just that it hits the quickfetch() code path and does not
> have to ask the other side for a pack. And that explains why it does hit
> in the --shallow case: we explicitly disable quickfetch in such cases.
>
> For the unshallow case, of course we could use it (but only for the
> second, backfill fetch). Something like this seems to work for me:
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ed84963..b33b90f 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -881,6 +881,8 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
>
>         transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>         transport_set_option(transport, TRANS_OPT_DEPTH, "0");
> +       if (unshallow)
> +               depth = NULL;
>         fetch_refs(transport, ref_map);
>
>         if (gsecondary) {
>
> But I admit I am not at all confident that it doesn't cause other
> problems, or that it covers all cases. Even in a shallow repo, we should
> be able to quickfetch individual tags, shouldn't we?

Yes. depth is only non-NULL when you pass --depth (or --unshallow).
quickfetch should happen when you fetch without those options.

> I wonder if we could just always set "depth = NULL" here.

--unshallow is essentially --depth=<max>, so I don't see why
--unshallow should be singled out here. We probably want to restore
depth back (or pass a flag to explicitly ignore the "depth" exception
in quickfetch). For multiple fetches, we spawn new commands so depth
being NULL does not harm. Just in case somebody tries to fetch a
couple more times in the same process in future.
-- 
Duy

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 11/19] pack-objects: use bitmaps when packing objects
Date: Fri, 25 Oct 2013 14:14:11 +0000
Message-ID: <CAJo=hJuDx=3AOoz2oEORVOzeBYBwvOWO_ye8D5d8PcDc3Zm+Ew@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180419.GK24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 16:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZi9u-0000jA-CR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 16:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab3JYOOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 10:14:34 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49815 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3JYOOd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 10:14:33 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so974742wgh.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YqqKT3eigPbpbLIfXow9bVRBaR62Ck/KyMWJV3cVkEo=;
        b=URKW4B75U1nuqN3e8ynZJvknPTkEzE/hMPdV6c+fB8IRzMi1uBUl+UvrYihSAmQWPL
         o1uE27AgTGLjAbjhQEiGp+z09XBL323DMu4n1Bb7ClkxFdIYhJ61ySc9nPxMwqz/zrJH
         rya0TKmSkcfJlup7TtEjNdFyVbjrmQ2WruH5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YqqKT3eigPbpbLIfXow9bVRBaR62Ck/KyMWJV3cVkEo=;
        b=d7xDKfLryd9eBafouEPQg9ZzTKtXG4Qzv6G2T1LxaDemDC+lpQ17HVdtRYR5tOOQ7J
         uwDA5KCXBzDsuP6AfnqHrmTYoFnAswpmEw4qMaz1IBPU6aZbS+iH5eMSeRZYBb9ti61G
         u2nKqxa8vB3YviB2vUIFFGs8CTLlcOycZnMPr2XynsBjFZj4m+a5/eX2d+X4YIiqndJ8
         pqDwdGXnvWf3EpLmlf6K5++1t8KWgafL+aIynqAsBE7RnMkQWMTTWWPOQforLC5aC3Mo
         e87Rg2NgvIL8/KtKwskgcCXBAiPEBfu6cEfTQrtxlDe9MWDOCrQkln3WNt51FYoHpGy7
         QXeA==
X-Gm-Message-State: ALoCoQlPOnz1PEX1Si3u1izxRxZ9gaRFQBcJXDcmhk0sV0hVKjDc9rekth77Y87ATH4J9x8rQp+0
X-Received: by 10.194.206.5 with SMTP id lk5mr7603457wjc.46.1382710472602;
 Fri, 25 Oct 2013 07:14:32 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Fri, 25 Oct 2013 07:14:11 -0700 (PDT)
In-Reply-To: <20131024180419.GK24180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236705>

On Thu, Oct 24, 2013 at 6:04 PM, Jeff King <peff@peff.net> wrote:
> For bitmaps to be used, the following must be true:
>
>   1. We must be packing to stdout (as a normal `pack-objects` from
>      `upload-pack` would do).
>
>   2. There must be a .bitmap index containing at least one of the
>      "have" objects that the client is asking for.

The client must explicitly "have" a commit that has a bitmap? In JGit
we allow the client to have anything, and walk backwards using
traditional graph traversal until a bitmap is found.

> @@ -704,6 +759,18 @@ static void write_pack_file(void)
>                 offset = write_pack_header(f, nr_remaining);
>                 if (!offset)
>                         die_errno("unable to write pack header");
> +
> +               if (reuse_packfile) {
> +                       off_t packfile_size;
> +                       assert(pack_to_stdout);
> +
> +                       packfile_size = write_reused_pack(f);
> +                       if (!packfile_size)
> +                               die_errno("failed to re-use existing pack");
> +
> +                       offset += packfile_size;
> +               }
> +
>                 nr_written = 0;
>                 for (; i < to_pack.nr_objects; i++) {
>                         struct object_entry *e = write_order[i];

Can reuse_packfile be true at the same time as to_pack.nr_objects > 0?

In JGit we write the to_pack list first, then the reuse pack. Our
rationale was the to_pack list is recent objects that are newer and
would appear first in a traditional traversal, so they should go at
the front of the stream. This does mean if they delta compress against
an object in that reuse_packfile slice they have to use REF_DELTA
instead of OFS_DELTA.


Is this series running on github.com/torvalds/linux? Last Saturday I
ran a live demo clone comparing github.com/torvalds/linux to a JGit
bitmap clone and some guy heckled me because GitHub was only a few
seconds slower. :-)

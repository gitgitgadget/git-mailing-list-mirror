From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] pack-revindex: drop hash table
Date: Mon, 21 Dec 2015 02:06:59 -0500
Message-ID: <CAPig+cTD+qknnZ3rH7skcTxZA16AL0BPbLT5ZaJdwwu_d-i=Jw@mail.gmail.com>
References: <20151221061948.GA25763@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAuYl-0000jg-PS
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 08:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbbLUHHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 02:07:00 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36010 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbbLUHHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 02:07:00 -0500
Received: by mail-vk0-f54.google.com with SMTP id f2so57158747vkb.3
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 23:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JIdDA/TO5Vx1IrNn9GfcUX29vmQuCv4a8mZTxIizgcw=;
        b=Y+TvTCdAs3XDgbyw8YVKRdiqHp4n+zKBdcrNmuFo3fKQCQC8aVnNJSoWiyYwaLnD0n
         mhtKmWj+EIKoOwSZvdT5MtmJRU20gHT+b4RmLexYYZIpyXRkad10HQ84cyUd3hliEk55
         //Zzpi/2GbbqhVHKDt0w4l+SGHeOLWzev928NbVH5NRFGhvt1DprRWiTm4+djpfIh+nW
         CIZ9Yx6l9aEYSBdonw+PpVLLTAqLLBzdqqrMX3mb443InxeetWUU3cdP0dngCMLCXpoZ
         7RN50luMOjEOv2Tumt2kvRqMVkGo4cEGDSttBV01PTFO9iZ7mRV3C7maVOaeYe1nCTO7
         26FA==
X-Received: by 10.31.16.226 with SMTP id 95mr11140007vkq.143.1450681619398;
 Sun, 20 Dec 2015 23:06:59 -0800 (PST)
Received: by 10.31.67.138 with HTTP; Sun, 20 Dec 2015 23:06:59 -0800 (PST)
In-Reply-To: <20151221061948.GA25763@sigill.intra.peff.net>
X-Google-Sender-Auth: Z1wlk_BVsdAfuNw8-iWs5fOsmG4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282786>

On Mon, Dec 21, 2015 at 1:19 AM, Jeff King <peff@peff.net> wrote:
> The main entry point to the pack-revindex code is
> find_pack_revindex(). This calls revindex_for_pack(), which
> lazily computes and caches the revindex for the pack.
>
> We store the cache in a very simple hash table. It's created
> by init_pack_revindex(), which inserts an entry for every
> packfile we know about, and we never grow or shrink the
> hash. If we ever need the revindex for a pack that isn't in
> the hash, we die() with an internal error.
>
> This can lead to a race, because we may load more packs
> after having called init_pack_revindex(). For example,
> imagine we have one process which needs to look at the
> revindex for a variety of objects (e.g., cat-file's
> "%(objectsize:disk)" format).  Simultaneously, git-gc is
> running, which is doing a `git repack -ad` is running. We
> might hit a sequence like:

Probably want to drop one of the "is running"s...

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 10:27:26 +0000
Message-ID: <CAJo=hJudyxLP-pSu-=Py6tSHsnbODDFCZ6JxAoRPtfe3opf=5A@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180357.GJ24180@sigill.intra.peff.net>
 <CAJo=hJvw-UNWVDADcGzA1P3GGOKJGh8h4LrETPYnjBNYmfkxjQ@mail.gmail.com> <20131030081023.GK11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 11:28:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbT0P-0007eV-DP
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 11:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab3J3K1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 06:27:50 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:43971 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab3J3K1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 06:27:48 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so1191291wid.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=85bQbtMu5F6fjfs3kyW9dWXIM8ChTsbS53sZB3K7Plw=;
        b=JPjNXta4sfPw9/2FdnMtnOGpZPhQ24eeTkq7SkXpLAxMyxLTWAMdE8BPS23/QIqu1n
         +hPMBqhLif3BU0gudexBrqnMEPJChAQEJbaZIn7P5KbPey+0ORAHg21xZI1lzGuAetnf
         DBhpAzHeec8f0F9hrIWcBJ8pJe/lA52mKZe9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=85bQbtMu5F6fjfs3kyW9dWXIM8ChTsbS53sZB3K7Plw=;
        b=Q0dTNLLF+DzNNGbcNk0i6rjf2TUNvjtPuN1Pfv/fJ0IOQzm4y8lZLaT8GuIOQ4E9U+
         XWqcMLkPr53k+ddpiNcRS7m3FRoRrRp3+Tlrsg03ud2d0dKwhIeskYDO6SDZiCjNGGvY
         z1f9l+/Odjx3SiQ/qjIlmwJ8ZKcxQxoKnngvze4aPxpsLChZlSdezqHPZYHPJSr/5/PO
         Bdi/L3Y8ZMsA3pQwsH41Fo60NuZ8XjNJgMYYW5syQPm13hEiEnX5I4yTseQlOyl1hsrn
         Bs9epya56HEaZRkuykrwL8Hss7C9NinADdhZ0TycYTwE65nY5z+erM8CkWVCl6+FfUsV
         +ofg==
X-Gm-Message-State: ALoCoQkxgpnlLk4e4DQ8koddHIoOnTq9GK4zgnifalv8Ka+pYayvqQijFTvKhy31fNaDoZbpj/QM
X-Received: by 10.180.36.242 with SMTP id t18mr2054529wij.28.1383128866988;
 Wed, 30 Oct 2013 03:27:46 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Wed, 30 Oct 2013 03:27:26 -0700 (PDT)
In-Reply-To: <20131030081023.GK11317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237008>

On Wed, Oct 30, 2013 at 8:10 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 25, 2013 at 01:55:13PM +0000, Shawn O. Pearce wrote:
>>
>> Yay! This is similar to the optimization we use in JGit to send the
>> entire pack, but the part about sending a leading prefix is new. Do
>> you have any data showing how well this works in practice for cases
>> where offset is before than length-20?
>
> Actually, I don't think it kicks in very much due to packfile ordering.
> You have all of the commits at the front of the pack, then all of the
> trees, then all of the blobs. So if you want the whole thing, it is easy
> to reuse a big chunk. But if you want only the most recent slice, we can
> reuse the early bit with the new commits, but we stop partway through
> the commit list. You still have to handle all of the trees and blobs
> separately.
>
> So in practice, I think this really only kicks in for clones anyway.
>
> In theory, you could find "islands" of ones in the bitmap and send whole
> slices of packfile at once. But you need to be careful not to send a
> delta without its base. Which I think means you end up having to
> generate the whole sha1 list anyway, and check that the other side has
> each base before reusing a delta (i.e., the normal code path).
>
> In fact, I'm not quite sure that even a partial reuse up to an offset is
> 100% safe. In a newly packed git repo it is, because we always put bases
> before deltas (and OFS_DELTA objects need this). But if you had a bitmap
> generated from a fixed thin pack, we would have REF_DELTA objects early
> on that depend on bases appended to the end of the pack. So I really
> wonder if we should scrap this partial reuse and either just have full
> reuse, or go through the regular object_entry construction.

Yes. This is why JGit only does whole pack file reuse (minus the 12
byte header and 20 byte SHA-1 trailer). Any other case has so many
corner cases that we just punt into the object entry construction path
and rely on individual object reuse.

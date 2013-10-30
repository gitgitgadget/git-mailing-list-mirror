From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/19] pack-objects: use bitmaps when packing objects
Date: Wed, 30 Oct 2013 17:28:08 +0700
Message-ID: <CACsJy8B3VS=WSNeF35_JTiF6byZiefvEYnadkC8BAmKG5Z7gQQ@mail.gmail.com>
References: <20131025055521.GD11810@sigill.intra.peff.net> <20131025060352.GI23098@sigill.intra.peff.net>
 <CACsJy8DMOfZu+2DS=-J9jfiP796XYi=e7B28cdV=ck9J-VOTtA@mail.gmail.com> <20131030073627.GG11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 11:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbT16-0007wE-NG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 11:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab3J3K2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 06:28:43 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:45970 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab3J3K2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 06:28:39 -0400
Received: by mail-qc0-f173.google.com with SMTP id l13so657093qcy.32
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nwPFBkkR70vGmOlrtZUBJgbKCkGAcO3Fct8CciyTJTQ=;
        b=ykdPOeBWP7h8olbHwokro4ZM2Anrx/9JIm0BFlv4c7CMvVpc/rABf9pRaminHvH7uc
         SiA3TqoJ+vUf54oDuKSUZPvkTIF/+YyT4UQEuQwaQoazsEHBPpV/aU2dt/P1NVK0dMIN
         Y/p2M6LSIZmjLXM65UvQ+t6MeS6Kbp4FE08CSgwhfz80rTZho0x1gSE9ga8X0P629QO8
         /2WFVYCeBiGoDxkTtQlXDq8Ru4oa+Xw1sMrnpSdUjbqfkXHtNHpiDiTt89minU4WZXxc
         j+jvhDZKo7Y50gY7LvcW1zKt+UIACSbXLe1+uPsJhWGbPvFoXPxFNhpXDOFB4b48V8Vp
         5rQQ==
X-Received: by 10.224.88.193 with SMTP id b1mr6826472qam.81.1383128918440;
 Wed, 30 Oct 2013 03:28:38 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 30 Oct 2013 03:28:08 -0700 (PDT)
In-Reply-To: <20131030073627.GG11317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237009>

On Wed, Oct 30, 2013 at 2:36 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Oct 26, 2013 at 05:25:14PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > For bitmaps to be used, the following must be true:
>> >
>> >   1. We must be packing to stdout (as a normal `pack-objects` from
>> >      `upload-pack` would do).
>> >
>> >   2. There must be a .bitmap index containing at least one of the
>> >      "have" objects that the client is asking for.
>> >
>> >   3. Bitmaps must be enabled (they are enabled by default, but can be
>> >      disabled by setting `pack.usebitmaps` to false, or by using
>> >      `--no-use-bitmap-index` on the command-line).
>> >
>> > If any of these is not true, we fall back to doing a normal walk of the
>> > object graph.
>>
>> I haven't read the bitmap creation code yet. But it probably does not
>> matter. If the client requests a shallow fetch, you probably want to
>> fall back to normal walk too.
>
> One other criterion I should have mentioned: we must be using the
> internal rev-list. That prevented us in v1.8.4.1 and earlier from using
> bitmaps for shallow fetches. But as of v1.8.4.2, we always use
> pack-objects' rev-walker. We may need to pass --no-use-bitmap-index for
> shallow fetches.

I don't think a new option is needed. The code just needs to check if
there are any commit grafts. If there are, fall back to the old way.
That covers both shallow fetches and some rare grafted repos. I think
refs/replace/* does not impact rev walking, so we should be fine if
it's used.

> As for repos that are themselves shallow, I do not know how doing a
> "repack -b" would fare. Probably not well.
-- 
Duy

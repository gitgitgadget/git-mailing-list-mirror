From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/19] pack-objects: use bitmaps when packing objects
Date: Thu, 31 Oct 2013 19:03:03 +0700
Message-ID: <CACsJy8DMskq8R5rfz8MFsnB5CRuX=b0Opf31uby7mB22Hg+c2g@mail.gmail.com>
References: <20131025055521.GD11810@sigill.intra.peff.net> <20131025060352.GI23098@sigill.intra.peff.net>
 <CACsJy8DMOfZu+2DS=-J9jfiP796XYi=e7B28cdV=ck9J-VOTtA@mail.gmail.com>
 <20131030073627.GG11317@sigill.intra.peff.net> <CACsJy8B3VS=WSNeF35_JTiF6byZiefvEYnadkC8BAmKG5Z7gQQ@mail.gmail.com>
 <20131030200754.GB23011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 13:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbqyc-0007lo-FA
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 13:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab3JaMDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 08:03:46 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:49379 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab3JaMDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 08:03:34 -0400
Received: by mail-qc0-f169.google.com with SMTP id x12so1585396qcv.14
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qFcWgck4crZ1digpcKk0VgmGh5NXbeL0aZVqpw9f0KQ=;
        b=P4A65GjSI9cM/lQGLJGagrQRq58LTzB81TxDZAU/uckm2xJ+Ml1VrR+uJGnXFAxPlv
         SyCoQHBUj8k2OxN3Iw1MzBROhewzm8HeI7QaFhd5rElq4AAyK24HhlxMVhdxjfxB5DSa
         8m0rz8BdQhVphhzvF1iuWgQEQ5vG0dw7Sdgu/wiVwyzJZNAcw7f8iVkqzvvICi3QvD5Z
         vcNPruAbMJ+0mykOyS2Flbmq0DRaDpRv3JaT3XCdq51SzMWAanuRQF75jy28uvPHpuq1
         Tdg417+tARfp0iW+gRSk4HkQuKkKWvTi+L58jc4Q41e57fXUcEGwmBEXJt6mg8koim/b
         IVGg==
X-Received: by 10.49.71.207 with SMTP id x15mr3419001qeu.49.1383221013940;
 Thu, 31 Oct 2013 05:03:33 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 31 Oct 2013 05:03:03 -0700 (PDT)
In-Reply-To: <20131030200754.GB23011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237121>

On Thu, Oct 31, 2013 at 3:07 AM, Jeff King <peff@peff.net> wrote:
> I think there are two cases that we need to consider:
>
>   1. We have a full repo and somebody requests a shallow clone for us.
>      We probably do not want to use bitmaps here.  In the series we have
>      been testing, shallow clones turned off bitmaps because we do not
>      use the internal rev_list. But as of cdab485 (upload-pack: delegate
>      rev walking in shallow fetch to pack-objects), that distinction
>      doesn't hold. I think we can check the use of --shallow-file
>      instead of explicitly turning off bitmaps there.

There's an (non-existing yet) case 1': somebody requests a clone and
the source clone is already shallow. is_repository_shallow() could
catch both cases.

>   2. We have a shallow clone that wants to repack. We probably want to
>      turn off bitmap writing here. I don't think that grafts actually
>      matter here, because pack-objects should always be looking at the
>      true graph. It would mean that using "git rev-list
>      --use-bitmap-index" does not respect the grafts, and we should
>      probably disable it in that case (and ditto for replacements).

Right. I forgot that the repo must be complete before it's grafted.
-- 
Duy

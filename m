From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 18:24:20 -0500
Organization: Twitter
Message-ID: <1453418660.16226.53.camel@twopensource.com>
References: <1453410708-23951-1-git-send-email-dturner@twopensource.com>
	 <20160121213056.GA6664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 00:24:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMOaZ-0003su-P9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 00:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbcAUXYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 18:24:25 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33953 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcAUXYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 18:24:23 -0500
Received: by mail-qg0-f54.google.com with SMTP id 6so45048677qgy.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 15:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=vMs/L0n9PBGB3pH++xiisnrujIzYAFMjODwm7/VfONg=;
        b=dDcn+aVojkc3xKR8eXf0tiUuq2lEr96leDH305Mp7xmsnOiXAQTD/tCbv84efb9KvW
         DgBrUFawEamJgPgqZG2HSnEVvU/u13sIWHod3P9r+ho/4pod8XPqKDfDps28zgdpA2Ex
         CR3FYkSzj2J878z2m8D2BxcSaS5NnIlKCIzC12CBBUseFRWRn75ya1cHlib7vbnVfJic
         Sn7ogKi8D10HTKAkg/I1fUtrcbrljrGUosbEdyzQmOgdpYsHUgurVYlOjhMimuSF5U+O
         yn+FMSspWhrX7ZX3lbgRqKs0u6M0mhvCjf36mtX2T0RgVoSPqgZm2Hg6Eo36Ow7rkTV7
         cbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vMs/L0n9PBGB3pH++xiisnrujIzYAFMjODwm7/VfONg=;
        b=mIhM1wORLoWlDoLskbyWTYZmDAgMOcVXLTK1j3ULEKJHfIx4PatbEed88C1yrtHScl
         kZ74U6hbuAVaX9936s4drDyQCeSfmHcZYByzWIhLlfpA591M5aJeAaGvTjIkwRoydsik
         4Z458ROpjD5bkvRzs2KIBRhI9ju/Jw31HwY+wJ0gZ2nT2JIQTT3Yzt1kMY/9FOS5DTe3
         pVHINYckCnZi04bES/baFVrfkHmwcE8IWUN699rtQH/hCcwhZsdRtiAyKFZUK6yKKQtP
         /2Jul+CZy6dEddFFERbBG7wNEZ/A2fUxfDmsmSs4K1mqNbfAu16h64OLZlZgyRCBP6qq
         5WlQ==
X-Gm-Message-State: ALoCoQmc5fDjM42FotezrSsvGZ3v47vFerpIi6CHI4f06Vf+9Cdl7zTiXYZcVrS+ZDIPvKdmv5uzvrQdr47+P6L3z1/uESJH9Q==
X-Received: by 10.140.27.139 with SMTP id 11mr55391354qgx.62.1453418662491;
        Thu, 21 Jan 2016 15:24:22 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id d195sm1585792qhc.17.2016.01.21.15.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 15:24:21 -0800 (PST)
In-Reply-To: <20160121213056.GA6664@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284542>

On Thu, 2016-01-21 at 16:30 -0500, Jeff King wrote:
> On Thu, Jan 21, 2016 at 04:11:48PM -0500, David Turner wrote:
> 
> > While unpacking trees (e.g. during git checkout), when we hit a
> > cache
> > entry that's past and outside our path, we cut off iteration.
> > 
> > This provides about a 45% speedup on git checkout between master
> > and
> > master^20000 on Twitter's monorepo.  Speedup in general will depend
> > on
> > repostitory structure, number of changes, and packfile packing
> > decisions.
> 
> I feel like I'm missing the explanation of the quadratic part. From
> looking at the patch, my guess is:
> 
>   1. We're doing a linear walk in a data structure (a "struct
>      index_state").
> 
>   2. For each element, we look it up in another structure
>      ("struct traverse_info") with a linear search.
> 
>      That leaves us at O(m*n), but if we assume both are on the same
>      order of magnitude, that's quadratic.

No, I think, it's the opposite order: we're doing a linear walk over
the incoming tree and for each entry, we're calling find_cache_pos.
find_cache_pos was doing a linear walk over struct index_state.  But
the same algorithmic complexity holds.

>   3. The fix works by knowing that once a lookup in (2) fails once,
> it's
>      likely to fail for all the remainder, and we short-cut that case
>      and skip out of (1) completely.
> 
> But that makes me wonder. Aren't we still quadratic in the case that
> ce_in_traverse_path() returns true? 

I think that doesn't happen very often, because it requires that the
paths match up.  

> If so, would we benefit from either:
> 
>   a. Improving the complexity of ce_in_traverse_path, to say O(log
> n),
>      which would give us O(n log n) for the whole operation in all
>      cases?
> 
>   b. If both lists are already sorted, maybe doing a list-merge to
>      compare them in O(2n) time?

(b) appears to be now (roughly) what we're now doing.

> I'm fairly ignorant of this part of the code, so there's probably a
> good
> reason why my suggestion is unworkable.

I am also quite ignorant of this part of the code; I just looked at
perf and did some simple counting.

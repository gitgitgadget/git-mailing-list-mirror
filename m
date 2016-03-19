From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] read-cache: increase write buffer size
Date: Sat, 19 Mar 2016 18:18:56 +0700
Message-ID: <CACsJy8ABvs822-vtELCm2wvvpxRV6wtEEr5Ge1qxH_zOcqdwSA@mail.gmail.com>
References: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 12:19:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahEur-0000dk-FI
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 12:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbcCSLT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 07:19:29 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35818 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbcCSLT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 07:19:28 -0400
Received: by mail-lb0-f177.google.com with SMTP id bc4so102758774lbc.2
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a9fnqrFw+v02+ghmDLGn6Jpk3jpJ18Dy56QzPiWAKl0=;
        b=xGGJ8F/v8IHKDSdTp+PPDqyUQvazL+vdC1mrntDUFnFOOia6h2QbOtfGsB7mV41PFs
         KJxrH2IobJF7NBpUb3xWmwXr16RuGdCqOVh3XB8WSfOWzbZeUMnI7urRS0U8zrlDC7Uw
         lO69dquYBd0skXZrLIWb6S6dvinXjbVabFONuyIgnPrFjKWv7WVlhmdMaR57mTLO+FVS
         BpsKfRrr9h0ULZzeTlLqvlNdq8Ai/mdQ30qa6Vwa5pRmA8sSdjUDQpsv0eCnxfug9Y+X
         O55TkdwqP2FvH7gceFSeOIDBXZd+ZiK4n1JlafuCi+SPHyBsWXnhQMI4Jep8cG2xV3YL
         Qysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a9fnqrFw+v02+ghmDLGn6Jpk3jpJ18Dy56QzPiWAKl0=;
        b=bDrRq2tzmqCP6Ensijbjt55lc6BYG3EFIpgPJBXWkSgnYKt1Rw0VnZtGc7t0cRh1JM
         3ykKkVLKRQAqxSKP6a+CCfL+OoLQSOPsqECoE1vY5C2Qt9bOyxAdBtjDeSVVCThxhLVu
         Z9CA+tK97Tykw7xBpgESL42fsWUGmSWNuz9qzwdso+fP1ctU3k/QdKW+ia/DW/MaOqVT
         kvgL/t12A6vhCT+wYaVmslAAltAmJJZIhc7F4g0y9k/2oxxffq/3Sz7bTN5piQp9VuYk
         RJZ+g6vg9kN399aFArij5lpZbyuTNrbdU8SWq9aKFkoE4jMIKF+m0dMuBc1ovJuPstKU
         kHKQ==
X-Gm-Message-State: AD7BkJJQ3itPOWVBKKPrVG3oNDoE1OQkMEyeQBnKQunhR+4lVdpPIxjj1gtkQVZCoowU9Mb/PfFPTVwpSOmFng==
X-Received: by 10.112.171.163 with SMTP id av3mr7505976lbc.145.1458386366598;
 Sat, 19 Mar 2016 04:19:26 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sat, 19 Mar 2016 04:18:56 -0700 (PDT)
In-Reply-To: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289302>

On Sat, Mar 19, 2016 at 8:19 AM, David Turner <dturner@twopensource.com> wrote:
> Each write() has syscall overhead, and writing a large index entails
> many such calls.  A larger write buffer reduces the overhead,
> leading to increased performance.
>
> On my repo, which has an index size of 30m, this saves about 10ms of
> time writing the index.

I wonder if split-index does not work as intended. Because if it does,
you should rarely need to write that such big index files (or is this
30mb the small part and the base index is even bigger?).

But I agree with Torsten that we should make this configurable,
preferably via config file, if not we can still move this define back
in Makefile, overridable using config.mak
-- 
Duy

From: Thierry Vignaud <thierry.vignaud@gmail.com>
Subject: Re: [PATCH] git-svn: fix auth parameter handling on SVN 1.9.0+
Date: Sat, 16 Jan 2016 15:00:36 +0100
Message-ID: <CAONrEtbEVwP8VxdYgar5oDtK4q94f5L_nAtFokSo8vVnp0ixog@mail.gmail.com>
References: <20160116101719.GA21147@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	797705@bugs.debian.org, Dair Grant <dair@feralinteractive.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 15:01:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKRQJ-0006Bj-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 15:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcAPOBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2016 09:01:36 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36038 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbcAPOA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 09:00:56 -0500
Received: by mail-qg0-f48.google.com with SMTP id e32so440059803qgf.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2016 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gGXm2rkBPXGAM6tIWGWn5JkIJV7CsUrHlYMsaiFnDXk=;
        b=begoAaLRtlaRZK+PXFqhYrn3zrBp94IpPQ8S36yEthH18H2m1HetVVg8X2k80PLNyd
         W30/OP29AIGW1FPR6SdKrm5gBIHBN01phKnVyS6t6N+pFxS3L5OwN8HuFIIOp1wKrZds
         fCuDlEmCpXpA2Ri5a2VIXqFAPITMJJBhdfBjvQWDPoioxgcN058Oh5pe0jAlXVAQEQiy
         mPU87hOW730X3ws9vLnLgoVg6nKWGS3Xz6ei7V5FbU/K5mAk4Mn+09vBoBe3soacWbiR
         tBdce4N1YTbiZRm13nW6umQftxDQ/BOQtrnkqOj6SEr4TGFzGp7HLMNl2245oSUTGTiF
         wkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=gGXm2rkBPXGAM6tIWGWn5JkIJV7CsUrHlYMsaiFnDXk=;
        b=MDGmiHgrdXAYVQ4o1LNmupnDMxUhdcyKW/62L9NAlGcIQNtdJRW7Q4lowNK4qQy+7Y
         l/qrcrYk3aMGrZPsmJEGD50/1oZziwl3TvgAq/1YrOO7xI+/mqdxM8Ys54ifOrM1dhPp
         BjD8wjL3k78pvrLuwLiYwV9IvPd56BD4HwThA12rHkFpP8PsNC7/OyVkEg+zLr9ZnBDh
         Uo4AIk+fRQge6vStoWu6+y8EHzcOZoWoU1/jSCkF8RE/pimADLnYw5dPfF3Ke07o87bt
         VDuO5M/aYC6Zw8m40nZ5VYo/2lghS4u2Vi06Y5a8Si9NnFAzMsZbyXkq9XjkvxpQioYw
         LYNw==
X-Gm-Message-State: ALoCoQnRZY1jX29dByWgS+PZQXEaEuHCPSaGdXQEnTYsB3qSkr2E/2dzjHTJAQdyYqfZE8y9qTCHEvEL3GGmKD/IbV8HVxz3Uw==
X-Received: by 10.140.82.11 with SMTP id g11mr19940291qgd.77.1452952855772;
 Sat, 16 Jan 2016 06:00:55 -0800 (PST)
Received: by 10.55.195.154 with HTTP; Sat, 16 Jan 2016 06:00:36 -0800 (PST)
In-Reply-To: <20160116101719.GA21147@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284242>

On 16 January 2016 at 11:17, Eric Wong <normalperson@yhbt.net> wrote:
> For users with "store-passwords = no" set in the "[auth]" section of
> their ~/.subversion/config, SVN 1.9.0+ would fail with the
> following message when attempting to call svn_auth_set_parameter:
>
>   Value is not a string (or undef) at Git/SVN/Ra.pm
>
> Ironically, this breakage was caused by r1553823 in subversion:
>
>   "Make svn_auth_set_parameter() usable from Perl bindings."
>
> Since 2007 (602015e0e6ec), git-svn has used a workaround to make
> svn_auth_set_parameter usable internally.  However this workaround
> breaks under SVN 1.9+, which deals properly with the type mapping
> and fails to recognize our workaround.
>
> For pre-1.9.0 SVN, we continue to use the existing workaround for
> the lack of proper type mapping in the bindings.
>
> Tested under subversion 1.6.17 and 1.9.3.
>
> I've also verified r1553823 was not backported to SVN 1.8.x:
>
>   BRANCH=http://svn.apache.org/repos/asf/subversion/branches/1.8.x
>   svn log -v $BRANCH/subversion/bindings/swig/core.i
>
> ref: https://bugs.debian.org/797705
> Cc: 797705@bugs.debian.org
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  Thanks to the reporter (Bcc:-ed to protect their privacy) who
>  notified Dair and I of this bug.
>
>  Junio: this should also head to maint, thanks.

Thanks, I confirm it fixed the issue.
You can add the following if you want:

Reported-by: Thierry Vignaud <thierry.vignaud@gmail.com>
Tested-by: Thierry Vignaud <thierry.vignaud@gmail.com>

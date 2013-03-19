From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Tue, 19 Mar 2013 22:43:40 +0700
Message-ID: <CACsJy8BxbJU9-7Q-Ef3cG2VV2cW8YbBGcjNT9wjT+JywDOxyNg@mail.gmail.com>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org> <20130318073229.GA5551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Ingo Molnar <mingo@elte.hu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:44:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyiP-0000s4-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339Ab3CSPoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:44:12 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55671 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab3CSPoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:44:11 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so633727oag.37
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=at7Oxt0wclsFWXGVQc6VWQl0LaZjPwHBClYeYQbwLaY=;
        b=Fpg95QFsXMk4VoRiWvbA4W07IDh3rIq5+bZ+ZnowZkPiOmPRD19O6/ZspCSIiJyzyx
         W5qo1cGCyV+1ewx5CVPLj3RrNHmEtnXM67Hafqwgzo8wb1JwePESsjQcyGVKIaDQY0+y
         3WRWDETNOruL7FtYm2ISXdZWUZ4caUaggzXuDAdidc5fMxLjJIP8DXMVQ13YcmWaVX00
         zr3IKzj31IAp8wyuoIDJnUb10+q5ZxzJCttIgbxiyv8/WiAl8iu8kI3MYA9NnAOqpShV
         5MXsNLqwtWajr/zVLV0+vZXCCrocdsmf2w1hQ23+/Ry0h5LZmD9etjKMvNY1TtMRlaXO
         dKrA==
X-Received: by 10.60.29.72 with SMTP id i8mr1568138oeh.93.1363707850639; Tue,
 19 Mar 2013 08:44:10 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 08:43:40 -0700 (PDT)
In-Reply-To: <20130318073229.GA5551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218527>

On Mon, Mar 18, 2013 at 2:32 PM, Jeff King <peff@peff.net> wrote:
> By the way, looking at that made me think for a few minutes about
> hashcmp, and I was surprised to find that we use an open-coded
> comparison loop. That dates back to this thread by Ingo:
>
>   http://article.gmane.org/gmane.comp.version-control.git/172286
>
> I could not replicate his benchmarks at all. In fact, my measurements
> showed a slight slowdown with 1a812f3 (hashcmp(): inline memcmp() by
> hand to optimize, 2011-04-28).
>
> Here are my best-of-five numbers for running "git rev-list --objects
> --all >/dev/null" on linux-2.6.git:
>
>   [current master, compiled with -O2]
>   real    0m45.612s
>   user    0m45.140s
>   sys     0m0.300s
>
>   [current master, compiled with -O3 for comparison]
>   real    0m45.588s
>   user    0m45.088s
>   sys     0m0.312s
>
>   [revert 1a812f3 (i.e., go back to memcmp), -O2]
>   real    0m44.358s
>   user    0m43.876s
>   sys     0m0.316s
>
>   [open-code first byte, fall back to memcmp, -O2]
>   real    0m43.963s
>   user    0m43.568s
>   sys     0m0.284s
>
> I wonder why we get such different numbers. Ingo said his tests are on a
> Nehalem CPU, as are mine (mine is an i7-840QM). I wonder if we should be
> wrapping the optimization in an #ifdef, but I'm not sure which flag we
> should be checking.

What gcc and glibc versions are you using? With gcc 4.5.3 I got "repz
cmpsb" after reverting the patch, just like what Ingo described
(although interestingly it ran a bit faster than current master, glibc
2.11.2 on Atom D510 32 bit). gcc 4.6.3 -O2 (on another machine, 64
bit) produced a call to libc's memcmp instead of "repz cmpsb". I guess
if "repz cmpsb" is what we are against, then we could pass
-fno-builtin-memcmp (potential impact to other parts of git though).
-- 
Duy

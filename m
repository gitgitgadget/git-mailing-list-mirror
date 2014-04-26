From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 10:56:22 -0700
Message-ID: <CAJo=hJs-Nn=o=aGS_3bO9mnxb+urst6JTZf29_qAejBipz_ZHg@mail.gmail.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
 <CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
 <87wqec8rb5.fsf@fencepost.gnu.org> <CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
 <87d2g481nb.fsf@fencepost.gnu.org> <874n1g80dd.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:57:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6r2-0006PS-Ml
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbaDZR4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:56:45 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:45511 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaDZR4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:56:43 -0400
Received: by mail-wg0-f47.google.com with SMTP id n12so1624767wgh.30
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oY5XwVd+EBqFD5yHuMYt+Pca+ZNoZz1UwbRO+HKf7J8=;
        b=EEJusKCJbwCWJdED6WkzeCib24tXYslYYUmjXK420FSz/3QLPqSb62o2Rqy1e1Fuje
         N4VquIeKrV/k92f6lrMgAFK5eD28ytNP2SrtKKxHipNd5faYZAfobxWnFeOpEFq8oo7o
         IO8TjVticfFf5zuIQv7NUUJwMe/wG3jDAETO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=oY5XwVd+EBqFD5yHuMYt+Pca+ZNoZz1UwbRO+HKf7J8=;
        b=aLXriDrgcD0DxGXKCZMVWvv4hYIMEK6QTPx7T8gZnb/G+64oyvcUY1tppT3QzXzxdv
         EfamS30n4WB0imnCmuC1RlavzKEEEEEgdj5Z1uRPiA156mYLz7xsFf62ghkDMl7BPn9t
         IbwNFgtd8vW64mfQZvEHzq0Tfh3MHb4lwcx4YaoQ/k/KZSu+jNjXU4v8sKN7kZz00DKY
         dmlyBcTU1PaxLG9mWn/BNDTrIWDcNgdROAzv29XmKXR4Mx21DhZIuptDDcjjumLYuAwO
         v9+A1E4sbeEF5Jr5tb/0Bb8TfGL+x5436bosVL3cYOVKUPABtBhO/TSxYCjxgc4vKWHA
         157A==
X-Gm-Message-State: ALoCoQlEIj5BlYhckFVAS7pBAo+BMtSN9L6+AIJalFW9lpUHOfEa4l8Gp08jQr9d2tpNJorNtmb9
X-Received: by 10.180.185.100 with SMTP id fb4mr8533734wic.11.1398535002336;
 Sat, 26 Apr 2014 10:56:42 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Sat, 26 Apr 2014 10:56:22 -0700 (PDT)
In-Reply-To: <874n1g80dd.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247173>

On Sat, Apr 26, 2014 at 10:30 AM, David Kastrup <dak@gnu.org> wrote:
> David Kastrup <dak@gnu.org> writes:
>
>> http://repo.or.cz/r/wortliste.git
>> git blame [-M / -C] wortliste
>>
>> The latter one is _really_ taking a severe hit from the O(n^2)
>> algorithms.  If your benchmarks for that one still point mostly to the
>> unpacking, your jgit blame should be fine regarding the stuff
>> I reimplemented.
>
> Here's some example:
>
> dak@lola:/usr/local/tmp/wortliste$ time git blame -n -s wortliste >/tmp/wl1
>
> real    15m47.118s
> user    14m39.928s
> sys     1m1.872s

Hah, this is quite the torture test. git before your patch is taking
22m11s on my laptop to compute this. (This was with default options, I
noticed you passed -s to suppress the author formatting.)

> dak@lola:/usr/local/tmp/wortliste$ time ../git/git blame -n -s wortliste >/tmp/wl2
>
> real    3m40.947s
> user    2m40.296s
> sys     0m59.440s

Meanwhile JGit computed in 4m30s on the same hardware. So I guess we
are "fine". Its still not as fast as I want it to be. :-)

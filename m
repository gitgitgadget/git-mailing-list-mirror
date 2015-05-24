From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Sun, 24 May 2015 16:00:36 +0700
Message-ID: <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com> <20150522071224.GA10734@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: steve.norman@thomsonreuters.com,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 24 11:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwRmV-0004Lh-Mx
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 11:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbbEXJBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 05:01:11 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37221 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbEXJBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 05:01:08 -0400
Received: by igbsb11 with SMTP id sb11so16936608igb.0
        for <git@vger.kernel.org>; Sun, 24 May 2015 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MgHkoMkCZVzZ7oObODCpfi8P/njnryHTmur9VG+mZyw=;
        b=j7jXZhCGmMYuU9GEbgVg2vxLug6FuXx3/8/E1+2xW536/E42cupVqxLS/QZ68YmnCc
         P7jwM9QBpf5pE8C/9uQQWnXDCPforvanOhLpmUb+wLGbRuGz0I4SkbwmF8qLkJ5U85uK
         6PYqJ9goI4fnL6AvS6EENezklUHQ6bA4KJObCyTQX06BNea0RpX4Fll/NPoY0WX7W7ca
         D05ylVhn5cCs9hw0XGfvWHbGkaZ3qIhlqXb8r4lJkMuf7Sj6ywPkOtlnynqs3SkyAxeM
         2/XJiNFlx0oawoNrgtqIpRKMDVngMEagg5zoEwOa+Vx0dmntRKr7JDQ7xHGijxsWhowr
         bFSw==
X-Received: by 10.107.128.30 with SMTP id b30mr21298935iod.84.1432458067341;
 Sun, 24 May 2015 02:01:07 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Sun, 24 May 2015 02:00:36 -0700 (PDT)
In-Reply-To: <20150522071224.GA10734@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269827>

On Fri, May 22, 2015 at 2:12 PM, Jeff King <peff@peff.net> wrote:
> So I think there are two possibilities for improving this:
>
>   1. Find places where we expect the object will not exist (like the
>      collision_test check you pointed out) and use a
>      "has_sha1_file_fast" that accepts that it may very occasionally
>      erroneously return false. In this case it would mean potentially
>      skipping a collision check, but I think that is OK. That could have
>      security implications, but only if an attacker:
>
>        a. has broken sha1 to generate a colliding object
>
>        b. can manipulate the victim into repacking in a loop
>
>        c. can manipulate the victim into fetching (or receiving a push)
>           simultaneously with (b)
>
>      at which point they can try to race the repack procedure to add
>      their colliding object to the repository. It seems rather unlikely
>      (especially part a).

In case you want to back away from option 2 because it starts to leak
raciness, which your old commit tried to fix in the first place. I
think the only other place that tests for lots of non-existent loose
objects is write_sha1_file (e.g. "tar -xf bigtarball.tar.gz; cd
bigtarball; git init; git add ."). But the number of calls should be
much smaller compared to index-pack and it does not use has_sha1_file,
it uses check_and_freshen_file() instead.

There are other places where has_sha1_file() may return 0, but I think
the number of calls is even smaller to bother (shallow.c,
fetch-pack.c, apply.c, buik-checkin.c)
-- 
Duy

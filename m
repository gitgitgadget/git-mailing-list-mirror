From: Andrew Lutomirski <luto@mit.edu>
Subject: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Thu, 12 May 2011 13:15:03 -0400
Message-ID: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: netdev@vger.kernel.org, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu May 12 19:15:33 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKZU2-0004LQ-T0
	for glk-linux-kernel-3@lo.gmane.org; Thu, 12 May 2011 19:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758125Ab1ELRPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 12 May 2011 13:15:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36442 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308Ab1ELRPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2011 13:15:24 -0400
Received: by pzk9 with SMTP id 9so803005pzk.19
        for <multiple recipients>; Thu, 12 May 2011 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Aswr7n/W5XSg4bcxSiHc+wBJjfcYablHOTPIIVP4nP0=;
        b=t7AdAAvu88BnXUOFNZEtDsqXMsEHuWorI+eccvWxtV/xdRSIfTLREaP+r5Xnppq6sP
         BxoyGJeJcQ4zEXvCs7GeUpxoGzQGJPjmE+cB5utdLWXS9W6FDvq0Rp3yyD0NA4ztZ+hK
         GZk5gDrclwLTzGUwXG4+y1znkQ2NmGPgX23po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=dM+BZam5ok9q/M9db+e00078eEJjduPFqrfh5V1g2pM5pk4lMPPAzJH0OFWuUZK5jU
         45nHjx/sgkXcj+n/jCb/bMfvWvwxjsT1ilf+0yymgt6NyTp37HY6d2JDHIVmGwPGXfNj
         0PBg+UnBH42d8eBGXErisaOquV+jR1X0UjBNM=
Received: by 10.68.44.130 with SMTP id e2mr570047pbm.515.1305220523027; Thu,
 12 May 2011 10:15:23 -0700 (PDT)
Received: by 10.68.41.197 with HTTP; Thu, 12 May 2011 10:15:03 -0700 (PDT)
X-Google-Sender-Auth: NJ7eBcnn6uKKhGZhbP9c4MvRK0w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173486>

On Thu, May 12, 2011 at 9:31 AM, Andrew Lutomirski <luto@mit.edu> wrote=
:
> I just installed 9f381a6 (-linus from yesterday) on my Sandy Bridge
> desktop, and it locks up hard within a few seconds of logging in.
> netconsole says:
>
> [ =A0506.629723] block group 24725422080 has an wrong amount of free =
space
> [ =A0506.629723] block group 24725422080 has an wrong amount of free =
space
> [ =A0506.808501] fuse init (API version 7.16)
> [ =A0506.819996] SELinux: initialized (dev fuse, type fuse), uses gen=
fs_contexts
> [ =A0506.829847] SELinux: initialized (dev fusectl, type fusectl), us=
es
> genfs_contexts
> [ =A0506.808501] fuse init (API version 7.16)
> [ =A0506.819996] SELinux: initialized (dev fuse, type fuse), uses gen=
fs_contexts
> [ =A0506.829847] SELinux: initialized (dev fusectl, type fusectl), us=
es
> genfs_contexts
>
> If it's any help, the system is locked so hard that the reset button
> doesn't work. =A0It's an Intel DQ67SW board, which apparently doesn't
> have the most reliable reset button in the world :)
>
> 2.6.38.{4,5,6} are all rock-solid on this box.
>
> I've started bisecting, but I don't expect to finish today. =A0I need=
 to
> do some work other than kernel hacking...

OK, this sucks.  In the course of bisecting this, I've hit two other
apparently unrelated bugs that prevent my from testing large numbers
of kernels.  Do I have two questions:

1. Anyone have any ideas from looking at the log?

It looks like most of what's left is network code, so cc netdev.

2.  The !&$#@ bisection is skipping all over the place.  I've seen
2.6.37 versions and all manner of -rc's out of order.  Linus, and
other people who like pontificating about git bisection: is there any
way to get the bisection to follow Linus' tree?  I think that if
bisect could be persuaded to consider only changes that are reached by
following only the *first* merge parent all the way from the bad
revision to the good revision, then the bisection would build versions
that were at least good enough for Linus to pull and might have fewer
bisection-killing bugs.

(This isn't a new idea [1], and git rev-list --bisect --first-parent
isn't so bad except that it doesn't bisect.)



Here's the log.

$ git bisect log
# bad: [9f381a61f58bb6487c93ce2233bb9992f8ea9211] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
# good: [521cb40b0c44418a4fd36dc633f575813d59a43d] Linux 2.6.38
git bisect start 'HEAD' 'v2.6.38'
# skip: [6899608533410557e6698cb9d4ff6df553916e98] Merge branch
'for-linus' of git://codeaurora.org/quic/kernel/davidb/linux-msm
# ******* This revision didn't build due to PSTORE.
# ******* Fixed config for the rest but no point in retrying...
git bisect skip 6899608533410557e6698cb9d4ff6df553916e98
# bad: [d3e458d78167102cc961237cfceef6fffc80c0b3] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/soun=
d-2.6
git bisect bad d3e458d78167102cc961237cfceef6fffc80c0b3
# good: [6445ced8670f37cfc2c5e24a9de9b413dbfc788d] Merge branch
'staging-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6
git bisect good 6445ced8670f37cfc2c5e24a9de9b413dbfc788d
# bad: [40c7f2112ce18fa5eb6dc209c50dd0f046790191] Merge branch
'drm-core-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6
git bisect bad 40c7f2112ce18fa5eb6dc209c50dd0f046790191
# bad: [23b41168fc942a4a041325a04ecc1bd17d031a3e] netdevice: make
initial group visible to userspace
git bisect bad 23b41168fc942a4a041325a04ecc1bd17d031a3e
# bad: [c0c84ef5c130f8871adbdaac2ba824b9195cb6d9] Merge branch
'master' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wire=
less-next-2.6
git bisect bad c0c84ef5c130f8871adbdaac2ba824b9195cb6d9
# skip: [3ad97fbcc233a295f2ccc2c6bdeb32323e360a5e] mac80211: remove
unneeded check
# ******* This revision hangs at edd=3Doff
git bisect skip 3ad97fbcc233a295f2ccc2c6bdeb32323e360a5e
# skip: [5bec3e5ade813ee4bdbab03af1bb6f85859272ea] ath9k: fix tx queue
index confusion in debugfs code
# ******* This revision hangs at edd=3Doff
git bisect skip 5bec3e5ade813ee4bdbab03af1bb6f85859272ea
# skip: [c210de8f88215db31cf3529c9763fc3124d6e09d] ath5k: Fix fast
channel switching
# ******* This revision hangs at edd=3Doff
git bisect skip c210de8f88215db31cf3529c9763fc3124d6e09d

# ******* For added fun, 479600777bb588724d044815415f7d708d06644b gets
stuck in systemd initialization.

--Andy

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: git rebase -i failing due to phantom index.lock
Date: Wed, 16 Sep 2015 22:08:27 +0200
Message-ID: <CAOxFTcwTOJjRnA=7gR4GP2u0bsDCRv+j8PEw0c8Nv-nVVrynTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:08:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJ0f-0004r0-Hh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbbIPUIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2015 16:08:49 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38422 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbIPUIs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 16:08:48 -0400
Received: by wiclk2 with SMTP id lk2so541692wic.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Vj0QeSwxLuJwIPh8+lHrc3lT3/T/nRWEVlIp7EeVaS8=;
        b=u25OYZD/I+Db4KlRh8OTuY6mHlqam6RpFL42M4XuRfWIEN9qs7Gbki20VKVbY8tasK
         FEgVuJZIvnCWIiHZKFLEsJ8zkmiVILufEt68hiBTj7D2mipTqopsqYavs3Vu9a0Vzs66
         3aFzHqgWJWfj7kVkHlynoixSJFQsGjjUKBpWpLnWxHqJ22KV9Jvz3A6C4fta4f/RGRJs
         DESZ5x3rQ9W4glOwv4kwY/ucAFDbB39cGuHdAx8vIeHsortzNDmTP4XMjfUKqbETt50z
         3ElLqIGoDrogEr/ArODbPAn8AkqwcauCh46j8PaFmssLm/uSA+TWad58E4yxh/cqy04G
         oBYQ==
X-Received: by 10.194.110.132 with SMTP id ia4mr25343234wjb.103.1442434126777;
 Wed, 16 Sep 2015 13:08:46 -0700 (PDT)
Received: by 10.194.101.100 with HTTP; Wed, 16 Sep 2015 13:08:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278058>

Hello all,

I've recently started to note an issue with git rebase -i failing with
alarming frequency, especially on one of my repositories, claiming
that index.lock could not be created because it exists, even though it
doesn't and nothing else seems to be locking the index. The rebase
bombs more usually during the initial checkout than during any other
of the steps.

The problem is somewhat randomly reproducible, as it doesn't happen
100% of the time. It also seems to happen more consistently with more
recent git versions, or at least with my custom built git than with
the distro-shipped one.

A somewhat problematic git bisect has allowed me to identify commit
03b86647722f11ccc321cd7279aa49b811d17cc2 as the first bad commit.

The problem has all signs of a timing issue, which I'm having problems
isolating, although simply providing a timeout on the index lock calls
seems to fix it. Making git stall instead of die on error allowed me
to obtain this backtrace which I suspect will not be particularly
useful:

#0 0x00000000004c4666 in unable_to_lock_message
(path=3Dpath@entry=3D0x1bad940 ".git/index", err=3D<optimized out>,
buf=3Dbuf@entry=3D0x7ffd3b990900) at lockfile.c:158
#1 0x00000000004c46c6 in unable_to_lock_die (path=3Dpath@entry=3D0x1bad=
940
".git/index", err=3D<optimized out>) at lockfile.c:167
#2 0x00000000004c480b in hold_lock_file_for_update_timeout
(lk=3Dlk@entry=3D0x1bd7be0, path=3D0x1bad940 ".git/index", flags=3D<opt=
imized
out>, timeout_ms=3Dtimeout_ms@entry=3D0) at lockfile.c:177
#3 0x00000000004e6e2a in hold_lock_file_for_update (flags=3D1,
path=3D<optimized out>, lk=3D0x1bd7be0) at lockfile.h:165
#4 hold_locked_index (lk=3Dlk@entry=3D0x1bd7be0,
die_on_error=3Ddie_on_error@entry=3D1) at read-cache.c:1411
#5 0x0000000000420cb0 in merge_working_tree (old=3D0x7ffd3b990a20,
old=3D0x7ffd3b990a20, new=3D0x7ffd3b990a00, new=3D0x7ffd3b990a00,
writeout_error=3D0x7ffd3b9909c0, opts=3D0x7ffd3b992a31)
at builtin/checkout.c:471
#6 switch_branches (new=3D0x7ffd3b990a00, opts=3D0x7ffd3b992a31) at
builtin/checkout.c:826
#7 checkout_branch (new=3D0x7ffd3b990a00, opts=3D0x7ffd3b992a31) at
builtin/checkout.c:1123
#8 cmd_checkout (argc=3D<optimized out>, argv=3D<optimized out>,
prefix=3D<optimized out>) at builtin/checkout.c:1273
#9 0x0000000000405e7e in run_builtin (argv=3D0x7ffd3b992480, argc=3D2,
p=3D0x7acab0 <commands+336>) at git.c:350
#10 handle_builtin (argc=3D2, argv=3D0x7ffd3b992480) at git.c:535
#11 0x0000000000405021 in run_argv (argv=3D0x7ffd3b9922d8,
argcp=3D0x7ffd3b9922bc) at git.c:581
#12 main (argc=3D2, av=3D<optimized out>) at git.c:689

Additional information: I have the bash git prompt enabled, I do not
have anything else accessing that repository at the same time, and the
repository is =E2=80=9Cspread out=E2=80=9D across multiple workdirs cre=
ated with git
new-workdir, each with a different branch checked out. It is also
usually accessed under a symlink (cd ~/shortcut/repo/branch rather
than ~/full/path/to/repo/branch). Running Debian unstable with Linux
4.1.0 on an SSD-backed ext4 partition mounted with data=3Dordered. I
can't thnk of any other detail that might be even just remotely
involved in this odd issue. Any suggestions on how to debug it are
welcome.

Best regards,

--=20
Giuseppe "Oblomov" Bilotta

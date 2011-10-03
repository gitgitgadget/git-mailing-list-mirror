From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: pack-object poor performance (with large number of objects?)
Date: Mon, 3 Oct 2011 16:43:02 +0200
Message-ID: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 16:43:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAjjb-0006Wd-C6
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 16:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab1JCOnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 10:43:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44435 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab1JCOnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 10:43:04 -0400
Received: by ywb5 with SMTP id 5so3475338ywb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=HbBvNc6aBE40Vc+WiFy44aAz+b74CdUICWnBcBxuLAg=;
        b=F+JgTLYP2MwPijqnx8/w0XijTu8lk584nL3Pscpu9mPhcyfGN2/CYCKB/ITW4JuVXZ
         VHI39jpgrJ9yMpjtPw+p0sF34sgs0yujJWyrYv4eeTMMsJOlwEj0jb24FMBaNmoeE/pK
         11nsIbiyNOUnUgiql0wH6WIShAekXLKiaOTO8=
Received: by 10.150.59.11 with SMTP id h11mr203563yba.173.1317652983024; Mon,
 03 Oct 2011 07:43:03 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Mon, 3 Oct 2011 07:43:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182664>

Hi,

I'm having poor git gc (pack-object) performance. Please read below
for details. What can I do to improve the performance/debug the reason
for the slowness? Should I leave the process running over night, or
should I stop it (for debugging)?
CCing people who posted some patches/benchmarks for pack-objects recently.

git gc was first run automatically by git svn clone. It found 1544673
objects and worked for 50 minutes until I've killed it.

Then I've run it by hand with --aggresive (because I've found on
Internet it helped in some cases). It found 1742200 objects this time.
At this moment it's been working for about 90 minutes.

The large number of unpacked objects is probably caused by me - I've
disabled auto gc when I was cloning from svn (I though it might speed
up things if it didn't repack several times during clone, only once
afterwards).

My git version is 1.7.7.rc3.4.g8d714
The file system is ext4.

First run process tree:
pkruk    27873  0.0  0.0  15704   816 pts/2    S+   11:53   0:00
       |           |                       \_ git gc --auto
pkruk    27885  0.0  0.0  15704   776 pts/2    S+   11:53   0:00
       |           |                           \_ git repack -d -l
pkruk    27886  0.0  0.0   4220   608 pts/2    S+   11:53   0:00
       |           |                               \_ /bin/sh
/usr/local/stow/git-master/libexec/git-core/git-repack -d -l
pkruk    27897  3.6  9.3 1136072 381148 pts/2  D+   11:53   5:51
       |           |                                   \_ git
pack-objects --keep-true-parents --honor-pack-keep --non-empty --all
--reflog --unpacked --incremental --local --delta-base-offset
/home/pkruk/dv/devel1_git_repos/.git/objects/pack/.tmp-27886-pack

Second run process tree:
pkruk     6171  0.0  0.0  15704  1428 pts/2    S+   14:34   0:00
       |           |               \_ git gc --aggressive
pkruk     6174  0.0  0.0  15704  1356 pts/2    S+   14:34   0:00
       |           |                   \_ git repack -d -l -f
--depth=250 --window=250 -A
pkruk     6175  0.0  0.0   4220   648 pts/2    S+   14:34   0:00
       |           |                       \_ /bin/sh
/usr/local/stow/git-master/libexec/git-core/git-repack -d -l -f
--depth=250 --window=250 -A
pkruk     6189  4.9 10.5 1143640 427396 pts/2  D+   14:34   4:50
       |           |                           \_ git pack-objects
--keep-true-parents --honor-pack-keep --non-empty --all --reflog
--unpack-unreachable --local --no-reuse-delta --depth=250 --window=250
--delta-base-offset
/home/pkruk/dv/devel1_git_repos/.git/objects/pack/.tmp-6175-pack



-- 
Piotr Krukowiecki

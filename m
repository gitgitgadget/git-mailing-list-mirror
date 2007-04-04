From: "Chris Lee" <clee@kde.org>
Subject: Partitioned packs
Date: Tue, 3 Apr 2007 18:36:44 -0700
Message-ID: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 03:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYuRh-0008UJ-V2
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 03:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966266AbXDDBhM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 21:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966246AbXDDBhB
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 21:37:01 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:23521 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966262AbXDDBgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 21:36:46 -0400
Received: by nz-out-0506.google.com with SMTP id s1so3734nze
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 18:36:45 -0700 (PDT)
Received: by 10.115.46.9 with SMTP id y9mr42353waj.1175650604863;
        Tue, 03 Apr 2007 18:36:44 -0700 (PDT)
Received: by 10.114.66.10 with HTTP; Tue, 3 Apr 2007 18:36:44 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 3fa9af19dad32070
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43701>

I've been running some experiments, as hinted earlier by the
discussion about just how much git-index-pack sucks (which, really,
isn't much since the gaping memleak is gone now).

These experiments include trying to see if there's a noticeable
performance improvement by splitting out objects of different types
into different packs. So far, it definitely seems to make a
difference, though not the one I was initially expecting. For all of
these tests, I did 'sysctl -w vm.drop_caches=3' before running, to
effectively simulate a cold-cache run.

Single 3.1GB pack file containing all commits, blobs, and trees
First run (cold cache):
git-rev-list --all > /dev/null  5.52s user 0.32s system 45% cpu 12.872 total
git-blame -- kdelibs/kdeui/kmenubar.cpp  0.00s user 0.01s system 0%
cpu 40.218s total
git-archive --format=tar HEAD -- kdelibs >> /dev/null  0.48s user
0.10s system 5% cpu 10.143 total

Subsequent runs (warm cache):
git-rev-list --all > /dev/null  5.19s user 0.48s system 98% cpu 5.750 total
git-blame -- kdelibs/kdeui/kmenubar.cpp  0.00s user 0.00s system 0%
cpu 11.960 total
git-archive --format=tar HEAD -- kdelibs >> /dev/null  0.43s user
0.04s system 100% cpu 0.472 total


Single pack for commit objects and another pack for the rest
First run (cold cache):
git-rev-list --all > /dev/null  5.84s user 0.34s system 31% cpu 19.427 total
git-blame -- kdelibs/kdeui/kmenubar.cpp  0.00s user 0.00s system 0%
cpu 9:42.74 total
git-archive --format=tar HEAD -- kdelibs >> /dev/null  0.50s user
0.26s system 0% cpu 1:35.44 total

Subsequent runs (warm cache):
git-rev-list --all > /dev/null  5.94s user 0.26s system 99% cpu 6.204 total
git-blame -- kdelibs/kdeui/kmenubar.cpp  0.00s user 0.00s system 0%
cpu 12.394 total
git-archive --format=tar HEAD -- kdelibs >> /dev/null  0.41s user
0.07s system 98% cpu 0.486 total

Fully-partitioned separate packs for commit, tree, and blob objects
First run (cold cache):
git-rev-list --all > /dev/null  6.24s user 0.32s system 25% cpu 25.689 total
git-blame -- kdelibs/kdeui/kmenubar.cpp  0.00s user 0.00s system 0%
cpu 1:08.76 total
git-archive --format=tar HEAD -- kdelibs >> /dev/null  0.38s user
0.30s system 0% cpu 1:35.89 total

Subsequent runs (warm cache):
git-rev-list --all > /dev/null  6.28s user 0.24s system 99% cpu 6.527 total
git-blame -- kdelibs/kdeui/kmenubar.cpp  0.00s user 0.00s system 0%
cpu 13.895 total
git-archive --format=tar HEAD -- kdelibs >> /dev/null  0.42s user
0.06s system 99% cpu 0.476 total

I packed all of these using --delta-base-offset, with a window of 100
and a depth of 10.

-clee

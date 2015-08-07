From: JuanLeon Lahoz <juanleon.lahoz@gmail.com>
Subject: Inconsistent results obtained regarding how git decides what commits
 modifies a given path
Date: Fri, 7 Aug 2015 08:42:52 +0200
Message-ID: <CANYPdHA6a1Jg2NUJGcg5O3KBG2AB+AK3071ckDywGL=MHghEZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 08:42:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNbMn-0001li-RR
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 08:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbbHGGmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 02:42:53 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36296 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbHGGmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 02:42:53 -0400
Received: by qgeh16 with SMTP id h16so68935775qge.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=uuvOtdmyWCCJ3bhwbNBBA5ors3wjmtv5dxBLp7Lwm/s=;
        b=ebvVCH8a9iy5GjJCKsKz5PLOhh/rxPRNtGDjWswZA3u0O8xaX6Gy321+eo9OUNlk+C
         Svewv1pD90nVXFcLCQdC3mkmGc/eis3gpiWwSPHFmGtf5JUAjLB/AC19fyjAW+eG/vgg
         LV5raCxz2S/hfAn6iOiNtRr6LKwAn7GlTJl9LdwBqa35UygeeeshDVDGHKMf96ySBIst
         w+RJvGu5XVpgE/MV7UM1iuuNX9AhOSO/Yo+E7CbsdW6KPxXzFX2vGvdZ2vrdJGCY9BfX
         2p3d7N6GaFaC3Fh34Mos9t0ZhCvQwTCU5Q1Ifhdg2ZYscbGTESKJ/NQXRz9hLmRFgQ6r
         Dg6A==
X-Received: by 10.140.235.18 with SMTP id g18mr10718488qhc.103.1438929772469;
 Thu, 06 Aug 2015 23:42:52 -0700 (PDT)
Received: by 10.140.30.35 with HTTP; Thu, 6 Aug 2015 23:42:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275461>

When I use git rev-list (or git log) with the -- option to restrict commits to
those that modify a path, I am getting resuls where I fail to see the
consistency. Worse than that, results vary with git version (pre 1.8.4, results
were consistent; in 1.8.4 or 2.5.0 they don't seem consistent to me, and they
are different than in older versions; I rather like more the pre 1.8.4
behaviour).

Inconsistencies (inside same git version) or differences (across versions)
affects only to merge commits that affect (depending on definition) to a file.

As per manual, "Commits are included if they are not TREESAME to any parent",
but I think I am getting false positives with git versions >= 1.8.4.

Here is an example where I find the results that confuse me:

-------------------------------------------

#!/bin/bash -e
git init
git commit --allow-empty -m initial

# Create four branches, each one enclosing the previous one
echo v1 > version
git add version
git commit -m v1
git branch b1

echo v2 > version
git add version
git commit -m v2
git branch b2

echo v3 > version
git add version
git commit -m v3
git branch b3

echo v4 > version
git add version
git commit -m v4
git branch b4

git tag checkpoint
# We create a couple of merges
git checkout -b b2_3 b2
git merge --no-ff b3

git checkout -b b1_4 b1
git merge --no-ff b4

# This prints nothing on git < 1.8.4; prints a commit that corresponds with
# "Merge branch 'b3' into b2_3" in git >= 1.8.4 (tested with 1.8.4 and 2.5.0)
echo COMMITS checkpoint..b2_3: $(git rev-list checkpoint..b2_3 -- version)
# This prints nothing on any git version I tested.
echo COMMITS checkpoint..b1_4: $(git rev-list checkpoint..b1_4 -- version)

-------------------------------------------

Is that a bug or I am misunderstanding something basic?

Thanks
juanleon

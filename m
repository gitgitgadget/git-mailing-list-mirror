From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 00/19] reset improvements
Date: Wed,  9 Jan 2013 00:15:57 -0800
Message-ID: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsqwI-0000Xg-NU
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab3AIIWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:22:50 -0500
Received: from mail-qa0-f74.google.com ([209.85.216.74]:39783 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3AIIWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:22:50 -0500
Received: by mail-qa0-f74.google.com with SMTP id r4so87867qaq.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=QcdpITiCxS+ArnK6WYBRKQlZbpNiqlKbuWTKgk/IkbM=;
        b=Xpy0uSCxXqCJZ6R1Dk+droyVbW8CS2+feYVheUMxcNM7i3tkm7APbfO8hDbw06wdKh
         cng/8Ws8+bhqfw2WD2/gPtwX0RuU35cjaX3LlW/uhJcOpIgmcB/lRAmyeCb9TmSnxmXt
         OV7XoN52rTJCqiVXrqC5vlNqyfqToPGbz/qgk8kubWCLeItSFhWGPCb00IqTMbT+aKAX
         KYYizrHuvGhg47FFeaJHiyYLtXEv6lUn6N3Wuql12KyOKlxQz9id5Md2xTS1mzz/jBAp
         E3ArHgmsGF0DsV8iuBDlEL+4k69CveW+wizgzFvec2axQBejuVRIqvn7iySiigg51sAj
         3zzw==
X-Received: by 10.236.116.10 with SMTP id f10mr37512376yhh.9.1357719407750;
        Wed, 09 Jan 2013 00:16:47 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i63si5738156yhk.5.2013.01.09.00.16.47
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:16:47 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id A2CB382004A;
	Wed,  9 Jan 2013 00:16:47 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 48217102B64; Wed,  9 Jan 2013 00:16:47 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
X-Gm-Message-State: ALoCoQkmI6WVBaI2yHXhs8bZ9MRv+TjM4KFMc3/WEQAWWYHPEVLgtt7bCWtV+0XYRNQXPo94UalBpNXH0tPtlYAhDXLT3Q4N4+bNoQ8t6WyRXRFrT+yU9lLUwXqEpr/KbvKTzIU2PxK8pbM3QL8XsCNa+1Az05JsnAJ+1rmkkEzK7ogMgYZzOqtnVlSSrx5lXlfIaJFrIatD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213041>

This is kind of a re-roll of [1] (wow, apparently it took me almost
two months to get done). The goal was, then and now, to teach "git
reset" to work on an unborn branch and to not require a commit when a
tree would do. This time, I also made some tangential improvements
along the way, mostly related to readability and performance.

As usual, the risker patches are towards the end. In particular, I
find it hard to evaluate how risky the last patch is. That last patch
is responsible for much of the improvements in the timing table below,
so it would be nice if it doesn't break things too badly (test pass,
of course). The timings are best-of-five, wall time.

Command                  Before     After
reset (warm)             0.23        0.07
reset -q (warm)          0.23        0.03
reset . (warm)           0.09        0.07
reset -q . (warm)        0.09        0.03
reset --keep (warm)      0.31        0.29
reset --keep -q (warm)   0.31        0.29
reset (cold)             9.74        2.60
reset -q (cold)          9.85        0.37
reset . (cold)           2.66        2.51
reset -q . (cold)        2.59        0.33
reset --keep (cold)      7.58        7.52
reset --keep -q (cold)   7.37        7.21



  [1] http://thread.gmane.org/gmane.comp.version-control.git/210568/focus=210855

Martin von Zweigbergk (19):
  reset $pathspec: no need to discard index
  reset $pathspec: exit with code 0 if successful
  reset.c: pass pathspec around instead of (prefix, argv) pair
  reset: don't allow "git reset -- $pathspec" in bare repo
  reset.c: extract function for parsing arguments
  reset.c: remove unnecessary variable 'i'
  reset.c: extract function for updating {ORIG,}HEAD
  reset.c: share call to die_if_unmerged_cache()
  reset.c: replace switch by if-else
  reset --keep: only write index file once
  reset: avoid redundant error message
  reset.c: move update_index_refresh() call out of read_from_tree()
  reset.c: move lock, write and commit out of update_index_refresh()
  reset [--mixed]: don't write index file twice
  reset.c: finish entire cmd_reset() whether or not pathspec is given
  reset [--mixed] --quiet: don't refresh index
  reset $sha1 $pathspec: require $sha1 only to be treeish
  reset: allow reset on unborn branch
  reset [--mixed]: use diff-based reset whether or not pathspec was
    given

 builtin/reset.c                | 281 +++++++++++++++++++----------------------
 t/t2013-checkout-submodule.sh  |   2 +-
 t/t7102-reset.sh               |  26 +++-
 t/t7106-reset-unborn-branch.sh |  52 ++++++++
 4 files changed, 200 insertions(+), 161 deletions(-)
 create mode 100755 t/t7106-reset-unborn-branch.sh

-- 
1.8.1.rc3.331.g1ef2165

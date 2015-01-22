From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/5] Fix bug in large transactions
Date: Wed, 21 Jan 2015 18:32:04 -0800
Message-ID: <1421893929-7447-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 03:33:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE7Zz-0008Ke-40
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 03:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbbAVCc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 21:32:59 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:60312 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbbAVCcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 21:32:13 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so4628038igb.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 18:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tBt6DAUb6ps1gaAQCrA0axVLP9eOVLQwu5KEKKrMoLw=;
        b=AI1yvmbEVuKLONfZE2pK3r7YqAvF7Bu/p1M65khIWroHDSIv5pEtTV0KJ8+6lyF27Q
         5h0I9cDvdOexzrlnzwDvLCymdkCH/SpfQ5764g4cy4Um6OI/vpF8hCapPq8pHtp6I7bq
         de3WacZfTUDFwsvOGb47jCk1CJvOE24Pwnx7zq7a5DUAJea5FEBzTd4fDvn4DWiwHqRu
         qZLD+gk1Cgu1NJkQm6oAXpB7wfmG2ct9eed596ArfKIJI28zLTnng9sCcOgDu62jt8Sf
         MpOCbB4/fY10yQVY+yFHf3yz8c6j5DRYRSoD5DwPjUIpiX0sZYJwDBgJxLB/GCz0idGI
         jZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tBt6DAUb6ps1gaAQCrA0axVLP9eOVLQwu5KEKKrMoLw=;
        b=Xc9h7mZBbQDgRoNmBNm2z+RATASelyiFo24eTuhXdTSbbiB5FvBgEHP2Sjs8qMRiS9
         2QMOAKT3xIq/UDChW6BZiI2cg1kiK0/E5RZzf092Db/U8mODZYnByv5U7xg/N0nkLP1Q
         wd1cnnNSkOmduFvaEF0UxcJLHo845Fe55UxccHadAHi9OgflTtR7e3gISf6YWTNpuQF0
         WmcjSs/rWzdFan1poLWgAGSb8l3wG9GSWF3P6ttnMH4yzstGSMOrmxz7ybhG1mWUDuJO
         YOfhdOu3rLRvEkK+gvkspw3XgOFCc4EyMC4E6VPbvMLDPnkaKUso4mMM1U/xQWEmXySY
         SPIw==
X-Gm-Message-State: ALoCoQnvxqfYI6Q71mc6uYPOviqWPbLmwkOSL6UyWILXsNjr2lq0++zvm0sUlbQzwHq0XJ0rdDbz
X-Received: by 10.42.38.9 with SMTP id a9mr257533ice.68.1421893932331;
        Wed, 21 Jan 2015 18:32:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id s17sm1191629igr.2.2015.01.21.18.32.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 18:32:11 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262797>

version2:

* This applies on top of origin/sb/atomic-push though it will result in a one
  line merge conflict with origin/jk/lock-ref-sha1-basic-return-errors when
  merging to origin/next.

* It now uses the FILE* pointer instead of file descriptors. This
  results in a combination of the 2 former patches "refs.c: have
  a write_in_full_to_lock_file wrapper" and "refs.c: write to a
  lock file only once" as the wrapper function is more adapted to
  its consumers

* no need to dance around with char *pointers which may leak.

* another new patch sneaked into the series: Renaming ULIMIT in t7004
  to ULIMIT_STACK_SIZE

That said, only the first and third patch are updated from the first version
of the patches. The others are new in the sense that rewriting them was cheaper
than keeping notes in between.

version1:

(reported as: git update-ref --stdin : too many open files, 2014-12-20)

First a test case is introduced to demonstrate the failure,
the patches 2-6 are little refactoring and the last patch
fixes the bug and also marks the bugs as resolved in the
test suite.

Unfortunately this applies on top of origin/next.

Any feedback would be welcome!

Thanks,
Stefan

Stefan Beller (5):
  update-ref: test handling large transactions properly
  t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
  refs.c: remove lock_fd from struct ref_lock
  refs.c: have a write_sha1_to_lock_file wrapper
  refs.c: enable large transactions

 refs.c                | 34 ++++++++++++++++++++++------------
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 t/t7004-tag.sh        |  4 ++--
 3 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.2.1.62.g3f15098

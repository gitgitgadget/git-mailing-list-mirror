From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 0/8] Make git-am a builtin
Date: Wed, 27 May 2015 21:33:30 +0800
Message-ID: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:34:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbTc-00065H-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbE0NeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:22 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33029 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbbE0NeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:21 -0400
Received: by pdbqa5 with SMTP id qa5so15497688pdb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UfyjTn6XDZDAw4GVp1UF0xOi5fvk7ROCDExn/yCsvSs=;
        b=ZDYnECiJwzCCKIFzQE3JezSK1rtWR0H6sEdhk45W4tUqnUeXre6rHy2CKjsY4l7Mie
         8P5cszqMAWszsRSPOruqc9QBT0u3+3DyCYwVEX/vjhXeYpCb5PuGqmMV8z2j6qltmsCR
         ajCHozuBnbIevKl/61FtB3D3M3IDf+cYayk3XyAiGf5AQeGdqMbxbW2tW1uM3zdCQw4r
         CHqtk/LVMOyy1jyPZb8TSKeNISX5mEqGGV5lC4sRB1KnsJhUXoyfPNm+JknahYjs9LBe
         S+Y5pBW2coq6gKZgVEs83GDoHJpq74qk1EqWY5USy7AC4mjHKhd7DRCzwpCmNhYc8fns
         7n3Q==
X-Received: by 10.70.49.168 with SMTP id v8mr59452124pdn.24.1432733661306;
        Wed, 27 May 2015 06:34:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.33.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:33:52 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270048>

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This WIP patch series rewrites git-am.sh into optimized C builtin/am.c. It is
based on my finished prototype of the rewrite[1], and over the next 5 weeks I
will be cutting out small patches from the prototype to make it easier to
review and refine the patch series.

This is part of my GSoC project to rewrite git-pull.sh into git-am.sh into C
builtins[2].

A small benchmark that applies 50 patches[3]:

	#!/bin/sh
	git init &&
	echo initial >file &&
	git add file &&
	git commit -m initial &&
	git branch before-am &&
	for x in $(seq 50)
	do
	    echo $x >>file &&
	    git commit -a -m $x
	done &&
	git format-patch --stdout before-am.. >patches &&
	git checkout before-am &&
	time git patches >/dev/null

I ran this benchmark on my *Linux* system.

Timings for git on master:

1.40s, 1.42s, 1.25s, 1.32s, 1.10s. Avg: ~1.30s

Timings for git on master + this patch series applied:

0.24s, 0.22s, 0.22s, 0.19s, 0.25s. Avg: ~0.22s

This is around a 6x speedup. It's not because this patch series does less than
git-am.sh -- similar speedups can be observed with the prototype, which passes
the test suite[4].

(Sorry for leaving the other reviews hanging. I was too preoccupied with the
git-am rewrite, and was afraid of forgetting important details should I context
switch. Now that the prototype is finished I can deal with the other patch
series'.)

[1] https://github.com/pyokagan/git/compare/master...pyokagan:pt/ref-builtin-am
[2] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1
[3] Since a 56-patch series was posted recently ;-)
[4] The subset of the test suite that calls git-rebase and git-am.

Paul Tan (8):
  wrapper: implement xopen()
  wrapper: implement xfopen()
  am: implement patch queue mechanism
  am: split out mbox/maildir patches with git-mailsplit
  am: detect mbox patches
  am: extract patch, message and authorship with git-mailinfo
  am: apply patch with git-apply
  am: commit applied patch

 Makefile          |   2 +-
 builtin.h         |   1 +
 builtin/am.c      | 687 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |   2 +
 git.c             |   1 +
 wrapper.c         |  37 +++
 6 files changed, 729 insertions(+), 1 deletion(-)
 create mode 100644 builtin/am.c

-- 
2.1.4

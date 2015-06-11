From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 00/19] Make git-am a builtin
Date: Thu, 11 Jun 2015 18:21:46 +0800
Message-ID: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zco-0007at-Qs
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbFKKWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34332 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbFKKWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:14 -0400
Received: by payr10 with SMTP id r10so1865838pay.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WGIDlqjbFK8KVqzki7mplkNng1L7UmVVBncb5s1uykM=;
        b=qd0CzXFTkl3C1gVlHron0EdBSFxbXb4usYCXTN7VOHL503FBNfipCdeJZecFNGLWHc
         8blFi9mRfQIFJBSGTcTSzfcFjfYbGYn1KQuydr/9YK8KCEJwJcGULgP5w/15w+JlQnmM
         8WFvcP6DZBJEQ4TTEmHGc6PchRBzQhEXU46rIA8YpkeMIoCj8xtn9hqxKWEglhEnzA13
         HmmeXnSXNAoK9yHFRdku4U6eFBAftNLTQM3k8YeA0aVMGJF8nrxSjPtGBYxytFayUYro
         peERzT4wzxaE6kBVmDVMFOC2E5+f6roTj4XAbudTbiKI3Kkfkny7F+hJ0s2K1blUPLC3
         i0rw==
X-Received: by 10.68.135.136 with SMTP id ps8mr13887658pbb.78.1434018133611;
        Thu, 11 Jun 2015 03:22:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:12 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271381>

This is a re-roll of [v1]. Thanks Junio, Torsten, Jeff, Eric for the reviews
last round.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/270048

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This WIP patch series rewrites git-am.sh into optimized C builtin/am.c, and is
part of my GSoC project to rewrite git-pull and git-am into C builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1

Paul Tan (19):
  wrapper: implement xopen()
  wrapper: implement xfopen()
  am: implement skeletal builtin am
  am: implement patch queue mechanism
  am: split out mbox/maildir patches with git-mailsplit
  am: detect mbox patches
  am: extract patch, message and authorship with git-mailinfo
  am: apply patch with git-apply
  am: commit applied patch
  am: refresh the index at start
  am: refuse to apply patches if index is dirty
  am: implement --resolved/--continue
  am: implement --skip
  am: implement --abort
  am: implement quiet option
  am: exit with user friendly message on patch failure
  am: implement am --signoff
  cache-tree: introduce write_index_as_tree()
  am: implement 3-way merge

 Makefile          |    1 +
 builtin.h         |    1 +
 builtin/am.c      | 1214 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.c      |   29 +-
 cache-tree.h      |    1 +
 git-compat-util.h |    2 +
 git.c             |    1 +
 wrapper.c         |   43 ++
 8 files changed, 1280 insertions(+), 12 deletions(-)
 create mode 100644 builtin/am.c

-- 
2.1.4

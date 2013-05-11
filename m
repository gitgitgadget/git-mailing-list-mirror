From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 00/10] Prepare for alternative remote-tracking branch location
Date: Sat, 11 May 2013 18:21:10 +0200
Message-ID: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCY7-0007L1-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab3EKQV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:26 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:58514 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab3EKQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:25 -0400
Received: by mail-wg0-f52.google.com with SMTP id k13so5034418wgh.19
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=HHQH/qhuK2pStmiB7gQKmrsstfcuGyOKYhsZvPJGFJ4=;
        b=TfsOrem6/mNwgPw7I8whvf1n5VWZ8WYW+eoHQ5T9lbvht2JNZj2GwbsTtac6VNu1+9
         qFF3I6W+U0Fil3WyTAihVYUthi4kCanEfkF2K3+IKKVw3tr4wNE9BmvLWnUbJyz64O6H
         Md5bRkzqwDf9NlBD3y5wH/pLcFOja6GTeIxQiduvjpRVl4nLiQZ3MmfS1iNXiXhuhju0
         WuxepfYXlz5S+EUZDR6Vf+jez/Q9ZfkRJQNzpRBThbKlI6yWeZeDJY9W8oIFKSZzEacY
         anWHf3VjuNJr83gW+NInbm6GFN495bTVYYkrOnQcXCJffHazdh/1b1AjJ56T1kBlCBhf
         q9IQ==
X-Received: by 10.180.188.141 with SMTP id ga13mr9876408wic.9.1368289284460;
        Sat, 11 May 2013 09:21:24 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223981>

Hi,

Here is the second iteration of the current series for teaching git to
work with remote ref namespaces. This iteration is pretty much a full
rework of the first iteration, based on Junio's comments to the first
iteration, and discussion with other Git developers at the Git Merge
conference in Berlin, particularily Jonathan Nieder has helped to work
out some of these issues.

Patches #1 - #2 are pretty much unchanged from v1, except that we now
put the remote refs in refs/peers/* instead of /refs/remotes/*.

Patches #3 - #5 gets us to the point where "git rev-parse origin/master"
will expand to "refs/peers/origin/heads/master", and vice versa for
shortening

Patches #6-#10 (except #7 which is a small unrelated test addition) is
about making "git branch -a" and "git branch -r" output remote-tracking
branches from the refs/peers/* hierarchy.

Note that this patch series is based on top of the jh/shorten-refname
series in 'pu'.


Have fun!

...Johan


Johan Herland (10):
  t7900: Start testing usability of namespaced remote refs
  t7900: Demonstrate failure to expand "$peer/$branch" according to refspecs
  refs.c: Refactor code for mapping between shorthand names and full refnames
  remote: Reject remote names containing '/'
  refs.c: Add support for expanding/shortening refs in refs/peers/*
  t7900: Test git branch -r/-a output w/remote-tracking branches in refs/peers/*
  t3203: Add testcase for fix in 1603ade81352a526ccb206f41ff81ecbc855df2d
  builtin/branch.c: Refactor ref_item.name and .dest into strbufs
  builtin/branch.c: Refactor "remotes/" prepending to remote-tracking branches
  branch: Fix display of remote branches in refs/peers/*

 builtin/branch.c                               | 114 +++++------
 builtin/remote.c                               |   4 +-
 cache.h                                        |   4 -
 refs.c                                         | 256 ++++++++++++++++++-------
 refs.h                                         |   6 +
 remote.c                                       |   6 +-
 t/t3203-branch-output.sh                       |  15 ++
 t/t5505-remote.sh                              |  12 ++
 t/t7900-working-with-namespaced-remote-refs.sh | 131 +++++++++++++
 t/t7901-multi-level-remote-name-failure.sh     |  20 ++
 10 files changed, 430 insertions(+), 138 deletions(-)
 create mode 100755 t/t7900-working-with-namespaced-remote-refs.sh
 create mode 100755 t/t7901-multi-level-remote-name-failure.sh

-- 
1.8.1.3.704.g33f7d4f

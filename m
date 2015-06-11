From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 00/19] Make git-am a builtin
Date: Thu, 11 Jun 2015 18:17:16 +0800
Message-ID: <1434017855-27954-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zYr-0005Nz-U7
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbFKKSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:18:08 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36628 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbFKKSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:18:06 -0400
Received: by pabqy3 with SMTP id qy3so1719275pab.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=EnYesRBnGKzzG+N0sd6ZmDXR5yn6ym7y1exA0XMwApw=;
        b=JhAVCHnkbgFQi67Qb7mN7/BzYoc9CLwXiXUyyHJZj2brBuAPDfOHqwgrHOUcI31m20
         3DWSZNIgPpYf0+H+OAZMcg/rQ3F36phEI94++YhtrZ6S9ovNP0CSDkO/+eEGu7ILs4Mn
         1hFMIxDtUC3flzb8CMKXfDhT/9KZZNWQ4EYV2nOrQCPZ3gF/s8GtyOzAhEybnz2MKTo6
         zbbnzlJ3mzz+8oovHmOTD4unTccDBJ5g1SiouUYlfg8B9Ea+2LENNqF8XibHjDqt4qw6
         FwzmbAp94+BWehVr4nqmFhiUWCcGoLTMtU0at6E5MR7xqvDxFVcm/2drTqf6uBt6qtRP
         ZXSg==
X-Received: by 10.70.33.67 with SMTP id p3mr13622388pdi.126.1434017885968;
        Thu, 11 Jun 2015 03:18:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jz10sm279799pbc.48.2015.06.11.03.18.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:18:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271380>

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

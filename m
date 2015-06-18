From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 00/31] Make git-am a builtin
Date: Thu, 18 Jun 2015 19:25:12 +0800
Message-ID: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xxh-0004Py-5T
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbbFRL0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:15 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33485 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbFRL0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:11 -0400
Received: by pdjn11 with SMTP id n11so64823006pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=rJ1DQrMWpSTPZgBMC84gyKryOXt6FIwFohtI4oR0jO4=;
        b=XoWNarJjHHTX5KuxdrmAkv4zuPYobnB4+WRUxsxhaCQy7kazf0nIGT1f4DtitQfP18
         XLYmBXv1JxWENHQWu+6oRa2fnz8rv7k0EC8Wh9OqGK8knsAe/WcGs5qdnm3cQVOC6IaM
         48FCCT/V0ZtRLQt0Z7wAs8WrRBnvRlkygHrx7NBNnibta5mRZL3ymqmfcrjTJ95JFlt/
         3EDoAzeZZQ/4s3/9UrrgyndDF7oZ0jx46btGRfyFCOxNjMz2h7e0cveZjxH7D/galeVH
         gQF/vlvKI4dxmzyD55Js5VHvt1eZvMhpUPiWkMD6NVcVCtBB4IYIwxvPFzlVb7ba6K1g
         Re5g==
X-Received: by 10.68.130.98 with SMTP id od2mr20203568pbb.73.1434626770659;
        Thu, 18 Jun 2015 04:26:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271967>

This patch series depends on pt/pull-builtin for OPT_PASSTHRU_ARGV() and
argv_array_pushv().

This is a re-roll of [WIP v3]. Thanks Junio and Stefan for the reviews last
round.

The biggest addition this round would be the support for git-rebase. Here's
a small unscientific benchmark that rebases 50 patches:

	git init &&
	echo initial >file &&
	git add file &&
	git commit -m initial &&
	git tag initial &&
	for x in $(seq 50)
	do
	    echo $x >>file &&
	    git commit -a -m $x
	done &&
	git checkout -b onto-rebase initial &&
	git commit --allow-empty -mempty &&
	time git rebase -q --onto onto-rebase initial master

With master:

1.53s, 1.55s, 1.17s, 1.52s, 1.22s. Avg: ~1.40s

With master + this patch series:

0.22s, 0.22s, 0.18s, 0.21s, 0.18s. Avg: ~0.20s

So this is around a 6-7x speedup.

Previous versions:

[WIP v1] http://thread.gmane.org/gmane.comp.version-control.git/270048
[WIP v2] http://thread.gmane.org/gmane.comp.version-control.git/271381

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This WIP patch series rewrites git-am.sh into optimized C builtin/am.c, and is
part of my GSoC project to rewrite git-pull and git-am into C builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (31):
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
  am: don't accept patches when there's a session in progress
  am: implement quiet option
  am: exit with user friendly message on patch failure
  am: implement am --signoff
  cache-tree: introduce write_index_as_tree()
  am: implement 3-way merge
  am: --rebasing
  am: don't use git-mailinfo if --rebasing
  am: handle stray state directory
  am: implement -k/--keep, --keep-non-patch
  am: implement --[no-]message-id, am.messageid
  am: support --keep-cr, am.keepcr
  am: implement --[no-]scissors
  am: pass git-apply's options to git-apply
  am: implement --ignore-date
  am: implement --committer-date-is-author-date
  am: implement -S/--gpg-sign, commit.gpgsign

 Makefile          |    1 +
 builtin.h         |    1 +
 builtin/am.c      | 1650 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.c      |   29 +-
 cache-tree.h      |    1 +
 git-compat-util.h |    2 +
 git.c             |    1 +
 wrapper.c         |   43 ++
 8 files changed, 1716 insertions(+), 12 deletions(-)
 create mode 100644 builtin/am.c

-- 
2.1.4

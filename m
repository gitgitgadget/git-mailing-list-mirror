From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Tue, 29 Apr 2014 06:17:00 -0500
Message-ID: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:27:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6CT-0004Pd-94
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933845AbaD2L1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:27:44 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:49369 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933682AbaD2L1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:27:42 -0400
Received: by mail-yk0-f170.google.com with SMTP id 79so40241ykr.29
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QktNCcGByQLsFO88NWX3+ovt7LljwDXkG5Syc2Srv2E=;
        b=0ygHNn/G6NFwxRBfeKEKbzP3FXaPQlig6TOZD3Lf3JPjySNsK5R18oI/6To0N0V80K
         N2ftqCR7FWnogOT5NsMaY3iFsGde5+4BYfcv1NBtzojzZbahGwp+XrBCkR1j4sNM0ndy
         q7RUnV6p3CRw2oiAd7qaGc0zN2SsahdpWZEFuz3q5/hOj0c889ZPmdyzYpwaV8lT1awB
         m/17KzB4euBCTK8Q0ob7yOpPHf9Iw00r3VreidCvVqzIEaIWN4G1GxqkjiNf4AHuL9W2
         UzthwmlQS6FpxxBALshasl+UuuYOWMsa2IKRpG5p+26yvK+mTTsmz+HUUpswR3SAqHn2
         8QHQ==
X-Received: by 10.236.21.241 with SMTP id r77mr45836811yhr.7.1398770862317;
        Tue, 29 Apr 2014 04:27:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c24sm36147685yhc.2.2014.04.29.04.27.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:27:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247567>

It is very typical for Git newcomers to inadvertently create merges and worst:
inadvertently pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been agreed that
'git pull' should barf by default if the merge is non-fast-forward.
Unfortunately this breaks backwards-compatibility, so we need to be careful
about the error messages we give, and that we provide enough information to our
users to move forward without distrupting their workflow too much.

With the proper error messages and documentation, it has been agreed that the
new behavior is OK.

These are the steps needed to achieve this:

4) Only allow fast-forward merges by default

We could pass --ff-only to `git merge`, however, if we do that we'll get an error like this:

  Not possible to fast-forward, aborting.

This is not friendly; we want an error that is user-friendly:

  The pull was not fast-forward, please either merge or rebase.
  If unsure, run 'git pull --merge'.

When we do this we want to give the users the option to go back to the previous
behavior, so a new configuration is needed.

3) Add merge-ff-only config

This option would trigger a check inside `git pull` itself, and error out with
the aforementioned message if it's not possible to do a fast-forward merge.

However, this option conflicts with --rebase, and --no-rebase. Solution below.

2) Add --merge option

Since we have a message that says "If unsure, run 'git pull --merge'", which is
more friendly than 'git pull --no-rebase', we should add this option, and
deprecate --no-rebase.

However, the documentation would become confusing if --merge is configured in
pull.rebase, instead, we want something like this:

  See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
  to make `git pull` always use `--merge`.

1) Rename pull.rename to pull.mode and
   branch.<name>.rebase to branch.<name>.pullmode

This way the configurations and options remain consistent:

  git pull --merge
  pull.mode = merge
  branch.<name>.pullmode = merge

  git pull --rebase
  pull.mode = rebase
  branch.<name>.pullmode = rebase

  git pull --rebase=preserve
  pull.mode = rebase-preserve
  branch.<name>.pullmode = rebase-preserve

  git pull
  pull.mode = merge-ff-only
  branch.<name>.pullmode = merge-ff-only
 
This patch series does all the steps mentioned, but in reverse order, and in
addition updates the tests to use the new configurations instead.


Felipe Contreras (6):
  pull: rename pull.rename to pull.mode
  pull: migrate all the tests to pull.mode
  pull: refactor $rebase variable into $mode
  pull: add --merge option
  pull: add merge-ff-only option
  pull: only allow ff merges by default

 Documentation/config.txt     |  37 ++++++++-------
 Documentation/git-pull.txt   |  28 ++++++++++--
 branch.c                     |   4 +-
 builtin/remote.c             |  14 +++++-
 git-pull.sh                  | 105 ++++++++++++++++++++++++++++++++-----------
 t/t3200-branch.sh            |  40 ++++++++---------
 t/t4013-diff-various.sh      |   2 +-
 t/t5500-fetch-pack.sh        |   2 +-
 t/t5505-remote.sh            |   2 +-
 t/t5520-pull.sh              |  90 ++++++++++++++++++++++++-------------
 t/t5524-pull-msg.sh          |   2 +-
 t/t5601-clone.sh             |   4 +-
 t/t5700-clone-reference.sh   |   4 +-
 t/t6022-merge-rename.sh      |  20 ++++-----
 t/t6026-merge-attr.sh        |   2 +-
 t/t6029-merge-subtree.sh     |   6 +--
 t/t6037-merge-ours-theirs.sh |  10 ++---
 17 files changed, 245 insertions(+), 127 deletions(-)

-- 
1.9.2+fc1.3.gade8541

From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 11:59:24 -0400
Message-ID: <20111013155923.GA13134@sigill.intra.peff.net>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 17:59:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RENhF-00060C-Dk
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 17:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364Ab1JMP7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 11:59:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59692
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756353Ab1JMP72 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 11:59:28 -0400
Received: (qmail 26294 invoked by uid 107); 13 Oct 2011 15:59:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Oct 2011 11:59:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2011 11:59:24 -0400
Content-Disposition: inline
In-Reply-To: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183492>

On Thu, Oct 13, 2011 at 12:38:53PM +0400, Kirill Likhodedov wrote:

> 'git pull' doesn't work from outside the working tree even if '--work-tree' is specified:
> 
> # git version
> git version 1.7.6
> # git --git-dir=/Users/loki/sandbox/git/child/.git --work-tree=/Users/loki/sandbox/git/child pull
> fatal: /opt/local/libexec/git-core/git-pull cannot be used without a working tree.
> 
> Note that  'git fetch' and 'git merge origin/master' work fine, so 'git pull' should be easy to fix :)
> 
> # git --git-dir=/Users/loki/sandbox/git/child/.git --work-tree=/Users/loki/sandbox/git/child merge origin/master
> Already up-to-date.

This is a known issue, and the fix is a one-liner, but it needed
somebody to look through the pull script to make sure it wasn't
introducing any new bugs. I just did this; the patch below should fix
your problem.

-- >8 --
Subject: [PATCH] pull,rebase: handle GIT_WORK_TREE better

You can't currently run git-pull or git-rebase from outside
of the work tree, even with GIT_WORK_TREE set, due to an
overeager require_work_tree function. Commit e2eb527
documents this problem and provides the infrastructure for a
fix, but left it to later commits to audit and update
individual scripts.

Changing these scripts to use require_work_tree_exists is
easy to verify. We immediately call cd_to_toplevel, anyway.
Therefore no matter which function we use, the state
afterwards is one of:

  1. We have a work tree, and we are at the top level.

  2. We don't have a work tree, and we have died.

The only catch is that we must also make sure no code that
ran before the cd_to_toplevel assumed that we were already
in the working tree.

In this case, we will only have included shell libraries and
called set_reflog_action, neither of which care about the
current working directory at all.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the low-hanging, obviously correct fruit. git-am and
git-stash also immediately cd_to_toplevel, but they look at
$PWD or `git rev-parse --show-prefix` beforehand, which
means those uses have to be audited separately.

 git-pull.sh   |    2 +-
 git-rebase.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 63da37b..902fc4a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -11,7 +11,7 @@ OPTIONS_SPEC=
 . git-sh-setup
 . git-sh-i18n
 set_reflog_action "pull${1+ $*}"
-require_work_tree
+require_work_tree_exists
 cd_to_toplevel
 
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 6759702..00ca7b9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -63,7 +63,7 @@ skip!              skip current patch and continue
 "
 . git-sh-setup
 set_reflog_action rebase
-require_work_tree
+require_work_tree_exists
 cd_to_toplevel
 
 LF='
-- 
1.7.6.4.37.g43b58b

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C577C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1197964FB8
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhCHXEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCHXDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 18:03:48 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1304EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 15:03:48 -0800 (PST)
Received: from vapier.lan (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id 3E54733BE68
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 23:03:46 +0000 (UTC)
From:   Mike Frysinger <vapier@gentoo.org>
To:     git@vger.kernel.org
Subject: [PATCH] contrib/rebase-catchup: helper for updating old branches
Date:   Mon,  8 Mar 2021 18:03:45 -0500
Message-Id: <20210308230345.28498-1-vapier@gentoo.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For people who want to rebase their work onto the latest branch
(instead of merging), but there's many conflicting changes.  This
allows you to address those conflicts one-by-one and work through
each issue instead of trying to take them all on at once.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
If there's no interest in merging this into contrib, then this is more spam,
and anyone interested can use https://github.com/vapier/git-rebase-catchup

 contrib/rebase-catchup/README.md             |  61 ++++++
 contrib/rebase-catchup/git-rebase-catchup.py | 187 +++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 contrib/rebase-catchup/README.md
 create mode 100755 contrib/rebase-catchup/git-rebase-catchup.py

diff --git a/contrib/rebase-catchup/README.md b/contrib/rebase-catchup/README.md
new file mode 100644
index 000000000000..083d2012f833
--- /dev/null
+++ b/contrib/rebase-catchup/README.md
@@ -0,0 +1,61 @@
+# Rebase Catchup
+
+Helpful when you have a branch tracking an old commit, and a lot of conflicting
+changes have landed in the latest branch, but you still want to update.
+
+A single rebase to the latest commit will require addressing all the different
+changes at once which can be difficult, overwhelming, and error-prone.  Instead,
+if you rebased onto each intermediate conflicting point, you'd break up the work
+into smaller pieces, and be able to run tests to make sure things were still OK.
+
+## Example
+
+Let's say you have a branch that is currently 357 commits behind.  When you try
+rebasing onto the latest, it hits a lot of conflicts.  The tool will bisect down
+to find the most recent commit it can cleanly rebase onto.
+
+```sh
+$ git rebase-catchup
+Local branch resolved to "s-logs"
+Tracking branch resolved to "origin/master"
+Branch is 2 commits ahead and 357 commits behind
+Trying to rebase onto latest origin/master ... failed; falling back to bisect
+Rebasing onto origin/master~178 ... failed
+Rebasing onto origin/master~267 ... failed
+Rebasing onto origin/master~312 ... failed
+Rebasing onto origin/master~334 ... failed
+Rebasing onto origin/master~345 ... OK
+Rebasing onto origin/master~339 ... OK
+Rebasing onto origin/master~336 ... failed
+Rebasing onto origin/master~337 ... OK
+Rebasing onto origin/master~336 ... failed
+Found first failure origin/master~336
+```
+
+Now you know the first conflicting change is `origin/master~336`.  Rebase onto
+that directly and address all the problems (and run tests/etc...).  Then restart
+the process.
+
+```sh
+$ git rebase origin/master~336
+... address all the conflicts ...
+$ git rebase --continue
+$ git rebase-catchup
+Local branch resolved to "s-logs"
+Tracking branch resolved to "origin/master"
+Branch is 2 commits ahead and 335 commits behind
+Trying to rebase onto latest origin/master ... failed; falling back to bisect
+Rebasing onto origin/master~167 ... OK
+Rebasing onto origin/master~83 ... OK
+Rebasing onto origin/master~41 ... failed
+Rebasing onto origin/master~62 ... OK
+Rebasing onto origin/master~51 ... OK
+Rebasing onto origin/master~46 ... OK
+Rebasing onto origin/master~43 ... failed
+Rebasing onto origin/master~44 ... failed
+Rebasing onto origin/master~45 ... OK
+Rebasing onto origin/master~44 ... failed
+Found first failure origin/master~44
+```
+
+Now you're only 44 commits behind.  Keep doing this until you catchup!
diff --git a/contrib/rebase-catchup/git-rebase-catchup.py b/contrib/rebase-catchup/git-rebase-catchup.py
new file mode 100755
index 000000000000..2cc5c5381616
--- /dev/null
+++ b/contrib/rebase-catchup/git-rebase-catchup.py
@@ -0,0 +1,187 @@
+#!/usr/bin/env python3
+# Distributed under the terms of the GNU General Public License v2 or later.
+
+"""Helper to automatically rebase onto latest commit possible.
+
+Helpful when you have a branch tracking an old commit, and a lot of conflicting
+changes have landed in the latest branch, but you still want to update.
+
+A single rebase to the latest commit will require addressing all the different
+changes at once which can be difficult, overwhelming, and error-prone.  Instead,
+if you rebased onto each intermediate conflicting point, you'd break up the work
+into smaller pieces, and be able to run tests to make sure things were still OK.
+"""
+
+import argparse
+import subprocess
+import sys
+from typing import List, Tuple, Union
+
+
+assert sys.version_info >= (3, 7), f'Need Python 3.7+, not {sys.version_info}'
+
+
+def git(args: List[str], **kwargs) -> subprocess.CompletedProcess:
+    """Run git."""
+    kwargs.setdefault('check', True)
+    kwargs.setdefault('capture_output', True)
+    kwargs.setdefault('encoding', 'utf-8')
+    # pylint: disable=subprocess-run-check
+    return subprocess.run(['git'] + args, **kwargs)
+
+
+def rebase(target: str) -> bool:
+    """Try to rebase onto |target|."""
+    try:
+        git(['rebase', target])
+        return True
+    except KeyboardInterrupt:
+        git(['rebase', '--abort'])
+        print('aborted')
+        sys.exit(1)
+    except:
+        git(['rebase', '--abort'])
+        return False
+
+
+def rebase_bisect(lbranch: str,
+                  rbranch: str,
+                  behind: int,
+                  leave_rebase: bool = False,
+                  force_checkout: bool = False):
+    """Try to rebase branch as close to |rbranch| as possible."""
+    def attempt(pos: int) -> bool:
+        target = f'{rbranch}~{pos}'
+        print(f'Rebasing onto {target} ', end='')
+        print('.', end='', flush=True)
+        # Checking out these branches directly helps clobber orphaned files,
+        # but is usually unnessary, and can slow down the overall process.
+        if force_checkout:
+            git(['checkout', '-f', target])
+        print('.', end='', flush=True)
+        if force_checkout:
+            git(['checkout', '-f', lbranch])
+        print('. ', end='', flush=True)
+        ret = rebase(target)
+        print('OK' if ret else 'failed')
+        return ret
+
+    # "pmin" is the latest branch position while "pmax" is where we're now.
+    pmin = 0
+    pmax = behind
+    old_mid = None
+    first_fail = 0
+    while True:
+        mid = pmin + (pmax - pmin) // 2
+        if mid == old_mid or mid < pmin or mid >= pmax:
+            break
+        if attempt(mid):
+            pmax = mid
+        else:
+            first_fail = max(first_fail, mid)
+            pmin = mid
+        old_mid = mid
+
+    if pmin or pmax:
+        last_target = f'{rbranch}~{first_fail}'
+        if leave_rebase:
+            print('Restarting', last_target)
+            result = git(['rebase', last_target], check=False)
+            print(result.stdout.strip())
+        else:
+            print('Found first failure', last_target)
+    else:
+        print('All caught up!')
+
+
+def get_ahead_behind(lbranch: str, rbranch: str) -> Tuple[int, int]:
+    """Return number of commits |lbranch| is ahead & behind relative to |rbranch|."""
+    output = git(
+        ['rev-list', '--left-right', '--count', f'{lbranch}...{rbranch}']).stdout
+    return [int(x) for x in output.split()]
+
+
+def get_tracking_branch(branch: str) -> Union[str, None]:
+    """Return branch that |branch| is tracking."""
+    merge = git(['config', '--local', f'branch.{branch}.merge']).stdout.strip()
+    if not merge:
+        return None
+
+    remote = git(['config', '--local', f'branch.{branch}.remote']).stdout.strip()
+    if remote:
+        if merge.startswith('refs/heads/'):
+            merge = merge[11:]
+        return f'{remote}/{merge}'
+    else:
+        return merge
+
+
+def get_local_branch() -> str:
+    """Return the name of the local checked out branch."""
+    return git(['branch', '--show-current']).stdout.strip()
+
+
+def get_parser() -> argparse.ArgumentParser:
+    """Get CLI parser."""
+    parser = argparse.ArgumentParser(
+        description=__doc__,
+        formatter_class=argparse.RawDescriptionHelpFormatter)
+    parser.add_argument(
+        '--skip-initial-rebase-latest', dest='initial_rebase',
+        action='store_false', default=True,
+        help='skip initial rebase attempt onto the latest branch')
+    parser.add_argument(
+        '--leave-at-last-failed-rebase', dest='leave_rebase',
+        action='store_true', default=False,
+        help='leave tree state at last failing rebase')
+    parser.add_argument(
+        '--checkout-before-rebase', dest='force_checkout',
+        action='store_true', default=False,
+        help='force checkout before rebasing to target (to cleanup orphans)')
+    parser.add_argument(
+        'branch', nargs='?',
+        help='branch to rebase onto')
+    return parser
+
+
+def main(argv: List[str]) -> int:
+    """The main entry point for scripts."""
+    parser = get_parser()
+    opts = parser.parse_args(argv)
+
+    lbranch = get_local_branch()
+    print(f'Local branch resolved to "{lbranch}"')
+    if not lbranch:
+        print('Unable to resolve local branch', file=sys.stderr)
+        return 1
+
+    if opts.branch:
+        rbranch = opts.branch
+    else:
+        rbranch = get_tracking_branch(lbranch)
+    print(f'Tracking branch resolved to "{rbranch}"')
+
+    ahead, behind = get_ahead_behind(lbranch, rbranch)
+    print(f'Branch is {ahead} commits ahead and {behind} commits behind')
+
+    if not behind:
+        print('Up-to-date!')
+    elif not ahead:
+        print('Fast forwarding ...')
+        git(['merge'])
+    else:
+        if opts.initial_rebase:
+            print(f'Trying to rebase onto latest {rbranch} ... ',
+                  end='', flush=True)
+            if rebase(rbranch):
+                print('OK!')
+                return 0
+            print('failed; falling back to bisect')
+        rebase_bisect(lbranch, rbranch, behind, leave_rebase=opts.leave_rebase,
+                      force_checkout=opts.force_checkout)
+
+    return 0
+
+
+if __name__ == '__main__':
+    sys.exit(main(sys.argv[1:]))
-- 
2.30.0


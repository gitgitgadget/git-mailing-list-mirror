Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4351AC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76AE20714
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 22:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgJOWyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:54:49 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:47624 "EHLO
        coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbgJOWyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 18:54:49 -0400
X-Greylist: delayed 14819 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 18:54:48 EDT
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id 280F92E6D6;
        Thu, 15 Oct 2020 23:54:47 +0100 (BST)
Date:   Thu, 15 Oct 2020 23:54:46 +0100
From:   Adam Spiers <git@adamspiers.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git list <git@vger.kernel.org>
Subject: Re: [PATCH v2] hook: add sample template for push-to-checkout
Message-ID: <20201015225446.b5tvyo3cquhslfry@gmail.com>
X-OS:   GNU/Linux
References: <20201015184703.5015-1-git@adamspiers.org>
 <xmqqo8l3dxu7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqo8l3dxu7.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 01:43:28PM -0700, Junio C Hamano wrote: 
>Adam Spiers <git@adamspiers.org> writes: 
>
>>The template is a more-or-less exact translation to shell of the C 
>>code for the default behaviour for git's push-to-checkout hook defined 
>>in the push_to_deploy() function in builtin/receive-pack.c, to serve 
>>as a convenient starting point for modification. 
>>
>>It also contains relevant text extracted from the git-config(1) and 
>>githooks(5) man pages. 
>>
>>Signed-off-by: Adam Spiers <git@adamspiers.org> 
>>---
>>  templates/hooks--push-to-checkout.sample | 74 ++++++++++++++++++++++++ 
>>  1 file changed, 74 insertions(+) 
>>  create mode 100755 templates/hooks--push-to-checkout.sample 
>>
>>diff --git a/templates/hooks--push-to-checkout.sample b/templates/hooks--push-to-checkout.sample 
>>new file mode 100755 
>>index 0000000000..2c6e06f8f1 
>>--- /dev/null 
>>+++ b/templates/hooks--push-to-checkout.sample 
>>@@ -0,0 +1,74 @@ 
>>+#!/bin/bash 
>
>If we want to make this part of the sample hooks shown to everybody, 
>we should stick to /bin/sh if we could.  Do you have to rely on any 
>bash-ism that are not found in other shells to write this script, or 
>is this just shows your inertia that you always work with bash? 

I usually work with bash and zsh, and just forgot to convert it in 
this case.

>>+# The hook receives the commit with which the tip of the current 
>>+# branch is going to be updated: 
>>+commit="$1" 
>
>Strictly speaking, a parameter on the right hand side of an 
>assignment does not have to get dquoted to protect it from getting 
>munged at $IFS, so this can be 
>
>	commit=$1

Ah, interesting thanks - not sure why it's taken me 25 years to 
discover that. 

-- >8 --
Subject: [PATCH v2] hook: add sample template for push-to-checkout

The template is a more-or-less exact translation to shell of the C
code for the default behaviour for git's push-to-checkout hook defined
in the push_to_deploy() function in builtin/receive-pack.c, to serve
as a convenient starting point for modification.

It also contains relevant text extracted from the git-config(1) and
githooks(5) man pages.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
  templates/hooks--push-to-checkout.sample | 78 ++++++++++++++++++++++++
  1 file changed, 78 insertions(+)
  create mode 100755 templates/hooks--push-to-checkout.sample

diff --git a/templates/hooks--push-to-checkout.sample b/templates/hooks--push-to-checkout.sample
new file mode 100755
index 0000000000..af5a0c0018
--- /dev/null
+++ b/templates/hooks--push-to-checkout.sample
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+# An example hook script to update a checked-out tree on a git push.
+#
+# This hook is invoked by git-receive-pack(1) when it reacts to git
+# push and updates reference(s) in its repository, and when the push
+# tries to update the branch that is currently checked out and the
+# receive.denyCurrentBranch configuration variable is set to
+# updateInstead.
+#
+# By default, such a push is refused if the working tree and the index
+# of the remote repository has any difference from the currently
+# checked out commit; when both the working tree and the index match
+# the current commit, they are updated to match the newly pushed tip
+# of the branch. This hook is to be used to override the default
+# behaviour; however the code below reimplements the default behaviour
+# as a starting point for convenient modification.
+#
+# The hook receives the commit with which the tip of the current
+# branch is going to be updated:
+commit=$1
+
+# It can exit with a non-zero status to refuse the push (when it does
+# so, it must not modify the index or the working tree).
+die () {
+	echo >&2 "$*"
+	exit 1
+}
+
+# Or it can make any necessary changes to the working tree and to the
+# index to bring them to the desired state when the tip of the current
+# branch is updated to the new commit, and exit with a zero status.
+#
+# For example, the hook can simply run git read-tree -u -m HEAD "$1"
+# in order to emulate git fetch that is run in the reverse direction
+# with git push, as the two-tree form of git read-tree -u -m is
+# essentially the same as git switch or git checkout that switches
+# branches while keeping the local changes in the working tree that do
+# not interfere with the difference between the branches.
+
+# The below is a more-or-less exact translation to shell of the C code
+# for the default behaviour for git's push-to-checkout hook defined in
+# the push_to_deploy() function in builtin/receive-pack.c.
+#
+# Note that the hook will be executed from the repository directory,
+# not from the working tree, so if you want to perform operations on
+# the working tree, you will have to adapt your code accordingly, e.g.
+# by adding "cd .." or using relative paths.
+
+if ! git update-index -q --ignore-submodules --refresh
+then
+	die "Up-to-date check failed"
+fi
+
+if ! git diff-files --quiet --ignore-submodules --
+then
+	die "Working directory has unstaged changes"
+fi
+
+# This is a rough translation of:
+#
+#   head_has_history() ? "HEAD" : EMPTY_TREE_SHA1_HEX
+if git cat-file -e HEAD 2>/dev/null
+then
+	head=HEAD
+else
+	head=$(git hash-object -t tree --stdin </dev/null)
+fi
+
+if ! git diff-index --quiet --cached --ignore-submodules $head --
+then
+	die "Working directory has staged changes"
+fi
+
+if ! git read-tree -u -m "$commit"
+then
+	die "Could not update working tree to new HEAD"
+fi
-- 
2.28.0


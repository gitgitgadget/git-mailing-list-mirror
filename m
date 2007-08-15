From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix initialization of a bare repository
Date: Wed, 15 Aug 2007 13:41:06 -0700
Message-ID: <7vhcn0pm3h.fsf@gitster.siamese.dyndns.org>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:41:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILPgY-0003zU-EK
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297AbXHOUlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbXHOUlP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 16:41:15 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbXHOUlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 16:41:14 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 984CD121EDC;
	Wed, 15 Aug 2007 16:41:29 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 15 Aug 2007 18:25:44 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55943>

Wait a minute.

Let's step back a bit and think what we want to happen here.

 * No GIT_DIR, no --bare.  Having GIT_WORK_TREE is an error.

   $ mkdir foo && cd foo && git init

   We want to say "not bare" and create foo/.git/config and friends. 

 * No GIT_DIR, with --bare.  Having GIT_WORK_TREE is an error.

   $ mkdir foo && cd foo && git --bare init

   We want to say "is bare" and create foo/config, foo/HEAD and
   friends.

 * With GIT_DIR but no GIT_WORK_TREE, with or without --bare.

   $ mkdir foo.git && GIT_DIR=foo.git git init
   $ mkdir foo.git && GIT_DIR=foo.git git --bare init

   We want to say "is bare" and create foo.git/config and friends.

 * With GIT_DIR and GIT_WORK_TREE.  Having --bare is an error.

   $ mkdir foo.git foo.work
   $ GIT_DIR=foo.git GIT_WORK_TREE=foo.work git init

   We want to say "not bare", create foo.git/config and friends,
   and record core.worktree = /full/path/to/foo.work

Is the above list reasonable?

---

 t/t0001-init.sh |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100755 t/t0001-init.sh

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
new file mode 100755
index 0000000..9fb2b59
--- /dev/null
+++ b/t/t0001-init.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+
+test_description='git init'
+
+. ./test-lib.sh
+
+check_config () {
+	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
+	then
+		: happy
+	else
+		echo "expected a directory $1, a file $1/config and $1/refs"
+		return 1
+	fi
+	bare=$(GIT_CONFIG="$1/config" git config --bool core.bare)
+	worktree=$(GIT_CONFIG="$1/config" git config core.worktree) ||
+	worktree=unset
+
+	test "$bare" = "$2" && test "$worktree" = "$3" || {
+		echo "expected bare=$2 worktree=$3"
+		echo "     got bare=$bare worktree=$worktree"
+		return 1
+	}
+}
+
+test_expect_success 'plain' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		mkdir plain &&
+		cd plain &&
+		git init
+	) &&
+	check_config plain/.git false unset
+'
+
+test_expect_success 'plain with GIT_WORK_TREE' '
+	if (
+		unset GIT_DIR &&
+		mkdir plain-wt &&
+		cd plain-wt &&
+		GIT_WORK_TREE=$(pwd) git init
+	)
+	then
+		echo Should have failed -- GIT_WORK_TREE should not be used
+		false
+	fi
+'
+
+test_expect_success 'plain bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		mkdir plain-bare &&
+		cd plain-bare &&
+		git --bare init
+	) &&
+	check_config plain-bare true unset
+'
+
+test_expect_success 'plain bare with GIT_WORK_TREE' '
+	if (
+		unset GIT_DIR &&
+		mkdir plain-bare &&
+		cd plain-bare &&
+		GIT_WORK_TREE=$(pwd) git --bare init
+	)
+	then
+		echo Should have failed -- GIT_WORK_TREE should not be used
+		false
+	fi
+'
+
+test_expect_success 'GIT_DIR bare (1)' '
+
+	(
+		mkdir git-dir-bare-1.git &&
+		GIT_DIR=git-dir-bare-1.git git init
+	) &&
+	check_config git-dir-bare-1.git true unset
+'
+
+test_expect_success 'GIT_DIR bare (2)' '
+
+	(
+		mkdir git-dir-bare-2.git &&
+		GIT_DIR=git-dir-bare-2.git git --bare init
+	) &&
+	check_config git-dir-bare-2.git true unset
+'
+
+test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
+
+	(
+		mkdir git-dir-wt-1.git &&
+		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
+	) &&
+	check_config git-dir-wt-1.git false "$(pwd)"
+'
+
+test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
+
+	if (
+		mkdir git-dir-wt-2.git &&
+		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
+	)
+	then
+		echo Should have failed -- --bare should not be used
+		false
+	fi
+'
+
+test_done

From: Stephan Beyer <s-beyer@gmx.net>
Subject: [RFC/PATCH] Add git-squash tool and tests
Date: Mon,  9 Jun 2008 22:29:58 +0200
Message-ID: <1213043398-30524-1-git-send-email-s-beyer@gmx.net>
References: <484D47C9.9050509@gnu.org>
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 22:31:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5o1C-0005lC-JI
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbYFIUaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYFIUaG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:30:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755976AbYFIUaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:30:04 -0400
Received: (qmail invoked by alias); 09 Jun 2008 20:30:02 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 09 Jun 2008 22:30:02 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19LOtdfsUhLapAcLZrpa8ou+e7WXhj3H4A6jeOCwC
	f4IAndFGE2Cv5+
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5o06-0007wg-Nc; Mon, 09 Jun 2008 22:29:58 +0200
X-Mailer: git-send-email 1.5.5.1.493.g7dfd.dirty
In-Reply-To: <484D47C9.9050509@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84420>

git-squash is a simple command that, given the parent commit of X,
squashes the commits X..HEAD into one.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

perhaps this is a little surprising, but because of:
> This could be done by providing a stand-alone git-squash command;
I thought it could be right to quickly write this as a script.

Here it is as RFC, yet without documentation.

Junio, this could be a backend for the zucchini instruction, by just
 zucchini <n>  =>  git-squash "HEAD~$(expr $n + 1)"   ;-)

 Makefile          |    1 +
 command-list.txt  |    1 +
 git-squash.sh     |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t3150-squash.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 0 deletions(-)
 create mode 100755 git-squash.sh
 create mode 100755 t/t3150-squash.sh

diff --git a/Makefile b/Makefile
index 1937507..863004b 100644
--- a/Makefile
+++ b/Makefile
@@ -251,6 +251,7 @@ SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
+SCRIPT_SH += git-squash.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/command-list.txt b/command-list.txt
index 3583a33..e342da3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -108,6 +108,7 @@ git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
+git-squash                              mainporcelain
 git-stash                               mainporcelain
 git-status                              mainporcelain common
 git-stripspace                          purehelpers
diff --git a/git-squash.sh b/git-squash.sh
new file mode 100755
index 0000000..64b5949
--- /dev/null
+++ b/git-squash.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+#
+# Squash commits from HEAD up to ... into one commit.
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git-squash [options] <commit-ish>
+--
+author=           use author <author>
+C,reuse-message=  use commit data from <commit-ish>
+F,file=           use commit message in <file>
+m,message=        use commit message <msg>
+e,edit            force edit of commit message
+s,signoff         add Signed-off-by:
+include-merges    don't fail if merge is in between
+"
+
+. git-sh-setup
+require_work_tree
+
+# test if working tree is clean
+git rev-parse --verify HEAD >/dev/null &&
+git update-index --refresh &&
+git diff-files --quiet &&
+git diff-index --cached --quiet HEAD -- ||
+	die "Working tree is dirty"
+
+git var GIT_COMMITTER_IDENT >/dev/null ||
+	die "You need to set your committer info first"
+
+HEAD=$(git rev-parse --verify HEAD) ||
+	die "No HEAD?"
+
+commitstr="git commit "
+merges=
+while test $# -gt 1
+do
+	case "$1" in
+	-m|-F|-C|--author)
+		commitstr="$commitstr $1 '$2'"
+		shift
+		;;
+	-e|-s)
+		commitstr="$commitstr $1"
+		;;
+	--include-merges)
+		merges=y
+		;;
+	--)
+		break
+		;;
+	esac
+	shift
+done
+
+test $# -gt 2 &&
+	die "Wrong number of arguments."
+test $# -lt 2 &&
+	die "No commit given."
+shift
+
+commit="$1"
+git rev-parse --verify "$commit" >/dev/null ||
+	die "$commit is no valid commit."
+
+# check for merges if no --include-merges given
+test -z "$merges" &&
+git log "$commit.." | grep -q "^Merge:" &&
+	die "$commit..HEAD contains a merge commit. You may try --include-merges."
+
+# reset and commit
+git reset --soft "$commit"
+eval "$commitstr" || {
+	git reset --hard $HEAD
+	die "Commit failed"
+}
diff --git a/t/t3150-squash.sh b/t/t3150-squash.sh
new file mode 100755
index 0000000..9f18995
--- /dev/null
+++ b/t/t3150-squash.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='git-squash'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	: >file1 &&
+	: >file2 &&
+	: >file3 &&
+	: >file4 &&
+	: >file5 &&
+	: >file6 &&
+	git add file1 &&
+	git commit -m file1 &&
+	git add file2 &&
+	git commit -m file2 &&
+	git checkout -b master2 HEAD^ &&
+	git add file3 &&
+	git commit -m file3 &&
+	git checkout master &&
+	git merge master2 &&
+	git add file4 &&
+	git commit -m file4 &&
+	git add file5 &&
+	git commit -m file5 &&
+	git add file6 &&
+	git commit -m file6
+'
+
+test_expect_success 'git-squash HEAD^ is a nop and fails' '
+	git checkout -b first master &&
+	! git squash HEAD^ &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse first)" &&
+	test "$(git rev-parse master)" = "$(git rev-parse first)"
+'
+
+test_expect_success 'git-squash works' '
+	git checkout -b second master &&
+	git squash -m "file5 and file6" --signoff HEAD^^ &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -f file1 -a -f file2 -a -f file3 -a \
+	     -f file4 -a -f file5 -a -f file6
+'
+
+test_expect_success 'git-squash fails if merge in between' '
+	git checkout -b third master &&
+	! git squash -C master master2^ &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
+	test "$(git rev-parse master)" = "$(git rev-parse third)"
+'
+
+test_expect_success 'git-squash works with --include-merges if merge in between' '
+	git checkout -b fourth master &&
+	git squash -C master --include-merges master2^ &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse fourth)"
+'
+
+test_expect_success 'git-squash aborts correctly if no commit message given' '
+	git checkout -b fifth master &&
+	! git squash HEAD~2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse fifth)" &&
+	test "$(git rev-parse master)" = "$(git rev-parse fifth)"
+'
+
+test_done
-- 
1.5.5.3

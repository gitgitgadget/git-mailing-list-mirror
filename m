From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git submodule add: make the <path> parameter optional
Date: Fri, 28 Aug 2009 21:19:36 +0200
Message-ID: <4A982DC8.3000407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6zC-0005s0-MG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbZH1TTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbZH1TTh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:19:37 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:56391 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbZH1TTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:19:35 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0FCA11104E702;
	Fri, 28 Aug 2009 21:19:37 +0200 (CEST)
Received: from [80.128.61.96] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mh6z2-0006lb-00; Fri, 28 Aug 2009 21:19:36 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19LFYOkiT59i9+/C6r9xu/XQfe8XNsuz2j5aq0o
	GkkSoL/S/lHY9r63iDb3U2mTfPw1C6g67u/p5DYqkk7N9T06WE
	2/Zk6lYzjffm/b2gkKuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127337>

When <path> is not given, use the "humanish" part of the source repository
instead.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

With this patch, git submodule add behaves like git clone in this respect.

 Documentation/git-submodule.txt |    8 ++++++--
 git-submodule.sh                |    7 ++++++-
 t/t7400-submodule-basic.sh      |   16 ++++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 5ccdd18..4ef70c4 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b branch]
-	      [--reference <repository>] [--] <repository> <path>
+	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
@@ -69,7 +69,11 @@ add::
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-This requires two arguments: <repository> and <path>.
+This requires at least one argument: <repository>. The optional
+argument <path> is the relative location for the cloned submodule
+to exist in the superproject. If <path> is not given, the
+"humanish" part of the source repository is used ("repo" for
+"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
diff --git a/git-submodule.sh b/git-submodule.sh
index bfbd36b..0c617eb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli

 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> <path>
+USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
@@ -160,6 +160,11 @@ cmd_add()
 	repo=$1
 	path=$2

+	if test -z "$path"; then
+		path=$(echo "$repo" |
+			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
+	fi
+
 	if test -z "$repo" -o -z "$path"; then
 		usage
 	fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 0f2ccc6..a0cc99a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -306,4 +306,20 @@ test_expect_success 'submodule <invalid-path> warns' '

 '

+test_expect_success 'add submodules without specifying an explicit path' '
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	echo r >r &&
+	git add r &&
+	git commit -m "repo commit 1" &&
+	cd .. &&
+	git clone --bare repo/ bare.git &&
+	cd addtest &&
+	git submodule add "$submodurl/repo" &&
+	git config -f .gitmodules submodule.repo.path repo &&
+	git submodule add "$submodurl/bare.git" &&
+	git config -f .gitmodules submodule.bare.path bare
+'
+
 test_done
-- 
1.6.4.1.246.g7bae7.dirty

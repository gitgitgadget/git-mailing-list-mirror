From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH RESEND] git submodule add: make the <path> parameter optional
Date: Tue, 22 Sep 2009 17:10:12 +0200
Message-ID: <4AB8E8D4.40105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq70h-0002gc-Qy
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 17:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbZIVPKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbZIVPKN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 11:10:13 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:56572 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbZIVPKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 11:10:12 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7E39811F28AE4;
	Tue, 22 Sep 2009 17:10:15 +0200 (CEST)
Received: from [80.128.111.117] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mq70R-0000Cc-00; Tue, 22 Sep 2009 17:10:15 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18DNcyURYgEiMNmAdz/jXD12SoBAU8Wl24ad6iB
	fb3bLpy23VhsvMOJHp3/VKx37pHOo0doB+kqE6U7FFGjY9hTea
	cVmn+DilpZQKxztMY7VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128937>

When <path> is not given, use the "humanish" part of the source repository
instead.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

With this patch, git submodule add behaves like git clone in this respect.

Didn't get a response the last weeks, so here is a resend.


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

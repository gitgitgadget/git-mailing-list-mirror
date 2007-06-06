From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix clone to setup the origin if its name ends with .git
Date: Thu, 7 Jun 2007 00:49:06 +0200
Message-ID: <20070606224906.GB3969@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 00:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw4Jc-0001yf-4c
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935482AbXFFWtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763548AbXFFWtL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:49:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:33470 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935482AbXFFWtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:49:10 -0400
Received: from tigra.home (Fa87f.f.strato-dslnet.de [195.4.168.127])
	by post.webmailer.de (mrclete mo14) (RZmta 7.2)
	with ESMTP id B05243j56IfMoT ; Thu, 7 Jun 2007 00:49:07 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 08E80277BD;
	Thu,  7 Jun 2007 00:49:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 02033BEA7; Thu,  7 Jun 2007 00:49:06 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49331>

The problem is visible when cloning a local repo. The cloned
repository will have the origin url setup incorrectly: the origin name
will be copied verbatim in origin url of the cloned repository.
Normally, the name is to be expanded into absolute path.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-clone.sh           |    2 +-
 t/t5701-clone-local.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)
 create mode 100755 t/t5701-clone-local.sh

diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..d45618d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -20,7 +20,7 @@ usage() {
 get_repo_base() {
 	(
 		cd "`/bin/pwd`" &&
-		cd "$1" &&
+		cd "$1" || cd "$1.git" &&
 		{
 			cd .git
 			pwd
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
new file mode 100755
index 0000000..fb027f3
--- /dev/null
+++ b/t/t5701-clone-local.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='test local clone'
+. ./test-lib.sh
+
+test_expect_success 'preparing origin repository' \
+':>file && git add . && git commit -m1 && mv .git a.git'
+
+unset GIT_CONFIG
+
+test_expect_success 'local clone without .git suffix' \
+'git clone -l -s a b && cd b && git fetch && cd ..'
+
+test_expect_success 'local clone with .git suffix' \
+'git clone -l -s a.git c && cd c && git fetch && cd ..'
+
+test_done
-- 
1.5.2.1.141.g3c63

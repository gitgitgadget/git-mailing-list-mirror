From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make t5710 more strict when creating nested repos
Date: Mon, 21 Jan 2008 21:53:25 +0100
Message-ID: <20080121205325.GA16670@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 21:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3ea-00073m-G3
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbYAUUxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbYAUUxb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:53:31 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:40215 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbYAUUx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 15:53:29 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKatAU=
Received: from tigra.home (Fab8e.f.strato-dslnet.de [195.4.171.142])
	by post.webmailer.de (klopstock mo26) (RZmta 15.4)
	with ESMTP id t05b58k0LGCqTk ; Mon, 21 Jan 2008 21:53:26 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BCB17277AE;
	Mon, 21 Jan 2008 21:53:25 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 8D5F956D22; Mon, 21 Jan 2008 21:53:25 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71334>

The test 'creating too deep nesting' can fail even when cloning the repos,
but is not its main purpose (it has to prepare nested repos and ensure
the last one is invalid). So split the test into the creation and
invalidity checking parts.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Noticed try to figure out why the test breaks on cygwin with the
recent in-core-index branch. Didn't manage that, though.

 t/t5710-info-alternate.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 699df6e..1908dc8 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -53,14 +53,18 @@ git prune'
 
 cd "$base_dir"
 
-test_expect_failure 'creating too deep nesting' \
+test_expect_success 'creating too deep nesting' \
 'git clone -l -s C D &&
 git clone -l -s D E &&
 git clone -l -s E F &&
 git clone -l -s F G &&
-git clone -l -s G H &&
-cd H &&
-test_valid_repo'
+git clone -l -s G H'
+
+test_expect_success 'invalidity of deepest repository' \
+'cd H && {
+	test_valid_repo
+	test $? -ne 0
+}'
 
 cd "$base_dir"
 
-- 
1.5.4.rc3.49.gd0cc3

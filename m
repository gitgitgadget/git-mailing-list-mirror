From: Jeff King <peff@peff.net>
Subject: [PATCH 12/16] git-submodule: avoid sed input with no newline
Date: Wed, 12 Mar 2008 17:40:44 -0400
Message-ID: <20080312214044.GM26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYhU-0002Mg-DM
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYCLVkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYCLVkr
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:40:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbYCLVkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:40:47 -0400
Received: (qmail 3581 invoked by uid 111); 12 Mar 2008 21:40:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:40:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:40:44 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77003>

Some versions of sed don't like this, and give no output at
all. Instead, we can use git-config to pare down the matches
for us.

The content of the last three lines of the patch aren't
changed at all; they merely fix a bogus 7-space indentation.

Signed-off-by: Jeff King <peff@peff.net>
---
And this is safe because of the --literal-match from the last patch.

 git-submodule.sh |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ceb2295..fb01d94 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -71,13 +71,12 @@ resolve_relative_url ()
 module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
-	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
-	name=$( GIT_CONFIG=.gitmodules \
-		git config --get-regexp '^submodule\..*\.path$' |
-		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-       test -z "$name" &&
-       die "No submodule mapping found in .gitmodules for path '$path'"
-       echo "$name"
+	name=$(git config --literal-match -f .gitmodules \
+		--get-regexp 'submodule\..*\.path$' "$1" |
+		sed -e 's/submodule\.//' -e 's/\.path.*//')
+	test -z "$name" &&
+	die "No submodule mapping found in .gitmodules for path '$path'"
+	echo "$name"
 }
 
 #
-- 
1.5.4.4.543.g30fdd.dirty

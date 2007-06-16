From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: [PATCH] Cloning from a repo without "current branch"
Date: Sat, 16 Jun 2007 15:26:08 -0700
Message-ID: <200706162226.l5GMQBss004492@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 01:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzhZD-0001vP-FF
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 01:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbXFPXUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 19:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXFPXUO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 19:20:14 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:38819 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbXFPXUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 19:20:12 -0400
X-Greylist: delayed 3239 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jun 2007 19:20:12 EDT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5GMQBss004492
	for <git@vger.kernel.org>; Sat, 16 Jun 2007 15:26:11 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:to:cc:date:from:subject:mime-version:
	content-type:content-transfer-encoding:user-agent:x-virus-scanned:
	x-virus-status:x-trusted-delivery;
	b=1N6dfYk2nNvdJeiIODRBCssukFdXo8hwFKQzLvakos9IL7a1NWxtEgWqb/xq3Ra5z
	jLAqzaGHGXBm5ZrFbWYWcwWr1BFI7J8AxjrHXBWJDPpPLwJ2ybwMGFB14GQXE/h
Received: from localhost (internal.bluebottle.com [206.188.24.43])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5GMQ8Z9003461;
	Sat, 16 Jun 2007 15:26:08 -0700
Received: from 86-15-251-64.serverpronto.com (86-15-251-64.serverpronto.com [64.251.15.86]) 
	by mail.bluebottle.com (IMP) with HTTP 
	for <nanako3@bluebottle.com@localhost>; Sat, 16 Jun 2007 15:26:08 -0700
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Virus-Scanned: ClamAV version 0.88.4, clamav-milter version 0.88.4 on localhost
X-Virus-Status: Clean
X-Trusted-Delivery: <07b500ae318fb448f1c2ebac8180b348>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50323>

If the remote repository does not have a "current branch", git-clone
was
confused and did not set up the resulting new repository correctly. 
It did
not reset HEAD from the default 'master', and did not write the SHA1
to the master branch.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>


diff --git a/git-clone.sh b/git-clone.sh
index 3a41062..bd44ce1 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -377,6 +377,13 @@ then
 		)
 	)
 
+	# Upstream URL
+	git-config remote."$origin".url "$repo" &&
+
+	# Set up the mappings to track the remote branches.
+	git-config remote."$origin".fetch \
+		"+refs/heads/*:$remote_top/*" '^$' &&
+
 	# Write out remote.$origin config, and update our
"$head_points_at".
 	case "$head_points_at" in
 	?*)
@@ -384,21 +391,20 @@ then
 		git-symbolic-ref HEAD "refs/heads/$head_points_at" &&
 
 		# Tracking branch for the primary branch at the remote.
-		origin_track="$remote_top/$head_points_at" &&
 		git-update-ref HEAD "$head_sha1" &&
 
-		# Upstream URL
-		git-config remote."$origin".url "$repo" &&
-
-		# Set up the mappings to track the remote branches.
-		git-config remote."$origin".fetch \
-			"+refs/heads/*:$remote_top/*" '^$' &&
 		rm -f "refs/remotes/$origin/HEAD"
 		git-symbolic-ref "refs/remotes/$origin/HEAD" \
 			"refs/remotes/$origin/$head_points_at" &&
 
 		git-config branch."$head_points_at".remote "$origin" &&
 		git-config branch."$head_points_at".merge
"refs/heads/$head_points_at"
+		;;
+	'')
+		# Source had detached HEAD pointing nowhere
+		git-update-ref --no-deref HEAD "$head_sha1" &&
+		rm -f "refs/remotes/$origin/HEAD"
+		;;
 	esac
 
 	case "$no_checkout" in
-- 
1.5.2

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com

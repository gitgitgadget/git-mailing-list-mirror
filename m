From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] remotes.not-origin.tagopt
Date: Thu, 15 Feb 2007 01:46:27 -0800
Message-ID: <7vfy97g3d8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 10:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdCC-0003je-8s
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 10:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbXBOJq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 04:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbXBOJq3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 04:46:29 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62891 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691AbXBOJq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 04:46:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215094628.YNTR22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 04:46:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PlmT1W00Q1kojtg0000000; Thu, 15 Feb 2007 04:46:28 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39804>

With a configuration entry like this:

	[remote "alt-git"]
        	url = git://repo.or.cz/alt.git/git/
                fetch = +refs/heads/*:refs/remotes/alt-git/*
                tagopt = --no-tags

you do not have to say "git pull --no-tags alt-git".  Just
saying "git pull alt-git" would suffice.

Obviously, if you want to get the tag from such an alternate
remote in a separate namespace, you could also do something like:

	[remote "alt-git"]
        	url = git://repo.or.cz/alt.git/git/
                fetch = +refs/heads/*:refs/remotes/alt-git/*
                fetch = +refs/tags/*:refs/remote-tags/alt-git/*
                tagopt = --no-tags

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-fetch.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index ca984e7..d230995 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -243,6 +243,15 @@ then
 	orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 fi
 
+# Allow --notags from remote.$1.tagopt
+case "$tags$no_tags" in
+'')
+	case "$(git-config --get "remote.$1.tagopt")" in
+	--no-tags)
+		no_tags=t ;;
+	esac
+esac
+
 # If --tags (and later --heads or --all) is specified, then we are
 # not talking about defaults stored in Pull: line of remotes or
 # branches file, and just fetch those and refspecs explicitly given.

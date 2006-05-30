From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [RFC] git-fetch - repack in the background after fetching
Date: Tue, 30 May 2006 16:42:43 +1200
Message-ID: <11489641631558-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue May 30 06:36:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkvyE-0006wd-7h
	for gcvg-git@gmane.org; Tue, 30 May 2006 06:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWE3Egj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 00:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWE3Egj
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 00:36:39 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:42381 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932078AbWE3Egi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 00:36:38 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Fkvy8-0006B9-O2; Tue, 30 May 2006 16:36:36 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1Fkw43-0007FM-00; Tue, 30 May 2006 16:42:43 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.g9927-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21011>

Check whether we have a large set of unpacked objects and repack
after the fetch, but don't for the user to wait for us.

---

There's been some discussion about repacking proactively without
preventing further work. But as Linus said, repacking on an active
repo is _safe_, so repack in the background. 

If we like this approach, we should at least respect a git-repo-config
entry saying core.noautorepack for users who don't want it. I don't
really know if there is any convention for us to check if we are in
a resource-constrained situation (aka laptops on battery). If there
is, we should respect that as well. I suspect anacron and others 
do this already but I can't find any references.

We can potentially do it on commit, merge and push as well. 
---

 git-fetch.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

5498d015eb1062928a504af3c6b3cb9b776088e8
diff --git a/git-fetch.sh b/git-fetch.sh
index 69bd810..4d64cdb 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -424,3 +424,9 @@ case ",$update_head_ok,$orig_head," in
 	fi
 	;;
 esac
+
+if test $(git rev-list --unpacked --all | wc -l) -gt 1000
+then
+	echo "Repacking in the background"
+	nice git repack -a -d -q &
+fi
-- 
1.3.2.g82000

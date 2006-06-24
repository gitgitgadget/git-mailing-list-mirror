From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [RFC] git-fetch - repack in the background after fetching
Date: Sat, 24 Jun 2006 23:30:00 +1200
Message-ID: <11511486003924-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 13:30:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu6Kv-0003KK-Bo
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWFXL35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbWFXL35
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:29:57 -0400
Received: from bm-3a.paradise.net.nz ([203.96.152.182]:10990 "EHLO
	linda-3.paradise.net.nz") by vger.kernel.org with ESMTP
	id S1752217AbWFXL35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:29:57 -0400
Received: from smtp-3.paradise.net.nz
 (tclsnelb1-src-1.paradise.net.nz [203.96.152.172]) by linda-3.paradise.net.nz
 (Paradise.net.nz) with ESMTP id <0J1D001TX3XVAA@linda-3.paradise.net.nz> for
 git@vger.kernel.org; Sat, 24 Jun 2006 23:29:56 +1200 (NZST)
Received: from localhost.localdomain
 (203-79-116-174.cable.paradise.net.nz [203.79.116.174])
	by smtp-3.paradise.net.nz (Postfix) with ESMTP id A44EF2CEA62; Sat,
 24 Jun 2006 23:29:55 +1200 (NZST)
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.4.1.rc1.g59c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22507>

Check whether we have a large set of unpacked objects and repack
after the fetch, but don't for the user to wait for us. Conditional
on core.autorepack =! no.

Having ' handle concurrent pruning of packed objects'
(637cdd9d1d997fca34a1fc668fed1311e30fe95f) from Jeff King it should
be safe to repack and prune in the background.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

This is a follow up to a similar patch earlier
http://www.gelato.unsw.edu.au/archives/git/0605/21401.html -- is there 
interest in making GIT more friendly to users who don't know or care
about packing and repacking their repos?

I loathe to do this conditionally only on the count of unpacked
objects. If there's a quick'n'dirty way of asking portably whether
the machine is busy or otherwise resource-constrained (ie: on battery)
it should use it to avoid running repack at inconvenient times.

---
 git-fetch.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 48818f8..7211318 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -427,3 +427,12 @@ case ",$update_head_ok,$orig_head," in
 	fi
 	;;
 esac
+
+if test "$(git-repo-config --get core.autorepack)" != 'no'
+then
+	if test $(git rev-list --unpacked --all | wc -l) -gt 1000
+	then
+		echo "Repacking in the background"
+		nice git repack -a -d -q &
+	fi
+fi
-- 
1.4.1.rc1.g59c8

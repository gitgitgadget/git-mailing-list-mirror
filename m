From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Thu, 12 Apr 2012 20:48:15 -0400
Message-ID: <1334278095-20212-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <1334274951-sup-6013@pinkfloyd.chass.utoronto.ca>
Cc: schwab@linux-m68k.org, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: gister@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 13 02:48:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIUgb-0000tv-0P
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 02:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934988Ab2DMAsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 20:48:19 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:36282 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab2DMAsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 20:48:19 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:60038 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SIUgT-0001DX-LB; Thu, 12 Apr 2012 20:48:17 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SIUgT-0005GW-K8; Thu, 12 Apr 2012 20:48:17 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1334274951-sup-6013@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195396>

The sed provided by Solaris in /usr/xpg4/bin has a bug whereby an
unanchored regex using * for zero or more repetitions sees two
separate matches fed to the substitution engine in some cases.

This is evidenced by:

$ for sed in /usr/xpg4/bin/sed /usr/bin/sed /opt/csw/gnu/sed; do \
echo 'ab' | $sed -e 's|[a]*|X|g'; \
done
XXbX
XbX
XbX

This bug was triggered during a git submodule clone operation as
exercised in the setup stage of t5526-fetch-submodules when using the
default SANE_TOOL_PATH for Solaris.  It led to paths such as
..../.. being used in the submodule .git gitdir reference.

As we do not need to handle fully qualfied paths we can make the regex
match 1 or more instead of 0 or more non-/ characters so use
's|[^/][^/]*|..|g' instead, which is correctly handled by all tested
sed implementations.  This expression is semantically different than
the original one.  It will not place leading '..' on a fully qualified
path as the original expression did.  None of the paths passed to the
regex relied on this behaviour so changing it shouldn't have negative
impact.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index efc86ad..7aa9e95 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,10 +167,10 @@ module_clone()
 	a=${a%/}
 	b=${b%/}
 
-	rel=$(echo $b | sed -e 's|[^/]*|..|g')
+	rel=$(echo $b | sed -e 's|[^/][^/]*|..|g')
 	echo "gitdir: $rel/$a" >"$path/.git"
 
-	rel=$(echo $a | sed -e 's|[^/]*|..|g')
+	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
 	(clear_local_git_env; cd "$path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
 
-- 
1.7.9

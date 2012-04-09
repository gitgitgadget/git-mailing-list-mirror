From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon,  9 Apr 2012 16:08:02 -0400
Message-ID: <1334002082-5375-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <1333997276-sup-2760@pinkfloyd.chass.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: schwab@linux-m68k.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 09 22:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHKt2-0006Ym-7o
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 22:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab2DIUIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 16:08:17 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55893 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab2DIUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 16:08:14 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49190 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHKsk-0001jY-4A; Mon, 09 Apr 2012 16:08:10 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHKsk-0001PB-31; Mon, 09 Apr 2012 16:08:10 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1333997276-sup-2760@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195037>

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

Using the expression 's|\([^/]*\(/*\)\)|..\2|g' provides the desired
result with all three three tested sed implementations but is harder
to read.  As we do not need to handle fully qualified paths though,
the expression could actually be [^/]+ which isn't properly handled
either.  Instead, use [^/][^/]*, as suggested by Andreas Schwab, which
works on all three tested sed implementations.

The new expression is semantically different than the original one.
It will not place a leading '..' on a fully qualified path as the
original expression did.  All of the paths being passed through this
regex are relative and did not rely on this behaviour so it's a safe
change.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-submodule.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index efc86ad..de972e7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,10 +167,12 @@ module_clone()
 	a=${a%/}
 	b=${b%/}
 
-	rel=$(echo $b | sed -e 's|[^/]*|..|g')
+	# Note: The extra [^/] is to work around a bug in Solairs'
+	# xpg4/sed.
+	rel=$(echo $b | sed -e 's|[^/][^/]*|..|g')
 	echo "gitdir: $rel/$a" >"$path/.git"
 
-	rel=$(echo $a | sed -e 's|[^/]*|..|g')
+	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
 	(clear_local_git_env; cd "$path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
 }
 
-- 
1.7.4.1

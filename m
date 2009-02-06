From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] submodule: handle trailing slash, warn about
 non-submodules
Date: Fri, 6 Feb 2009 05:00:22 +0100 (CET)
Message-ID: <b14e34d2529721c24437ec9da3f8f15c916d4051.1233892769u.git.johannes.schindelin@gmx.de>
References: <cover.1233892769u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 06 05:01:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVHty-0004yI-VG
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 05:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZBFD7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 22:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbZBFD7s
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 22:59:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:46732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752650AbZBFD7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 22:59:47 -0500
Received: (qmail invoked by alias); 06 Feb 2009 03:59:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 06 Feb 2009 04:59:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oV4t/T90o9/40hev3SQyn4/I83uiskxgIzKWJk/
	GKOTHBcrSnyevJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233892769u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108649>

Earlier, when you called

	git submodule path/to/submodule/

(which happens easily if you are a heavy user of tab-completion), Git
would silently ignore the given path, as "git ls-files path/to/submodule/"
does not return anything due to the trailing slash.

Git would also silently ignore paths that do not point to submodules at
all, without warning the user about the likely mistake.

Now, "git submodule" strips trailing slashes, and it warns about parameters
that are no submodules.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-submodule.sh |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..b878909 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -59,7 +59,19 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --stage -- "$@" | grep '^160000 '
+	while test $# -gt 0
+	do
+		line=$(git ls-files --stage ${1%/} | grep '^160000 ')
+		case "$line" in
+		'')
+			echo "Warning: ignoring non-submodule '$1'" >&2
+			;;
+		*)
+			echo "$line"
+			;;
+		esac
+		shift
+	done
 }
 
 #
-- 
1.6.1.2.630.g01a7e

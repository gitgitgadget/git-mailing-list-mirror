From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 3/4] Add to stg-mdiff the ability to pass options to
	underlying diff opts.
Date: Tue, 24 Jul 2007 20:57:41 +0200
Message-ID: <20070724185740.17180.72586.stgit@gandelf.nowhere.earth>
References: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPal-0005vj-IC
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbXGXS6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbXGXS6d
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:58:33 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45258 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbXGXS6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:58:32 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8F9EA4E;
	Tue, 24 Jul 2007 20:58:31 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 763BC751D;
	Tue, 24 Jul 2007 20:58:31 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 11EB01F084;
	Tue, 24 Jul 2007 20:57:41 +0200 (CEST)
In-Reply-To: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53629>

From: Yann Dirson <yann.dirson@sagem.com>

So we now have -O, similar to the existing option in stg diff, to pass
flags to git-diff when computing the 2 diffs to compare (-M, -C and -w
come to mind as being potentially useful here), and -o can be used to
tune the invocation of diff on those 2 diffs.

Note that -o is only there temporarily, and will disappear when a more
sophisticated process than plain diff will be used.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-mdiff |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/contrib/stg-mdiff b/contrib/stg-mdiff
index 9bb324a..61cba9e 100755
--- a/contrib/stg-mdiff
+++ b/contrib/stg-mdiff
@@ -12,21 +12,38 @@ set -e
 
 usage()
 {
-    echo "Usage: $(basename $0) <from1>..[<to1>]|<patch1> <from2>..[<to2>]|<patch2>"
+    echo "Usage: [-o <diff-flags>] [-O <gitdiff-flags>] $(basename $0) <from1>..[<to1>]|<patch1> <from2>..[<to2>]|<patch2>"
     exit 1
 }
 
+diffopts=
+subdiffopts=
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+	-o) diffopts="$2"; shift ;;
+	-O) subdiffopts="-O $2"; shift ;;
+	-*) usage ;;
+	*) break ;;
+    esac
+    shift
+done
+
 if [ "$#" != 2 ]; then
     usage
 fi
 
+if [ -z "$diffopts" ]; then
+    diffopts="-u"
+fi
+
 case "$1" in
-*..*) cmd1="stg diff" ;;
-*)    cmd1="stg show" ;;
+*..*) cmd1="stg diff $subdiffopts -r" ;;
+*)    cmd1="stg show $subdiffopts" ;;
 esac
 case "$2" in
-*..*) cmd2="stg diff" ;;
-*)    cmd2="stg show" ;;
+*..*) cmd2="stg diff $subdiffopts -r" ;;
+*)    cmd2="stg show $subdiffopts" ;;
 esac
 
-colordiff -u <($cmd1 "$1") <($cmd2 "$2") | less -RFX
+colordiff $diffopts \
+    <($cmd1 "$1") <($cmd2 "$2") | less -RFX

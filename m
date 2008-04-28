From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 5/7] don't rely on zero-argument "git fetch" from within git pull
Date: Mon, 28 Apr 2008 11:32:16 -0400
Message-ID: <b5b9b866e5f942d024831d528ae599e3e6ce31da.1209391615.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 <65b938da49b447129297d4dbf20191be52d16670.1209391614.git.bonzini@gnu.org>
 <d941a7a16cb7d5529b22a47f1dc7b986ba66ee56.1209391615.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:35:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMi-0004Kp-58
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935673AbYD1Pcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934721AbYD1Pck
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:40 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60642 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935627AbYD1Pcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:35 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004fD-Q1; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <d941a7a16cb7d5529b22a47f1dc7b986ba66ee56.1209391615.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80547>

Since the series will change the meaning of zero-argument
"git fetch", it is necessary that git pull does not rely on it.
Instead, it resolves it using git-parse-remote, which will
return either branch.*.remote or "origin" (at the end of the
series, the latter will throw out a big deprecation warning).

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 git-pull.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index bf0c298..5dec4cf 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -106,10 +106,13 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
+. git-parse-remote
+if test $# = 0; then
+	set x $(get_default_remote); shift
+fi
+
+origin="$1"
 test true = "$rebase" && {
-	. git-parse-remote &&
-	origin="$1"
-	test -z "$origin" && origin=$(get_default_remote)
 	reflist="$(get_remote_refs_for_fetch "$@" 2>/dev/null |
 		sed "s|refs/heads/\(.*\):|\1|")" &&
 	oldremoteref="$(git rev-parse --verify \
-- 
1.5.5

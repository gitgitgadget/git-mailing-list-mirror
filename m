From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH 1/3] GIT-VERSION-GEN: make use of git describe --dirty
Date: Fri, 22 Oct 2010 13:24:12 +0200
Message-ID: <4CC1745C.70506@debugon.org>
References: <cover.1287746107.git.misfire@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 13:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Fjd-0003pR-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 13:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab0JVLYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 07:24:16 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:64903 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab0JVLYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 07:24:15 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MBWuQ-1PJfKd2A4M-00AxDi; Fri, 22 Oct 2010 13:24:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <cover.1287746107.git.misfire@debugon.org>
X-Provags-ID: V02:K0:hdbtwB+8WpsQDD9pOgNXUSTHr0UzoriYZvZw3lQ3vow
 XtgMo+OaGK4KAxAwUEYkfIpx2qf5upiuAgt2PJOIOoeZQViRqB
 orj8kWFeddF/e58A8nLUDrLVUQ2pd9gOQOu0XiKEGOznbAbfI+
 dCkiIV9Ulk6l6DMzKwawQN5QpduROM6XSxO9xho6VrI8km4eU9
 HCJIrqWA4LXtjtxN2stWGS6nVwAGoOQ/OPOo5RhnIk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159678>

Currently, GIT-VERSION-GEN invokes the plumbing commands "git update-index" and
"git diff-index" to determine if the working tree is dirty. It then appends
"-dirty" to the version string returned by "git describe".

However, as of Git v1.6.6, "git describe" can be told to do all that with the
"--dirty" option, saving us the plumbing.

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 GIT-VERSION-GEN |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index d441d88..73d5cf9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,13 +12,10 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=4 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v[0-9]*" --abbrev=4 --dirty 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
-	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
+	v[0-9]*) : ;;
 	esac
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
-- 
1.7.3.2

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] Multiple refs from the same remote in one git fetch
Date: Tue, 8 Aug 2006 01:19:14 +0300
Message-ID: <20060807221914.GA24393@mellanox.co.il>
References: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 00:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GADPh-0005q5-CZ
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWHGWR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWHGWR2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:17:28 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:37329 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932227AbWHGWR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 18:17:27 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 7fbb7d44.2315770800.63159.00-024.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 16:17:27 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 8 Aug 2006 01:23:21 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue,  8 Aug 2006 01:19:14 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 22:23:21.0109 (UTC) FILETIME=[16F7F450:01C6BA70]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25047>

Quoting r. Junio C Hamano <junkio@cox.net>:
> > At least, fix the error message?
> 
> That would touch the same vicinity of code so if I were to do
> that myself I would rather see if the restriction can be
> loosened properly first.

The following seems to fix this issue: simply scan the full
refspec list for each remote instead of breaking on the first match.
I had to touch the git-fetch.sh script as well as it is scanning
the remote list, too. Works for me.

---

Fix git fetch for when multiple refspecs reference the same remote head.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/Makefile b/Makefile
diff --git a/connect.c b/connect.c
index 4422a0d..3880191 100644
--- a/connect.c
+++ b/connect.c
@@ -115,6 +115,7 @@ int get_ack(int fd, unsigned char *resul
 int path_match(const char *path, int nr, char **match)
 {
 	int i;
+	int found = 0;
 	int pathlen = strlen(path);
 
 	for (i = 0; i < nr; i++) {
@@ -128,9 +129,9 @@ int path_match(const char *path, int nr,
 		if (pathlen > len && path[pathlen - len - 1] != '/')
 			continue;
 		*s = 0;
-		return (i + 1);
+		found = i + 1;
 	}
-	return 0;
+	return found;
 }
 
 struct refspec {
diff --git a/fetch-pack.c b/fetch-pack.c
diff --git a/git-fetch.sh b/git-fetch.sh
index c2eebee..c35bae6 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -373,26 +373,22 @@ fetch_main () {
 	      +$remote_name:*)
 		  single_force=t
 		  not_for_merge=
-		  found="$ref"
-		  break ;;
+		  found="$ref";;
 	      .+$remote_name:*)
 		  single_force=t
 		  not_for_merge=t
-		  found="$ref"
-		  break ;;
+		  found="$ref";;
 	      .$remote_name:*)
 		  not_for_merge=t
-		  found="$ref"
-		  break ;;
+		  found="$ref";;
 	      $remote_name:*)
 		  not_for_merge=
-		  found="$ref"
-		  break ;;
+		  found="$ref";;
 	      esac
-	  done
-	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
-	  append_fetch_head "$sha1" "$remote" \
+	      local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
+	      append_fetch_head "$sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+	  done
       done
     ) || exit ;;
   esac

-- 
MST

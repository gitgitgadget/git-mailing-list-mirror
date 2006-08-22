From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH repost] Multiple refs from the same remote in one git fetch
Date: Tue, 22 Aug 2006 18:10:29 +0300
Message-ID: <20060822151029.GA19247@mellanox.co.il>
References: <20060814051302.GB21963@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 17:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFXv9-0000t3-Q1
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 17:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHVPKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWHVPKw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 11:10:52 -0400
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:21690 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S932309AbWHVPKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 11:10:51 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id a7e1be44.2646895536.54996.00-001.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 22 Aug 2006 09:10:50 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Aug 2006 18:16:55 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue, 22 Aug 2006 18:10:29 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060814051302.GB21963@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 22 Aug 2006 15:16:55.0593 (UTC) FILETIME=[01024990:01C6C5FE]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25860>

Hi, Junio!
Is the following likely to get merged eventually?
It was pointed out that I can work-around the limitation
by using softlinks, so it's not a show-stopper for me.

---

Fix git fetch for when multiple refspecs reference the same remote head.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

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
diff --git a/git-fetch.sh b/git-fetch.sh
index c2eebee..328168b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -366,33 +366,44 @@ fetch_main () {
 		  exit 1 ;;
 	  esac
 	  found=
-	  single_force=
+	  found_any=
 	  for ref in $refs
 	  do
 	      case "$ref" in
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
+		  single_force=
 		  not_for_merge=t
-		  found="$ref"
-		  break ;;
+		  found="$ref";;
 	      $remote_name:*)
+		  single_force=
+		  not_for_merge=
+		  found="$ref";;
+	      *)
+		  single_force=
 		  not_for_merge=
-		  found="$ref"
-		  break ;;
+		  found=;;
 	      esac
+	      if test "$found" != ""
+	      then
+		  found_any=1
+		  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
+		  append_fetch_head "$sha1" "$remote" "$remote_name" \
+		      "$remote_nick" "$local_name" "$not_for_merge"
+	      fi
 	  done
-	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
-	  append_fetch_head "$sha1" "$remote" \
-		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+	  if test "$found_any" == ""
+	  then
+	      append_fetch_head "$sha1" "$remote" "$remote_name" \
+	          "$remote_nick" "" ""
+	  fi
       done
     ) || exit ;;
   esac

-- 
MST

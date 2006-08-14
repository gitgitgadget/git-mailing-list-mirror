From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 03:13:29 +0300
Message-ID: <20060814001329.GA24694@mellanox.co.il>
References: <7vveoxo8ni.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 02:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCQ3H-0004Ip-5F
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 02:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWHNAL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 20:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWHNAL1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 20:11:27 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:6278 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751750AbWHNAL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 20:11:27 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id eafbfd44.2545642416.181408.00-002.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 13 Aug 2006 18:11:26 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 03:17:28 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 03:13:29 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vveoxo8ni.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 00:17:28.0203 (UTC) FILETIME=[06A215B0:01C6BF37]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25300>

Quoting r. Junio C Hamano <junkio@cox.net>:
> >> Looks Ok, although I have to admit I just gave a cursory look.
> >> Thanks.
> >> 
> >
> > Could this go into next then? 
> 
> No.  Spoke too fast.  Breaks t6200 test because it reports the
> refs fetched in duplicates.
> 
> 

Right, The problem was with the way I coded the loop in git-fetch.sh.
Here's the fixed versin - seems to pass make test fine.

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
index c2eebee..80a7a5d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -366,6 +366,7 @@ fetch_main () {
 		  exit 1 ;;
 	  esac
 	  found=
+	  found_any=
 	  single_force=
 	  for ref in $refs
 	  do
@@ -373,26 +374,34 @@ fetch_main () {
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
+	      *)
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
+	      local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
+	      append_fetch_head "$sha1" "$remote" "$remote_name" \
+	          "$remote_nick" "$local_name" "$not_for_merge"
+	  fi
       done
     ) || exit ;;
   esac
diff --git a/t/Makefile b/t/Makefile

-- 
MST

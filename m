From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 08:13:02 +0300
Message-ID: <20060814051302.GB21963@mellanox.co.il>
References: <7vac68i2wv.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 07:11:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCUjA-0001pb-3x
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 07:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWHNFLA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 01:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWHNFLA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 01:11:00 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:30619 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751853AbWHNFK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 01:10:59 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 3e500e44.2372877232.235939.00-001.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 13 Aug 2006 23:10:59 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 08:17:00 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 08:13:02 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac68i2wv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 05:17:00.0890 (UTC) FILETIME=[DF307BA0:01C6BF60]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25317>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> >> > Could this go into next then? 
> >> 
> >> No.  Spoke too fast.  Breaks t6200 test because it reports the
> >> refs fetched in duplicates.
> >
> > Right, The problem was with the way I coded the loop in git-fetch.sh.
> > Here's the fixed versin - seems to pass make test fine.
> 
> But what are you doing for single_force and not_for_merge when
> there are more than one matches in the patch?  They seem to get
> set to a random value depending on whatever happens to match
> last, which does not feel quite right.
> 

I think it was only true for single_force - but here's a patch to fix it and
also make this explicit.

BTW, does it still look like it's worth it the effort to lift the restriction,
or does fixing the error message to something like
"no such remote or duplicate ref %s"
make more sense to you?

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
diff --git a/t/Makefile b/t/Makefile

-- 
MST

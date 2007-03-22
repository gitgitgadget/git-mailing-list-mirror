From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] Put FETCH_HEAD data in merge commit message
Date: Thu, 22 Mar 2007 11:07:30 +0200
Message-ID: <20070322090730.GF29341@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
	<20070322074051.GA29341@mellanox.co.il>
	<7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUJG1-0001HB-5B
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 10:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbXCVJGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 05:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbXCVJGs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 05:06:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:6206 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030266AbXCVJGr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 05:06:47 -0400
Received: by ug-out-1314.google.com with SMTP id 44so626231uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 02:06:46 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr4600357ugh.1174554405958;
        Thu, 22 Mar 2007 02:06:45 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id e33sm2936501ugd.2007.03.22.02.06.44;
        Thu, 22 Mar 2007 02:06:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42850>

This makes git-fetch <URL> && git-merge FETCH_HEAD produce same merge
message as git-pull <URL>

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> To reiterate the more important points (this is also for my own
> purpose because I do not want the patch lost in this noise we
> are making):
> 
>  - Checking readability of $GIT_DIR/$remote itself is too loose;
>    the name FETCH_HEAD should explicitly be checked, as that is
>    the file that has the specific format that is understood by
>    fmt-merge-msg.
> 
>  - "echo -n" is to be avoided for portability.
> 
>  - "git fetch $URL foo bar" would leave two lines in FETCH_HEAD;
>    subsequent "git merge FETCH_HEAD" would merge only foo.  Pick
>    the first line, stripping out not-for-merge marker and let it
>    processed by fmt-merge-msg.

Is this OK?

diff --git a/git-merge.sh b/git-merge.sh
index 8759c5a..417bf33 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -108,6 +108,10 @@ merge_name () {
 		git-show-ref -q --verify "refs/heads/$truname" 2>/dev/null
 	then
 		echo "$rh		branch '$truname' (early part) of ."
+	elif test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
+	then
+		sed -e 's/	not-for-merge	/		/' -e 1q\
+	       		"$GIT_DIR/FETCH_HEAD"
 	else
 		echo "$rh		commit '$remote'"
 	fi

-- 
MST

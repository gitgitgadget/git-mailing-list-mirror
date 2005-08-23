From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Improve can_hardlink diagnostics, remove suggest_hardlink
Date: Tue, 23 Aug 2005 12:23:58 -0400
Message-ID: <1124814238.11038.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 23 18:28:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7bak-00058M-Tv
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 18:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVHWQY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 12:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVHWQY5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 12:24:57 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62856 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932210AbVHWQY4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 12:24:56 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E7bYr-00065J-7K
	for git@vger.kernel.org; Tue, 23 Aug 2005 12:24:28 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E7bZ9-0002tc-KJ; Tue, 23 Aug 2005 12:23:59 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7NGNwBa011131;
	Tue, 23 Aug 2005 12:23:58 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

suggest_hardlink is write-only in cg-pull - remove it.  can_hardlink
should not be shown to the user as is (it's either "l" or empty) - we
should output something meaningful instead.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -207,7 +207,6 @@ fetch_local()
 	cp_flags_l="-vdpR"
 	if [ "$1" = "-u" ]; then
 		cp_flags_l="$cp_flags_l -fu$can_hardlink"
-		suggest_hardlink=
 		shift
 	fi
 
@@ -293,12 +292,16 @@ else
 	symlinked=
 	is_same_repo "$_git_objects" "$uri/objects" && symlinked=1
 
-	# See if we can hardlink and drop "l" if not.
+	# See if we can hardlink and add "-l" to cp flags.
 	can_hardlink=
 	sample_file=$(find $uri -type f -print | head -n 1)
 	rm -f $_git/.,,lntest
-	ln "$sample_file" "$_git/.,,lntest" 2>/dev/null && can_hardlink=l
-	echo $can_hardlink
+	if cp -fl "$sample_file" "$_git/.,,lntest" 2>/dev/null; then
+		can_hardlink=l
+		echo "Using hard links"
+	else
+		echo "Hard links don't work - using copy"
+	fi
 	rm -f $_git/.,,lntest
 fi
 


-- 
Regards,
Pavel Roskin

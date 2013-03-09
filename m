From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 03/19] Use .gittrees config file like a .gitmodules when pull
 or push
Date: Sat, 9 Mar 2013 19:21:31 +0000
Message-ID: <CALeLG_mY2BPpPjbGJ=3BKkeu3V7cngEmvhDOJ2UWDeO25E+aLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	James Roper <jroper@vz.net>, mhart <michael@adslot.com>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>,
	Paul Cartwright <paul.cartwright@ziilabs.com>,
	Peter Jaros <pjaros@pivotallabs.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPLD-000693-6w
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab3CITVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:21:33 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:32797 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:21:32 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so3271569oag.21
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=UkH0RlDjvHilP8+PL5arpFd8BPyT1kQquZdecH5i6Kw=;
        b=HTc87m7TQ/wcmO3st78Y825uxlYra1PRyIwM/3LfXR/7r64D0iTl2S693eXXrKKHFL
         K5RDnwCTLRen/eglKZ7dRTOdm6JMJGf2Qo66A2D1XdS9b3DFsLqlzNAzikM05RFYjbqQ
         oMtfxv9H5xMq0RXk7QMp90tNk0SoDMlR2BT6MW6D53glUQPPCM0STb1v9eJSHFJmaRh/
         LR4TJfh+e2X1NgISzxaIQpGYzlo4WphcgrAsClMD8tdT1VErN44nbIWLq0U8zrf2uW2w
         p6+SwYgKiQRyfWQ8JmtAfXEeWnps3TrsXnAuqymvnT4aZrKoltPCMcpGmVsAynWNvw1d
         2jrA==
X-Received: by 10.182.3.196 with SMTP id e4mr5144166obe.36.1362856891865; Sat,
 09 Mar 2013 11:21:31 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:21:31 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQk4WcjLhwP9tlczxSx0iNYH1UeSAWUuew4GJ6nmd6ulkmPQQlu8569MGaeavgT2OvyHjO38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217740>

>From 92787322c6e0e8c9166f02f98a71b6e0af9dc405 Mon Sep 17 00:00:00 2001
From: bibendi <bibendi@bk.ru>
Date: Fri, 20 May 2011 00:15:53 +0600
Subject: [PATCH 03/19] Use .gittrees config file like a .gitmodules when pull
 or push

---
 contrib/subtree/git-subtree.sh | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index caf4988..cb9e288 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -593,7 +593,8 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		say -n "$revcount/$revmax ($createcount)
+"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
@@ -700,21 +701,31 @@ cmd_merge()

 cmd_pull()
 {
-	ensure_clean
-	git fetch "$@" || exit $?
-	revs=FETCH_HEAD
-	set -- $revs
-	cmd_merge "$@"
+    if [ $# -ne 1 ]; then
+	    die "You must provide <branch>"
+	fi
+	if [ -e "$dir" ]; then
+	    ensure_clean
+	    repository=$(git config -f .gittrees subtree.$prefix.url)
+	    refspec=$1
+	    git fetch $repository $refspec || exit $?
+	    echo "git fetch using: " $repository $refspec
+	    revs=FETCH_HEAD
+	    set -- $revs
+	    cmd_merge "$@"
+	else
+	    die "'$dir' must already exist. Try 'git subtree add'."
+	fi
 }

 cmd_push()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <refspec>"
+	if [ $# -ne 1 ]; then
+	    die "You must provide <branch>"
 	fi
 	if [ -e "$dir" ]; then
-	    repository=$1
-	    refspec=$2
+	    repository=$(git config -f .gittrees subtree.$prefix.url)
+	    refspec=$1
 	    echo "git push using: " $repository $refspec
 	    git push $repository $(git subtree split
--prefix=$prefix):refs/heads/$refspec
 	else
-- 
1.8.2.rc1


-- 
Paul [W] Campbell

From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] git-tag-script tag message commandline option
Date: Wed, 10 Aug 2005 11:06:29 -0700
Message-ID: <20050810180629.GG8041@shell0.pdx.osdl.net>
References: <20050809000442.GD8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 20:07:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2uyL-00086k-H9
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 20:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbVHJSGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 14:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbVHJSGe
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 14:06:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965262AbVHJSGd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 14:06:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7AI6TjA016260
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Aug 2005 11:06:29 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7AI6TYC002398;
	Wed, 10 Aug 2005 11:06:29 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j7AI6TUE002397;
	Wed, 10 Aug 2005 11:06:29 -0700
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050809000442.GD8041@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[resend more clearly identified as patch]

Apparently I was under a rock sleeping when git-tag-script changed to no
longer take input from stdin.  So my script which did:

TAG=$(echo "$TAG_MSG" | git-tag-script $RELEASE)
echo $TAG > .git/refs/tags/$RELEASE

Is broken in two ways.  First it's no longer building an annotated tag,
second it creaets a zero length file .git/refs/tags/$RELEASE.  Second
issue is trivial to fix in my script. First one needs some change in the
tag script.  Below is a simple patch for a stab at fixing.  Thoughts?


thanks,
-chris
--


Allow users to create a tag message by passing message on command line
instead of requiring an $EDITOR session.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -4,13 +4,14 @@
 . git-sh-setup-script || die "Not a git archive"
 
 usage () {
-    echo >&2 "Usage: git-tag-script [-a | -s] [-f] tagname"
+    echo >&2 "Usage: git-tag-script [-a | -s] [-f] [-m "tag message"] tagname"
     exit 1
 }
 
 annotate=
 signed=
 force=
+message=
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
@@ -24,6 +25,11 @@ do
     -f)
 	force=1
 	;;
+    -m)
+    	annotate=1
+	shift
+	message="$1"
+	;;
     -*)
         usage
 	;;
@@ -48,10 +54,14 @@ tagger=$(git-var GIT_COMMITTER_IDENT) ||
 trap 'rm -f .tmp-tag* .tagmsg .editmsg' 0
 
 if [ "$annotate" ]; then
-    ( echo "#"
-      echo "# Write a tag message"
-      echo "#" ) > .editmsg
-    ${VISUAL:-${EDITOR:-vi}} .editmsg || exit
+    if [ -z "$message" ]; then
+        ( echo "#"
+          echo "# Write a tag message"
+          echo "#" ) > .editmsg
+        ${VISUAL:-${EDITOR:-vi}} .editmsg || exit
+    else
+        echo "$message" > .editmsg
+    fi
 
     grep -v '^#' < .editmsg | git-stripspace > .tagmsg
 

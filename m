From: Tom Prince <tom.prince@ualberta.net>
Subject: [PATCH] Fix handling of not_for_merge '.' flag in refspec.
Date: Thu, 29 Sep 2005 17:53:09 -0600
Message-ID: <11280379894186-git-send-email-tom.prince@ualberta.net>
Reply-To: Tom Prince <tom.prince@ualberta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Fri Sep 30 01:54:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL8DG-0000bG-HH
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 01:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVI2XxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 19:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVI2XxP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 19:53:15 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20325 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932378AbVI2XxO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 19:53:14 -0400
Received: from pd5mr2so.prod.shaw.ca
 (pd5mr2so-qfe3.prod.shaw.ca [10.0.141.233]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0INL00HTXROJN870@l-daemon> for git@vger.kernel.org; Thu,
 29 Sep 2005 17:53:07 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd5mr2so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0INL004IGROJXH10@pd5mr2so.prod.shaw.ca> for
 git@vger.kernel.org; Thu, 29 Sep 2005 17:53:07 -0600 (MDT)
Received: from socrates (S0106000fea73ae52.ed.shawcable.net [68.148.44.80])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0INL00346ROIMF@l-daemon> for git@vger.kernel.org; Thu,
 29 Sep 2005 17:53:07 -0600 (MDT)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with SMTP id j8TNr9Ap007837; Thu, 29 Sep 2005 17:53:09 -0600
In-reply-to: 
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9528>

canon_refs_list_for_fetch did not know about '.', so it mangled any
reference with it. Further, it added '.' to any refspec on the command
line other than the first.

Signed-off-by: Tom Prince <tom.prince@ualberta.net>


---

 Documentation/pull-fetch-param.txt |    5 +++--
 git-parse-remote.sh                |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

446dda983492e3c07dc73b271cb9208a4359a734
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -49,7 +49,7 @@
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
-	'+?<src>:<dst>'; that is, an optional plus '+', followed
+	'.?+?<src>:<dst>'; that is, an optional plus '+', followed
 	by the source ref, followed by a colon ':', followed by
 	the destination ref.
 
@@ -68,7 +68,8 @@
 	ref that matches it is fast forwarded using <src>.
 	Again, if the optional plus '+' is used, the local ref
 	is updated even if it does not result in a fast forward
-	update.
+	update. If the optional dot '.' is used, the remote ref
+	is fetched, but not used for merging.
 
 	Some short-cut notations are also supported.
 
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -72,8 +72,15 @@ canon_refs_list_for_fetch () {
 	dot_prefix=
 	for ref
 	do
+		not_for_merge=
 		force=
 		case "$ref" in
+		.*)
+			ref=$(expr "$ref" : '\.\(.*\)')
+			not_for_merge=.
+			;;
+		esac
+		case "$ref" in
 		+*)
 			ref=$(expr "$ref" : '\+\(.*\)')
 			force=+
@@ -94,7 +101,12 @@ canon_refs_list_for_fetch () {
 		heads/* | tags/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
-		echo "${dot_prefix}${force}${remote}:${local}"
+		case "$octopus$not_for_merge" in
+		'')	
+			not_for_merge=$dot_prefix
+			;;
+		esac
+		echo "${not_for_merge}${force}${remote}:${local}"
 		dot_prefix=.
 	done
 }
@@ -114,6 +126,7 @@ get_remote_default_refs_for_fetch () {
 		# This prefixes the second and later default refspecs
 		# with a '.', to signal git-fetch to mark them
 		# not-for-merge.
+		octopus=
 		canon_refs_list_for_fetch $(sed -ne '/^Pull: */{
 						s///p
 					}' "$GIT_DIR/remotes/$1")
@@ -155,6 +168,7 @@ get_remote_refs_for_fetch () {
 			;;
 		    esac
 		fi
+		octopus=t
 		canon_refs_list_for_fetch "$ref"
 	    done
 	    ;;

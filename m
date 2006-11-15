X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: git tag: don't complain of empty messages
Date: Wed, 15 Nov 2006 16:34:25 +0100
Message-ID: <ejfc1t$6am$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090907000002080200010106"
NNTP-Posting-Date: Wed, 15 Nov 2006 15:35:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 72
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31446>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkMn8-0000Yn-8k for gcvg-git@gmane.org; Wed, 15 Nov
 2006 16:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030589AbWKOPen (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 10:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWKOPen
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 10:34:43 -0500
Received: from main.gmane.org ([80.91.229.2]:40920 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030589AbWKOPem (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 10:34:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkMmT-0000Pr-Ly for git@vger.kernel.org; Wed, 15 Nov 2006 16:34:29 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 15 Nov 2006 16:34:29 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006 16:34:29
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------090907000002080200010106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

GIT refuses to set annotated tags without a comment. I think this is a 
silly restriction when the message is explicitly set to the empty string.

The attached patch should fix this;  Unfortunately, I've been unable to 
test it. Running the script with sh -x stops at

++exec /home/hanwen/usr/pkg/git/bin/git-sh-setup

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

--------------090907000002080200010106
Content-Type: text/plain;
 name="tagpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tagpatch"

commit 446cfbd9edcfaf5fe76f597823e0e3314d091489
Author: Han-Wen Nienhuys <hanwen@lilypond.org>
Date:   Wed Nov 15 16:27:27 2006 +0100

    always set tag if -m is given, even if empty

diff --git a/git-tag.sh b/git-tag.sh
index ac269e3..f2533a3 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -5,6 +5,7 @@ USAGE='-l [<pattern>] | [-a | -s | -u <k
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
+message_given=
 annotate=
 signed=
 force=
@@ -37,6 +38,7 @@ do
     	annotate=1
 	shift
 	message="$1"
+	message_given=1
 	;;
     -u)
 	annotate=1
@@ -83,7 +85,7 @@ tagger=$(git-var GIT_COMMITTER_IDENT) ||
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 
 if [ "$annotate" ]; then
-    if [ -z "$message" ]; then
+    if [ -z "$message_given" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
@@ -95,7 +97,7 @@ if [ "$annotate" ]; then
     grep -v '^#' <"$GIT_DIR"/TAG_EDITMSG |
     git-stripspace >"$GIT_DIR"/TAG_FINALMSG
 
-    [ -s "$GIT_DIR"/TAG_FINALMSG ] || {
+    [ -s "$GIT_DIR"/TAG_FINALMSG -o -n "$message_given" ] || {
 	echo >&2 "No tag message?"
 	exit 1
     }

--------------090907000002080200010106--

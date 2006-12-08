X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/5] rerere: avoid misrecording on a skipped or aborted rebase/am
Date: Fri,  8 Dec 2006 02:49:26 -0800
Message-ID: <11655749724034-git-send-email-normalperson@yhbt.net>
References: <20061205092126.GE27236@soma>
NNTP-Posting-Date: Fri, 8 Dec 2006 10:49:42 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061205092126.GE27236@soma>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33681>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdIP-00039f-02 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425351AbWLHKtf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425349AbWLHKte
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:49:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47162 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425343AbWLHKtd
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:49:33 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 434B82DC089; Fri,  8 Dec 2006 02:49:32 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:49:32 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Data in rr-cache isn't valid after a patch application is
skipped or and aborted, so our next commit could be misrecorded
as a resolution of that skipped/failed commit, which is wrong.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-am.sh       |    4 ++++
 git-rebase.sh   |    8 ++++++++
 git-rerere.perl |   12 ++++++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index afe322b..28ccae3 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -246,6 +246,10 @@ last=`cat "$dotest/last"`
 this=`cat "$dotest/next"`
 if test "$skip" = t
 then
+	if test -d "$GIT_DIR/rr-cache"
+	then
+		git-rerere clear
+	fi
 	this=`expr "$this" + 1`
 	resume=
 fi
diff --git a/git-rebase.sh b/git-rebase.sh
index 25530df..2b4f347 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -139,6 +139,10 @@ do
 	--skip)
 		if test -d "$dotest"
 		then
+			if test -d "$GIT_DIR/rr-cache"
+			then
+				git-rerere clear
+			fi
 			prev_head="`cat $dotest/prev_head`"
 			end="`cat $dotest/end`"
 			msgnum="`cat $dotest/msgnum`"
@@ -157,6 +161,10 @@ do
 		exit
 		;;
 	--abort)
+		if test -d "$GIT_DIR/rr-cache"
+		then
+			git-rerere clear
+		fi
 		if test -d "$dotest"
 		then
 			rm -r "$dotest"
diff --git a/git-rerere.perl b/git-rerere.perl
index d3664ff..dd86577 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -172,6 +172,18 @@ sub merge {
 -d "$rr_dir" || exit(0);
 
 read_rr();
+
+if (@ARGV && $ARGV[0] eq 'clear') {
+	for my $path (keys %merge_rr) {
+		my $name = $merge_rr{$path};
+		if (-d "$rr_dir/$name") {
+			rmtree(["$rr_dir/$name"]);
+		}
+	}
+	unlink $merge_rr;
+	exit 0;
+}
+
 my %conflict = map { $_ => 1 } find_conflict();
 
 # MERGE_RR records paths with conflicts immediately after merge
-- 
1.4.4.2.g860f4

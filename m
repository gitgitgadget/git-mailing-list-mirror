X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/5] status: show files that would have resolutions recorded by rerere
Date: Fri,  8 Dec 2006 02:49:27 -0800
Message-ID: <11655749732181-git-send-email-normalperson@yhbt.net>
References: <20061205092126.GE27236@soma>
NNTP-Posting-Date: Fri, 8 Dec 2006 10:49:54 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061205092126.GE27236@soma>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33683>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdId-0003Cg-I2 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425343AbWLHKtj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425350AbWLHKtj
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:49:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47164 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425343AbWLHKte
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:49:34 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 750F32DC034; Fri,  8 Dec 2006 02:49:33 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:49:33 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-commit.sh   |   17 ++++++++++++++++-
 git-rerere.perl |   18 ++++++++++++------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..9f6d1ef 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -48,7 +48,22 @@ run_status () {
 		GIT_INDEX_FILE="$NEXT_INDEX"
 		export GIT_INDEX_FILE
 	fi
-
+	if test -d "$GIT_DIR/rr-cache"
+	then
+	    rr_shown=
+	    git-rerere status | while read line; do
+		if [ -z "$rr_shown" ]; then
+		    echo '#'
+		    echo '# Resolutions to be recorded for files:'
+		    echo '#   (git-rerere will automatically record' \
+			 'conflict resolutions'
+		    echo '#    when these files are committed)'
+		    echo '#'
+		    rr_shown=1
+		fi
+		echo  "#	$line"
+	    done
+	fi
 	case "$status_only" in
 	t) color= ;;
 	*) color=--nocolor ;;
diff --git a/git-rerere.perl b/git-rerere.perl
index dd86577..b78194a 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -173,14 +173,20 @@ sub merge {
 
 read_rr();
 
-if (@ARGV && $ARGV[0] eq 'clear') {
-	for my $path (keys %merge_rr) {
-		my $name = $merge_rr{$path};
-		if (-d "$rr_dir/$name") {
-			rmtree(["$rr_dir/$name"]);
+if (my $arg = shift @ARGV) {
+	if ($arg eq 'clear') {
+		for my $path (keys %merge_rr) {
+			my $name = $merge_rr{$path};
+			if (-d "$rr_dir/$name") {
+				rmtree(["$rr_dir/$name"]);
+			}
+		}
+		unlink $merge_rr;
+	} elsif ($arg eq 'status') {
+		for my $path (keys %merge_rr) {
+			print $path, "\n";
 		}
 	}
-	unlink $merge_rr;
 	exit 0;
 }
 
-- 
1.4.4.2.g860f4

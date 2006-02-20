From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Mon, 20 Feb 2006 14:05:51 -0800
Message-ID: <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 23:06:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBJAP-0006FJ-Qj
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 23:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWBTWFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWBTWFy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 17:05:54 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19446 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932664AbWBTWFx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 17:05:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220220303.ZSGQ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 17:03:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <20060220191011.GA18085@hand.yhbt.net> (Eric Wong's message of
	"Mon, 20 Feb 2006 11:10:12 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16502>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Eric, thanks for the hint.  I have this four-patch series.
   Could people with perl 5.6 please check them?

 git-fmt-merge-msg.perl |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

615782c9609bf23be55b403e994d88c1047be996
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index c34ddc5..a77e94e 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -28,11 +28,12 @@ sub andjoin {
 }
 
 sub repoconfig {
-	my $fh;
 	my $val;
 	eval {
-		open $fh, '-|', 'git-repo-config', '--get', 'merge.summary'
-		    or die "$!";
+		my $pid = open(my $fh, '-|');
+		if (!$pid) {
+			exec('git-repo-config', '--get', 'merge.summary');
+		}
 		($val) = <$fh>;
 		close $fh;
 	};
@@ -41,25 +42,32 @@ sub repoconfig {
 
 sub current_branch {
 	my $fh;
-	open $fh, '-|', 'git-symbolic-ref', 'HEAD' or die "$!";
+	my $pid = open($fh, '-|');
+	die "$!" unless defined $pid;
+	if (!$pid) {
+	    exec('git-symbolic-ref', 'HEAD') or die "$!";
+	}
 	my ($bra) = <$fh>;
 	chomp($bra);
+	close $fh or die "$!";
 	$bra =~ s|^refs/heads/||;
 	if ($bra ne 'master') {
 		$bra = " into $bra";
 	} else {
 		$bra = "";
 	}
-
 	return $bra;
 }
 
 sub shortlog {
 	my ($tip, $limit) = @_;
 	my ($fh, @result);
-	open $fh, '-|', ('git-log', "--max-count=$limit", '--topo-order',
-			 '--pretty=oneline', $tip, '^HEAD')
-	    or die "$!";
+	my $pid = open($fh, '-|');
+	die "$!" unless defined $pid;
+	if (!$pid) {
+	    exec('git-log', "--max-count=$limit", '--topo-order',
+		 '--pretty=oneline', $tip, '^HEAD') or die "$!";
+	}
 	while (<$fh>) {
 		s/^[0-9a-f]{40}\s+//;
 		push @result, $_;
-- 
1.2.2.g5be4ea

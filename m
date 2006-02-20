From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] cvsimport: avoid open "-|" list form for Perl 5.6
Date: Mon, 20 Feb 2006 14:19:15 -0800
Message-ID: <7v8xs5ad24.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBJNJ-0000ff-PW
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 23:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWBTWTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 17:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWBTWTS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 17:19:18 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:12000 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932626AbWBTWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 17:19:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220221921.HSXO25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 17:19:21 -0500
To: git@vger.kernel.org
In-Reply-To: <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 20 Feb 2006 14:05:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16506>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Fifth of the four patch series.  I cannot count ;-).

 git-cvsimport.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

eb815c1bb8a40ae18d80e99f8547137ea05318bf
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 24f9834..b46469a 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -846,8 +846,12 @@ while(<CVS>) {
 			print "Drop $fn\n" if $opt_v;
 		} else {
 			print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $opt_v;
-			open my $F, '-|', "git-hash-object -w $tmpname"
+			my $pid = open(my $F, '-|');
+			die $! unless defined $pid;
+			if (!$pid) {
+			    exec("git-hash-object", "-w", $tmpname)
 				or die "Cannot create object: $!\n";
+			}
 			my $sha = <$F>;
 			chomp $sha;
 			close $F;
-- 
1.2.2.g5be4ea

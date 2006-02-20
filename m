From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-email: avoid open "-|" list form for Perl 5.6
Date: Mon, 20 Feb 2006 14:12:19 -0800
Message-ID: <7vk6bpaddo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:13:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBJH7-0007iL-P1
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 23:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWBTWMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 17:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWBTWMb
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 17:12:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:26754 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932639AbWBTWMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 17:12:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220220946.BJLU17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 17:09:46 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16505>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-send-email.perl |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

044ece3bc8bde227babd2f710f8216f2cb631034
diff --git a/git-send-email.perl b/git-send-email.perl
index 13b85dd..b4f04f9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -59,24 +59,29 @@ my $rc = GetOptions("from=s" => \$from,
 
 # Now, let's fill any that aren't set in with defaults:
 
-open(GITVAR,"-|","git-var","-l")
-	or die "Failed to open pipe from git-var: $!";
-
-my ($author,$committer);
-while(<GITVAR>) {
-	chomp;
-	my ($var,$data) = split /=/,$_,2;
-	my @fields = split /\s+/, $data;
-
-	my $ident = join(" ", @fields[0...(@fields-3)]);
-
-	if ($var eq 'GIT_AUTHOR_IDENT') {
-		$author = $ident;
-	} elsif ($var eq 'GIT_COMMITTER_IDENT') {
-		$committer = $ident;
-	}
+sub gitvar {
+    my ($var) = @_;
+    my $fh;
+    my $pid = open($fh, '-|');
+    die "$!" unless defined $pid;
+    if (!$pid) {
+	exec('git-var', $var) or die "$!";
+    }
+    my ($val) = <$fh>;
+    close $fh or die "$!";
+    chomp($val);
+    return $val;
+}
+
+sub gitvar_ident {
+    my ($name) = @_;
+    my $val = gitvar($name);
+    my @field = split(/\s+/, $val);
+    return join(' ', @field[0...(@field-3)]);
 }
-close(GITVAR);
+
+$author = gitvar_ident('GIT_AUTHOR_IDENT');
+$committer = gitvar_ident('GIT_COMMITTER_IDENT');
 
 my $prompting = 0;
 if (!defined $from) {
-- 
1.2.2.g5be4ea

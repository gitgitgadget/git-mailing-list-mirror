From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: fix a copied-tree bug in an overzealous assertion
Date: Fri, 3 Mar 2006 13:35:48 -0800
Message-ID: <20060303213548.GA30403@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 03 22:36:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFHwx-0005G2-B1
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 22:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCCVg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 16:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWCCVg3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 16:36:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:25224 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751370AbWCCVg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 16:36:29 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BAFE32DC03A;
	Fri,  3 Mar 2006 13:36:26 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  3 Mar 2006 13:35:48 -0800
To: Junio C Hamano <junkio@cox.net>, git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17158>

I thought passing --stop-on-copy to svn would save us from all
the trouble svn-arch-mirror had with directory (project) copies.
I was wrong, there was one thing I overlooked.

If a tree was moved from /foo/trunk to /bar/foo/trunk with no
other changes in r10, but the last change was done in r5, the
Last Changed Rev (from svn info) in /bar/foo/trunk will still be
r5, even though the copy in the repository didn't exist until
r10.

Now, if we ever detect that the Last Changed Rev isn't what
we're expecting, we'll run svn diff and only croak if there are
differences between them.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

35f4b65079f730e7413b8b585e44526e489e8b1c
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 25d2935..c575883 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -337,10 +337,17 @@ sub assert_svn_wc_clean {
 	my ($svn_rev, $treeish) = @_;
 	croak "$svn_rev is not an integer!\n" unless ($svn_rev =~ /^\d+$/);
 	croak "$treeish is not a sha1!\n" unless ($treeish =~ /^$sha1$/o);
-	my $svn_info = svn_info('.');
-	if ($svn_rev != $svn_info->{'Last Changed Rev'}) {
-		croak "Expected r$svn_rev, got r",
-				$svn_info->{'Last Changed Rev'},"\n";
+	my $lcr = svn_info('.')->{'Last Changed Rev'};
+	if ($svn_rev != $lcr) {
+		print STDERR "Checking for copy-tree ... ";
+		# use
+		my @diff = grep(/^Index: /,(safe_qx(qw(svn diff),
+						"-r$lcr:$svn_rev")));
+		if (@diff) {
+			croak "Nope!  Expected r$svn_rev, got r$lcr\n";
+		} else {
+			print STDERR "OK!\n";
+		}
 	}
 	my @status = grep(!/^Performing status on external/,(`svn status`));
 	@status = grep(!/^\s*$/,@status);
-- 
1.2.4.g198d

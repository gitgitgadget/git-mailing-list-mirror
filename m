From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: ensure fetch always works chronologically.
Date: Thu, 16 Feb 2006 18:13:32 -0800
Message-ID: <20060217021332.GA11061@Muzzle>
References: <20060216073826.GA12055@hand.yhbt.net> <43F4A4B1.4010307@blairos.org> <20060216190426.GC12055@hand.yhbt.net> <43F4CF5E.1010700@blairos.org> <20060216194532.GA4446@Muzzle> <20060216194751.GB4446@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 17 03:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9v7r-0004RD-VC
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 03:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWBQCNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 21:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBQCNf
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 21:13:35 -0500
Received: from hand.yhbt.net ([66.150.188.102]:11162 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751114AbWBQCNe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 21:13:34 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by hand.yhbt.net (Postfix) with SMTP id AF3D82DC08D;
	Thu, 16 Feb 2006 18:13:32 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Thu, 16 Feb 2006 18:13:32 -0800
To: git list <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060216194751.GB4446@Muzzle>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16321>

We run svn log against a URL without a working copy for the first fetch,
so we end up a log that's sorted from highest to lowest.  That's bad, we
always want lowest to highest.  Just default to --revision 0:HEAD now if
-r isn't specified for the first fetch.

Also sort the revisions after we get them just in case somebody
accidentally reverses the argument to --revision for whatever reason.

Thanks again to Emmanuel Guerin for helping me find this.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

2ec4f205eaa3914a64205ea224292b9e27e06cdf
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index ddd9579..2caf057 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -168,14 +168,15 @@ sub fetch {
 	my (@parents) = @_;
 	$SVN_URL ||= file_to_s("$GIT_DIR/$GIT_SVN/info/url");
 	my @log_args = -d $SVN_WC ? ($SVN_WC) : ($SVN_URL);
-	if (-d $SVN_WC && !$_revision) {
-		$_revision = 'BASE:HEAD';
+	unless ($_revision) {
+		$_revision = -d $SVN_WC ? 'BASE:HEAD' : '0:HEAD';
 	}
-	push @log_args, "-r$_revision" if $_revision;
+	push @log_args, "-r$_revision";
 	push @log_args, '--stop-on-copy' unless $_no_stop_copy;
 
 	eval { require XML::Simple or croak $! };
 	my $svn_log = $@ ? svn_log_raw(@log_args) : svn_log_xml(@log_args);
+	@$svn_log = sort { $a->{revision} <=> $b->{revision} } @$svn_log;
 
 	my $base = shift @$svn_log or croak "No base revision!\n";
 	my $last_commit = undef;
-- 
1.2.0.gdee6

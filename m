From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: make --repack work consistently between fetch and multi-fetch
Date: Thu, 4 Jan 2007 18:09:56 -0800
Message-ID: <20070105020955.GA27984@localdomain>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104023350.GA1194@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 03:10:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2eWv-0000aK-Cu
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 03:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXAECJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 21:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbXAECJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 21:09:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60718 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbXAECJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 21:09:58 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A1B837DC099;
	Thu,  4 Jan 2007 18:09:56 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 04 Jan 2007 18:09:56 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070104023350.GA1194@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35969>

Since fetch reforks itself at most every 1000 revisions, we
need to update the counter in the parent process to have a
working count if we set our repack interval to be > ~1000
revisions.  multi-fetch has always done this correctly
because of an extra process; now fetch uses the extra process;
as well.

While we're at it, only compile the $sha1 regex that checks for
repacking once.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

I wrote:
> 	Just set the repack interval to something smaller than 1000;
> 	(--repack=100) if you experience timeouts.

Chris: you shouldn't get timeouts (at least not across HTTP(s)).
Also, don't worry about repack=100 either; there was a bug that
was triggered only in 'fetch' not 'multi-fetch' (you should use
'multi-fetch').  This patch fixes the 'fetch' bug.

 git-svn.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0fc386a..5377762 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -102,7 +102,7 @@ my %cmt_opts = ( 'edit|e' => \$_edit,
 );
 
 my %cmd = (
-	fetch => [ \&fetch, "Download new revisions from SVN",
+	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision, %fc_opts } ],
 	init => [ \&init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -293,6 +293,10 @@ sub init {
 	setup_git_svn();
 }
 
+sub cmd_fetch {
+	fetch_child_id($GIT_SVN, @_);
+}
+
 sub fetch {
 	check_upgrade_needed();
 	$SVN_URL ||= file_to_s("$GIT_SVN_DIR/info/url");
@@ -836,7 +840,6 @@ sub fetch_child_id {
 	my $ref = "$GIT_DIR/refs/remotes/$id";
 	defined(my $pid = open my $fh, '-|') or croak $!;
 	if (!$pid) {
-		$_repack = undef;
 		$GIT_SVN = $ENV{GIT_SVN_ID} = $id;
 		init_vars();
 		fetch(@_);
@@ -844,7 +847,7 @@ sub fetch_child_id {
 	}
 	while (<$fh>) {
 		print $_;
-		check_repack() if (/^r\d+ = $sha1/);
+		check_repack() if (/^r\d+ = $sha1/o);
 	}
 	close $fh or croak $?;
 }
@@ -1407,7 +1410,6 @@ sub git_commit {
 
 	# this output is read via pipe, do not change:
 	print "r$log_msg->{revision} = $commit\n";
-	check_repack();
 	return $commit;
 }
 
-- 
1.5.0.rc0.g0d67

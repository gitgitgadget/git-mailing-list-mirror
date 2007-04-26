From: Eric Wong <normalperson@yhbt.net>
Subject: [RFH] git-svn: sanitizing refnames
Date: Thu, 26 Apr 2007 12:49:01 -0700
Message-ID: <20070426194901.GA913@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 21:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9y1-0001b2-Cq
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031357AbXDZTtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031359AbXDZTtJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:49:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33859 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031357AbXDZTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:49:07 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 032AB7DC0A0;
	Thu, 26 Apr 2007 12:49:04 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 26 Apr 2007 12:49:01 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45651>

I had a small pocket of time on Sunday and started working on this, but
probably won't finish soon (the segfault issue take precedence, and
*that* is taking a while to complete with other things going on...).

Problem: git-svn maps directory names (branches and tags) from SVN into
refnames for git.  Unfortunately, some SVN users create branches and
tags with characters that git doesn't like.

Below is my work-in-progress patch to handle sanitation of
refnames.

It seems that storing a refmap dictionary in .git/config (or
git/svn/config) of already-translated refnames is necessary
so we can avoid conflicts with different refs sanitizing.

How to populate that dictionary is another problem.  Should we prompt
the user for input[1]?  Or should we just escape and append[2] characters
to the end?

We could probably just copy and modify the uri_encode() function
to %xx escape all the characters we don't like, and append '-'


[1] - keep in mind that some people probably run cron-jobs to keep
their mirrors synced.
[2] - parent following appends a "@<revision_number>", and
then enough '-'s until it's unique.

diff --git a/git-svn.perl b/git-svn.perl
index 4ea6f20..8d08572 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -987,6 +987,29 @@ sub sanitize_remote_name {
 	$name;
 }
 
+sub sanitize_ref_name {
+	my ($ref) = @_;
+	eval { command('check-ref-format', $ref) };
+	return unless $@;
+	my ($cfg, $ctx) = command_output_pipe('config', '--get-all',
+	                                      "svn-remote.$repo_id.refmap");
+	my $ref_encoded = uri_encode($ref);
+	my $re = qr/^\Q$ref_encoded\E=/;
+	my $ret;
+	while (<$ls>) {
+		next unless s/$re//;
+		chomp;
+		$ret = $_;
+		last;
+	}
+	close $cfg; # break the pipe
+	unless (defined $ret) {
+		command_noisy('config', '--add', "svn-remote.$repo_id.refmap",
+		              "$ref_encoded=$ret");
+	}
+	$ret;
+}
+
 sub find_existing_remote {
 	my ($url, $remotes) = @_;
 	return undef if $no_reuse_existing;
@@ -2088,6 +2111,7 @@ sub _new {
 		$_[2] = $ref_id = $Git::SVN::default_ref_id;
 	}
 	$_[1] = $repo_id = sanitize_remote_name($repo_id);
+	$_[2] = $ref_id = sanitize_ref_name($repo_id, $ref_id);
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
 	$_[3] = $path = '' unless (defined $path);
 	mkpath(["$ENV{GIT_DIR}/svn"]);
-- 
Eric Wong

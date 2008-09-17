From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git-svn: do a partial rebuild if rev_map is out-of-date
Date: Tue, 16 Sep 2008 23:13:04 -0400
Message-ID: <20080917031304.GA2505@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 05:20:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfnae-0004em-TB
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 05:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbYIQDNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 23:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYIQDNU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 23:13:20 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53334 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYIQDNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 23:13:19 -0400
Received: by gxk9 with SMTP id 9so28924173gxk.13
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=EKCq2AVLgFQEuE/pmGuvVybCrwRmSc4Pm2/7Nw3Bf6o=;
        b=C93IMnyuZE4d6QjuO04Z15PUtlL65xQ7+//Rf2JQ+rjUei3GSZLESbPZQxBA20b3eA
         RIQ214oDCRLp+lES1GW5iED3n8vEKkuxtn+0iVxOIobZohnM/TkIkup/hrsDKEH2grYr
         IZYh7OtdaIhkAUitfGkIV521NxB+YeZaDcCtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=eqgBff3JDfcpjvVnrTSs5txZrrPvJXQ8BmQF5H+Rl7UpowvHbg8WzII2YhHFWLjLQy
         IDNRszw0g/5RxH+/5+NkwVEZRvAk4jYkJgD5P5OhIE7GvZosTl4SL4/neCkblaabL9x6
         KcQuphgyuyPgG5yBrs8vOx07C/3CEy8cB1h9A=
Received: by 10.65.137.5 with SMTP id p5mr3511941qbn.50.1221621196475;
        Tue, 16 Sep 2008 20:13:16 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ( [68.40.49.130])
        by mx.google.com with ESMTPS id k27sm8280627qba.10.2008.09.16.20.13.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 20:13:15 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96065>

Suppose you're using git-svn to work with a certain SVN repository.
Since you don't like 'git-svn fetch' to take forever, and you don't want
to accidentally interrupt it and end up corrupting your repository, you
set up a remote Git repository to mirror the SVN repository, which does
its own 'git-svn fetch' on a cronjob; now you can 'git-fetch' from the
Git mirror into your local repository, and still dcommit to SVN when you
have changes to push.

After you do this, though, git-svn will get very confused if you ever
try to do 'git-svn fetch' in your local repository again, since its
rev_map will differ from the branch's head, and it will be unable to
fetch new commits from SVN because of the metadata conflict.  But all
the necessary metadata are there in the Git commit message; git-svn
already knows how to rebuild rev_map files that get blown away, by
using the metadata.

This commit will have git-svn do a partial rebuild of the rev_map to
match the true state of the branch, if it ever is used to fetch again.

This will only work for projects not using either noMetadata or
useSvmProps configuration options; if you are using these options,
git-svn will fall back to the previous behaviour.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
It's possible that this can be extended to work with useSvmProps, but I don't
know how to do so.

 git-svn.perl |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 88066c9..2e7a8ce 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2626,9 +2626,9 @@ sub rebuild_from_rev_db {
 sub rebuild {
 	my ($self) = @_;
 	my $map_path = $self->map_path;
-	return if (-e $map_path && ! -z $map_path);
+	my $partial = (-e $map_path && ! -z $map_path);
 	return unless ::verify_ref($self->refname.'^0');
-	if ($self->use_svm_props || $self->no_metadata) {
+	if (!$partial && ($self->use_svm_props || $self->no_metadata)) {
 		my $rev_db = $self->rev_db_path;
 		$self->rebuild_from_rev_db($rev_db);
 		if ($self->use_svm_props) {
@@ -2638,10 +2638,12 @@ sub rebuild {
 		$self->unlink_rev_db_symlink;
 		return;
 	}
-	print "Rebuilding $map_path ...\n";
+	print "Rebuilding $map_path ...\n" if (!$partial);
+	my ($base_rev, $head) = ($partial ? $self->rev_map_max_norebuild(1) :
+		(undef, undef));
 	my ($log, $ctx) =
 	    command_output_pipe(qw/rev-list --pretty=raw --no-color --reverse/,
-	                        $self->refname, '--');
+				($head ? "^$head" : ""), $self->refname, '--');
 	my $metadata_url = $self->metadata_url;
 	remove_username($metadata_url);
 	my $svn_uuid = $self->ra_uuid;
@@ -2664,12 +2666,17 @@ sub rebuild {
 		    ($metadata_url && $url && ($url ne $metadata_url))) {
 			next;
 		}
+		if ($partial && $head) {
+			print "Partial-rebuilding $map_path ...\n";
+			print "Currently at $base_rev = $head\n";
+			$head = undef;
+		}
 
 		$self->rev_map_set($rev, $c);
 		print "r$rev = $c\n";
 	}
 	command_close_pipe($log, $ctx);
-	print "Done rebuilding $map_path\n";
+	print "Done rebuilding $map_path\n" if (!$partial || !$head);
 	my $rev_db_path = $self->rev_db_path;
 	if (-f $self->rev_db_path) {
 		unlink $self->rev_db_path or croak "unlink: $!";
@@ -2809,6 +2816,12 @@ sub rev_map_set {
 sub rev_map_max {
 	my ($self, $want_commit) = @_;
 	$self->rebuild;
+	my ($r, $c) = $self->rev_map_max_norebuild($want_commit);
+	$want_commit ? ($r, $c) : $r;
+}
+
+sub rev_map_max_norebuild {
+	my ($self, $want_commit) = @_;
 	my $map_path = $self->map_path;
 	stat $map_path or return $want_commit ? (0, undef) : 0;
 	sysopen(my $fh, $map_path, O_RDONLY) or croak "open: $!";
-- 
1.5.4.3

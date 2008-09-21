From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2 1/1] git-svn: do a partial rebuild if rev_map is
	out-of-date
Date: Sat, 20 Sep 2008 22:45:50 -0400
Message-ID: <20080921024550.GC2505@riemann.deskinm.fdns.net>
References: <20080917031304.GA2505@riemann.deskinm.fdns.net> <20080918063754.GA13328@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 04:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhEzA-00059b-6Y
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 04:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYIUCqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 22:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYIUCqY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 22:46:24 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:4391 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbYIUCqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 22:46:23 -0400
Received: by an-out-0708.google.com with SMTP id d40so87203and.103
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 19:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=8z0DNSBaXcl9G2BeD9MZ8SNDHQgK/CUfZBMsAs2Fdls=;
        b=Z1Y6YKTxwzniIqf4Xm9maYFsqnXr0fqWl277ixhzbwWUT/M6HvsPUvL9w5mioCNTbn
         FWNhtQj/++ALQ+uiNDIoTH0Lpx/sKW991MNGVPDqt178o69L43OhqcgIFWXg4HVBnZVE
         KVIvPLUFFXCu6Mp3YKSYSEQDG3l4p6330CVxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=FqxeSVHS27OlAP+OLk1Z9dDdIWEQLCGmbE+K9LTqwdRNnj99it81JZcFZNX1q0lc3Z
         OiN6BOrvbBCRaKLiwu2OCCBdvlugF+SaXTwzmydtVAgLa3ejOGsAAz9J8g0yJ340eofu
         82jH7ikvlHfO+YEsyOb/EHHnDAZxfa+m922m0=
Received: by 10.64.241.3 with SMTP id o3mr3771009qbh.14.1221965183060;
        Sat, 20 Sep 2008 19:46:23 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ( [68.40.49.130])
        by mx.google.com with ESMTPS id 12sm3356782qbw.2.2008.09.20.19.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 19:46:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080918063754.GA13328@untitled>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96381>

>From 11ef3a043bb9cf89cd87d7030c684a1ee566a87a Mon Sep 17 00:00:00 2001
From: Deskin Miller <deskinm@umich.edu>
Date: Mon, 15 Sep 2008 21:12:58 -0400

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
On Wed, Sep 17, 2008 at 11:38:04PM -0700, Eric Wong wrote:
> This seems to break the following test case for me:
> 
> *** t9107-git-svn-migrate.sh ***
> *   ok 1: setup old-looking metadata
> *   ok 2: git-svn-HEAD is a real HEAD
> *   ok 3: initialize old-style (v0) git svn layout
> *   ok 4: initialize a multi-repository repo
> *   ok 5: multi-fetch works on partial urls + paths
> *   ok 6: migrate --minimize on old inited layout
> * FAIL 7: .rev_db auto-converted to .rev_map.UUID
> 
> I haven't had time to diagnose it.  Also, can you add a test that
> demonstrates this functionality (and ensures things keeps working when
> future work is done on git-svn?)

Here is the new, fixed version.  It allows the test in patch 0/1 to pass.

 git-svn.perl |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index af8279a..80a5728 100755
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
@@ -2638,10 +2638,13 @@ sub rebuild {
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
+				($head ? "$head.." : "") . $self->refname,
+				'--');
 	my $metadata_url = $self->metadata_url;
 	remove_username($metadata_url);
 	my $svn_uuid = $self->ra_uuid;
@@ -2664,12 +2667,17 @@ sub rebuild {
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
@@ -2809,6 +2817,12 @@ sub rev_map_set {
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
1.6.0.2.GIT

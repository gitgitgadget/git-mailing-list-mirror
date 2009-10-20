From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 3/5] git-svn: convert SVK merge tickets to extra parents
Date: Tue, 20 Oct 2009 15:42:01 +1300
Message-ID: <1256006523-5493-4-git-send-email-sam.vilain@catalyst.net.nz>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-2-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-3-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 04:43:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04hY-0008AQ-TB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbZJTCne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbZJTCne
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:43:34 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42706 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235AbZJTCnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:43:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 528AD32396;
	Tue, 20 Oct 2009 15:43:37 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07lE5EeXyHpT; Tue, 20 Oct 2009 15:43:34 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id D50DF3237F;
	Tue, 20 Oct 2009 15:43:34 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1256006523-5493-3-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130751>

SVK is a simple case to start with, as its idea of merge parents
matches git's one.  When a svk:merge ticket is encountered, check each
of the listed merged revisions to see if they are in the history of
this commit; if not, then we have encountered a merge - record it.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
   I'm not sure if 'other_gs' is the right method to call here;
   ideally we should lookup a revmap by UUID and path, that would
   in principle allow people to import from a bunch of SVK depots all
   being tracked.  Perhaps however this is sufficient.

 git-svn.perl                |   50 ++++++++++++++++++++++++++++++++++++++++++-
 t/t9150-svk-mergetickets.sh |   23 +++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletions(-)
 create mode 100644 t/t9150-svk-mergetickets.sh

diff --git a/git-svn.perl b/git-svn.perl
index eb4b75a..3c2534c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2878,14 +2878,62 @@ sub check_author {
 	$author;
 }
 
+sub find_extra_svk_parents {
+	my ($self, $ed, $tickets, $parents) = @_;
+	# aha!  svk:merge property changed...
+	my @tickets = split "\n", $tickets;
+	my @known_parents;
+	for my $ticket ( @tickets ) {
+		my ($uuid, $path, $rev) = split /:/, $ticket;
+		if ( $uuid eq $self->ra_uuid ) {
+			my $url = $self->rewrite_root || $self->{url};
+			my $repos_root = $url;
+			my $branch_from = $path;
+			$branch_from =~ s{^/}{};
+			my $gs = $self->other_gs($repos_root."/".$branch_from, $url,
+						 $branch_from, $rev, $self->{ref_id});
+			#my $gs = other_gs ( $url, $repos_root, $branch_from,
+				#$self->{ref_id} );
+			if ( my $commit = $gs->rev_map_get($rev, $uuid) ) {
+				# wahey!  we found it, but it might be
+				# an old one (!)
+				push @known_parents, $commit;
+			}
+		}
+	}
+	for my $parent ( @known_parents ) {
+		my @cmd = ('rev-list', $parent, map { "^$_" } @$parents );
+		my ($msg_fh, $ctx) = command_output_pipe(@cmd);
+		my $new;
+		while ( <$msg_fh> ) {
+			$new=1;last;
+		}
+		command_close_pipe($msg_fh, $ctx);
+		if ( $new ) {
+			print STDERR "Found merge parent (svk:merge ticket): $parent\n";
+			push @$parents, $parent;
+		}
+	}
+}
+
 sub make_log_entry {
 	my ($self, $rev, $parents, $ed) = @_;
 	my $untracked = $self->get_untracked($ed);
 
+	my @parents = @$parents;
+	my $ps = $ed->{path_strip} || "";
+	for my $path ( grep { m/$ps/ } %{$ed->{dir_prop}} ) {
+		my $props = $ed->{dir_prop}{$path};
+		if ( $props->{"svk:merge"} ) {
+			$self->find_extra_svk_parents
+				($ed, $props->{"svk:merge"}, \@parents);
+		}
+	}
+
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
 	print $un "r$rev\n" or croak $!;
 	print $un $_, "\n" foreach @$untracked;
-	my %log_entry = ( parents => $parents || [], revision => $rev,
+	my %log_entry = ( parents => \@parents, revision => $rev,
 	                  log => '');
 
 	my $headrev;
diff --git a/t/t9150-svk-mergetickets.sh b/t/t9150-svk-mergetickets.sh
new file mode 100644
index 0000000..8000c34
--- /dev/null
+++ b/t/t9150-svk-mergetickets.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Sam Vilain
+#
+
+test_description='git-svn svk merge tickets'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load svk depot' "
+	svnadmin load -q '$rawsvnrepo' < '../t9150/svk-merge.dump' &&
+	git svn init --minimize-url -R svkmerge \
+	  -T trunk -b branches '$svnrepo' &&
+	git svn fetch --all
+	"
+
+uuid=b48289b2-9c08-4d72-af37-0358a40b9c15
+
+test_expect_success 'svk merges were represented coming in' "
+	[ `git-cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
+	"
+
+test_done
-- 
1.6.3.3

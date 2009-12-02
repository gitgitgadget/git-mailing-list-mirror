From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 2/5] git-svn: Make merge metadata accessible to make_log_entry
Date: Wed,  2 Dec 2009 14:07:51 -0500
Message-ID: <1259780874-14706-3-git-send-email-alex@chmrr.net>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv1G-0007cC-Tj
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbZLBThg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZLBThg
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:37:36 -0500
Received: from chmrr.net ([209.67.253.66]:56887 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558AbZLBThe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:37:34 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NFuYj-0004Rd-5B
	for git@vger.kernel.org; Wed, 02 Dec 2009 14:08:20 -0500
X-Mailer: git-send-email 1.6.6.rc0.327.g032bc
In-Reply-To: <1259780874-14706-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-02 14:08:20
X-Connected-IP: 75.147.59.54:47077
X-Message-Linecount: 94
X-Body-Linecount: 85
X-Message-Size: 3024
X-Body-Size: 2609
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134382>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 53bf20c..5337326 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2924,7 +2924,7 @@ sub check_author {
 }
 
 sub find_extra_svk_parents {
-	my ($self, $ed, $tickets, $parents) = @_;
+	my ($self, $ed, $tickets, $parents, $merges) = @_;
 	# aha!  svk:merge property changed...
 	my @tickets = split "\n", $tickets;
 	my @known_parents;
@@ -2944,14 +2944,15 @@ sub find_extra_svk_parents {
 				# wahey!  we found it, but it might be
 				# an old one (!)
 				push @known_parents, [ $rev, $commit ];
+				push @known_parents, [ $rev, $path, $commit ];
 			}
 		}
 	}
 	# Ordering matters; highest-numbered commit merge tickets
 	# first, as they may account for later merge ticket additions
 	# or changes.
-	@known_parents = map {$_->[1]} sort {$b->[0] <=> $a->[0]} @known_parents;
-	for my $parent ( @known_parents ) {
+	for my $merge ( sort {$b->[0] <=> $a->[0]} @known_parents ) {
+		my ($rev, $path, $parent) = @{$merge};
 		my @cmd = ('rev-list', $parent, map { "^$_" } @$parents );
 		my ($msg_fh, $ctx) = command_output_pipe(@cmd);
 		my $new;
@@ -2963,6 +2964,7 @@ sub find_extra_svk_parents {
 			print STDERR
 			    "Found merge parent (svk:merge ticket): $parent\n";
 			push @$parents, $parent;
+			push @$merges, "$path:$rev";
 		}
 	}
 }
@@ -3061,27 +3063,31 @@ sub make_log_entry {
 	my ($self, $rev, $parents, $ed) = @_;
 	my $untracked = $self->get_untracked($ed);
 
-	my @parents = @$parents;
+	my %log_entry = ( parents => $parents,
+	                  merged_branches => [],
+	                  revision => $rev,
+	                  log => '');
 	my $ps = $ed->{path_strip} || "";
 	for my $path ( grep { m/$ps/ } %{$ed->{dir_prop}} ) {
 		my $props = $ed->{dir_prop}{$path};
 		if ( $props->{"svk:merge"} ) {
 			$self->find_extra_svk_parents
-				($ed, $props->{"svk:merge"}, \@parents);
+				($ed,
+				 $props->{"svk:merge"},
+				 $log_entry{parents},
+				 $log_entry{merged_branches});
 		}
 		if ( $props->{"svn:mergeinfo"} ) {
 			$self->find_extra_svn_parents
 				($ed,
 				 $props->{"svn:mergeinfo"},
-				 \@parents);
+				 $log_entry{parents});
 		}
 	}
 
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
 	print $un "r$rev\n" or croak $!;
 	print $un $_, "\n" foreach @$untracked;
-	my %log_entry = ( parents => \@parents, revision => $rev,
-	                  log => '');
 
 	my $headrev;
 	my $logged = delete $self->{logged_rev_props};
-- 
1.6.6.rc0.327.g032bc

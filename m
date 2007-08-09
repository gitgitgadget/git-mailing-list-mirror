From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Teach the update-paranoid to look at file differences
Date: Thu, 9 Aug 2007 02:38:12 -0400
Message-ID: <20070809063812.GB26843@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ1fW-00087S-4d
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 08:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764269AbXHIGiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 02:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762991AbXHIGiS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 02:38:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763964AbXHIGiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 02:38:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IJ1ev-0001DO-Ow; Thu, 09 Aug 2007 02:38:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C15E320FB65; Thu,  9 Aug 2007 02:38:12 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55416>

In some applications of the update hook a user may be allowed to
modify a branch, but only if the file level difference is also an
allowed change.  This is the commonly requested feature of allowing
users to modify only certain files.

A new repository.*.allow syntax permits granting the three basic
file level operations:

  A: file is added relative to the other tree
  M: file exists in both trees, but its SHA-1 or mode differs
  D: file is removed relative to the other tree

on a per-branch and path-name basis.  The user must also have a
branch level allow line already granting them access to create,
rewind or update (CRU) that branch before the hook will consult
any file level rules.

In order for a branch change to succeed _all_ files that differ
relative to some base (by default the old value of this branch,
but it can also be any valid tree-ish) must be allowed by file
level allow rules.  A push is rejected if any diff exists that
is not covered by at least one allow rule.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/hooks/update-paranoid |  112 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index fb2aca3..84ed452 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -102,6 +102,8 @@ my ($this_user) = getpwuid $<; # REAL_USER_ID
 my $repository_name;
 my %user_committer;
 my @allow_rules;
+my @path_rules;
+my %diff_cache;
 
 sub deny ($) {
 	print STDERR "-Deny-    $_[0]\n" if $debug;
@@ -122,6 +124,13 @@ sub git_value (@) {
 	open(T,'-|','git',@_); local $_ = <T>; chop; close T; $_;
 }
 
+sub match_string ($$) {
+	my ($acl_n, $ref) = @_;
+	   ($acl_n eq $ref)
+	|| ($acl_n =~ m,/$, && substr($ref,0,length $acl_n) eq $acl_n)
+	|| ($acl_n =~ m,^\^, && $ref =~ m:$acl_n:);
+}
+
 sub parse_config ($$$$) {
 	my $data = shift;
 	local $ENV{GIT_DIR} = shift;
@@ -209,6 +218,31 @@ sub check_committers (@) {
 	}
 }
 
+sub load_diff ($) {
+	my $base = shift;
+	my $d = $diff_cache{$base};
+	unless ($d) {
+		local $/ = "\0";
+		open(T,'-|','git','diff-tree',
+			'-r','--name-status','-z',
+			$base,$new) or return undef;
+		my %this_diff;
+		while (<T>) {
+			my $op = $_;
+			chop $op;
+
+			my $path = <T>;
+			chop $path;
+
+			$this_diff{$path} = $op;
+		}
+		close T or return undef;
+		$d = \%this_diff;
+		$diff_cache{$base} = $d;
+	}
+	return $d;
+}
+
 deny "No GIT_DIR inherited from caller" unless $git_dir;
 deny "Need a ref name" unless $ref;
 deny "Refusing funny ref $ref" unless $ref =~ s,^refs/,,;
@@ -266,7 +300,19 @@ RULE:
 			s/\${user\.$k}/$v->[0]/g;
 		}
 
-		if (/^([CDRU ]+)\s+for\s+([^\s]+)$/) {
+		if (/^([AMD ]+)\s+of\s+([^\s]+)\s+for\s+([^\s]+)\s+diff\s+([^\s]+)$/) {
+			my ($ops, $pth, $ref, $bst) = ($1, $2, $3, $4);
+			$ops =~ s/ //g;
+			$pth =~ s/\\\\/\\/g;
+			$ref =~ s/\\\\/\\/g;
+			push @path_rules, [$ops, $pth, $ref, $bst];
+		} elsif (/^([AMD ]+)\s+of\s+([^\s]+)\s+for\s+([^\s]+)$/) {
+			my ($ops, $pth, $ref) = ($1, $2, $3);
+			$ops =~ s/ //g;
+			$pth =~ s/\\\\/\\/g;
+			$ref =~ s/\\\\/\\/g;
+			push @path_rules, [$ops, $pth, $ref, $old];
+		} elsif (/^([CDRU ]+)\s+for\s+([^\s]+)$/) {
 			my $ops = $1;
 			my $ref = $2;
 			$ops =~ s/ //g;
@@ -300,13 +346,65 @@ foreach my $acl_entry (@allow_rules) {
 	next unless $acl_ops =~ /^[CDRU]+$/; # Uhh.... shouldn't happen.
 	next unless $acl_n;
 	next unless $op =~ /^[$acl_ops]$/;
+	next unless match_string $acl_n, $ref;
+
+	# Don't test path rules on branch deletes.
+	#
+	grant "Allowed by: $acl_ops for $acl_n" if $op eq 'D';
+
+	# Aggregate matching path rules; allow if there aren't
+	# any matching this ref.
+	#
+	my %pr;
+	foreach my $p_entry (@path_rules) {
+		my ($p_ops, $p_n, $p_ref, $p_bst) = @$p_entry;
+		next unless $p_ref;
+		push @{$pr{$p_bst}}, $p_entry if match_string $p_ref, $ref;
+	}
+	grant "Allowed by: $acl_ops for $acl_n" unless %pr;
 
-	grant "Allowed by: $acl_ops for $acl_n"
-	if (
-	   ($acl_n eq $ref)
-	|| ($acl_n =~ m,/$, && substr($ref,0,length $acl_n) eq $acl_n)
-	|| ($acl_n =~ m,^\^, && $ref =~ m:$acl_n:)
-	);
+	# Allow only if all changes against a single base are
+	# allowed by file path rules.
+	#
+	my @bad;
+	foreach my $p_bst (keys %pr) {
+		my $diff_ref = load_diff $p_bst;
+		deny "Cannot difference trees." unless ref $diff_ref;
+
+		my %fd = %$diff_ref;
+		foreach my $p_entry (@{$pr{$p_bst}}) {
+			my ($p_ops, $p_n, $p_ref, $p_bst) = @$p_entry;
+			next unless $p_ops =~ /^[AMD]+$/;
+			next unless $p_n;
+
+			foreach my $f_n (keys %fd) {
+				my $f_op = $fd{$f_n};
+				next unless $f_op;
+				next unless $f_op =~ /^[$p_ops]$/;
+				delete $fd{$f_n} if match_string $p_n, $f_n;
+			}
+			last unless %fd;
+		}
+
+		if (%fd) {
+			push @bad, [$p_bst, \%fd];
+		} else {
+			# All changes relative to $p_bst were allowed.
+			#
+			grant "Allowed by: $acl_ops for $acl_n diff $p_bst";
+		}
+	}
+
+	foreach my $bad_ref (@bad) {
+		my ($p_bst, $fd) = @$bad_ref;
+		print STDERR "\n";
+		print STDERR "Not allowed to make the following changes:\n";
+		print STDERR "(base: $p_bst)\n";
+		foreach my $f_n (sort keys %$fd) {
+			print STDERR "  $fd->{$f_n} $f_n\n";
+		}
+	}
+	deny "You are not permitted to $op $ref";
 }
 close A;
 deny "You are not permitted to $op $ref";
-- 
1.5.3.rc4.29.g74276

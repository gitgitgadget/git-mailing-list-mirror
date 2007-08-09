From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Teach update-paranoid how to store ACLs organized by groups
Date: Thu, 9 Aug 2007 02:38:09 -0400
Message-ID: <20070809063809.GA26843@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ1fV-00087S-Jd
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 08:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764327AbXHIGiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 02:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764269AbXHIGiQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 02:38:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38806 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763706AbXHIGiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 02:38:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IJ1et-0001DL-3r; Thu, 09 Aug 2007 02:38:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DFF0020FBAE; Thu,  9 Aug 2007 02:38:09 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55415>

In some applications of this paranoid update hook the set of ACL
rules that need to be applied to a user can be large, and the
number of users that those rules must also be applied to can be
more than a handful of individuals.  Rather than repeating the same
rules multiple times (once for each user) we now allow users to be
members of groups, where the group supplies the list of ACL rules.
For various reasons we don't depend on the underlying OS groups
and instead perform our own group handling.

Users can be made a member of one or more groups by setting the
user.memberOf property within the "users/$who.acl" file:

  [user]
    memberOf = developer
	memberOf = administrator

This will cause the hook to also parse the "groups/$groupname.acl"
file for each value of user.memberOf, and merge any allow rules
that match the current repository with the user's own private rules
(if they had any).

Since some rules are basically the same but may have a component
differ based on the individual user, any user.* key may be inserted
into a rule using the "${user.foo}" syntax.  The allow rule does
not match if the user does not define one (and exactly one) value
for the key "foo".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/hooks/update-paranoid |   60 ++++++++++++++++++++++++++++++-----------
 1 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index 5ee1835..fb2aca3 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -118,22 +118,29 @@ sub info ($) {
 	print STDERR "-Info-    $_[0]\n" if $debug;
 }
 
-sub parse_config ($$) {
-	my ($data, $fn) = @_;
-	info "Loading $fn";
-	open(I,'-|','git',"--git-dir=$acl_git",'cat-file','blob',$fn);
+sub git_value (@) {
+	open(T,'-|','git',@_); local $_ = <T>; chop; close T; $_;
+}
+
+sub parse_config ($$$$) {
+	my $data = shift;
+	local $ENV{GIT_DIR} = shift;
+	my $br = shift;
+	my $fn = shift;
+	info "Loading $br:$fn";
+	open(I,'-|','git','cat-file','blob',"$br:$fn");
 	my $section = '';
 	while (<I>) {
 		chomp;
 		if (/^\s*$/ || /^\s*#/) {
 		} elsif (/^\[([a-z]+)\]$/i) {
-			$section = $1;
+			$section = lc $1;
 		} elsif (/^\[([a-z]+)\s+"(.*)"\]$/i) {
-			$section = "$1.$2";
+			$section = join('.',lc $1,$2);
 		} elsif (/^\s*([a-z][a-z0-9]+)\s*=\s*(.*?)\s*$/i) {
-			push @{$data->{"$section.$1"}}, $2;
+			push @{$data->{join('.',$section,lc $1)}}, $2;
 		} else {
-			deny "bad config file line $. in $fn";
+			deny "bad config file line $. in $br:$fn";
 		}
 	}
 	close I;
@@ -202,11 +209,6 @@ sub check_committers (@) {
 	}
 }
 
-sub git_value (@) {
-	open(T,'-|','git',@_); local $_ = <T>; chop; close T;
-	$_;
-}
-
 deny "No GIT_DIR inherited from caller" unless $git_dir;
 deny "Need a ref name" unless $ref;
 deny "Refusing funny ref $ref" unless $ref =~ s,^refs/,,;
@@ -231,13 +233,39 @@ $op = 'U' if ($op eq 'R'
 	&& $ref =~ m,^heads/,
 	&& $old eq git_value('merge-base',$old,$new));
 
-# Load the user's ACL file.
+# Load the user's ACL file. Expand groups (user.memberof) one level.
 {
 	my %data = ('user.committer' => []);
-	parse_config(\%data, "$acl_branch:users/$this_user.acl");
+	parse_config(\%data,$acl_git,$acl_branch,"external/$repository_name.acl");
+
+	%data = (
+		'user.committer' => $data{'user.committer'},
+		'user.memberof' => [],
+	);
+	parse_config(\%data,$acl_git,$acl_branch,"users/$this_user.acl");
+
 	%user_committer = map {$_ => $_} @{$data{'user.committer'}};
-	my $rules = $data{"repository.$repository_name.allow"} || [];
+	my $rule_key = "repository.$repository_name.allow";
+	my $rules = $data{$rule_key} || [];
+
+	foreach my $group (@{$data{'user.memberof'}}) {
+		my %g;
+		parse_config(\%g,$acl_git,$acl_branch,"groups/$group.acl");
+		my $group_rules = $g{$rule_key};
+		push @$rules, @$group_rules if $group_rules;
+	}
+
+RULE:
 	foreach (@$rules) {
+		while (/\${user\.([a-z][a-zA-Z0-9]+)}/) {
+			my $k = lc $1;
+			my $v = $data{"user.$k"};
+			next RULE unless defined $v;
+			next RULE if @$v != 1;
+			next RULE unless defined $v->[0];
+			s/\${user\.$k}/$v->[0]/g;
+		}
+
 		if (/^([CDRU ]+)\s+for\s+([^\s]+)$/) {
 			my $ops = $1;
 			my $ref = $2;
-- 
1.5.3.rc4.29.g74276

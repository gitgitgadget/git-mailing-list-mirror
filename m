From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Contribute a fairly paranoid update hook
Date: Fri, 20 Apr 2007 02:08:47 -0400
Message-ID: <20070420060847.GA8255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 08:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HemIj-0004yv-8S
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 08:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422952AbXDTGIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 02:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422963AbXDTGIx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 02:08:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55749 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422952AbXDTGIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 02:08:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HemIb-00012S-2q; Fri, 20 Apr 2007 02:08:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BB62320FBAE; Fri, 20 Apr 2007 02:08:47 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45064>

I'm using a variant of this update hook in a corporate environment
where we perform some validations of the commits and tags that
are being pushed.  The model is a "central repository" type setup,
where users are given access to push to specific branches within
the shared central repository.  In this particular installation we
run a specially patched git-receive-pack in setuid mode via SSH,
allowing all writes into the repository as the repository owner,
but only if this hook blesses it.

One of the major checks we perform with this hook is that the
'committer' line of a commit, or the 'tagger' line of a new annotated
tag actually correlates to the UNIX user who is performing the push.
Users can falsify these lines on their local repositories, but
the central repository that management trusts will reject all such
forgery attempts.  Of course 'author' lines are still allowed to
be any value, as sometimes changes do come from other individuals.

Another nice feature of this hook is the access control lists for
all repositories on the system can also be stored and tracked in
a supporting Git repository, which can also be access controlled
by itself.  This allows full auditing of who-had-what-when-and-why,
thanks to git-blame's data mining capabilities.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I have often mentioned this hook on the list, and some people
 have been interested in at least looking at it, or using it as a
 foundation for their own hooks.  I think it is a reasonable thing
 for contrib/hooks, so here it is...  ;-)

 contrib/hooks/update-paranoid |  284 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 284 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/update-paranoid

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
new file mode 100644
index 0000000..5ee1835
--- /dev/null
+++ b/contrib/hooks/update-paranoid
@@ -0,0 +1,284 @@
+#!/usr/bin/perl
+
+use strict;
+use File::Spec;
+
+$ENV{PATH}     = '/opt/git/bin';
+my $acl_git    = '/vcs/acls.git';
+my $acl_branch = 'refs/heads/master';
+my $debug      = 0;
+
+=doc
+Invoked as: update refname old-sha1 new-sha1
+
+This script is run by git-receive-pack once for each ref that the
+client is trying to modify.  If we exit with a non-zero exit value
+then the update for that particular ref is denied, but updates for
+other refs in the same run of receive-pack may still be allowed.
+
+We are run after the objects have been uploaded, but before the
+ref is actually modified.  We take advantage of that fact when we
+look for "new" commits and tags (the new objects won't show up in
+`rev-list --all`).
+
+This script loads and parses the content of the config file
+"users/$this_user.acl" from the $acl_branch commit of $acl_git ODB.
+The acl file is a git-config style file, but uses a slightly more
+restricted syntax as the Perl parser contained within this script
+is not nearly as permissive as git-config.
+
+Example:
+
+  [user]
+    committer = John Doe <john.doe@example.com>
+    committer = John R. Doe <john.doe@example.com>
+
+  [repository "acls"]
+    allow = heads/master
+    allow = CDUR for heads/jd/
+    allow = C    for ^tags/v\\d+$
+
+For all new commit or tag objects the committer (or tagger) line
+within the object must exactly match one of the user.committer
+values listed in the acl file ("HEAD:users/$this_user.acl").
+
+For a branch to be modified an allow line within the matching
+repository section must be matched for both the refname and the
+opcode.
+
+Repository sections are matched on the basename of the repository
+(after removing the .git suffix).
+
+The opcode abbrevations are:
+
+  C: create new ref
+  D: delete existing ref
+  U: fast-forward existing ref (no commit loss)
+  R: rewind/rebase existing ref (commit loss)
+
+if no opcodes are listed before the "for" keyword then "U" (for
+fast-forward update only) is assumed as this is the most common
+usage.
+
+Refnames are matched by always assuming a prefix of "refs/".
+This hook forbids pushing or deleting anything not under "refs/".
+
+Refnames that start with ^ are Perl regular expressions, and the ^
+is kept as part of the regexp.  \\ is needed to get just one \, so
+\\d expands to \d in Perl.  The 3rd allow line above is an example.
+
+Refnames that don't start with ^ but that end with / are prefix
+matches (2nd allow line above); all other refnames are strict
+equality matches (1st allow line).
+
+Anything pushed to "heads/" (ok, really "refs/heads/") must be
+a commit.  Tags are not permitted here.
+
+Anything pushed to "tags/" (err, really "refs/tags/") must be an
+annotated tag.  Commits, blobs, trees, etc. are not permitted here.
+Annotated tag signatures aren't checked, nor are they required.
+
+The special subrepository of 'info/new-commit-check' can
+be created and used to allow users to push new commits and
+tags from another local repository to this one, even if they
+aren't the committer/tagger of those objects.  In a nut shell
+the info/new-commit-check directory is a Git repository whose
+objects/info/alternates file lists this repository and all other
+possible sources, and whose refs subdirectory contains symlinks
+to this repository's refs subdirectory, and to all other possible
+sources refs subdirectories.  Yes, this means that you cannot
+use packed-refs in those repositories as they won't be resolved
+correctly.
+
+=cut
+
+my $git_dir = $ENV{GIT_DIR};
+my $new_commit_check = "$git_dir/info/new-commit-check";
+my $ref = $ARGV[0];
+my $old = $ARGV[1];
+my $new = $ARGV[2];
+my $new_type;
+my ($this_user) = getpwuid $<; # REAL_USER_ID
+my $repository_name;
+my %user_committer;
+my @allow_rules;
+
+sub deny ($) {
+	print STDERR "-Deny-    $_[0]\n" if $debug;
+	print STDERR "\ndenied: $_[0]\n\n";
+	exit 1;
+}
+
+sub grant ($) {
+	print STDERR "-Grant-   $_[0]\n" if $debug;
+	exit 0;
+}
+
+sub info ($) {
+	print STDERR "-Info-    $_[0]\n" if $debug;
+}
+
+sub parse_config ($$) {
+	my ($data, $fn) = @_;
+	info "Loading $fn";
+	open(I,'-|','git',"--git-dir=$acl_git",'cat-file','blob',$fn);
+	my $section = '';
+	while (<I>) {
+		chomp;
+		if (/^\s*$/ || /^\s*#/) {
+		} elsif (/^\[([a-z]+)\]$/i) {
+			$section = $1;
+		} elsif (/^\[([a-z]+)\s+"(.*)"\]$/i) {
+			$section = "$1.$2";
+		} elsif (/^\s*([a-z][a-z0-9]+)\s*=\s*(.*?)\s*$/i) {
+			push @{$data->{"$section.$1"}}, $2;
+		} else {
+			deny "bad config file line $. in $fn";
+		}
+	}
+	close I;
+}
+
+sub all_new_committers () {
+	local $ENV{GIT_DIR} = $git_dir;
+	$ENV{GIT_DIR} = $new_commit_check if -d $new_commit_check;
+
+	info "Getting committers of new commits.";
+	my %used;
+	open(T,'-|','git','rev-list','--pretty=raw',$new,'--not','--all');
+	while (<T>) {
+		next unless s/^committer //;
+		chop;
+		s/>.*$/>/;
+		info "Found $_." unless $used{$_}++;
+	}
+	close T;
+	info "No new commits." unless %used;
+	keys %used;
+}
+
+sub all_new_taggers () {
+	my %exists;
+	open(T,'-|','git','for-each-ref','--format=%(objectname)','refs/tags');
+	while (<T>) {
+		chop;
+		$exists{$_} = 1;
+	}
+	close T;
+
+	info "Getting taggers of new tags.";
+	my %used;
+	my $obj = $new;
+	my $obj_type = $new_type;
+	while ($obj_type eq 'tag') {
+		last if $exists{$obj};
+		$obj_type = '';
+		open(T,'-|','git','cat-file','tag',$obj);
+		while (<T>) {
+			chop;
+			if (/^object ([a-z0-9]{40})$/) {
+				$obj = $1;
+			} elsif (/^type (.+)$/) {
+				$obj_type = $1;
+			} elsif (s/^tagger //) {
+				s/>.*$/>/;
+				info "Found $_." unless $used{$_}++;
+				last;
+			}
+		}
+		close T;
+	}
+	info "No new tags." unless %used;
+	keys %used;
+}
+
+sub check_committers (@) {
+	my @bad;
+	foreach (@_) { push @bad, $_ unless $user_committer{$_}; }
+	if (@bad) {
+		print STDERR "\n";
+		print STDERR "You are not $_.\n" foreach (sort @bad);
+		deny "You cannot push changes not committed by you.";
+	}
+}
+
+sub git_value (@) {
+	open(T,'-|','git',@_); local $_ = <T>; chop; close T;
+	$_;
+}
+
+deny "No GIT_DIR inherited from caller" unless $git_dir;
+deny "Need a ref name" unless $ref;
+deny "Refusing funny ref $ref" unless $ref =~ s,^refs/,,;
+deny "Bad old value $old" unless $old =~ /^[a-z0-9]{40}$/;
+deny "Bad new value $new" unless $new =~ /^[a-z0-9]{40}$/;
+deny "Cannot determine who you are." unless $this_user;
+
+$repository_name = File::Spec->rel2abs($git_dir);
+$repository_name =~ m,/([^/]+)(?:\.git|/\.git)$,;
+$repository_name = $1;
+info "Updating in '$repository_name'.";
+
+my $op;
+if    ($old =~ /^0{40}$/) { $op = 'C'; }
+elsif ($new =~ /^0{40}$/) { $op = 'D'; }
+else                      { $op = 'R'; }
+
+# This is really an update (fast-forward) if the
+# merge base of $old and $new is $old.
+#
+$op = 'U' if ($op eq 'R'
+	&& $ref =~ m,^heads/,
+	&& $old eq git_value('merge-base',$old,$new));
+
+# Load the user's ACL file.
+{
+	my %data = ('user.committer' => []);
+	parse_config(\%data, "$acl_branch:users/$this_user.acl");
+	%user_committer = map {$_ => $_} @{$data{'user.committer'}};
+	my $rules = $data{"repository.$repository_name.allow"} || [];
+	foreach (@$rules) {
+		if (/^([CDRU ]+)\s+for\s+([^\s]+)$/) {
+			my $ops = $1;
+			my $ref = $2;
+			$ops =~ s/ //g;
+			$ref =~ s/\\\\/\\/g;
+			push @allow_rules, [$ops, $ref];
+		} elsif (/^for\s+([^\s]+)$/) {
+			# Mentioned, but nothing granted?
+		} elsif (/^[^\s]+$/) {
+			s/\\\\/\\/g;
+			push @allow_rules, ['U', $_];
+		}
+	}
+}
+
+if ($op ne 'D') {
+	$new_type = git_value('cat-file','-t',$new);
+
+	if ($ref =~ m,^heads/,) {
+		deny "$ref must be a commit." unless $new_type eq 'commit';
+	} elsif ($ref =~ m,^tags/,) {
+		deny "$ref must be an annotated tag." unless $new_type eq 'tag';
+	}
+
+	check_committers (all_new_committers);
+	check_committers (all_new_taggers) if $new_type eq 'tag';
+}
+
+info "$this_user wants $op for $ref";
+foreach my $acl_entry (@allow_rules) {
+	my ($acl_ops, $acl_n) = @$acl_entry;
+	next unless $acl_ops =~ /^[CDRU]+$/; # Uhh.... shouldn't happen.
+	next unless $acl_n;
+	next unless $op =~ /^[$acl_ops]$/;
+
+	grant "Allowed by: $acl_ops for $acl_n"
+	if (
+	   ($acl_n eq $ref)
+	|| ($acl_n =~ m,/$, && substr($ref,0,length $acl_n) eq $acl_n)
+	|| ($acl_n =~ m,^\^, && $ref =~ m:$acl_n:)
+	);
+}
+close A;
+deny "You are not permitted to $op $ref";
-- 
1.5.1.1.135.gf948

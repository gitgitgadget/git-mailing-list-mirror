From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Repository Security
Date: Mon, 22 Jan 2007 15:53:04 -0500
Message-ID: <20070122205304.GB29739@spearce.org>
References: <200701221433.13257.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 21:53:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96AQ-00008w-1W
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbXAVUxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbXAVUxN
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:53:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39461 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbXAVUxL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:53:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H969x-0005Kk-Mx; Mon, 22 Jan 2007 15:52:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93BEC20FBAE; Mon, 22 Jan 2007 15:53:04 -0500 (EST)
To: Andre Masella <andre@masella.no-ip.org>
Content-Disposition: inline
In-Reply-To: <200701221433.13257.andre@masella.no-ip.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37451>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andre Masella <andre@masella.no-ip.org> wrote:
> I've been using git for a while and really like it, but I have a concern about 
> security.

Me too, until I fixed it locally.  ;-)
 
> As I understand it, none of the repository backends allow any per-user 
> per-branch access control. SSH and HTTP come the closest with the right 
> hooks, but since the repository is writeable by those users, there is little 
> to stop them from changing the repository directly.

Yes.  But hooks cannot be run in the HTTP case, can they?  However in
the HTTP case we use WebDAV to update the remote server, which means
security controls in the WebDAV server are probably sufficient to
prevent unauthorized object upload or ref updates.

In the SSH case I fixed it by installing git-receive-pack setuid
to the repository owner.  I locally patched receive-pack.c so it
disables hook execution if that particular hook isn't owned by the
repository user (to prevent rogue users from running arbitrary things
as the repository owner).  This way nobody can change anything in
a repository except through git-receive-pack.

I have the attached script as hooks/update in each repository.
It checks not only that a user can create/update/rewind(aka force
update)/delete a given ref, but that refs/tags are annotated,
refs/heads aren't, and that the committer strings on all commits
(or tagger strings on all tags) match the UNIX user's identity.

Rather draconian.  But in a corporate world with some strict legal
requirements placed upon you by your contracts with your customers
sometimes you do have to verify that Bob really is Bob, or at least
knows Bob's password.

> If this is truly the case, I was thinking of creating something similar to 
> SVN's Apache plugin to provide more sophisticated access control. I'm leaning 
> toward the HTTP remote (transport? backend? What's the right term?) because 
> Apache can do many kinds of authentication. I could also make the HTTP less 
> dumb, if I had a better idea what that might involve. This could also be a 
> way to solve the requests for remote repository creation I see in the survey.

The HTTP push client is dumb because it needs to send loose objects
to the remote repository.  (Though actually that's probably not a
good idea for pushes over 100 objects.)  But its also dumb because
it cannot send all ref updates in one shot, like the Git native
protocol is doing over SSH, or locally over a pipe.

A "smart" plugin to Apache is unnecessary I think.  A CGI which
splits the main() method of git-receive-pack into two halves (one
to write_head_info, the other to do the rest of the work) is all
that is required here to make HTTP push smart.  Then have the HTTP
client make one GET request to obtain the head info, then a POST
request to upload the pack to git-receive-pack.

Actually, looking at git-receive-pack's code, it might just be a
15 line patch to make it do these two tasks with the code it has now.

Since the hooks are then running as the web server user, and inherit
the entire HTTP environment, you can do authentication in the web
server but do authorization from within the hook, where you have
much finer control to inspect what is occurring.  And only the web
server needs to have write access to the repository.

-- 
Shawn.

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=update-acl

#!/opt2/perl/bin/perl

##
## Invoked as: update refname old-sha1 new-sha1
##

##
## Reads 'info/allowed-users' to determine access.
## Each line in allowed-users is two regex patterns
## to be applied to the refname and the username.
##
##    Example:
##         AURD:refs/heads/sp/     spearce
##         U:refs/heads/env-dev$   spearce|bob|smith
##
## The first line gives UNIX user 'spearce' access to create (A),
## update (U), rewind (R) and delete (D) branches under the path
## 'refs/heads/sp/.  The second line gives UNIX users 'spearce',
## 'bob', and 'smith' access to update (U) *only* refs/heads/env-dev.
##

##
## Reads 'info/allowed-committers' to verify committer
## names within all incoming commits.   Each line in
## allowed-committers is the UNIX username and the Git
## committer string (from git-var GIT_COMMITTER_IDENT).
## A user may only push a tag or commit in which they
## were the committer or the tagger.
##
##    Example:
##         spearce  Shawn O. Pearce <spearce@spearce.org>
##         spearce  Shawn Pearce <spearce@spearce.org>
##         bob      Bobby Brown <bb@example.com>
##
## The first two lines says that UNIX user 'spearce' may use the
## either committer name and email shown.
##

use strict;
local $ENV{PATH} = '/sw/git/bin';
my $debug = 0;
my $git_dir = $ENV{GIT_DIR};
my $committers = "$git_dir/info/allowed-committers";
my $acl = "$git_dir/info/allowed-users";
my $new_commit_check = "$git_dir/info/new-commit-check";

my $ref = $ARGV[0];
my $old = $ARGV[1];
my $new = $ARGV[2];
my $new_type;
my ($this_user) = getpwuid $<; # REAL_USER_ID

sub deny ($)
{
	print STDERR "-Deny-    $_[0]\n" if $debug;
	print STDERR "\ndenied: $_[0]\n\n";
	exit 1;
}

sub grant ($)
{
	print STDERR "-Grant-   $_[0]\n" if $debug;
	exit 0;
}

sub info ($)
{
	print STDERR "-Info-    $_[0]\n" if $debug;
}

sub all_new_committers ()
{
	local $ENV{GIT_DIR} = $git_dir;
	$ENV{GIT_DIR} = $new_commit_check if -d $new_commit_check;

	info "Getting committers of new commits.";
	my %used;
	open(T, '-|', 'git-rev-list','--pretty=raw',$new,'--not','--all');
	while (<T>)
	{
		next unless s/^committer //;
		chop;
		s/>.*$/>/;
		info "Found $_." unless $used{$_}++;
	}
	close T;
	info "No new commits." unless %used;
	%used;
}

sub all_new_taggers ()
{
	my %exists;
	open(T, '-|', 'git-for-each-ref',
		'--format=%(objectname)','refs/tags');
	while (<T>)
	{
		chop;
		$exists{$_} = 1;
	}
	close T;

	info "Getting taggers of new tags.";
	my %used;
	my $obj = $new;
	my $obj_type = $new_type;
	while ($obj_type eq 'tag')
	{
		last if $exists{$obj};
		$obj_type = '';
		open(T, '-|', 'git-cat-file', 'tag', $obj);
		while (<T>)
		{
			chop;
			if (/^object ([a-z0-9]{40})$/)
			{
				$obj = $1;
			}
			elsif (/^type (.+)$/)
			{
				$obj_type = $1;
			}
			elsif (s/^tagger //)
			{
				s/>.*$/>/;
				info "Found $_." unless $used{$_}++;
				last;
			}
		}
		close T;
	}
	info "No new tags." unless %used;
	%used;
}

sub check_committers (%)
{
	my %used = @_;
	return unless %used;

	info "Checking committer strings for $this_user";
	open(A, $committers) or deny "Cannot read $committers";
	info "Scanning $committers";
	while (<A>)
	{
		chomp;
		next if /^#/ || /^\s*$/;
		my ($unix_user, $cstr) = split /\s+/, $_, 2;
		next unless $this_user eq $unix_user;

		if ($used{$cstr})
		{
			info "$cstr allowed by line $.";
			delete $used{$cstr};
		}
	}
	close A;

	if (%used)
	{
		print STDERR "\n";
		print STDERR "You are not $_.\n" foreach (sort keys %used);
		deny "You cannot push changes not committed by you.";
	}
}

deny "Need a ref name" unless $ref;
deny "Bad old value $old" unless $old =~ /^[a-z0-9]{40}$/;
deny "Bad new value $new" unless $new =~ /^[a-z0-9]{40}$/;
deny "Cannot determine who you are." unless $this_user;

my $op = '';
my %op_desc = (
	'A' => 'create',
	'D' => 'delete',
	'R' => 'rewind',
	'U' => 'update',
	);

if ($old =~ /^0{40}$/)
{
	$op = 'A';
}
elsif ($new =~ /^0{40}$/)
{
	$op = 'D';
}
else
{
	$op = 'R';
}

if ($op eq 'R' && $ref =~ m,^refs/heads/,)
{
	open(T, '-|', 'git-merge-base', $old, $new);
	my $base = <T>;
	close T;
	chop $base;
	$op = 'U' if $base eq $old;
}

deny "Operation '$op' not permitted." unless $op_desc{$op};

if ($op ne 'D')
{
	open(T, '-|', 'git-cat-file', '-t', $new);
	$new_type = <T>;
	close T;
	chop $new_type;

	if ($ref =~ m,^refs/heads/env-([^/]+)$,)
	{
		open(T, '-|', 'git-repo-config', "buildenv.$1.name");
		my $env_name = <T>;
		close T;
		if ($env_name)
		{
			deny "$ref must be an annotated tag."
				unless $new_type eq 'tag';
		}
		else
		{
			deny "$ref must be a commit." unless $new_type eq 'commit';
		}
	}
	elsif ($ref =~ m,^refs/heads/,)
	{
		deny "$ref must be a commit." unless $new_type eq 'commit';
	}
	elsif ($ref =~ m,^refs/tags/,)
	{
		deny "$ref must be an annotated tag." unless $new_type eq 'tag';
	}

	check_committers (all_new_committers);
	check_committers (all_new_taggers) if $new_type eq 'tag';
}

info "Requesting $op_desc{$op} of $ref";
info "Checking access for $this_user to $ref";
open(A, $acl) or deny "No such file: $acl";
info "Scanning $acl";
while (<A>)
{
	chomp;
	next if /^#/ || /^\s*$/;
	my ($ref_pat, $user_pat) = split /\s+/, $_, 2;
	my $op_pat = 'AU';
	$op_pat = $1 if $ref_pat =~ s/^([ADRU]+)://;

	if ($ref =~ m:^$ref_pat:
		&& $this_user =~ /^(?:$user_pat)$/
		&& $op =~ /^[$op_pat]$/)
	{
		grant "Allowed by line $.";
	}
}
close A;

deny "You are not permitted to $op_desc{$op} $ref.";

--0F1p//8PRICkK4MW--

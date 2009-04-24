From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: How to sync changes in GIT to ClearCase or How to get the list
	of files changed in GIT for a specific branch
Date: Fri, 24 Apr 2009 11:20:07 +0200
Message-ID: <20090424092007.GD25300@m62s10.vlinux.de>
References: <23197522.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ask4thunder <ask4thunder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 11:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxHX2-00021d-5c
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 11:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbZDXJPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 05:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756705AbZDXJPn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 05:15:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:48947 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756835AbZDXJPk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 05:15:40 -0400
Received: (qmail invoked by alias); 24 Apr 2009 09:15:39 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp027) with SMTP; 24 Apr 2009 11:15:39 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/0yjhHlkT03gE0hB86ECPQlgj6jJgYiLpAjid8ma
	9AeKtCGBQqESh0
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 2653218091; Fri, 24 Apr 2009 11:20:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <23197522.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117423>

On Thu, Apr 23, 2009 at 11:59:20AM -0700, ask4thunder wrote:
> 
> Hi Everyone, 
> 
> Thanks for looking into this thread.
> 
> This is a help on GIT to ClearCase sync and am using UNIX session and not
> Windows
> 
> I am intending to use ClearCase in the background and GIT in the front.
> For syncing files from ClearCase to GIT i 
> checkout the git branch
> use rsync command to get the changed files in ClearCase
> and then i do the 'git add' and 'git commit'
> 
> This works out well, but i want to get a list of files changed in GIt so
> that i can bring that to ClearCase and checkout and checkin files.
> 
> Can someone provide me the commands to
> 
> 1. Get list of files changed in GIT, after i do commit?
> 2. Get list of files changed in GIT after commit, but files changed after a
> tag (baseline).
> 3. Sync these files to ClearCase?
> 
> 
> Hope you gurus can help me....am in desperate need of these commands. 
> Appreciate your help  in this.
> 
> Thanks
> ask4thunder
> 

This is what I used to work with clearcase in a former job:

Use cc_import.sh to import your changes and later export your changes
back to CC with export2cc.pl <path_to_CC_repo> <LABEL> <from> <to>

Greetings,
Peter


cc_import.sh: Importing files from the clearcase checkout

#!/bin/sh

# ATTENTION: This will create a branch named 'cc' in your git import
# Make sure that your actual checkout is NEVER on that branch if
# running this script!!!!


###########################
# Adapt this to your needs

BRANCH=refs/heads/cc

export GIT_WORK_TREE="/place/where/your/clearcase/checkout/is"
MY_GIT_IMPORT="/place/to/your/git-import"

###########################



export GIT_INDEX_FILE="${MY_GIT_IMPORT}/.git/index.clearcase"

# save your HEAD
cp .git/HEAD .git/HEAD.local

# switch to the clearcase import branch
git symbolic-ref HEAD "$BRANCH"

git add -u
git add .


# use the date of the checkin as commit message
datum=$(date +'%Y.%m.%d %T')
git commit -m"$datum"

# switch HEAD back to your previous one
cp .git/HEAD.local .git/HEAD


========================

export2cc.pl: exporting git revisions to CC

#!/usr/bin/perl

# TODO's:
#  - The commit msg might be extracted multiple times
#  - it has a hardcoded path name (right now: /d/msg)
#  - There is a proplem adding a deep hierarchy of files
#    (e.g. newdir1/newdir2/newfile1}
#  - No rename support


use File::Basename;
use strict;

my $verbose = 1;
my $upstream;
my $from;

my $cc_repo;
my $CC_LABEL;

$cc_repo = shift @ARGV;
$CC_LABEL = shift @ARGV;

print "CC repo: $cc_repo\n";
print "Label:   $cc_repo\n";

sub run_cmd_pipe {
	if ($^O eq 'MSWin32' || $^O eq 'msys') {
		my @invalid = grep {m/[":*]/} @_;
		die "$^O does not support: @invalid\n" if @invalid;
		my @args = map { m/ /o ? "\"$_\"": $_ } @_;
		return qx{@args};
	} else {
		my $fh = undef;
		open($fh, '-|', @_) or die;
		return <$fh>;
	}
}

if (scalar(@ARGV) >= 1) {
	$upstream = $ARGV[0];

	$from = ((scalar(@ARGV) >= 2) ? "$ARGV[1]" : "HEAD");
}


my @revisions;
push @revisions, "$ARGV[0]";

doit($revisions[0]);

sub doit($) {
	my $rev = shift;

	my @difftree_result = qx(git diff-tree -r --name-status $rev^ $rev -- );

	my @added_files;	# A
	my @copied_files;	# C
	my @deleted_files;	# D
	my @renamed_files;	# R

	my @modified_files;	# M

	foreach (@difftree_result) {
		my ($status, $file) = split /\t/;
		chomp $file;


		if ($status =~ /A/) {
			print "adding file \'$file\'\n" if ($verbose);
			push @added_files, "$file";
		}

		if ($status =~ /C/) {
			print "copied file '$file'\n" if ($verbose);
			push @copied_files, "$file";
		}

		if ($status =~ /D/) {
			print "deleted file '$file'\n" if ($verbose);
			push @deleted_files, "$file";
		}

		if ($status =~ /R/) {
			print "renamed file '$file'\n" if ($verbose);
			push @renamed_files, "$file";
		}

		if ($status =~ /M/) {
			print "modify file '$file'\n" if ($verbose);
			push @modified_files, "$file";
		}
	}

	# sort the files
	@added_files   = sort @added_files;
	@copied_files  = sort @copied_files;
	@deleted_files = sort @deleted_files;
	@renamed_files = sort @renamed_files;
	@modified_files= sort @modified_files;

	my $commit_msg = extract_commitmsg_from_git($rev);
	print $commit_msg;

	foreach (@renamed_files, @copied_files) {
		print "- $_" . "\n";
		die "can't handle renames";
	}


	foreach (@deleted_files) {
		my ($filename, $dirname) = fileparse($_);

		die "The directory $cc_repo/$dirname doesn't exist" if (! -d "$cc_repo/$dirname");

		cc_checkout($cc_repo, $dirname, "") || die "Can't checkout $dirname\n";
		cc_rmname($cc_repo, $_, $commit_msg) || die "Can't delete $_\n";
		cc_checkin($cc_repo, $dirname, "") || die "Can't checkin $dirname\n";

		# lable file and directory
		cc_mklabel($cc_repo, $dirname, $CC_LABEL) || die "Can't label $_\n";
	}
	
	foreach (@added_files) {
		print "N $_" . "\t(add the file manually)\n";
		
		my ($filename, $dirname) = fileparse($_);

		die "The directory $cc_repo/$dirname doesn't exist" if (! -d "$cc_repo/$dirname");

		cc_checkout($cc_repo, $dirname, "") || die "Can't checkout $dirname\n";
		extract_file_from_git($cc_repo, $_, $rev);
		cc_mkelem($cc_repo, $_, $commit_msg);
		cc_checkin($cc_repo, $_, "") || die "Can't checkin $_\n";
		cc_checkin($cc_repo, $dirname, "") || die "Can't checkin $dirname\n";

		# lable file and directory
		cc_mklabel($cc_repo, $_, $CC_LABEL) || die "Can't label $_\n";
		cc_mklabel($cc_repo, $dirname, $CC_LABEL) || die "Can't label $_\n";
	}

	foreach (@modified_files) {
		print "M $_" . "\n";
		cc_checkout($cc_repo, $_, $commit_msg) || die "Can't checkout $_\n";
		extract_file_from_git($cc_repo, $_, $rev);
		cc_checkin($cc_repo, $_, $commit_msg) || die "Can't checkin $_\n";
		cc_mklabel($cc_repo, $_, $CC_LABEL);
	}
}



sub cc_checkout ($$$) {
	my $path_to_repo = shift;
	my $file = shift;
	my $commit_msg = shift;

	my $result;
	my $errcode = 0;

	if ($commit_msg eq "") {
		$result = qx(cleartool co -res -ncomment "$path_to_repo/$file");
		$errcode = ($? >> 8);
	} else {
		my $msg_file = "/d/msg.txt";
		open(MSGFILE, ">$msg_file")
			or die "can't export the commit msg";
	
		print MSGFILE $commit_msg;
		close(MSGFILE);
	
		#print "cleartool co -res -unr -cfi $msg_file $path_to_repo/$file\n";
		$result = qx(cleartool co -res -unr -cfi $msg_file "$path_to_repo/$file");
		$errcode = ($? >> 8);
	
		qx(rm $msg_file);
	}

	print $result;
	return !$errcode;
}

sub cc_checkin ($$$) {
	my $path_to_repo = shift;
	my $file = shift;
	my $commit_msg = shift;

	my $result;
	my $errcode = 0;

	if ($commit_msg eq "") {
		$result = qx(cleartool ci -nc "$path_to_repo/$file");
		$errcode = ($? >> 8);
	} else {
		my $msg_file = "/d/msg.txt";
		open(MSGFILE, ">$msg_file")
			or die "can't export the commit msg";

		print MSGFILE $commit_msg;
		close(MSGFILE);

		$result = qx(cleartool ci -cfi $msg_file "$path_to_repo/$file");
		$errcode = ($? >> 8);

		qx(rm $msg_file);
	}

	print $result;

	return !$errcode;
}

##
# Add a new file/directory to clearcase
#
# @preconditon: the underlying directory is already checked out
sub cc_mkelem($$$) {
	my $path_to_repo = shift;
	my $file = shift;
	my $commit_msg = shift;

	my $msg_file = "/d/msg.txt";
	open(MSGFILE, ">$msg_file")
		or die "can't export the commit msg";

	print MSGFILE $commit_msg;
	close(MSGFILE);

	my $result = qx(cleartool mkelem -cfi $msg_file "$path_to_repo/$file");
	die "mkelem $path_to_repo/$file failed" if ($?);
	
	print $result;

	qx(rm $msg_file);
}

##
# Delete a file from clearcase
#
# @precondition: the underlying directory is already checked out
sub cc_rmname($$$) {
	my $path_to_repo = shift;
	my $file = shift;
	my $commit_msg = shift;

	my $errcode = 0;

	my $msg_file = "/d/msg.txt";
	open(MSGFILE, ">$msg_file")
		or die "can't export the commit msg";

	print MSGFILE $commit_msg;
	close(MSGFILE);

	my $result = qx(cleartool rmname -f -cfi $msg_file "$path_to_repo/$file");
	die "rmname $path_to_repo/$file failed" if ($?);
	$errcode = ($? >> 8);
	
	print $result;

	qx(rm $msg_file);
	return !$errcode;
}

##
#
sub cc_mklabel($$$) {
	my $path_to_repo = shift;
	my $file = shift;
	my $label = shift;
	
	my $result = qx(cleartool mklabel -replace "$label" "$path_to_repo/$file");
	die "mklabel $path_to_repo/$file failed" if ($?);
	print $result;
}

sub extract_file_from_git($$$) {
	my $cc_repo_path = shift;
	my $file = shift;
	my $rev = shift;

	my $result = qx(git show $rev:$file > $cc_repo_path/$file);
	die "extract_file_from_git $cc_repo_path/$file failed" if ($?);
}

sub extract_commitmsg_from_git($) {
	my $revision = shift;

	my $result = qx(git log -1 --pretty=format:'%s%n%b' $revision --);
	die "extract_commitmsg_from_git $revision failed" if ($?);
	return $result;
}

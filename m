From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: GIT Web Interface
Date: Tue, 19 Apr 2005 19:32:42 +0200
Message-ID: <20050419173242.GA32478@vrfy.org>
References: <20050419004415.GA10628@vrfy.org> <20050419005244.GR5554@pasky.ji.cz> <1113926385.29953.7.camel@localhost.localdomain> <20050419165247.GB32259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:29:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwWp-00052S-Di
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDSRc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSRc7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:32:59 -0400
Received: from soundwarez.org ([217.160.171.123]:42451 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261366AbVDSRco (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:32:44 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 1390021EB4; Tue, 19 Apr 2005 19:32:42 +0200 (CEST)
To: Greg KH <greg@kroah.com>
Content-Disposition: inline
In-Reply-To: <20050419165247.GB32259@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 09:52:48AM -0700, Greg KH wrote:
> On Tue, Apr 19, 2005 at 05:59:45PM +0200, Kay Sievers wrote:
> > On Tue, 2005-04-19 at 02:52 +0200, Petr Baudis wrote:
> > > Dear diary, on Tue, Apr 19, 2005 at 02:44:15AM CEST, I got a letter
> > > where Kay Sievers <kay.sievers@vrfy.org> told me that...
> > > > I'm hacking on a simple web interface, cause I missed the bkweb too much.
> > > > It can't do much more than browse through the source tree and show the
> > > > log now, but that should change... :)
> > > >   http://ehlo.org/~kay/gitweb.pl?project=linux-2.6
> > > 
> > > Hmm, looks nice for a start. (But you have obsolete git-pasky tree there! ;-)
> > 
> > Yeah, it's fresh now. :)
> > 
> > > > How can I get the files touched with a changeset and the corresponding
> > > > diffs belonging to it?
> > > 
> > > diff-tree to get the list of files, you can do the corresponding diffs
> > > e.g. by doing git diff -r tree1:tree2. Preferably make a patch for it
> > > first to make it possible to diff individual files this way.
> > 
> > Ah, nice! Got it working.
> 
> Looks good, care to post the updated version?

Sure, but expect it to change dramatically tonight. :)

Thanks,
Kay

-- 
#!/usr/bin/perl

# This file is licensed under the GPL v2, or a later version
# (C) 2005, Kay Sievers <kay.sievers@vrfy.org>


use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $query = new CGI;
my $myself = "gitweb.pl";
my $gitbin = "/home/kay/bin";
my $gitroot = "/home/kay/public_html";
my $gittmp = "/tmp";

my $project = $query->param("project") || "";
my $action = $query->param("action") || "";
my $hash = $query->param("hash") || "";
my $parent = $query->param("parent") || "";
my $projectroot = "$gitroot/$project";
$ENV{'SHA1_FILE_DIRECTORY'} = "$projectroot/.git/objects";

$hash =~ s/[^0-9a-fA-F]//g;
$parent =~ s/[^0-9a-fA-F]//g;

sub header {
	print $query->header();
	print $query->start_html("gitweb");
	if ($project ne "") {
		print $query->h1($project);
		print $query->a({-href => "$myself?project=$project&action=show_tree"}, "Browse Project") . "<br/>\n";
		print $query->a({-href => "$myself?project=$project&action=show_log"}, "Show Log") . "<br/>\n";
		print "<br/><br/>\n";
	}
}

sub footer {
	print $query->end_html();
}

if ($project eq "") {
	open my $fd, "-|", "ls", "-1", $gitroot;
	my (@path) = map { chomp; $_ } <$fd>;
	close $fd;
	header();
	print "Projects:<br/><br/>\n";
	foreach my $line (@path) {
		if (-e "$gitroot/$line/.git/HEAD") {
			print $query->a({-href => "$myself?project=$line"}, $line) . "<br/>\n";
		}
	}
	footer();
	exit;
}

if ($action eq "") {
	print $query->redirect("$myself?project=$project&action=show_log");
	exit;
}

if ($action eq "show_file") {
	header();
	print "<pre>\n";
	open my $fd, "-|", "$gitbin/cat-file", "blob", $hash;
	my $nr;
	while (my $line = <$fd>) {
		$nr++;
		print "$nr\t$line";
	}
	close $fd;
	print "</pre>\n";
	footer();
} elsif ($action eq "show_tree") {
	if ($hash eq "") {
		open my $fd, "$projectroot/.git/HEAD";
		my $head = <$fd>;
		chomp $head;
		close $fd;

		open $fd, "-|", "$gitbin/cat-file", "commit", $head;
		my $tree = <$fd>;
		chomp $tree;
		$tree =~ s/tree //;
		close $fd;
		$hash = $tree;
	}
	open my $fd, "-|", "$gitbin/ls-tree", $hash;
	my (@entries) = map { chomp; $_ } <$fd>;
	close $fd;
	header();
	print "<pre>\n";
	foreach my $line (@entries) {
		$line =~ m/^([0-9]+)\t(.*)\t(.*)\t(.*)$/;
		my $t_type = $2;
		my $t_hash = $3;
		my $t_name = $4;
		if ($t_type eq "blob") {
			print "FILE\t" . $query->a({-href => "$myself?project=$project&action=show_file&hash=$3"}, $4) . "\n";
		} elsif ($t_type eq "tree") {
			print "DIR\t" . $query->a({-href => "$myself?project=$project&action=show_tree&hash=$3"}, $4) . "\n";
		}
	}
	print "</pre>\n";
	footer();
} elsif ($action eq "show_log") {
	open my $fd, "$projectroot/.git/HEAD";
	my $head = <$fd>;
	chomp $head;
	close $fd;

	open my $fd, "-|", "$gitbin/rev-tree", $head;
	my (@revtree) = map { chomp; $_ } <$fd>;
	close $fd;

	header();
	foreach my $rev (reverse sort @revtree) {
		$rev =~ m/^([0-9]+) ([0-9a-fA-F]+).* ([0-9a-fA-F]+)/;
		my $time = $1;
		my $commit = $2;
		my $parent = $3;

		open my $fd, "-|", "$gitbin/cat-file", "commit", $commit;
		print "commit $commit " . $query->a({-href => "$myself?project=$project&action=show_cset&hash=$commit&parent=$parent"}, "(show cset)") . "<br/>\n";
		while (my $line = <$fd>) {
			if ($line =~ m/^tree (.*)$/) {
				print "$line " . $query->a({-href => "$myself?project=$project&action=show_tree&hash=$1"}, "(show tree)") . "<br/>\n";
			} elsif ($line =~ m/^(author|committer) (.*)/) {
				$line =~ m/^(.*) (.*>) ([0-9]+) (.*)$/;
				my $type = $1;
				my $name = $2;
				my $time = $3;
				my $timezone = $4;
				$name =~ s/</&lt;/;
				$name =~ s/>/&gt;/;
				$time = gmtime($time);
				print "$type $name $time $timezone<br/>\n";
			} else {
				$line =~ s/</&lt;/;
				$line =~ s/>/&gt;/;
				print "$line<br/>\n";
			}
		}
		close $fd;
		print "====================================<br/><br/>\n";
	}
	footer();
} elsif ($action eq "show_cset") {
	open my $fd, "-|", "$gitbin/cat-file", "commit", $hash;
	my $tree = <$fd>;
	chomp $tree;
	$tree =~ s/tree //;
	close $fd;

	open my $fd, "-|", "$gitbin/cat-file", "commit", $parent;
	my $parent_tree = <$fd>;
	chomp $parent_tree;
	$parent_tree =~ s/tree //;
	close $fd;

	open my $fd, "-|", "$gitbin/diff-tree", "-r", $parent_tree, $tree;
	my (@difftree) = map { chomp; $_ } <$fd>;
	close $fd;

	header();
	print "<pre>\n";
	foreach my $line (@difftree) {
		$line =~ m/^(.)(.*)\t(.*)\t(.*)\t(.*)$/;
		my $op = $1;
		my $mode = $2;
		my $type = $3;
		my $id = $4;
		my $file = $5;
		if ($type eq "blob") {
			if ($op eq "+") {
				print "NEW\t" . $query->a({-href => "$myself?project=$project&action=show_file&hash=$id"}, $file) . "\n";
			} elsif ($op eq "-") {
				print "DEL\t" . $query->a({-href => "$myself?project=$project&action=show_file&hash=$id"}, $file) . "\n";
			} elsif ($op eq "*") {
				$id =~ m/([0-9a-fA-F]+)->([0-9a-fA-F]+)/;
				my $old = $1;
				my $new = $2;
				print "DIFF\t" . $query->a({-href => "$myself?project=$project&action=show_diff&hash=$old&parent=$new"}, $file) . "\n";
			}
		}
	}
	print "</pre>\n";
	footer();
} elsif ($action eq "show_diff") {
	open my $fd2, "> $gittmp/$hash";
	open my $fd, "-|", "$gitbin/cat-file", "blob", $hash;
	while (my $line = <$fd>) {
		print $fd2 $line;
	}
	close $fd2;
	close $fd;

	open my $fd2, "> $gittmp/$parent";
	open my $fd, "-|", "$gitbin/cat-file", "blob", $parent;
	while (my $line = <$fd>) {
		print $fd2 $line;
	}
	close $fd2;
	close $fd;

	header();
	print "<pre>\n";
	open my $fd, "-|", "/usr/bin/diff", "-L", "$hash", "-L", "$parent", "-u", "-p", "$gittmp/$hash", "$gittmp/$parent";
	while (my $line = <$fd>) {
		$line =~ s/</&lt;/;
		$line =~ s/>/&gt;/;
		print $line;
	}
	close $fd;
	unlink("$gittmp/$hash");
	unlink("$gittmp/$parent");
	print "</pre>\n";
	footer();
} else {
	header();
	print "unknown action\n";
	footer();
}


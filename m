From: Kay Sievers <kay.sievers@vrfy.org>
Subject: GIT Web Interface
Date: Tue, 19 Apr 2005 02:44:15 +0200
Message-ID: <20050419004415.GA10628@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 02:41:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgnn-0004oW-PL
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDSApA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDSAo5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:44:57 -0400
Received: from soundwarez.org ([217.160.171.123]:57815 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261224AbVDSAoR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 20:44:17 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id A29F42222F; Tue, 19 Apr 2005 02:44:15 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm hacking on a simple web interface, cause I missed the bkweb too much.
It can't do much more than browse through the source tree and show the
log now, but that should change... :)
  http://ehlo.org/~kay/gitweb.pl?project=linux-2.6

How can I get the files touched with a changeset and the corresponding
diffs belonging to it?

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
my $gitbin = "/home/kay/bin";
my $gitroot = "/home/kay/public_html";

my $project = $query->param("project") || "";
my $action = $query->param("action") || "";
my $hash = $query->param("hash") || "";
my $projectroot = "$gitroot/$project";
$ENV{'SHA1_FILE_DIRECTORY'} = "$projectroot/.git/objects";

sub header {
	print $query->header();
	print $query->start_html("gitweb");
	print $query->h1($project);
}

sub footer {
	print $query->end_html();
}

if ($project eq "") {
	open my $fd, "-|", "ls", "-1", $gitroot;
	my (@path) = map { chomp; $_ } <$fd>;
	close $fd;
	header();
	print "projects:<br/>\n";
	foreach my $line (@path) {
		if (-e "$gitroot/$line/.git/HEAD") {
			print $query->a({-href => "gitweb.pl?project=$line"}, $line) . "<br/>\n";
		}
	}
	footer();
	exit;
}

if ($action eq "") {
	print $query->redirect("gitweb.pl?project=$project&action=show_log");
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
	foreach my $line (@entries) {
		$line =~ m/^([0-9]+)\t(.*)\t(.*)\t(.*)$/;
		my $t_type = $2;
		my $t_hash = $3;
		my $t_name = $4;
		if ($t_type eq "blob") {
			print "B\t" . $query->a({-href => "gitweb.pl?project=$project&action=show_file&hash=$3"}, $4) . "<br/>\n";
		} elsif ($t_type eq "tree") {
			print "T\t" . $query->a({-href => "gitweb.pl?project=$project&action=show_tree&hash=$3"}, $4) . "<br/>\n";
		}
	}
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
		$rev =~ m/^([0-9]+) ([0-9a-fA-F]+)/;
		my $time = $1;
		my $commit = $2;

		open my $fd, "-|", "$gitbin/cat-file", "commit", $commit;
		print "commit $commit<br/>\n";
		while (my $line = <$fd>) {
			if ($line =~ m/^tree (.*)$/) {
				print $query->a({-href => "gitweb.pl?project=$project&action=show_tree&hash=$1"}, $line) . "<br/>\n";
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
} else {
	header();
	print "unknown action\n";
	footer();
}


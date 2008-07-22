From: "Vincent Kergonna" <git@kergonna.fr>
Subject: Re: post-receive-hook emailer
Date: Tue, 22 Jul 2008 18:45:03 +0200 (CEST)
Message-ID: <2754.78.153.224.34.1216745103.squirrel@mail.kergonna.fr>
References: <00AEED4D-BD34-4584-B303-32C5F587EF0F@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ask =?iso-8859-1?Q?Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:33:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLKnc-0003Pb-IT
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbYGVQcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYGVQcG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:32:06 -0400
Received: from tulipe.kergonna.fr ([91.121.105.123]:53081 "EHLO
	tulipe.kergonna.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbYGVQcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:32:04 -0400
Received: from localhost ([127.0.0.1] helo=mail.kergonna.fr)
	by tulipe.kergonna.fr with esmtp (Exim 4.63)
	(envelope-from <git@kergonna.fr>)
	id 1KLKz1-0002rP-G8; Tue, 22 Jul 2008 18:45:03 +0200
Received: from 78.153.224.34
        (SquirrelMail authenticated user git@kergonna.fr)
        by mail.kergonna.fr with HTTP;
        Tue, 22 Jul 2008 18:45:03 +0200 (CEST)
In-Reply-To: <00AEED4D-BD34-4584-B303-32C5F587EF0F@develooper.com>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89496>

> Hi everyone,
>

Hi,

> Anyway - anyone have a mailer that sends diffs and such?  :-)   Or
> should I just write a wrapper around format-patch and send-email?
> (To handle branches well it gets slightly complicated, quick - or
> maybe I just haven't understood how the post-receive hook works).

Below is a script I use to send diffs for each commit pushed to a
repository. This script should be called from the 'update' hook.

-- 
Vincent


#!/usr/bin/perl
#
# Tool to send git commit notifications
#
# Copyright 2005 Alexandre Julliard
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
#
# This script is meant to be called from .git/hooks/update.
#
# Usage: git-notify [options] [--] refname old-sha1 new-sha1
#
#   -c name   Send CIA notifications under specified project name
#   -m addr   Send mail notifications to specified address
#   -n max    Set max number of individual mails to send
#   -r name   Set the git repository name
#   -s bytes  Set the maximum diff size in bytes (-1 for no limit)
#   -u url    Set the URL to the gitweb browser
#   -x branch Exclude changes to the specified branch from reports
#

use strict;
use open ':utf8';
use Encode 'encode';
use Cwd 'realpath';

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

# some parameters you may want to change

# base URL of the gitweb repository browser (can be set with the -u option)
my $gitweb_url = "";

# set this to something that takes "-s"
my $mailer = "/usr/bin/mail";

# default repository name (can be changed with the -r option)
my $repos_name = "";

# Repository owner
my $repos_owner = "";

# max size of diffs in bytes (can be changed with the -s option)
my $max_diff_size = 2500000;

# address for mail notices (can be set with -m option)
my $commitlist_address;

# project name for CIA notices (can be set with -c option)
my $cia_project_name;

# CIA notification address
my $cia_address = "cia\@cia.navi.cx";

# max number of individual notices before falling back to a single global
notice (can be set with -n option)
my $max_individual_notices = 100;

# debug mode
my $debug = 0;

# branches to exclude
my @exclude_list = ();

sub usage()
{
    print "Usage: $0 [options] [--] refname old-sha1 new-sha1\n";
    print "   -c name   Send CIA notifications under specified project
name\n";
    print "   -m addr   Send mail notifications to specified address\n";
    print "   -n max    Set max number of individual mails to send\n";
    print "   -r name   Set the git repository name\n";
    print "   -s bytes  Set the maximum diff size in bytes (-1 for no
limit)\n";
    print "   -u url    Set the URL to the gitweb browser\n";
    print "   -x branch Exclude changes to the specified branch from
reports\n";
	  print "   -o owner  Set repository owner (used as a filter on commits)\n";
    exit 1;
}

sub xml_escape($)
{
    my $str = shift;
    $str =~ s/&/&amp;/g;
    $str =~ s/</&lt;/g;
    $str =~ s/>/&gt;/g;
    my @chars = unpack "U*", $str;
    $str = join "", map { ($_ > 127) ? sprintf "&#%u;", $_ : chr($_); }
@chars;
    return $str;
}

# format an integer date + timezone as string
# algorithm taken from git's date.c
sub format_date($$)
{
    my ($time,$tz) = @_;

    if ($tz < 0)
    {
        my $minutes = (-$tz / 100) * 60 + (-$tz % 100);
        $time -= $minutes * 60;
    }
    else
    {
        my $minutes = ($tz / 100) * 60 + ($tz % 100);
        $time += $minutes * 60;
    }
    return gmtime($time) . sprintf " %+05d", $tz;
}

# parse command line options
sub parse_options()
{
    while (@ARGV && $ARGV[0] =~ /^-/)
    {
        my $arg = shift @ARGV;

        if ($arg eq '--') { last; }
        elsif ($arg eq '-c') { $cia_project_name = shift @ARGV; }
        elsif ($arg eq '-m') { $commitlist_address = shift @ARGV; }
        elsif ($arg eq '-n') { $max_individual_notices = shift @ARGV; }
        elsif ($arg eq '-r') { $repos_name = shift @ARGV; }
        elsif ($arg eq '-s') { $max_diff_size = shift @ARGV; }
        elsif ($arg eq '-u') { $gitweb_url = shift @ARGV; }
        elsif ($arg eq '-x') { push @exclude_list, "^" . shift @ARGV; }
		    elsif ($arg eq '-o') { $repos_owner = shift @ARGV; }
        elsif ($arg eq '-d') { $debug++; }
        else { usage(); }
    }
    if (@ARGV && $#ARGV != 2) { usage(); }
}

# send an email notification
sub mail_notification($$$@)
{
    my ($name, $subject, $content_type, @text) = @_;
    $subject = encode("MIME-Q",$subject);
    if ($debug)
    {
        print "---------------------\n";
        print "To: $name\n";
        print "Subject: $subject\n";
        print "Content-Type: $content_type\n";
        print "\n", join("\n", @text), "\n";
    }
    else
    {
        my $pid = open MAIL, "|-";
        return unless defined $pid;
        if (!$pid)
        {
            exec $mailer, "-s", $subject, "-a", "Content-Type:
$content_type", $name or die "Cannot exec $mailer";
        }
        print MAIL join("\n", @text), "\n";
        close MAIL;
    }
}

# get the default repository name
sub get_repos_name()
{
    my $dir = `git rev-parse --git-dir`;
    chomp $dir;
    my $repos = realpath($dir);
    $repos =~ s/(.*?)((\.git\/)?\.git)$/\1/;
    $repos =~ s/(.*)\/([^\/]+)\/?$/\2/;
    return $repos;
}

# extract the information from a commit or tag object and return a hash
containing the various fields
sub get_object_info($)
{
    my $obj = shift;
    my %info = ();
    my @log = ();
    my $do_log = 0;

    open TYPE, "-|" or exec "git", "cat-file", "-t", $obj or die "cannot
run git-cat-file";
    my $type = <TYPE>;
    chomp $type;
    close TYPE;

    open OBJ, "-|" or exec "git", "cat-file", $type, $obj or die "cannot
run git-cat-file";
    while (<OBJ>)
    {
        chomp;
        if ($do_log)
        {
            last if /^-----BEGIN PGP SIGNATURE-----/;
            push @log, $_;
        }
        elsif (/^(author|committer|tagger) ((.*)(<.*>)) (\d+) ([+-]\d+)$/)
        {
            $info{$1} = $2;
            $info{$1 . "_name"} = $3;
            $info{$1 . "_email"} = $4;
            $info{$1 . "_date"} = $5;
            $info{$1 . "_tz"} = $6;
        }
        elsif (/^tag (.*)$/)
        {
            $info{"tag"} = $1;
        }
        elsif (/^$/) { $do_log = 1; }
    }
    close OBJ;

    $info{"type"} = $type;
    $info{"log"} = \@log;
    return %info;
}

# send a commit notice to a mailing list
sub send_commit_notice($$)
{
    my ($ref,$obj) = @_;
    my %info = get_object_info($obj);
    my @notice = ();
    my $subject;

	return if $info{"log"} eq "^(m|M)erge.*";

	if ($info{"author"} =~ "$repos_owner") {

		if ($info{"type"} eq "tag")
		{
			push @notice,
			"Module: $repos_name",
			"Branch: $ref",
			"Tag:    $obj",
			#"URL:    $gitweb_url/?a=tag;h=$obj",
			"",
			"Tagger: " . $info{"tagger"},
			"Date:   " . format_date($info{"tagger_date"},$info{"tagger_tz"}),
			"",
			join "\n", @{$info{"log"}};
			$subject = "[CommitDiff] Tag " . $info{"tag"} . " : " .
$info{"tagger_name"} . ": " . ${$info{"log"}}[0];
		}
		else
		{
			push @notice,
			"Module: $repos_name",
			"Branch: $ref",
			"Commit: $obj",
			"Parent: $info()",
			"URL:    $gitweb_url/?a=commit;h=$obj",
			"Author: " . $info{"author"},
			"AuthorDate:   " . format_date($info{"author_date"},$info{"author_tz"}),
			"",
			join "\n", @{$info{"log"}},
			"",
			"---",
			"";

			open STAT, "-|" or exec "git", "diff-tree", "--stat", "-M",
"--no-commit-id", $obj or die "cannot exec git-diff-tree";
			push @notice, join("", <STAT>);
			close STAT;

			open DIFF, "-|" or exec "git", "diff-tree", "-p", "-M",
"--no-commit-id", $obj or die "cannot exec git-diff-tree";
			my $diff = join( "", <DIFF> );
			close DIFF;

			if (($max_diff_size == -1) || (length($diff) < $max_diff_size))
			{
				push @notice, $diff;
			}
			else
			{
				push @notice, "Diff:   $gitweb_url/?a=commitdiff;h=$obj",
			}

			$subject = "[CommitDiff] " . ${$info{"log"}}[0];
		}

		mail_notification($commitlist_address, $subject, "text/plain;
charset=UTF-8", @notice);
	}
}

# send a commit notice to the CIA server
sub send_cia_notice($$)
{
    my ($ref,$commit) = @_;
    my %info = get_object_info($commit);
    my @cia_text = ();

    return if $info{"type"} ne "commit";

    push @cia_text,
        "<message>",
        "  <generator>",
        "    <name>git-notify script for CIA</name>",
        "  </generator>",
        "  <source>",
        "    <project>" . xml_escape($cia_project_name) . "</project>",
        "    <module>" . xml_escape($repos_name) . "</module>",
        "    <branch>" . xml_escape($ref). "</branch>",
        "  </source>",
        "  <body>",
        "    <commit>",
        "      <revision>" . substr($commit,0,10) . "</revision>",
        "      <author>" . xml_escape($info{"author"}) . "</author>",
        "      <log>" . xml_escape(join "\n", @{$info{"log"}}) . "</log>",
        "      <files>";

    open COMMIT, "-|" or exec "git", "diff-tree", "--name-status", "-r",
"-M", $commit or die "cannot run git-diff-tree";
    while (<COMMIT>)
    {
        chomp;
        if (/^([AMD])\t(.*)$/)
        {
            my ($action, $file) = ($1, $2);
            my %actions = ( "A" => "add", "M" => "modify", "D" => "remove" );
            next unless defined $actions{$action};
            push @cia_text, "        <file action=\"$actions{$action}\">"
. xml_escape($file) . "</file>";
        }
        elsif (/^R\d+\t(.*)\t(.*)$/)
        {
            my ($old, $new) = ($1, $2);
            push @cia_text, "        <file action=\"rename\" to=\"" .
xml_escape($new) . "\">" . xml_escape($old) . "</file>";
        }
    }
    close COMMIT;

    push @cia_text,
        "      </files>",
        "      <url>" . xml_escape("$gitweb_url/?a=commit;h=$commit") .
"</url>",
        "    </commit>",
        "  </body>",
        "  <timestamp>" . $info{"author_date"} . "</timestamp>",
        "</message>";

    mail_notification($cia_address, "DeliverXML", "text/xml", @cia_text);
}

# send a global commit notice when there are too many commits for
individual mails
sub send_global_notice($$$)
{
    my ($ref, $old_sha1, $new_sha1) = @_;
    my @notice = ();

    open LIST, "-|" or exec "git", "rev-list", "--pretty", "^$old_sha1",
"$new_sha1", @exclude_list or die "cannot exec git-rev-list";
    while (<LIST>)
    {
        chomp;
        s/^commit /URL:    $gitweb_url\/?a=commit;h=/;
        push @notice, $_;
    }
    close LIST;

    mail_notification($commitlist_address, "New commits on branch $ref",
"text/plain; charset=UTF-8", @notice);
}

# send all the notices
sub send_all_notices($$$)
{
    my ($ref, $old_sha1, $new_sha1) = @_;

    $ref =~ s/^refs\/heads\///;

    if ($old_sha1 eq '0' x 40)  # new ref
    {
        send_commit_notice( $ref, $new_sha1 ) if $commitlist_address;
        return;
    }

    my @commits = ();

    open LIST, "-|" or exec "git", "rev-list", "^$old_sha1", "$new_sha1",
@exclude_list or die "cannot exec git-rev-list";
    while (<LIST>)
    {
        chomp;
        die "invalid commit $_" unless /^[0-9a-f]{40}$/;
        unshift @commits, $_;
    }
    close LIST;

    if (@commits > $max_individual_notices)
    {
        send_global_notice( $ref, $old_sha1, $new_sha1 ) if
$commitlist_address;
        return;
    }

    foreach my $commit (@commits)
    {
        send_commit_notice( $ref, $commit ) if $commitlist_address;
        send_cia_notice( $ref, $commit ) if $cia_project_name;
    }
}

$repos_name = get_repos_name();
parse_options();

# append repository path to URL
$gitweb_url .= "/$repos_name.git";

if (@ARGV)
{
    send_all_notices( $ARGV[0], $ARGV[1], $ARGV[2] );
}
else  # read them from stdin
{
    while (<>)
    {
        chomp;
        if (/^([0-9a-f]{40}) ([0-9a-f]{40}) (.*)$/) { send_all_notices(
$3, $1, $2 ); }
    }
}

exit 0;

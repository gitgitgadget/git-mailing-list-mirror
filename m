From: JD Horelick <jdhore1@gmail.com>
Subject: New CIA.vc script
Date: Mon, 6 Jun 2011 06:36:33 -0400
Message-ID: <BANLkTi=_nXGOcqC1PMLFJfgkdx8HbsweEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 12:36:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTXAm-00007d-GG
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 12:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab1FFKgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 06:36:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50607 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab1FFKgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 06:36:35 -0400
Received: by fxm17 with SMTP id 17so2311282fxm.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=gLdLWgFL5Y+RBFHdjFsFooWPboPN0o4aCwphrm5nFzc=;
        b=pD0/wNpxFh8UBdIXcTukHkxcv9cqxnhuYIhEFlSI7pFd23mWLykQwynJQ3GDoTmLzd
         7avWz3v5Xvx0Lc7g8zUvXTm/u0L/m45kZzCx2IlJjfrab9eSH1u9X2gXNRRi1X1+m3YX
         m2gn2OQmd61Jv7OIOCBOt+pjbcQ/Tm/S26q3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=caObDkNfQ+E9Lu3FTjIb+6FcLBhUUL1Ph1FXXQfHDXaj2kwf1SP/YIOE1rDwunItxb
         G2qodGHx6k2LPH/qlXw3xBKDAA0td2/bt8FekFaDdJFjxGW8CbhmbdbX1D4jCASFIeh+
         rbBtG4xDkl2ZLrWHU1bF8Otgi+8NdZoT0TFcQ=
Received: by 10.223.95.198 with SMTP id e6mr2459591fan.13.1307356593518; Mon,
 06 Jun 2011 03:36:33 -0700 (PDT)
Received: by 10.223.29.138 with HTTP; Mon, 6 Jun 2011 03:36:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175116>

Hello all,

I'm apologizing in advance if this email is formatted badly or done
wrong. I'm not really a mailing list guy.
I recently decided to take the ciabot.pl script for Git and improve
upon it and now I am submitting it for inclusion in upstream Git.

I decided to use the Perl version for many reasons including: I know
Perl better than I know Python, Git seems more Perl-centric to me and
the Perl script was already closest to what I needed.

Here are the things this script does better than any other CIA.vc
client script implementations i've seen for Git:
1. It can use both RPC and email for sending commit notifications to
CIA.vc. The Python and Shell versions only use email, which has been
deprecated by CIA.vc for a long while.
2. It uses Git's config system for storing the options that will
change on a per-project basis if the script is running on a central
host.
3. It has support for the "module" variable allowing (for example) a
seperate plugins repository to go to the same project page as the main
repository, just prefixed with plugins (or whatever) so it's
discernable. If it is empty, no module variable is sent to CIA.

I'm attaching the new ciabot.pl inline here:

#!/usr/bin/perl -w
#
# ciabot -- Mail a git log message to a given address, for the purposes of CIA
#
# Loosely based on cvslog by Russ Allbery <rra@stanford.edu>
# Copyright 1998  Board of Trustees, Leland Stanford Jr. University
#
# Copyright 2001, 2003, 2004, 2005  Petr Baudis <pasky@ucw.cz>
# Copyright 2011 JD Horelick <jdhore1@gmail.com>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2, as published by the
# Free Software Foundation.
#
# The master location of this file is in the Cogito repository
# (see http://www.kernel.org/git/).
#
# This program is designed to run as the .git/hooks/post-commit hook. It takes
# the commit information, massages it and mails it to the address given below.
#
# The calling convention of the post-commit hook is:
#
#    .git/hooks/post-commit $commit_sha1 $branch_name
#
# If it does not work, try to disable $xml_rpc in the configuration section
# below. Also, remember to make the hook file executable.
#
#
# Note that you can (and it might be actually more desirable) also use this
# script as the GIT update hook:
#
#    refname=${1#refs/heads/}
#    [ "$refname" = "master" ] && refname=
#    oldhead=$2
#    newhead=$3
#    for merged in $(git rev-list $newhead ^$oldhead | tac); do
#        /path/to/ciabot.pl $merged $refname
#    done
#
# This is useful when you use a remote repository that you only push to. The
# update hook will be triggered each time you push into that repository, and
# the pushed commits will be reported through CIA.
# This script no longer TinyURL's the link to gitweb as the link will be
# short enough anyway as it's sent on its own line

use strict;
use Carp;
use vars qw ($project $module $repo $baseurl $from_email $dest_email
$noisy $rpc_uri $sendmail
        $xml_rpc $ignore_regexp $alt_local_message_target);


### Configuration

# Project name (as known to CIA).
chomp($project = `git config --get cia.project`);

# Module name (if applicable)
chomp($module = `git config --get cia.module`);

# Repository name in the web interface
chomp($repo = `git config --get cia.repo`);

# Base URL for a GitWeb or cgit instance
# You must comment all the baseurl lines out if you do not have a web interface
# or do not want the web interface URL for the commit displayed
# Gitweb
#$baseurl = "http://git.example.com/cgi-bin/gitweb.cgi?p=$repo;a=commit;h=";
# cgit
#$baseurl = "http://git.example.com/$repo/commit/?id=";

# The from address in generated mails.
$from_email = 'cia@example.com';

# Mail all reports to this address.
$dest_email = 'cia@cia.vc';

# If using XML-RPC, connect to this URI.
$rpc_uri = 'http://cia.vc/RPC2';

# Path to your USCD sendmail compatible binary (your mailer daemon created this
# program somewhere).
$sendmail = '/usr/sbin/sendmail';

# If set, the script will send CIA the full commit message. If unset, only the
# first line of the commit message will be sent.
$noisy = 1;

# This script can communicate with CIA either by mail or by an XML-RPC
# interface. The XML-RPC interface is faster and more efficient, however you
# need to have RPC::XML perl module installed, and some large CVS hosting sites
# (like Savannah or Sourceforge) might not allow outgoing HTTP connections
# while they allow outgoing mail. Also, this script will hang and eventually
# not deliver the event at all if CIA server happens to be down, which is
# unfortunately not an uncommon condition.
$xml_rpc = 1;

# This variable should contain a regexp, against which each file will be
# checked, and if the regexp is matched, the file is ignored. This can be
# useful if you do not want auto-updated files, such as e.g. ChangeLog, to
# appear via CIA.
#
# The following example will make the script ignore all changes in two specific
# files in two different modules, and everything concerning module 'admin':
#
# $ignore_regexp = "^(gentoo/Manifest|elinks/src/bfu/inphist.c|admin/)";
$ignore_regexp = "";

# It can be useful to also grab the generated XML message by some other
# programs and e.g. autogenerate some content based on it. Here you can specify
# a file to which it will be appended.
$alt_local_message_target = "";




### The code itself

use vars qw ($commit $tree @parent $author $committer);
use vars qw ($user $branch $rev @files $logmsg $message $shorturl);
my $line;

if ($project eq "") {
    croak "Project variable is required. Please set one with git
config --add cia.project";
}

if ($repo eq "") {
    undef $baseurl;
}

# Let's be extra-safe here
if ($module eq "") {
    undef $module;
}


### Input data loading


# The commit stuff
$commit = $ARGV[0];
$branch = $ARGV[1];

open COMMIT, "git cat-file commit $commit|" or die "git cat-file
commit $commit: $!";
my $state = 0;
$logmsg = '';
while (defined ($line = <COMMIT>)) {
  if ($state == 1) {
    $logmsg .= $line;
    $noisy or $state++;
    next;
  } elsif ($state > 1) {
    next;
  }

  chomp $line;
  unless ($line) {
    $state = 1;
    next;
  }

  my ($key, $value) = split(/ /, $line, 2);
  if ($key eq 'tree') {
    $tree = $value;
  } elsif ($key eq 'parent') {
    push(@parent, $value);
  } elsif ($key eq 'author') {
    $author = $value;
  } elsif ($key eq 'committer') {
    $committer = $value;
  }
}
close COMMIT;


open DIFF, "git diff-tree -r $parent[0] $tree|" or die "git diff-tree
$parent[0] $tree: $!";
while (defined ($line = <DIFF>)) {
  chomp $line;
  my @f;
  (undef, @f) = split(/\t/, $line, 2);
  push (@files, @f);
}
close DIFF;


# Figure out who is doing the update.
# XXX: Too trivial this way?
($user) = $author =~ /<(.*?)@/;


$rev = substr($commit, 0, 12);




### Remove to-be-ignored files

@files = grep { $_ !~ m/$ignore_regexp/; } @files
  if ($ignore_regexp);
exit unless @files;



### Compose the mail message


my ($VERSION) = '2.0';
my $ts = time;

$message = <<EM
<message>
   <generator>
       <name>CIA Perl client for Git</name>
       <version>$VERSION</version>
   </generator>
   <source>
       <project>$project</project>

EM
;
$message .= "       <module>$module</module>" if ($module);
$message .= "       <branch>$branch</branch>" if ($branch);
$message .= <<EM
   </source>
   <timestamp>
       $ts
   </timestamp>
   <body>
       <commit>
           <author>$user</author>
           <revision>$rev</revision>
           <files>
EM
;

foreach (@files) {
  s/&/&amp;/g;
  s/</&lt;/g;
  s/>/&gt;/g;
  $message .= "  <file>$_</file>\n";
}

$logmsg =~ s/&/&amp;/g;
$logmsg =~ s/</&lt;/g;
$logmsg =~ s/>/&gt;/g;

if (defined $baseurl) {
    $shorturl = $baseurl . $rev;
    $logmsg = $logmsg . $shorturl;
}

$message .= <<EM
           </files>
    <log>$logmsg</log>
       </commit>
   </body>
</message>
EM
;



### Write the message to an alt-target

if ($alt_local_message_target and open (ALT, ">>$alt_local_message_target")) {
  print ALT $message;
  close ALT;
}



### Send out the XML-RPC message


if ($xml_rpc) {
  # We gotta be careful from now on. We silence all the warnings because
  # RPC::XML code is crappy and works with undefs etc.
  $^W = 0;
  $RPC::XML::ERROR if (0); # silence perl's compile-time warning

  require RPC::XML;
  require RPC::XML::Client;

  my $rpc_client = new RPC::XML::Client $rpc_uri;
  my $rpc_request = RPC::XML::request->new('hub.deliver', $message);
  my $rpc_response = $rpc_client->send_request($rpc_request);

  unless (ref $rpc_response) {
    die "XML-RPC Error: $RPC::XML::ERROR\n";
  }
  exit;
}



### Send out the mail


# Open our mail program

open (MAIL, "| $sendmail -t -oi -oem") or die "Cannot execute
$sendmail : " . ($?>>8);


# The mail header

print MAIL <<EOM;
From: $from_email
To: $dest_email
Content-type: text/xml
Subject: DeliverXML

EOM

print MAIL $message;


# Close the mail

close MAIL;
die "$0: sendmail exit status " . ($? >> 8) . "\n" unless ($? == 0);

# vi: set sw=2:


I welcome any constructive criticism and I hope to see this in
contrib/ciabot soon. :)

Thanks
JD

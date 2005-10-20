From: David Ho <davidkwho@gmail.com>
Subject: Re: git-filehistory (2nd try at detecting renames)
Date: Thu, 20 Oct 2005 16:52:13 -0400
Message-ID: <4dd15d180510201352m754e70afycc580b0daf66c6d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 22:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EShOc-0003p8-F8
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 22:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVJTUwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVJTUwP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 16:52:15 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:38490 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932532AbVJTUwO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 16:52:14 -0400
Received: by qproxy.gmail.com with SMTP id v40so406725qbe
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 13:52:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QkGuevqwBV25oxXigaTGVDeToSpZsD1damsJ19PCt6cA19V/c1913Bp0ce1JV7skWVVp/QRXu+UKkDITX+6ZEE8kB2dwVnOBHVh2/nwbdUe07vTAuvGaS2u0P0nwyQRfzP6/LsvzbzRqtJqdo2BDtxIZFyOO28u0NU68Xh/e/Dk=
Received: by 10.65.44.13 with SMTP id w13mr1858568qbj;
        Thu, 20 Oct 2005 13:52:13 -0700 (PDT)
Received: by 10.65.22.3 with HTTP; Thu, 20 Oct 2005 13:52:13 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10380>

The output is a bit more manageable with this, but still a bit slow.
I tried it on git-commit.sh

David

[davidho@penguin git-tutorial]$ cat git-filehistory.perl
#!/usr/bin/perl

use warnings;
use strict;

sub usage($);

# Sanity checks:
my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";

unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" &&
        -d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
        usage("Git repository not found.");
}

usage("") if scalar @ARGV != 1;

my ($file) = @ARGV;

unless (-f $file) {
        usage("git filehistory: '$file' does not exist");
}

open(F,"-|","git-rev-parse",,"--default","HEAD","--revs-only",$file);
my $git_rev_args = <F>;
chomp ($git_rev_args);
close (F);

open(F,"-|","git-rev-list", $git_rev_args);
my @commits = <F>;
close (F);

my $nextname = $file;
my (@renamecommit, @renamecomment, @renameentry);
for (my $i=0; $i < scalar @commits; $i++)
{
        my $commit = $commits[$i];
        chomp ($commit);

        open(F,"-|","git-diff-tree","-r","-M", $commit)
                or die "Failed to open pipe from git-diff-tree: " . $!;
        my @lines = grep /R\d{3}.+$nextname/, <F>;
        close(F);
        if (scalar @lines >=1) {
                #The file is renamed!
                #my $rc = system
("git-diff-tree","-r","-M","-p","--pretty=medium",$commit);
                open (F,
"-|","git-diff-tree","-r","-M","--pretty=medium",$commit);
                        @renamecommit = <F>;
                        @renamecomment = grep /^[^:]/, @renamecommit;
                        @renameentry = grep /R\d{3}.+$nextname/, @renamecommit;
                        push @renamecomment, @renameentry;
                        foreach (@renamecomment) {
                                print;
                        }
                if ($lines[0] =~ /R\d{3}\t(.+)\t(.+)/) {
                        $nextname = $1;
                }
                close(F);
        }
        else {
                #Not renamed
                #my $rc = system
("git-diff-tree","-r","-m","-p","--pretty=medium",$commit, $nextname);
                my $rc = system
("git-diff-tree","-r","--pretty=medium",$commit, $nextname);
                die "git-diff-tree failed" if $rc;
        }
}

sub usage($) {
        my $s = shift;
        print $s, "\n" if (length $s != 0);
        print <<EOT;
$0 <file>
This script traces renames to find the origin of the file
EOT
        exit(1);
}

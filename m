From: David Ho <davidkwho@gmail.com>
Subject: git-filehistory (first cut at detecting renames)
Date: Thu, 20 Oct 2005 15:51:58 -0400
Message-ID: <4dd15d180510201251p57bea756s18b2e77d4be4ec35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 21:54:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESgSp-000273-2Y
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 21:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVJTTwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVJTTwA
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 15:52:00 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:44576 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbVJTTv7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 15:51:59 -0400
Received: by qproxy.gmail.com with SMTP id v40so397815qbe
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 12:51:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SX2+JzaTdtao63zDc2ZNRnmB8q6teuyar55svC+mf+ZldVx2dZIGlI0fddcT0COop/pdcFmtAA24KTYS6+oYCiGCVeSlEyWs0LNPRhoRjUMAtuOjL4iWB6cynrO1/hJjsLGkABIEcntMeBYlxYf5zaODybA3l13bEH2+USQ3ifs=
Received: by 10.64.183.2 with SMTP id g2mr1834345qbf;
        Thu, 20 Oct 2005 12:51:58 -0700 (PDT)
Received: by 10.65.22.3 with HTTP; Thu, 20 Oct 2005 12:51:58 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10375>

Hi all,

This is my stupid perl script to detect renames all the way to it's
origin.  This is my first attempt at writing a perl script so it looks
a bit awful.  It's not perfect, if a file is renamed, the entire
commit is dumped out.  Maybe if git-diff-tree -M <pathname> does post
processing to output changes relevant to <pathname> then it will work
quite well.

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
                my $rc = system
("git-diff-tree","-r","-M","-p","--pretty=medium",$commit);
                die "git-diff-tree failed" if $rc;
                print "\n";
                if ($lines[0] =~ /R\d{3}\t(.+)\t(.+)/) {
                        $nextname = $1;
                }
        }
        else {
                #Not renamed
                my $rc = system
("git-diff-tree","-r","-m","-p","--pretty=medium",$commit, $nextname);
                die "git-diff-tree failed" if $rc;
                print "\n";
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

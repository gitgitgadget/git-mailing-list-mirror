From: David Ho <davidkwho@gmail.com>
Subject: Re: git-filehistory (3rd try at detecting renames)
Date: Thu, 20 Oct 2005 17:23:09 -0400
Message-ID: <4dd15d180510201423y5e200b68xec32bffec0f0cf84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 23:25:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EShsi-0004De-HW
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 23:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJTVXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVJTVXO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 17:23:14 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:56805 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932481AbVJTVXO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 17:23:14 -0400
Received: by qproxy.gmail.com with SMTP id v40so410746qbe
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 14:23:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E6hRuAx7WIjSjaHKZRXFu550FjVPOjf7PZfx6pETtz42//WFRB05akHo1QXs1Q8v+X7wlG7mMhKJ5mCNo+okTyeKaj6KJqhpA3SAYcw7CJkSys+n0KBHyGGYn/GkczKcRsCXILE/worrPp83fG7pJOxV/k7JZKVglkXtRt7li+Y=
Received: by 10.65.189.6 with SMTP id r6mr1832044qbp;
        Thu, 20 Oct 2005 14:23:09 -0700 (PDT)
Received: by 10.65.22.3 with HTTP; Thu, 20 Oct 2005 14:23:09 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10381>

Sorry, once again, this calls git-diff-tree once per commit.

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
        open (F, "-|","git-diff-tree","-r","-M","--pretty=medium",$commit);
        @renamecommit = <F>;
        close(F);
        @renamecomment = grep /^[^:]/, @renamecommit;
        @renameentry = grep /$nextname/, @renamecommit;
        push @renamecomment, @renameentry;
        if (scalar @renameentry) {
                if ($renameentry[0] =~ /\t$nextname$/) {
                        foreach (@renamecomment) {
                                print;
                        }
                }
                if ($renameentry[0] =~ /R\d{3}\t(.+)\t(.+)/) {
                        #The file is renamed
                        $nextname = $1;
                }
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

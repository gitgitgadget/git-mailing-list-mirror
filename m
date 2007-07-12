From: Eric Wong <normalperson@yhbt.net>
Subject: Re: mtimes of working files
Date: Wed, 11 Jul 2007 23:26:05 -0700
Message-ID: <20070712062605.GD29676@muzzle>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> <Pine.LNX.4.64.0707111902040.4516@racer.site> <f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com> <Pine.LNX.4.64.0707111940080.4516@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 08:26:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8s88-0006bs-N0
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 08:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXGLG0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 02:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbXGLG0I
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 02:26:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40522 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbXGLG0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 02:26:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0ACC42DC032;
	Wed, 11 Jul 2007 23:26:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707111940080.4516@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52248>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi list,
> 
> > > > How difficult is it to have script (or maybe existing git option) 
> > > > that would make mtimes of all working files equal to time of last 
> > > > commit ?
> 
> Now I slowly get really curious.  Does _anybody_ know a scenario where 
> this makes sense?
> 
> (No, Eric, there are enough corner cases where your example of a clustered 
> webserver breaks down, so I am not fully convinced that this is a useful 
> case.)

I'll have to admit that most of my git usage is via git-svn, so I
mostly deal with linear history and some branching, but no real merges
in a git sense.

This is what I whipped up the other night:

http://yhbt.net/git-set-file-times

-----------------------------------8<-----------------------------------------
#!/usr/bin/perl -w
use strict;

# sets mtime and atime of files to the latest commit time in git
#
# This is useful for serving static content (managed by git)
# from a cluster of identically configured HTTP servers.  HTTP
# clients and content delivery networks can get consistent
# Last-Modified headers no matter which HTTP server in the
# cluster they hit.  This should improve caching behavior.
#
# This does not take into account merges, but if you're updating
# every machine in the cluster from the same commit (A) to the
# same commit (B), the mtimes will be _consistent_ across all
# machines if not necesarily accurate.
#
# THIS IS NOT INTENDED TO OPTIMIZE BUILD SYSTEMS SUCH AS 'make'
# YOU HAVE BEEN WARNED!

my %ls = ();
my $commit_time;

$/ = "\0";
open FH, 'git ls-files -z|' or die $!;
while (<FH>) {
	chomp;
	$ls{$_} = $_;
}
close FH;


$/ = "\n";
open FH, "git log -r --name-only --no-color --pretty=raw -z @ARGV |" or die $!;
while (<FH>) {
	chomp;
	if (/^committer .*? (\d+) (?:[\-\+]\d+)$/) {
		$commit_time = $1;
	} elsif (s/\0\0commit [a-f0-9]{40}$//) {
		my @files = delete @ls{split(/\0/, $_)};
		@files = grep { defined $_ } @files;
		next unless @files;
		utime $commit_time, $commit_time, @files;
	}
	last unless %ls;

}
close FH;
-----------------------------------8<-----------------------------------------

-- 
Eric Wong

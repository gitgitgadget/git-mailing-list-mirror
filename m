From: Jeff King <peff@peff.net>
Subject: Re: git-who
Date: Tue, 7 Oct 2008 22:25:05 -0400
Message-ID: <20081008022505.GB29313@coredump.intra.peff.net>
References: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 04:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnOkn-0003Fu-Mg
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 04:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbYJHCZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 22:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYJHCZI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 22:25:08 -0400
Received: from peff.net ([208.65.91.99]:2704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbYJHCZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 22:25:08 -0400
Received: (qmail 11242 invoked by uid 111); 8 Oct 2008 02:25:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 07 Oct 2008 22:25:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2008 22:25:05 -0400
Content-Disposition: inline
In-Reply-To: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97757>

On Tue, Oct 07, 2008 at 05:02:46PM -0400, Kate Rhodes wrote:

> As is it's probably not worth including in git, but I'm thinking that  
> someone else can probably come up with some improvements, such as dates in 
> the verbose mode, support for a treeish instead of a single file path, and 
> / or rewriting it in C so that it can work on Windows.

Scripts like this often find a good home in git's contrib/ directory.
Consider submitting a patch which adds it there.

> git://github.com/masukomi/git_accessories.git

I took a look. My biggest complaint is that for many files, it produces
too many names. It would be nice to at least sort the names by number
of commits. But even more accurate might be the number of added lines.
Somebody who creates a 200-line file should surely come before somebody
who made a 1-line tweak, right?

But perhaps even more accurate would be to rely on blame output, since
it attributes not just added lines, but lines which have actually
survived into the current product. And fortunately that is relatively
easy to do (only lightly tested):

-- >8 --
#!/usr/bin/perl
#
# Invoke as 'git who -M -C file.c' (or whichever blame options
# you prefer). You can even check a particular set of lines
# with "git who -M -C -L 40,60 file.c".

use strict;

open(my $in, '-|', qw(git blame -p), @ARGV);

my %count;
my %author;
my $current_sha1;
while(<$in>) {
  if (!$current_sha1) {
    /^[0-9a-f]{40}/ or die "expected sha1, got $_";
    $current_sha1 = $&;
    $count{$current_sha1}++;
  }
  elsif (/^author (.*)/) {
    $author{$current_sha1} = $1;
  }
  elsif (/^\t/) {
    $current_sha1 = undef;
  }
}

my %acount;
while(my ($h, $c) = each %count) {
  $acount{$author{$h}} += $c;
}

foreach (sort { $acount{$b} <=> $acount{$a} } keys %acount) {
  print "$_ ($acount{$_})\n";
}

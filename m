From: Jeff King <peff@peff.net>
Subject: Re: gitweb filter for patches by a specific person in a specific timeframe
Date: Mon, 28 Aug 2006 14:16:27 -0400
Message-ID: <20060828181626.GB2950@coredump.intra.peff.net>
References: <200608281459.26643.kai.blin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 20:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHlf8-0000Lx-7n
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 20:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWH1SQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWH1SQa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 14:16:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:47517 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751259AbWH1SQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 14:16:29 -0400
Received: (qmail 2742 invoked from network); 28 Aug 2006 14:15:49 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Aug 2006 14:15:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Aug 2006 14:16:27 -0400
To: Kai Blin <kai.blin@gmail.com>
Content-Disposition: inline
In-Reply-To: <200608281459.26643.kai.blin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26172>

On Mon, Aug 28, 2006 at 02:59:21PM +0200, Kai Blin wrote:

> I have just completed my Google Summer of Code[1] project[2] working for the 
> Wine project. Now, as I was submitting patches to a git repository, I don't 
> have a branch solely containing my patches or something like that. Google 
> seems to want something like this, so I figured maybe I could get gitweb to 
> filter for my patches during the SoC period. Is that possible?
> If not, does it sound like something feasible to add?

You can create an mbox of all of the changes you made. Unfortunately
git-rev-list doesn't do author/committer matching, so you'll need a
short perl script:

-- >8 --
$ cat >match-who.pl <<'EOF'
#!/usr/bin/perl

my $name = shift;
my $match = qr/$name/i;

my $commit;
while(<>) {
  chomp;
  next unless $_;
  next if /^\s/;
  my ($k, $v) = split / /, $_, 2;
  if($k eq 'commit') {
    $commit = $v;
  }
  if($commit && ($k eq 'author' || $k eq 'committer') && $v =~ $match) {
    print "$commit\n";
    $commit = undef;
  }
}
-- >8 --

Then you should be able to do:
$ git-rev-list --pretty=raw master |
  perl match-who.pl kai.blin@gmail.com |
  git-diff-tree -p --stdin --pretty=email \
  > my-patches

You can either look through that, or you can try applying the patches
with git-am (though if your patches depend on changes not by you that
happened in the intervening time, you'll probably have some rejects).

-Peff

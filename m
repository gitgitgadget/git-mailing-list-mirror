From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Thu, 17 Mar 2011 15:34:50 -0400
Message-ID: <20110317193450.GD20508@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
 <1300371608.16335.1.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0IyI-0006p5-5N
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab1CQTew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:34:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58693
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab1CQTew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:34:52 -0400
Received: (qmail 26563 invoked by uid 107); 17 Mar 2011 19:35:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 15:35:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 15:34:50 -0400
Content-Disposition: inline
In-Reply-To: <1300371608.16335.1.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169262>

On Thu, Mar 17, 2011 at 02:20:08PM +0000, Will Palmer wrote:

> On Wed, 2011-03-09 at 14:14 +0200, Alexei Sholik wrote:
> > .................. Just ran this command
> > 
> > git blame -p "$1" | awk '$1 ~ /author$/ { print substr($0,
> > length("author  "), length($0)) }' | sort | uniq -c | sort -nr
> > 
> > on the for-each-ref.c and saw that Junio had the first place by a
> > relatively large margin.
> > 
> 
> Wrap that up in a script and submit /that/ as a patch ;)

That just counts the number of commits that have any surviving line in a
given file. So it's slightly better than "shortlog -ns" in that it
removes commits whose contents have been totally rewritten (and it
properly handles content-following). But if you are going to use blame,
the more interesting measure is probably a count of lines attributed to
each author.  Something like:

  git blame -p "$1" | perl -ne '
    if (/^([0-9a-f]{40})/) {
      $sha1 = $1;
      $count{$sha1}++;
    }
    elsif (/^author (.*)/) {
      $author{$sha1} = $1;
    }
    END {
      foreach my $sha1 (keys(%count)) {
        $r{$author{$sha1}} += $count{$sha1};
      }
      foreach my $a (sort { $r{$b} <=> $r{$a} } keys(%r)) {
        print "$r{$a} $a\n";
      }
    }
  '

-Peff

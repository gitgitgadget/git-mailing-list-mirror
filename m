From: Jeff King <peff@peff.net>
Subject: Re: Graph sloc tool for git repos
Date: Sun, 13 Mar 2016 22:50:53 -0400
Message-ID: <20160314025052.GB19753@sigill.intra.peff.net>
References: <1457780426.2632189.547083938.25305E83@webmail.messagingengine.com>
 <20160314023545.GA19753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kai Hendry <hendry@iki.fi>
X-From: git-owner@vger.kernel.org Mon Mar 14 03:52:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afIc4-0006Fd-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 03:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933150AbcCNCwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 22:52:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:59066 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754620AbcCNCvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 22:51:01 -0400
Received: (qmail 2878 invoked by uid 102); 14 Mar 2016 02:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Mar 2016 22:50:55 -0400
Received: (qmail 18961 invoked by uid 107); 14 Mar 2016 02:51:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Mar 2016 22:51:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Mar 2016 22:50:53 -0400
Content-Disposition: inline
In-Reply-To: <20160314023545.GA19753@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288764>

On Sun, Mar 13, 2016 at 10:35:45PM -0400, Jeff King wrote:

> Like (this is back on the "we resolved as master" version of my example,
> to illustrate how the merge is shown):
> 
>   $ git log --first-parent -m --numstat --oneline
>   4244c8a resolved
>   1       1       file
>   b9bbaf9 side
>   1       0       file
>   09037ef base
>   1       0       file

You'd probably want --reverse, of course, since the point is to build up
the count in the same order as time flows.

So this is the working version I came up with:

    git log --reverse --first-parent -m --format=%ct --numstat |
    perl -lne '
      if (/^\d+$/) {
              if (defined $time) {
                      print "$time $total"
              }
              $time = $&;
      } elsif (/^(\d+)\s+(\d+)\s/) {
              $total += $1 - $2;
      }
      END {
        # flush last entry
        print "$time $total";
      }
    '

For my git.git repo, the final line it produces is:

    1457666843 789457

which should be the final sloc-count right now.  If I count the lines in
the lines in HEAD, it's close but not quite the same:

   $ git ls-tree -r HEAD |
     awk '{print $3}' |
     xargs -n1 git cat-file blob |
     wc -l
   790437

I'd guess that the difference comes from a few files which are treated
as binary (and thus get "-" in their numstat output, but happen to have
newlines which cause "wc" to increment its count).

-Peff

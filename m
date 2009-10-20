From: Jeff King <peff@peff.net>
Subject: Re: Which dates 'git log --since= --after=' compare?
Date: Tue, 20 Oct 2009 04:37:03 -0400
Message-ID: <20091020083703.GA14740@coredump.intra.peff.net>
References: <4c067ee1.a34185.4adc390d.a980c@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Tue Oct 20 10:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ADU-0000YV-3O
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 10:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbZJTIhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbZJTIhE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 04:37:04 -0400
Received: from peff.net ([208.65.91.99]:53488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbZJTIhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 04:37:03 -0400
Received: (qmail 23752 invoked by uid 107); 20 Oct 2009 08:40:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Oct 2009 04:40:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Oct 2009 04:37:03 -0400
Content-Disposition: inline
In-Reply-To: <4c067ee1.a34185.4adc390d.a980c@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130773>

On Mon, Oct 19, 2009 at 12:01:49PM +0200, Daniel wrote:

> I can see that 'git log --since= --after=' compares commit's dates,
> not author's dates.How can I limit commits by Author's date?

AFAIK, there is currently no way to do it with a simple option. In fact,
we don't even parse the author date when doing revision limiting.

So it would need a patch, but the "obvious" solution of just parsing and
storing the author date in a "struct commit" might not be acceptable; as
I recall, some performance tuning went into keeping the per-commit
memory footprint as small as possible, which had a noticeable speed
benefit (I'm not saying it couldn't be done, but care needs to be taken
in that regard).

If it's not something you need to do often, I'd consider something like:

  git log --format='%H %at' |
    perl -ane '
      BEGIN {
        use DateTime::Format::Natural;
        $max_age = DateTime::Format::Natural->new->parse_datetime(
                      "last friday"
                   )->epoch;
      }
      print $F[0], "\n" if $F[1] < $max_age;
  '

Of course that's awful to type, and it will be much slower than git
doing the revision limiting itself.

-Peff

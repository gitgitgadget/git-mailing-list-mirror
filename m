From: Alex Vandiver <alex@chmrr.net>
Subject: Re: git-config: case insensitivity for subsections
Date: Mon, 29 Aug 2011 12:47:46 -0400
Message-ID: <1314636466.17526.16.camel@umgah.localdomain>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
	 <20110825205849.GA10384@sigill.intra.peff.net>
	 <20110825215757.GA94231@hal.rescomp.berkeley.edu>
	 <1314579031.10094.19.camel@umgah.localdomain>
	 <20110829054240.GB94231@hal.rescomp.berkeley.edu>
	 <20110829155819.GA756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: milki <milki@rescomp.berkeley.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy50E-0001YR-2Z
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1H2Qr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:47:57 -0400
Received: from chmrr.net ([209.67.253.66]:34546 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753595Ab1H2Qr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:47:57 -0400
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.64])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1Qy503-0008ST-Vj; Mon, 29 Aug 2011 12:47:55 -0400
In-Reply-To: <20110829155819.GA756@sigill.intra.peff.net>
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2011-08-29 12:47:55
X-Connected-IP: 75.147.59.54:45000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180320>

On Mon, 2011-08-29 at 11:58 -0400, Jeff King wrote:
> Isn't his config somewhat broken?  It looks like this:
> 
>   last = "!f(){ since="$1"; shift; git lg --since=\"last $since\" "$@"; }; f"
> 
> Those interior double-quotes should all be backslash-escaped. I didn't
> check, but git should interpret this as:
> 
>   !f(){ since=$1; shift; git lg --since="last $since" $@; }; f
> 
> which is probably not quite what he wanted (the quotes around $1 were
> actually superfluous, but the ones around $@ are important).

Yes, those should be escaped to do what he probably intends.
Nonetheless, certainly a parsing bug.

> That being said, I think it is intentional that the value is not just "a
> single double-quoted chunk" but rather could consist of several quoted
> (or unquoted) chunks concatenated together. What does your parser think
> of:
> 
>   [foo]
>     bar = "foo"bar"baz"
> 
> It should be:
> 
>   $ git config foo.bar
>   foobarbaz

And with the below patch to config-gitlike, it does -- thanks for the
bug report.
 - Alex

--------8<-----------
From 433dcc2f739c8906c65329a899b45424c146535c Mon Sep 17 00:00:00 2001
From: Alex Vandiver <alexmv@bestpractical.com>
Date: Mon, 29 Aug 2011 12:04:37 -0400
Subject: [PATCH] Allow quoted strings to adjoin directly to unquoted strings

This resolves a bug wherein:

    [foo]
        bar = "foo"bar"baz"

...was incorrectly parsed as << foo.bar=foobar"baz" >> and not the
correct << foo.bar=foobarbaz >>.  Make the fall-through value not
consume quotes when consuming a token, as it should be instead parsed as
the start of a quoted-value.  This bug was only evident when the quoted
value abutted the unquoted value with no separating space.
---
 lib/Config/GitLike.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Config/GitLike.pm b/lib/Config/GitLike.pm
index c19911e..8a7195b 100644
--- a/lib/Config/GitLike.pm
+++ b/lib/Config/GitLike.pm
@@ -333,7 +333,7 @@ sub parse_content {
                     $value .= $v;
                 }
                 # valid value (no escape codes)
-                elsif ($c =~ s/\A([^\t \\\n]+)//im) {
+                elsif ($c =~ s/\A([^\t \\\n"]+)//im) {
                     $value .= $1;
                 # unparseable
                 }
-- 
1.7.4.1

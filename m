From: Jeff King <peff@peff.net>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 3 Mar 2010 15:42:57 -0500
Message-ID: <20100303204257.GA5501@coredump.intra.peff.net>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 21:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvPY-00071R-6X
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0CCUnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:43:00 -0500
Received: from peff.net ([208.65.91.99]:53335 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab0CCUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:42:59 -0500
Received: (qmail 15304 invoked by uid 107); 3 Mar 2010 20:43:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Mar 2010 15:43:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Mar 2010 15:42:57 -0500
Content-Disposition: inline
In-Reply-To: <7vhboxno38.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141477>

On Wed, Mar 03, 2010 at 12:32:11PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I did see it on my debian unstable box with with dash as /bin/sh (though
> 
> 3deea89 (submodule summary: Don't barf when invoked in an empty repo,
> 2010-02-16) looks broken.  It shifts $1 unconditionally when:

Yeah, I can confirm that the breakage was introduced there (and it looks
like for bash, an extra "shift" is a failing command but doesn't make
the shell barf, but for dash it is more serious, which explains why
tests passed for you).

>  - "git submodule summary", no arguments given and defaults to HEAD which
>    is _not_ unborn (we shouldn't shift in this case);

Yes, definitely a bug.

>  - "git submodule summary HEAD path...", which is not unborn (we should shift);

Yes, and I think we do that part right.

>  - "git submodule summary path...", defaults to HEAD which is _not_ unborn
>    (we shouldn't shift).

I don't think this is a problem. We do:

  git rev-parse -q --verify --default HEAD path

and it correctly reports failure, so we never do the problematic shift.

So I think we just need

diff --git a/git-submodule.sh b/git-submodule.sh
index 1ea4143..bf5ea50 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -556,7 +556,7 @@ cmd_summary() {
 	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
 	then
 		head=$rev
-		shift
+		test -n "$1" && shift
 	elif test -z "$1" -o "$1" = "HEAD"
 	then
 		return

-Peff

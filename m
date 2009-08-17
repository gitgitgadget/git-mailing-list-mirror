Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 28797 invoked by uid 107); 17 Aug 2009 06:48:21 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 17 Aug 2009 02:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbZHQGsD (ORCPT <rfc822;peff@peff.net>);
	Mon, 17 Aug 2009 02:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882AbZHQGsC
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:48:02 -0400
Received: from peff.net ([208.65.91.99]:55400 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbZHQGsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:48:01 -0400
Received: (qmail 28790 invoked by uid 107); 17 Aug 2009 06:48:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 17 Aug 2009 02:48:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2009 02:48:02 -0400
Date:	Mon, 17 Aug 2009 02:48:02 -0400
From:	Jeff King <peff@peff.net>
To:	Mike Galbraith <efault@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
Subject: Re: How to stop sharing objects between repositories
Message-ID: <20090817064801.GA31543@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
 <1250475682.7155.16.camel@marge.simson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1250475682.7155.16.camel@marge.simson.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 17, 2009 at 04:21:22AM +0200, Mike Galbraith wrote:

> >  (1) Such a user does not necessarily know a casual "git repack -a" breaks
> >      the dependency, defeating the -s option s/he deliberately used in
> >      order to save disk space in the first place.  Perhaps we can reword
> >      this further to kill two penguins with a single stone?
> 
> Perhaps a runtime warning that you're about to break it?  This user may
> not even be the one who set the thing up, no?

I'm not really sure what such a setup would look like. If it is a big
hosting site like kernel.org or repo.or.cz, then probably it wouldn't
matter much. The admins there should probably be running "git repack -l
-d -A" periodically to consolidate the object stores (which can happen
from this sort of repacking, or from people just pushing the same
commits to their repos).

That being said, I can see there being setups where such a warning might
be useful. However, we don't really know if the user _wants_ that
effect, or if it is an accident. So people following the recommnded
"here is how you break the dependency" advice will also get the warning.

I'm torn on whether this is actually a good idea.

-- >8 --
Subject: [PATCH] repack: warn when "-l" is not used with alternates

Failing to use "-l" means that we will copy objects from the
source repository, nullifying the usefulness of "-s". We
don't want to make this an error, though, since "git repack
-a" is used to intentionally break the dependency.

Signed-off-by: Jeff King <peff@peff.net>
---
Is "test -s" portable? It's in POSIX, but I have some lingering doubt in
the back of my mind.

A user seeing such a warning can perhaps ^C to abort the pack. However,
should we also give instructions on how to undo the copying (which
should be "git repack -d -l -A")?

 git-repack.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..0bdc6e9 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -44,6 +44,15 @@ do
 	shift
 done
 
+if test -z "$local" && test -s "$GIT_DIR/objects/info/alternates"; then
+cat >&2 <<'EOF'
+warning: this repository uses objects from other repositories via the
+warning: "alternates" mechanism; repacking without "-l" will cause objects
+warning: to be copied into this repository, wasting disk space.
+
+EOF
+fi
+
 case "`git config --bool repack.usedeltabaseoffset || echo true`" in
 true)
 	extra="$extra --delta-base-offset" ;;
-- 
1.6.4.283.ga2765.dirty


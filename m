From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] fetch-pack: sort incoming heads
Date: Thu, 24 May 2012 02:04:51 -0400
Message-ID: <20120524060451.GA13502@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521221702.GA22914@sigill.intra.peff.net>
 <7v7gw43rn9.fsf@alter.siamese.dyndns.org>
 <20120522202336.GA31231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 08:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXRAQ-0008H3-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 08:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab2EXGEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 02:04:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53419
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab2EXGEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 02:04:53 -0400
Received: (qmail 24518 invoked by uid 107); 24 May 2012 06:05:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 02:05:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 02:04:51 -0400
Content-Disposition: inline
In-Reply-To: <20120522202336.GA31231@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198356>

On Tue, May 22, 2012 at 04:23:36PM -0400, Jeff King wrote:

> On Tue, May 22, 2012 at 01:08:42PM -0700, Junio C Hamano wrote:
> 
> > > @@ -1076,6 +1081,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
> > >  			st.st_mtime = 0;
> > >  	}
> > >  
> > > +	qsort(heads, nr_heads, sizeof(*heads), compare_heads);
> > > +
> > >  	if (heads && nr_heads)
> > >  		nr_heads = remove_duplicates(nr_heads, heads);
> > 
> > Hrm, could heads and/or nr_heads be NULL/0 here when we try to run qsort()
> > in this codepath?
> [...]
> A sane qsort would see that its second parameter is 0 and never try to
> dereference the array. But I'm not sure all qsort implementations we
> will see are sane, so it's probably better to protect it by putting it
> inside the conditional block just below.

I eye-balled what you queued in pu, and I wonder if you mis-read my
"just below" as "just below the existing line in the conditional" and
not "in the conditional that is just below the code we are talking
about".

I think we need this on top (or squashed in, but it looks like it is
already in next):

-- >8 --
Subject: fetch-pack: sort incoming heads list earlier

Commit 4435968 started sorting heads fed to fetch-pack so
that later commits could use more optimized algorithms;
commit 7db8d53 switched the remove_duplicates function to
such an algorithm.

Of course, the sorting is more effective if you do it
_before_ the algorithm in question.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect that all parts of git feed the refs in sorted order already,
which is why there were no test failures. But we should handle arbitrary
order from the command-line.

 builtin/fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 8a72473..b18ba05 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1082,8 +1082,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	}
 
 	if (heads && nr_heads) {
-		nr_heads = remove_duplicates(nr_heads, heads);
 		qsort(heads, nr_heads, sizeof(*heads), compare_heads);
+		nr_heads = remove_duplicates(nr_heads, heads);
 	}
 
 	if (!ref) {
-- 
1.7.10.1.25.g7031a0f

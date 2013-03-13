From: Jeff King <peff@peff.net>
Subject: Re: Tag peeling peculiarities
Date: Wed, 13 Mar 2013 17:58:00 -0400
Message-ID: <20130313215800.GA23838@sigill.intra.peff.net>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 22:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFtgu-0002hj-3b
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 22:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325Ab3CMV6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 17:58:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51155 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933283Ab3CMV6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 17:58:03 -0400
Received: (qmail 8334 invoked by uid 107); 13 Mar 2013 21:59:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Mar 2013 17:59:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2013 17:58:00 -0400
Content-Disposition: inline
In-Reply-To: <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218094>

On Wed, Mar 13, 2013 at 10:29:54AM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > It is not
> > clear to me whether the prohibition of tags outside of refs/tags should
> > be made more airtight or whether the peeling of tags outside of
> > refs/tags should be fixed.
> 
> Retroactively forbidding presense/creation of tags outside the
> designated refs/tags hierarchy will not fly.  I think we should peel
> them when we are reading from "# pack-refs with: peeled" version.
> 
> Theoretically, we could introduce "# pack-refs with: fully-peeled"
> that records peeled versions for _all_ annotated tags even in
> unusual places, but that would be introducing problems to existing
> versions of the software to cater to use cases that is not blessed
> officially, so I doubt it has much value.

I agree. The REF_KNOWS_PEELED thing is an optimization, so it's OK to
simply omit the optimization in the corner case, since we don't expect
it to happen often. So what happens now is a bug, but it is a bug in the
reader that mis-applies the optimization, and we can just fix the
reader.

I do not think there is any point in peeling while we are reading the
pack-refs file; it is no more expensive to do so later, and in most
cases we will not even bother peeling. We should simply omit the
REF_KNOWS_PEELED bit so that later calls to peel_ref do not follow the
optimization code path. Something like this:

diff --git a/refs.c b/refs.c
index 175b9fc..ee498c8 100644
--- a/refs.c
+++ b/refs.c
@@ -824,7 +824,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, flag, 1);
+			int this_flag = flag;
+			if (prefixcmp(refname, "refs/tags/"))
+				this_flag &= ~REF_KNOWS_PEELED;
+			last = create_ref_entry(refname, sha1, this_flag, 1);
 			add_ref(dir, last);
 			continue;
 		}

I think with this patch, though, that upload-pack would end up having to
read the object type of everything under refs/heads to decide whether it
needs to be peeled (and in most cases, it does not, making the initial
ref advertisement potentially much more expensive). How do we want to
handle that? Should we teach upload-pack not to bother advertising peels
outside of refs/tags? That would break people who expect tag
auto-following to work for refs outside of refs/tags, but I am not sure
that is a sane thing to expect.

-Peff

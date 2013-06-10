From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sort-in-topological-order: use commit-queue
Date: Mon, 10 Jun 2013 01:31:00 -0400
Message-ID: <20130610053059.GE3621@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-4-git-send-email-gitster@pobox.com>
 <7vehcan9e0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UluhQ-00053G-FH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124Ab3FJFbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 01:31:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41855 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab3FJFbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:31:04 -0400
Received: (qmail 19907 invoked by uid 102); 10 Jun 2013 05:31:53 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 00:31:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 01:31:00 -0400
Content-Disposition: inline
In-Reply-To: <7vehcan9e0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227239>

On Sun, Jun 09, 2013 at 04:37:27PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Use the commit-queue data structure to implement a priority queue
> > of commits sorted by committer date, when handling --date-order.
> > The commit-queue structure can also be used as a simple LIFO stack,
> > which is a good match for --topo-order processing.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  commit-queue.c | 13 +++++++++++
> >  commit-queue.h |  3 +++
> >  commit.c       | 74 ++++++++++++++++++++++++++++++++++------------=
------------
> >  3 files changed, 59 insertions(+), 31 deletions(-)
>=20
> Peff, I think you were the one who did a priority queue previously,
> primarily for performance.  The primary reason for this round was so
> that I didn't have to touch the revision.c and struct commit in
> order to sort by keys in commit-info-slabs and I was not aiming for
> performance but a quick and rough benchmarking seems to indicate
> that
>=20
>  - for a small repository like git.git, there is not much difference
>    in runtime;
>=20
>  - but it does seem to cut down the memory pressure (less minor
>    faults).
>=20
> Representative runs of "rev-list --date-order v0.99..v1.8.3" on my
> box with 'master' and with these patches spend 0.47user/0.04system
> with 0.50elapsed (no time change), with 13450 vs 13108 minor faults
> (smaller memory use).

The performance enhancement of the priority queue came from replacing
"commit_list_insert_by_date" calls with insertion into a queue. That
drops O(n^2) behavior on the linked-list down to O(n log n), as we have
"n" insertions, each causing an O(log n) heapify operation.

Around the same time, though, Ren=C3=A9 wrote the linked-list merge sor=
t that
powers commit_list_sort_by_date. And topo-sort learned to do O(1)
insertions into the unsorted list, and then one O(n log n) sort.

So your results are exactly what I would expect: the time should be
about the same (due to the same complexity), but the memory is used mor=
e
compactly (array of pointers instead of linked list of pointers).

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sort-in-topological-order: use commit-queue
Date: Mon, 10 Jun 2013 14:24:41 -0400
Message-ID: <20130610182441.GB2084@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-4-git-send-email-gitster@pobox.com>
 <7vehcan9e0.fsf@alter.siamese.dyndns.org>
 <20130610053059.GE3621@sigill.intra.peff.net>
 <7vsj0ql924.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6lv-0005Qe-4r
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab3FJSYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 14:24:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:47089 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3FJSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:24:45 -0400
Received: (qmail 24028 invoked by uid 102); 10 Jun 2013 18:25:36 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 13:25:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 14:24:41 -0400
Content-Disposition: inline
In-Reply-To: <7vsj0ql924.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227341>

On Mon, Jun 10, 2013 at 12:27:31AM -0700, Junio C Hamano wrote:

> > Around the same time, though, Ren=C3=A9 wrote the linked-list merge=
 sort that
> > powers commit_list_sort_by_date. And topo-sort learned to do O(1)
> > insertions into the unsorted list, and then one O(n log n) sort.
>=20
> Yes, but that only affects the "sort the work queue in date order"
> before entering the main loop, and maintenance of work queue as we
> dig along still is "find the place to put this in the date-order
> sorted linked list", no?

Ah, you're right. I was thinking that we saw all of the commits up
front and then sorted. And we do, but we still keep a separate list in
the work queue.

So I think it may just be the case that "N" does not get very big here
(the width of the graph), so log(N) versus (N) does not make a big
difference.

> I've been disturbed every time I saw the commit_list insertion
> function that does a small allocation which will be freed fairly
> often and have been wondering if we can rewrite it with custom slab
> allocator, but not using linked list where we do not have to feels
> like a better solution to that issue, and use of pqueue may be a
> right direction to go in.

Agreed. The only thing I'd worry about is that somebody cares about the
order stability of same-time commits in the output. But I cannot think
of a case where it is important (especially because the timestamps are
subject to minor skew anyway, so it is not like you could even count on
particular commits having equivalent timestamps).

-Peff

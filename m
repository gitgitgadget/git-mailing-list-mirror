From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] implement generic key/value map
Date: Mon, 6 Aug 2012 16:35:58 -0400
Message-ID: <20120806203558.GB11977@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
 <20120804171038.GA19378@sigill.intra.peff.net>
 <7vehnm8dbv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:36:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyU25-0006UR-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 22:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab2HFUgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 16:36:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53687 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974Ab2HFUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 16:36:01 -0400
Received: (qmail 19250 invoked by uid 107); 6 Aug 2012 20:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 16:36:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 16:35:58 -0400
Content-Disposition: inline
In-Reply-To: <7vehnm8dbv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202985>

On Sat, Aug 04, 2012 at 03:58:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It is frequently useful to have a fast, generic data
> > structure mapping keys to values. We already have something
> > like this in the "decorate" API, but it has two downsides:
> >
> >   1. The key type must always be a "struct object *".
> >
> >   2. The value type is a void pointer, which means it is
> >      inefficient and cumbersome for storing small values.
> >      One must either encode their value inside the void
> >      pointer, or allocate additional storage for the pointer
> >      to point to.
> >
> > This patch introduces a generic map data structure, mapping
> > keys of arbitrary type to values of arbitrary type.
> 
> Does the type of keys in a map have to be of the same size, or can a
> key of a type with variable size (e.g. struct with a flex member at
> the end)?  Same question for the type of values.

Both have to be fixed size, since we represent the hash table using an
array. But there is nothing stopping you from storing a fixed-size
pointer to a variable-sized item (that is what is happening with "struct
object *", anyway; the actual storage is inside a "struct commit",
"struct tree", etc). But then you get the accompanying memory-management
issues (which are easy for "struct object", as our policy is to keep a
global valid-until-the-program-exits store of all objects we ever see).

> Is the type of keys in a map required to have a total order over it,
> or is it suffice only to have equality defined?

No, you only have to define equality. However, for the later patch which
adds a persistent backing store, you need to be able to serialize keys
to a byte representation, which provides an implicit total order (by
sorting the bytes).

> The latter might matter once we start talking about a huge map that
> we may not want to hold in-core.

Right. See patch 5/8.

-Peff

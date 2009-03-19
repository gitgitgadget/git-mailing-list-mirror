From: Jeff King <peff@peff.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 16:03:08 -0400
Message-ID: <20090319200308.GB17028@coredump.intra.peff.net>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net> <alpine.DEB.1.00.0903191135530.10279@pacific.mpi-cbg.de> <7vhc1pai84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:07:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOVu-00019D-EY
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760102AbZCSUDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759918AbZCSUDU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:03:20 -0400
Received: from peff.net ([208.65.91.99]:50859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759781AbZCSUDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:03:19 -0400
Received: (qmail 3155 invoked by uid 107); 19 Mar 2009 20:03:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 16:03:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 16:03:08 -0400
Content-Disposition: inline
In-Reply-To: <7vhc1pai84.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113818>

On Thu, Mar 19, 2009 at 04:02:19AM -0700, Junio C Hamano wrote:

> > Do we really want an API for that?  Calling qsort() directly should be 
> > obvious enough, no?
> 
> I think so.  If it were done like this (notice the lack of double
> indirection in the cmp_fn signature):
> 
>     typedef int string_list_item_cmp_fn(const struct string_list_item *, const struct string_list_item *);
> 
>     void sort_string_list_with_fn(struct string_list *list, string_list_item_cmp_fn *);
> 
> it would have made more sense, though.

IIRC, that is actually not valid C according to the standard (that is,
even though a void* can be implicitly assigned to any other pointer, a
function taking a void* and a function taking another pointer do not
necessarily have the same function signature or calling conventions).
Which is why cmp_items in string-list.c already does the indirection.

That being said, I think this is probably one of those cases where it
works fine on any sane platform that we care about and we can choose to
ignore the standard.

Actually, I think an even nicer API would be to give a function that
_just_ compares the util fields; string_list_sort() would sort on the
"string" fields, and only call the util cmp to sort entries with equal
strings. Sadly, because qsort lacks a slot for extra data to pass to the
callback, implementing this ends up with a global variable:

  static int (*cmp_util)(const void *, const void *);

  int cmp_items(const void *a, const void *b)
  {
    const struct string_list_item *one = a;
    const struct string_list_item *two = b;
    int cmp = strcmp(one->string, two->string);
    return cmp ? cmp : cmp_util(one->util, b->util);
  }

  int sort_string_list_with_util(struct string_list *list,
                       int (*fn)(const void *, const void *))
  {
    cmp_util = fn;
    qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
  }

If only C had closures. ;)

But this is really getting beyond the issue at hand. I can submit a
finalized patch; just let me know how you prefer it.

-Peff

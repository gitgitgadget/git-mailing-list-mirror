From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Sat, 6 Dec 2014 00:27:52 -0500
Message-ID: <20141206052752.GD31301@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 06:27:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx7uR-0006IT-4s
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 06:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbaLFF1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 00:27:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:49299 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751224AbaLFF1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 00:27:53 -0500
Received: (qmail 6069 invoked by uid 102); 6 Dec 2014 05:27:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 23:27:53 -0600
Received: (qmail 9509 invoked by uid 107); 6 Dec 2014 05:27:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 00:27:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 00:27:52 -0500
Content-Disposition: inline
In-Reply-To: <20141206020458.GR16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260937>

On Fri, Dec 05, 2014 at 06:04:58PM -0800, Jonathan Nieder wrote:

> That reminds me: why do we call this string_list_clear instead of
> string_list_free?

Because it does not free the struct itself, and because you can then use
the result again. I think we try to draw a distinction between:

  /* Free resources, but do not reinitialize! */
  void string_list_free_data(struct string_list *s)
  {
	int i;
	for (i = 0; i < s->nr; i++)
		free(s->items[i].string);
	free(s->items[i];
  }

  /* Free resources, and go back to initialized but empty state */
  void string_list_clear(struct string_list *s)
  {
	string_list_free_data(s);
	s->nr = s->alloc = 0;
	s->items = NULL;
  }

  /* Free all resources from dynamically allocated structure */
  void string_list_free(struct string_list *s)
  {
	string_list_clear(s);
	free(s);
  }

Ideally we use consistent names to distinguish between them. We are not
always consistent, though (probably strbuf_release should be called
strbuf_clear for consistency). But I think we are fairly consistent that
"_free()" means "...and free the pointer, too".

In general, we try to avoid the first as a public interface (because it
is error-prone when somebody tries to reuse the list, and the extra work
of zero-ing the pointer is not enough to care about).

We also tend to avoid the third, because it is quite often not the
business of the object whether it was dynamically constructed or not
(exceptions tend to be node-oriented structures like linked lists and
trees; c.f. cache_tree and commit_list).

Maybe that should go into CodingGuidelines? It's not really style,
exactly, but it is convention.

-Peff

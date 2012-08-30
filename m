From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 23:36:11 -0400
Message-ID: <20120830033611.GA32268@sigill.intra.peff.net>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <7vligxuv6l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 05:37:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vZ1-0005kU-8n
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2H3DgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:36:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47649 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356Ab2H3DgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:36:17 -0400
Received: (qmail 4995 invoked by uid 107); 30 Aug 2012 03:36:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Aug 2012 23:36:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2012 23:36:11 -0400
Content-Disposition: inline
In-Reply-To: <7vligxuv6l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204508>

On Wed, Aug 29, 2012 at 04:37:06PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Note that this is fairly expensive (see NEEDSWORK comment in the
> > code).
> 
> And this is with the "notes-cache".
> [...]
> +static int get_tip_weight(struct commit *commit)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t sz;
> +	int weight;
> +	char *note = notes_cache_get(&weight_cache, commit->object.sha1, &sz);
> +
> +	if (note && !strtol_i(note, 10, &weight)) {
> +		free(note);
> +		return weight;
> +	}
> +	free(note);
> +
> +	weight = compute_tip_weight(commit);
> +	strbuf_addf(&buf, "%d", weight);
> +	notes_cache_put(&weight_cache, commit->object.sha1,
> +			buf.buf, buf.len);
> +	strbuf_release(&buf);
> +	weight_cache_updated = 1;
> +	return weight;
> +}

It looks like you didn't update compute_tip_weight at all, so it will
still do the full traversal down to the roots. I wonder if you can
define the weight as a recursive function of the parents. Using the sum
of the weights of the parents is not right, because you would
double-count in this situation:

  A--B--C--D---M
      \       /
       E--F--G

That would double-count "A" and "B" in this example. But maybe there is
a clever way to define it that avoids that.

The advantage would be that you could cheaply find the weights of new
commits by only traversing back to the last cached one. I did something
similar with the generation number cache (but the recursive definition
is easier there).

> +	if (use_weight)
> +		notes_cache_init(&weight_cache, "name-rev-weight", "2012-08-29");

Is that a sufficient validity field? What about grafts or replace
objects? For the generation cache, I used a hash of the graft and
replace fields.

-Peff

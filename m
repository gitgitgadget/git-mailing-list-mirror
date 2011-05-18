From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/11] streaming: a new API to read from the object store
Date: Wed, 18 May 2011 04:09:47 -0400
Message-ID: <20110518080947.GE27482@sigill.intra.peff.net>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 10:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMbpN-0000R4-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab1ERIJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:09:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50268
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab1ERIJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:09:49 -0400
Received: (qmail 2964 invoked by uid 107); 18 May 2011 08:11:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 04:11:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 04:09:47 -0400
Content-Disposition: inline
In-Reply-To: <1305505831-31587-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173856>

On Sun, May 15, 2011 at 05:30:26PM -0700, Junio C Hamano wrote:

> +struct git_istream *open_istream(const unsigned char *sha1,
> +				 enum object_type *type,
> +				 unsigned long *sz)
> +{
> +	struct git_istream *st;
> +	struct object_info oi;
> +	const unsigned char *real = lookup_replace_object(sha1);
> +	enum input_source src = istream_source(real, type, &oi);
> +
> +	if (src < 0)
> +		return NULL;
> +
> +	st = xmalloc(sizeof(*st));
> +	st->source = src;
> +	if (open_istream_tbl[src](st, &oi, real, type, sz)) {
> +		if (open_istream_incore(st, &oi, real, type, sz)) {
> +			free(st);
> +			st = NULL;
> +		}
> +	}
> +	return st;
> +}

I assume the "sz" parameter is meant to be an output parameter with the
total size of the object. The open_istream_incore function fills it in
properly. But later, when you add open_istream_loose and
open_istream_pack_non_delta, neither of them actually touches the "sz"
parameter at all. So code like:

  struct git_istream *st;
  enum object_type type;
  unsigned long size;
  st = open_istream(sha1, &type, &size);

may or may not have "size" meaningful at this point, which seems like a
bug.

-Peff

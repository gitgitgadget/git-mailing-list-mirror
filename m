From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Sun, 5 Feb 2012 19:04:21 -0500
Message-ID: <20120206000420.GC28735@sigill.intra.peff.net>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 01:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuC4S-000512-1C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 01:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab2BFAEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 19:04:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58456
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003Ab2BFAEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 19:04:23 -0500
Received: (qmail 20847 invoked by uid 107); 6 Feb 2012 00:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 19:11:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 19:04:21 -0500
Content-Disposition: inline
In-Reply-To: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189988>

On Sun, Feb 05, 2012 at 02:28:07PM -0800, Tom Grennan wrote:

> This filters the list for annotated|signed tags of the given object.
> Example,
> 
>    john$ git tag -s v1.0-john v1.0
>    john$ git tag -l --points-at v1.0
>    v1.0-john

I really like this approach. One big question, and a few small comments:

> +--points-at <object>::
> +	Only list annotated or signed tags of the given object.
> +

It is unclear to me from this documentation if we will only peel a
single level, or if we will peel indefinitely. E.g., what will this
show:

  $ git tag one v1.0
  $ git tag two one
  $ git tag --points-at=v1.0

It will clearly show "one", but will it also show "two" (from reading
the code, I think the answer is "no")? If not, should it?

> +		buf = read_sha1_file(sha1, &type, &size);
> +		if (!buf || !size)
> +			return 0;

Before your patch, a tag whose sha1 could not be read would get its name
printed, and then we would later return without printing anything more.
Now it won't get even the first bit printed.

However, I'm not sure the old behavior wasn't buggy; it would print part
of the line, but never actually print the newline.

> +		if (filter->points_at) {
> +			unsigned char tagged_sha1[20];
> +			if (memcmp("object ", buf, 7) \
> +			    || buf[47] != '\n' \
> +			    || get_sha1_hex(buf + 7, tagged_sha1) \
> +			    || memcmp(filter->points_at, tagged_sha1, 20)) {
> +				free(buf);
> +				return 0;
> +			}
> +		}

Hmm, I would have expected to use parse_tag_buffer instead of doing it
by hand. This is probably a tiny bit more efficient, but I wonder if the
code complexity is worth it.

>  static int list_tags(const char **patterns, int lines,
> -			struct commit_list *with_commit)
> +			struct commit_list *with_commit,
> +			unsigned char *points_at)

Like Junio, I was surprised this did not allow a list.

-Peff

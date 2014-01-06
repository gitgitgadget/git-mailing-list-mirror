From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 15:38:47 -0500
Message-ID: <20140106203847.GA643@sigill.intra.peff.net>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
 <20140106145723.GA15489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Maurer <bmaurer@fb.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:38:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Gwn-0007r2-AX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbaAFUit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:38:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:56088 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755814AbaAFUit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:38:49 -0500
Received: (qmail 16977 invoked by uid 102); 6 Jan 2014 20:38:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 14:38:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 15:38:47 -0500
Content-Disposition: inline
In-Reply-To: <20140106145723.GA15489@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240060>

On Mon, Jan 06, 2014 at 09:57:23AM -0500, Jeff King wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..0cff874 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1402,6 +1402,19 @@ static void check_object(struct object_entry *entry)
>  			base_entry->delta_child = entry;
>  			unuse_pack(&w_curs);
>  			return;
> +		} else if(base_ref && bitmap_have(base_ref)) {
> +			entry->type = entry->in_pack_type;
> +			entry->delta_size = entry->size;
> +			/*
> +			 * XXX we'll leak this, but it's probably OK
> +			 * since we'll exit immediately after the packing
> +			 * is done
> +			 */
> +			entry->delta = xcalloc(1, sizeof(*entry->delta));
> +			hashcpy(entry->delta->idx.sha1, base_ref);
> +			entry->delta->preferred_base = 1;
> +			unuse_pack(&w_curs);
> +			return;
>  		}

Just reading over this again, the conditional here should obviously be
checking "thin" (which needs to become a global, as in your patch).

-Peff

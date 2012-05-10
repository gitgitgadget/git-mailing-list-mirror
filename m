From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] apply: fall back on three-way merge
Date: Thu, 10 May 2012 16:31:13 -0400
Message-ID: <20120510203113.GB18276@sigill.intra.peff.net>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
 <1336629745-22436-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSa1B-0004KP-2P
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab2EJUbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:31:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39136
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab2EJUbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:31:16 -0400
Received: (qmail 2694 invoked by uid 107); 10 May 2012 20:31:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 16:31:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 16:31:13 -0400
Content-Disposition: inline
In-Reply-To: <1336629745-22436-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197630>

On Wed, May 09, 2012 at 11:02:23PM -0700, Junio C Hamano wrote:

> +static int try_threeway_fallback(struct image *image, struct patch *patch,
> +				 struct stat *st, struct cache_entry *ce)
> +{
> +	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t len;
> +	char *img;
> +	struct image tmp_image;
> +
> +	/* No point falling back to 3-way merge in these cases */
> +	if (patch->is_binary || patch->is_new || patch->is_delete ||
> +	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
> +		return -1;

Is it true that there is no point in doing a 3-way fallback when
patch->is_binary? What if the user has a custom merge driver?
For that matter, a custom driver could handle additions or deletions,
too (e.g., for a sorted record-oriented file, merging two additions
might just mean collating the records).

It seems like we should just keep the logic here as stupid as possible,
try to setup the 3-way content, and then hand it off to the merge code
to try to make something happen. The only thing we have to lose is a
little bit of efficiency in setting up blobs that are unlikely to
actually get merged.

-Peff

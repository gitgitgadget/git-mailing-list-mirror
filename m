From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Mon, 19 May 2014 07:21:51 -0400
Message-ID: <20140519112151.GC17492@sigill.intra.peff.net>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 19 13:21:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmLdl-0007Ek-Tt
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 13:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbaESLVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 07:21:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:54954 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752756AbaESLVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 07:21:53 -0400
Received: (qmail 6052 invoked by uid 102); 19 May 2014 11:21:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 06:21:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 07:21:51 -0400
Content-Disposition: inline
In-Reply-To: <20140518182939.5260.91202.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249576>

On Sun, May 18, 2014 at 08:29:38PM +0200, Christian Couder wrote:

> +static int create_graft(int argc, const char **argv, int force)
> +{
> +	unsigned char old[20], new[20];
> +	const char *old_ref = argv[0];
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf new_parents = STRBUF_INIT;
> +	const char *parent_start, *parent_end;
> +	int i;
> +
> +	if (get_sha1(old_ref, old) < 0)
> +		die(_("Not a valid object name: '%s'"), old_ref);
> +	lookup_commit_or_die(old, old_ref);
> +	if (read_sha1_commit(old, &buf))
> +		die(_("Invalid commit: '%s'"), old_ref);

Do we want to peel to commits here? That is, should:

  git replace --graft v1.5.0 v1.4.0

work? On the one hand, I see it as friendly. On the other, it may be a
bit surprising when working with something as potentially dangerous a
replace refs. If we don't do it automatically, the user can still say
"v1.5.0^{commit}" to be explicit. I dunno; maybe I am being overly
paranoid.

> +	/* prepare new parents */
> +	for (i = 1; i < argc; i++) {
> +		unsigned char sha1[20];
> +		if (get_sha1(argv[i], sha1) < 0)
> +			die(_("Not a valid object name: '%s'"), argv[i]);
> +		lookup_commit_or_die(sha1, argv[i]);
> +		strbuf_addf(&new_parents, "parent %s\n", sha1_to_hex(sha1));
> +	}

Either way, I think _this_ peeling is a sane thing to do.

-Peff

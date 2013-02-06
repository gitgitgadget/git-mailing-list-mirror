From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed, 6 Feb 2013 17:06:44 -0500
Message-ID: <20130206220644.GB27507@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3D9h-0006Xn-EB
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156Ab3BFWHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:07:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37128 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758502Ab3BFWGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:06:47 -0500
Received: (qmail 10850 invoked by uid 107); 6 Feb 2013 22:08:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:08:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:06:44 -0500
Content-Disposition: inline
In-Reply-To: <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215648>

On Wed, Feb 06, 2013 at 04:08:50PM +0100, Michael J Gruber wrote:

> diff --git a/builtin/log.c b/builtin/log.c
> index 8f0b2e8..f83870d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -402,10 +402,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
>  	strbuf_release(&out);
>  }
>  
> -static int show_blob_object(const unsigned char *sha1, struct rev_info *rev)
> +static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)

Should this maybe just take the whole object_array_entry as a cleanup?

>  {
> +	unsigned char sha1c[20];
> +	struct object_context obj_context;
> +	char *buf;
> +	unsigned long size;
> +
>  	fflush(stdout);
> -	return stream_blob_to_fd(1, sha1, NULL, 0);
> +	if (!DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
> +		return stream_blob_to_fd(1, sha1, NULL, 0);
> +
> +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
> +		die("Not a valid object name %s", obj_name);

It seems a little hacky that we have to look up the sha1 again. What
should happen in the off chance that "hashcmp(sha1, sha1c) != 0" due to
a race with a simultaneous update of a ref?

Would it be better if object_array_entry replaced its "mode" member with
an object_context? The only downside I see is that we might waste a
significant amount of memory (each context has a PATH_MAX buffer in it).

-Peff

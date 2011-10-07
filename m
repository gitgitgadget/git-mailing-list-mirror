From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] fetch: treat --tags like refs/tags/*:refs/tags/*
 when pruning
Date: Fri, 7 Oct 2011 12:33:19 -0400
Message-ID: <20111007163319.GC4399@sigill.intra.peff.net>
References: <20111006205103.GA1271@erythro.kitwarein.com>
 <1317936107-1230-1-git-send-email-cmn@elego.de>
 <1317936107-1230-4-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Oct 07 18:33:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCDMW-0002ha-1Y
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 18:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760107Ab1JGQdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 12:33:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54997
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439Ab1JGQdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 12:33:22 -0400
Received: (qmail 23561 invoked by uid 107); 7 Oct 2011 16:33:22 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Oct 2011 12:33:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2011 12:33:19 -0400
Content-Disposition: inline
In-Reply-To: <1317936107-1230-4-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183085>

On Thu, Oct 06, 2011 at 11:21:47PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b937d71..94b2bd3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -699,8 +699,17 @@ static int do_fetch(struct transport *transport,
>  		free_refs(ref_map);
>  		return 1;
>  	}
> -	if (prune)
> +	if (prune) {
> +		/* If --tags was specified, we need to tell prune_refs
> +		 * that we're filtering the refs from the remote */
> +		if (tags =3D=3D TAGS_SET) {
> +			const char * tags_refspec =3D "refs/tags/*:refs/tags/*";
> +			refs =3D xrealloc(refs, (ref_count + 1) * sizeof(struct refspec))=
;
> +			refs[ref_count] =3D *parse_fetch_refspec(1, &tags_refspec);
> +			ref_count++;
> +		}
>  		prune_refs(transport, refs, ref_count, ref_map);
> +	}

I don't think we can realloc refs here. It's passed into do_fetch. When
we realloc it, the old pointer value will be invalid. But when we retur=
n
from do_fetch, the caller (fetch_one) will still have that old value,
and will call free() on it.

Instead, you have to make a whole new list, copy the old values in, add
your new one, and then free the result.

-Peff

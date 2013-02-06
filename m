From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/4] cat-file: do not die on --textconv without
 textconv filters
Date: Wed, 6 Feb 2013 17:19:12 -0500
Message-ID: <20130206221912.GD27507@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DLA-00082Z-1g
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab3BFWTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:19:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37147 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146Ab3BFWTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:19:16 -0500
Received: (qmail 11255 invoked by uid 107); 6 Feb 2013 22:20:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:20:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:19:12 -0500
Content-Disposition: inline
In-Reply-To: <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215652>

On Wed, Feb 06, 2013 at 04:08:51PM +0100, Michael J Gruber wrote:

> When a command is supposed to use textconv filters (by default or with
> "--textconv") and none are configured then the blob is output without
> conversion; the only exception to this rule is "cat-file --textconv".
> 
> Make it behave like the rest of textconv aware commands.

Makes sense.

> -		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> -			die("git cat-file --textconv: unable to run textconv on %s",
> -			    obj_name);
> -		break;
> +		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> +			break;

The implication here is that textconv_object should be handling its own
errors and dying, and the return is always "yes, I converted" or "no, I
did not". Which I think is the case.

> +
> +		/* otherwise expect a blob */
> +		exp_type = "blob";
>  
>  	case 0:
>  		if (type_from_string(exp_type) == OBJ_BLOB) {

I wondered at first why we needed to set exp_type here; shouldn't we
already be expecting a blob if we are doing textconv? But then I see
this is really about the fall-through in the switch (which we might want
an explicit comment for).

Which made me wonder: what happens with:

  git cat-file --textconv HEAD

It looks like we die just before textconv-ing, because we have no
obj_context.path. But that is also unlike all of the other --textconv
switches, which mean "turn on textconv if you are showing a blob that
supports it" and not "the specific operation is --textconv, apply it to
this blob". I don't know if that is worth changing or not.

-Peff

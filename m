From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 3/6] verify-commit: scriptable commit signature
 verification
Date: Fri, 13 Jun 2014 07:19:45 -0400
Message-ID: <20140613111945.GC14066@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <48984553eb1d9ac53dd4b9604af568e22c735109.1402655839.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvPWR-00021c-RF
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbaFMLTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:19:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:43389 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750788AbaFMLTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 07:19:47 -0400
Received: (qmail 21799 invoked by uid 102); 13 Jun 2014 11:19:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 06:19:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 07:19:45 -0400
Content-Disposition: inline
In-Reply-To: <48984553eb1d9ac53dd4b9604af568e22c735109.1402655839.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251547>

On Fri, Jun 13, 2014 at 12:42:45PM +0200, Michael J Gruber wrote:

> +
> +	free(signature_check.gpg_output);
> +	free(signature_check.gpg_status);
> +	free(signature_check.signer);
> +	free(signature_check.key);
> +	return signature_check.result != 'G';
> +}

How about .payload here?

> +	type = sha1_object_info(sha1, NULL);
> +	if (type != OBJ_COMMIT)
> +		return error("%s: cannot verify a non-commit object of type %s.",
> +				name, typename(type));
> +
> +	buf = read_sha1_file(sha1, &type, &size);
> +	if (!buf)
> +		return error("%s: unable to read file.", name);

I think you can drop the sha1_object_info call and just check "type"
from read_sha1_file (they _should_ agree, but if they do not, I'd rather
pay attention to the one that came along with the buffer). And this is
the uncommon error path, so expanding the object into memory before we
die is not a big deal.

Should this peel to a commit if given a tag? I'd say probably. I know
you raised the issue elsewhere of keeping things simple, but I think if
you are calling verify-commit, you know you want a commit, and we should
treat the argument as a commit-ish. Anyway, if you go that route, then
lookup_commit_or_die is probably what you want.

Also, minor nit, but we typically do not end the error messages with a
full stop (we've been rather inconsistent in the past, but these days
seem to mostly settle on no punctuation).

-Peff

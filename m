From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/4] cat-file: do not die on --textconv without
 textconv filters
Date: Wed, 06 Feb 2013 08:47:16 -0800
Message-ID: <7vr4ktmlt7.fsf@alter.siamese.dyndns.org>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
 <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U389v-00047Q-JM
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 17:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab3BFQrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 11:47:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab3BFQrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 11:47:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B4AAB750;
	Wed,  6 Feb 2013 11:47:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoJ4Ky6alU9IXUgP5X8VrrBD+HY=; b=l9TybM
	SKJtEIamdvLfjvZyFclTstPKdy0KxYIKfnrLICqaDRsO40I7y0GqwNNqKPMd05mc
	m5OhFY2F0lo+y3iCE7eo1qR8ywfWy9AMIBlEXvcSrVBmrLr+CHmRRH7fTrccfzJJ
	GkeiwzuTT0KCWxKnwqpmfw2qCMdBdSfIgUYlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NCdWgfj1YwnAGHVDTrSM8K2sH9v9Re6b
	9x7XXZC97ToquGrUkKYzmY42FBWygfActsiUW7DzG+EKmJrQ0r9rn1/URpomJm9s
	CJ5R3Vz/uaXrxXUp3pFnThvEo2hTyWalWc5fPV0dx4dLRByUMwYewfCJXM5dM42n
	TXf1xJcWxT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FEB4B74E;
	Wed,  6 Feb 2013 11:47:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CA40B74D; Wed,  6 Feb 2013
 11:47:18 -0500 (EST)
In-Reply-To: <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 6 Feb 2013 16:08:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE8BBF14-707C-11E2-B749-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215598>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When a command is supposed to use textconv filters (by default or with
> "--textconv") and none are configured then the blob is output without
> conversion; the only exception to this rule is "cat-file --textconv".

I am of two minds.  Because cat-file is mostly a low-level plumbing,
I do not necessarily think it is a bad behaviour for it to error out
when it was asked to apply textconv where there is no filter or when
the filter fails to produce an output.  On the other hand, it
certainly makes it more convenient for callers that do not care too
deeply, taking textconv as a mere hint just like Porcelains do.

>
> Make it behave like the rest of textconv aware commands.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/cat-file.c           |  9 +++++----
>  t/t8007-cat-file-textconv.sh | 20 +++++---------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 00528dd..6912dc2 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -146,10 +146,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  			die("git cat-file --textconv %s: <object> must be <sha1:path>",
>  			    obj_name);
>  
> -		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> -			die("git cat-file --textconv: unable to run textconv on %s",
> -			    obj_name);
> -		break;
> +		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> +			break;
> +
> +		/* otherwise expect a blob */
> +		exp_type = "blob";

Please use the constant string blob_type that is available for all
callers including this one.

But stepping back a bit.

What happens when I say "cat-file -c HEAD:Documentation", and what
should happen when I do so?

I think what we want to see in the ideal world might be:

 * If we have a textconv for tree objects at that path to format it
   specially, textconv_object() may be allowed to textualize it
   (even though it is not a blob, and textconv so far has always
   been about blobs; it needs to be considered carefully if it makes
   sense to allow such a usage) and show it;

 * If we don't, we act as if -c were -p; in other words, we treat
   the built-in "human output" implemented by "cat-file -p" as if
   that is a textconv.

In other words, you may want to fall-thru to case 'p', not case 0
with forced "blob" type.

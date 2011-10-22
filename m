From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 7/5] pretty: %G[?GS] placeholders
Date: Sat, 22 Oct 2011 12:47:07 +0200
Message-ID: <CA+EOSB=EowzV5B9jjq9D9rshPt8LmO9K_GbwNWo_x3Uv9+kwxg@mail.gmail.com>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
	<1319071023-31919-1-git-send-email-gitster@pobox.com>
	<7v7h3x7h6j.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 12:50:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHZ9O-0006oD-1Q
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 12:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab1JVKrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 06:47:09 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34220 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab1JVKrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 06:47:08 -0400
Received: by vcge1 with SMTP id e1so3893319vcg.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=P3dYSmhxsdliJymlyNYxI/PFoFqpkiKa6Cl7fXv9kyE=;
        b=pzuWYovGjsa3OHLOErE6AfpC68f/BLHX5wcOYuDRawS4hCs5p/0hnzPsAF82bdRPjh
         nb1mHYltV0GsQsmNsvGBWOQKr0kl38sA8/vcjOuJAmN+UzJq3W18KrgTqwsQ86MIumEq
         Y3RnrisN+ki8HWNIhB/1Rh2ByN7HZroduWfu4=
Received: by 10.220.107.16 with SMTP id z16mr1211650vco.146.1319280427119;
 Sat, 22 Oct 2011 03:47:07 -0700 (PDT)
Received: by 10.220.76.82 with HTTP; Sat, 22 Oct 2011 03:47:07 -0700 (PDT)
In-Reply-To: <7v7h3x7h6j.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184098>

Can you suggest what do you think can be useful placeholders ? Thanks.

2011/10/22, Junio C Hamano <gitster@pobox.com>:
> Add new placeholders related to the GPG signature on signed commits.
>
>  - %GG to show the raw verification message from GPG;
>  - %G? to show either "G" for Good, "B" for Bad;
>  - %GS to show the name of the signer.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * The 6th is the one that works with a bogus commit with NUL in it I sent
>    out previously.
>
>    This concludes the series; I'll leave the design and implementation of
>    other useful placeholders to the list for now.
>
>  pretty.c |   86
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index f45eb54..392d656 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -9,6 +9,7 @@
>  #include "notes.h"
>  #include "color.h"
>  #include "reflog-walk.h"
> +#include "gpg-interface.h"
>
>  static char *user_format;
>  static struct cmt_fmt_map {
> @@ -640,6 +641,12 @@ struct format_commit_context {
>  	const struct pretty_print_context *pretty_ctx;
>  	unsigned commit_header_parsed:1;
>  	unsigned commit_message_parsed:1;
> +	unsigned commit_signature_parsed:1;
> +	struct {
> +		char *gpg_output;
> +		char good_bad;
> +		char *signer;
> +	} signature;
>  	char *message;
>  	size_t width, indent1, indent2;
>
> @@ -822,6 +829,59 @@ static void rewrap_message_tail(struct strbuf *sb,
>  	c->indent2 = new_indent2;
>  }
>
> +static struct {
> +	char result;
> +	const char *check;
> +} signature_check[] = {
> +	{ 'G', ": Good signature from " },
> +	{ 'B', ": BAD signature from " },
> +};
> +
> +static void parse_signature_lines(struct format_commit_context *ctx)
> +{
> +	const char *buf = ctx->signature.gpg_output;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(signature_check); i++) {
> +		const char *found = strstr(buf, signature_check[i].check);
> +		const char *next;
> +		if (!found)
> +			continue;
> +		ctx->signature.good_bad = signature_check[i].result;
> +		found += strlen(signature_check[i].check);
> +		next = strchrnul(found, '\n');
> +		ctx->signature.signer = xmemdupz(found, next - found);
> +		break;
> +	}
> +}
> +
> +static void parse_commit_signature(struct format_commit_context *ctx)
> +{
> +	struct strbuf payload = STRBUF_INIT;
> +	struct strbuf signature = STRBUF_INIT;
> +	struct strbuf gpg_output = STRBUF_INIT;
> +	int status;
> +
> +	ctx->commit_signature_parsed = 1;
> +
> +	if (parse_signed_commit(ctx->commit->object.sha1,
> +				&payload, &signature) <= 0)
> +		goto out;
> +	status = verify_signed_buffer(payload.buf, payload.len,
> +				      signature.buf, signature.len,
> +				      &gpg_output);
> +	if (status && !gpg_output.len)
> +		goto out;
> +	ctx->signature.gpg_output = strbuf_detach(&gpg_output, NULL);
> +	parse_signature_lines(ctx);
> +
> + out:
> +	strbuf_release(&gpg_output);
> +	strbuf_release(&payload);
> +	strbuf_release(&signature);
> +}
> +
> +
>  static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
>  				void *context)
>  {
> @@ -974,6 +1034,30 @@ static size_t format_commit_one(struct strbuf *sb,
> const char *placeholder,
>  		return 0;
>  	}
>
> +	if (placeholder[0] == 'G') {
> +		if (!c->commit_signature_parsed)
> +			parse_commit_signature(c);
> +		switch (placeholder[1]) {
> +		case 'G':
> +			if (c->signature.gpg_output)
> +				strbuf_addstr(sb, c->signature.gpg_output);
> +			break;
> +		case '?':
> +			switch (c->signature.good_bad) {
> +			case 'G':
> +			case 'B':
> +				strbuf_addch(sb, c->signature.good_bad);
> +			}
> +			break;
> +		case 'S':
> +			if (c->signature.signer)
> +				strbuf_addstr(sb, c->signature.signer);
> +			break;
> +		}
> +		return 2;
> +	}
> +
> +
>  	/* For the rest we have to parse the commit header. */
>  	if (!c->commit_header_parsed)
>  		parse_commit_header(c);
> @@ -1114,6 +1198,8 @@ void format_commit_message(const struct commit
> *commit,
>
>  	if (context.message != commit->buffer)
>  		free(context.message);
> +	free(context.signature.gpg_output);
> +	free(context.signature.signer);
>  }
>
>  static void pp_header(const struct pretty_print_context *pp,
> --
> 1.7.7.555.g02edb3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile

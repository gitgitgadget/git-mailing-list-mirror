From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git apply: binary files differ can be applied with -pN
 (N>1).
Date: Wed, 24 Nov 2010 09:20:28 -0800
Message-ID: <7vlj4itz8j.fsf@alter.siamese.dyndns.org>
References: <4CECA0AE.90505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 18:20:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLJ1P-0004Fj-Lr
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 18:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab0KXRUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 12:20:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab0KXRUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 12:20:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08D772FB9;
	Wed, 24 Nov 2010 12:20:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IgtZPaf93oeMpfnhV3/MAY2cHys=; b=oF8KqP
	+VBIyU72S1OYDY9Rdzq5fEXDAvSVY8LH67Hjw6+tu1UNZOOmdJFIWg058d3nBodf
	vToElv4lEzhpkW6l/4ULwrrjFxEZXFK+Foa17rp7aGk/IeWZeRRT8c4tVNEWcrLS
	efEsVIct7KH2QR32fyBB1btFf10XbL7iz5Zg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+XTDtK0C/AaG96qq3D0A9f63QhcNSLt
	zA3dsYnnJNIaLadcPE3ohiTdHVNgCNtB8th3VzMSV22RDfmeN1QlRwSYihtRjmyd
	EbS8K/9KWwApA8Tao/9visQp+AbZPpOFIoNi3JUQILTbeZ9RiamUuG9mVazgndG+
	YNiaq23s2UI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAD232FB8;
	Wed, 24 Nov 2010 12:20:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DEAA12FB7; Wed, 24 Nov 2010
 12:20:43 -0500 (EST)
In-Reply-To: <4CECA0AE.90505@gmail.com> (Jiang Xin's message of "Wed\, 24 Nov
 2010 13\:20\:46 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CFF5F2E-F7EF-11DF-96E1-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162070>

Jiang Xin <worldhello.net@gmail.com> writes:

> When patch file generated against two non-git directories using
> 'git diff --binary --no-index' without '--no-prefix', the patch
> file has patch level greater then 1, and should be applied with
> '-p2' option. But it does not work if there are binary differ
> in the patch file, it is because in one case the patch level is
> not properly handled.
>
> Signed-off-by: Jiang Xin <jiangxin@ossxp.com>

Can you please add a testcase to protect your fix from getting broken by
later changes by other people, perhaps to t/t4120?

By the way, this codepath is shared by all forms of patches "diff --git"
header, not just binary.  Do you see a similar breakage with --no-prefix
patches that are not binary, and if not why?

> ---
>  builtin/apply.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 23c18c5..d603e37 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1126,6 +1126,7 @@ static char *git_header_name(char *line, int llen)
>  	 * form.
>  	 */
>  	for (len = 0 ; ; len++) {
> +		int nslash = p_value;
>  		switch (name[len]) {
>  		default:
>  			continue;
> @@ -1137,7 +1138,7 @@ static char *git_header_name(char *line, int llen)
>  				char c = *second++;
>  				if (c == '\n')
>  					return NULL;
> -				if (c == '/')
> +				if (c == '/' && --nslash <= 0)
>  					break;
>  			}
>  			if (second[len] == '\n' && !memcmp(name, second, len)) {
> -- 
> 1.7.3.2.245.g03276.dirty

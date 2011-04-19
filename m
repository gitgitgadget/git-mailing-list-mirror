From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] i18n.repositoryencoding: a new variable specifying
 the encoding of blobs in the repository
Date: Mon, 18 Apr 2011 21:34:13 -0700
Message-ID: <7vy6366ere.fsf@alter.siamese.dyndns.org>
References: <1302987004-28134-1-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "ZHANG\, Le" <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 06:34:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC2e5-00044W-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 06:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab1DSEeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 00:34:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1DSEeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 00:34:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00CE252EB;
	Tue, 19 Apr 2011 00:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UVyUyymM+ThRLeoqHzaTSQoRpLg=; b=SJYUfY
	PJ2CifOa3rskFEKrnmMttXck2LE0/GZywgsCcWx9UInTOQ6XbZMicat3ve/QmGrO
	tVKjaM2DKfASA4yVw303DZddnhNKZmnukQogMtLgp/kWy2aIBDKtGfWX7bz4BhR1
	XmNgiVxZtIFHoXgGYuC5jVEumtw52w/P7+msk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l91NFluxZ8ZSGc+ZzNOCqL5Yyg7ITh1y
	sRCOKa07Jdj+3K1ngnwH1ja9o2N8PCRlWE9A1I40yYlajZS7T1Mog6yDiDMw30f6
	teW/EZShINLt2hCdYOzRFkgRAtztZdynEY7NkicHupXvSQK44PFP1WIT1B7J+Ovk
	Ixu6kJIPQy4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC1E852EA;
	Tue, 19 Apr 2011 00:36:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DBB0F52E6; Tue, 19 Apr 2011
 00:36:15 -0400 (EDT)
In-Reply-To: <1302987004-28134-1-git-send-email-r0bertz@gentoo.org> (Le
 ZHANG's message of "Sat, 16 Apr 2011 13:50:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91CA2AD0-6A3E-11E0-9F89-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171773>

"ZHANG, Le" <r0bertz@gentoo.org> writes:

> When not set it defaults to 'verbatim', nothing will be done.
> When set, the encoding of the blobs in repository will be converted to it.
> The original encoding is get from mail header.
>
> Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>

As I suspect that you would need to reroll the [PATCH 1/2], my comment on
this patch might become unapplicable, but anyway...

> @@ -824,8 +825,10 @@ static int handle_commit_msg(struct strbuf *line)
>  	return 0;
>  }
>  
> -static void handle_patch(const struct strbuf *line)
> +static void handle_patch(struct strbuf *line)
>  {
> +	if (strcasecmp(repository_charset, "verbatim"))
> +		convert_to(line, repository_charset, charset.buf);

I really do not want to see you call this strcasecmp for each and every
line of the input.  The majority of the users (read: the current users who
are fine without using this new feature) do not want to pay the overhead.

How about doing it this way instead:

 - Do not define repository_charset variable in this file; do not define
   get_repository_encoding() function in environment.c; just declare
   "const char *repository_encoding" in cache.h (as "extern const ...")
   and define it in environment.c.

 - git_default_i18n_config() in config.c reads i18n.repositoryencoding
   into "repository_encoding".  This variable is initialized to NULL when
   the program is loaded, and as a special case, when the configuration
   variable is "verbatim", this variable is reset to NULL.  Otherwise it
   will hold a copy of the string given by the configuration file (or -c
   option from the command line).

 - This callsite checks if repository_encoding is non-NULL, and if so
   calls convert_to().

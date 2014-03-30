From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] MSVC: fix t0040-parse-options crash
Date: Sat, 29 Mar 2014 19:01:54 -0700
Message-ID: <7vtxago359.fsf@alter.siamese.dyndns.org>
References: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>
	<1396123762-28673-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Sun Mar 30 04:00:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU53M-0001Rt-MK
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 04:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbaC3CAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 22:00:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbaC3CAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 22:00:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D4879430;
	Sat, 29 Mar 2014 22:00:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jYi9Tn5agxY8zLDrOi7dgPXS3wU=; b=NQV2M4
	RITzKsO35O/2OtEROy+f07A+OzGIEYpHUxt+C9Cyly29o3iwvNGDlhdIkqaF5Eee
	IEFTGv1qEiNTjPClvLdEVyc96GPeZ7aZjZTBpenqd2xQAW+cEEnl9z0dnciGLGDt
	oGI9TPg8HVPtdvOKLfLQ/ZNkWDY6niFbbdBRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DnCHVQmwfzsRqwPdWDh+ZBMNsTD1uKvh
	xxV+ejuSqwwnk0mTmyRKmc4vkHoO2lmk//gx6mdy44ov6IE/FhJN/MRq0zXDZ67e
	uqS1cqNnLpEOvXhYwCp0BFOSfui+yDT23sVgQtB/TPhBCgSWy4uv6EgC7SDqDY14
	6FSoZ8zl9vQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3713C7942F;
	Sat, 29 Mar 2014 22:00:35 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A7377942B;
	Sat, 29 Mar 2014 22:00:34 -0400 (EDT)
In-Reply-To: <1396123762-28673-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Sun, 30 Mar 2014 00:09:22 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 146E557C-B7AF-11E3-AE2A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245452>

Marat Radchenko <marat@slonopotamus.org> writes:

> On 64-bit MSVC, pointers are 64 bit but `long` is only 32.
> Thus, casting string to `unsigned long`, which is redundand on other
> platforms, throws away important bits and when later cast to `intptr_t`
> results in corrupt pointer.
>
> This patch fixes test-parse-options by replacing harming cast with
> correct one.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>
> Aargh! Didn't notice that V2 introduced compilation warning. Take three.

I am glad that I asked you to clarify, as I totally forgot that
there are L32P64 boxes.

I love it every time to see an attempt to describe why the solution
works clearly results in a better patch.  It is not about writing
verbose log message; it is about thinking things through and clearly
cut to the core of the issue.  Moving the string literal to a
separate variable to be used in the constructor in v1 was totally a
red-herring.  Your updated log message makes it crystal clear that
using the correct typecast, not "unsigned long" but "intptr_t", is
the core of the solution.

As OPT_SET_PTR() is about setting the pointer value to intptr_t defval,
a follow-up patch on top of this fix (see attached) may not be a bad
thing to have, but that patch alone will not fix this issue without
dropping the unneeded and unwanted cast to unsigned long.

Thanks.

>  test-parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 434e8b8..6f6c656 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -60,7 +60,7 @@ int main(int argc, char **argv)
>  		OPT_STRING('o', NULL, &string, "str", "get another string"),
>  		OPT_NOOP_NOARG(0, "obsolete"),
>  		OPT_SET_PTR(0, "default-string", &string,
> -			"set string to default", (unsigned long)"default"),
> +			"set string to default", (intptr_t)"default"),
>  		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
>  		OPT_GROUP("Magic arguments"),
>  		OPT_ARGUMENT("quux", "means --quux"),


 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index d670cb9..7a24d2e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -129,7 +129,7 @@ struct option {
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (p) }
+				      (h), PARSE_OPT_NOARG, NULL, (intptr_t)(p) }
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }

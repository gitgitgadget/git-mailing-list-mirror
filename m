From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/14] handle_revision_opt(): use convert_i() when handling "-<digit>"
Date: Wed, 18 Mar 2015 23:34:50 -0700
Message-ID: <xmqqwq2djy0l.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<1426608016-2978-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:34:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYU2k-0000OZ-2b
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 07:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbbCSGex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 02:34:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750972AbbCSGex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 02:34:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 756923A6F7;
	Thu, 19 Mar 2015 02:34:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GBfkMy2QFVEZ3QLGRX5B5ngKjHs=; b=R1bGgC
	ADaAtCCKyf3tDNx8mkyrWi+J0+2PuqWxRWtrMnRgY7n0UTfyEz2EFywtOSl+ytVB
	hrO+edDiUpAjPbIOg8Cizw6g+v5AnNyXd2S1xA/HaveMG9necPWXdUr1Dh9peb7r
	gWxQL+5YfDmlkydvzivbHM07vS4d5ZcXTWoOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/YOLfPNm+aB8aLdVzJQPBwDQHQNDSa4
	U7c+Zu0hLAf9tVabgxl89hyw1HmjIMePTvZi9hPyQ81ViCkZF3QMdrBzkBAYTIgp
	GAeqg1Pp+tQ8YaeYH6pdtaVnhxmhM5o1G9Rp66EsYpa6+4b0ryIwdSPnG3aIdgU1
	GuGCxvtTg5w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E0063A6F0;
	Thu, 19 Mar 2015 02:34:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C44543A6EF;
	Thu, 19 Mar 2015 02:34:51 -0400 (EDT)
In-Reply-To: <1426608016-2978-6-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 17 Mar 2015 17:00:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C37345E-CE02-11E4-8012-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265789>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This tightens up the parsing a bit:
>
> * Leading whitespace is no longer allowed
> * '+' and '-' are no longer allowed
>
> It also removes the need to check separately that max_count is
> non-negative.

Hmmm, on the surface this sound nice, but I am not sure if it is a
good idea.  "git cmd-in-log-family -3 --max-count=-1" would have
been a nice way to flip a max-count given earlier on the command
line back to the default (unlimited) and we are removing it without
giving any escape hatch?

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  revision.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 25838fc..4908e66 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "numparse.h"
>  #include "tag.h"
>  #include "blob.h"
>  #include "tree.h"
> @@ -1709,8 +1710,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		return argcount;
>  	} else if ((*arg == '-') && isdigit(arg[1])) {
>  		/* accept -<digit>, like traditional "head" */
> -		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
> -		    revs->max_count < 0)
> +		if (convert_i(arg + 1, 10, &revs->max_count))
>  			die("'%s': not a non-negative integer", arg + 1);

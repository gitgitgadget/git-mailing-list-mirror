From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] bundle.c: fix memory leak
Date: Tue, 10 Mar 2015 15:40:16 -0700
Message-ID: <xmqq1tkwzdbj.fsf@gitster.dls.corp.google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
	<1425920304-22360-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSp6-0000SN-QH
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbCJWkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:40:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751844AbbCJWkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:40:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 130223E302;
	Tue, 10 Mar 2015 18:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4FXokClfOuFpesdMmmxJ8pStJEc=; b=BCAblZ
	vlOfRZsde7uZt0wS+YNZqbK10Kdchq2W746PL4FVr6phplVYjflutR1fS4wu9uUZ
	Q4+hqu+xmesYxkmoLcRdnkIc9sktAXKBpqmwrT9pgtSPH02rT2ztcRgqGHAGN9XP
	JV03Hlx5jCUpIz7olBV3viZzDy6YE0Nf+ZVUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WImKqheOxldqY5KLZtaMcR3YNcXNcfTD
	wK4vGgTWE1C9JvgaqRXz95HQ522t6q0Y1bCkQ6tPzaRbAtmwhMa6d0/jmme5RNt6
	CnblFLF3KSTCoG9gauaV8Iz157yRxcU3f47x/+Rx6kEUVljtHlz3dmwxm+HHbCFU
	9HOB+v23oDM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C2CD3E301;
	Tue, 10 Mar 2015 18:40:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DE8C3E300;
	Tue, 10 Mar 2015 18:40:17 -0400 (EDT)
In-Reply-To: <1425920304-22360-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 9 Mar 2015 09:58:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CE97484-C776-11E4-BB2E-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265274>

Stefan Beller <sbeller@google.com> writes:

> The continue statements nearby also have an accompanying free(ref);
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I wonder what happens when dwim_ref() returned 2 or more, though.

>  bundle.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/bundle.c b/bundle.c
> index 2e2dbd5..534783d 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -342,6 +342,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
>  		if (e->item->type == OBJ_TAG &&
>  				!is_tag_in_date_range(e->item, revs)) {
>  			e->item->flags |= UNINTERESTING;
> +			free(ref);
>  			continue;
>  		}

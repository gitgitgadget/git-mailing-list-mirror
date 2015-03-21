From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] builtin/apply.c: fix a memleak
Date: Fri, 20 Mar 2015 20:45:06 -0700
Message-ID: <xmqqsiczau9p.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:45:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZALb-0002jX-87
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbCUDpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:45:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751453AbbCUDpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:45:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F90A42A4B;
	Fri, 20 Mar 2015 23:45:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IGYkQqNoQfQUrMFvpEu5d4i5fmc=; b=LouUdp
	QGIsxBPp6vzYOwiWxW7niJH/3fjjGbIi7g81iLVFGhiRpWU2PA+dAyuejTwwOSTf
	JdVcxh24REBHjt2TGBCrsqDiTfCw+mHmUQ4tq4ydbTnhqxRb9qLIIA+I5Ex0q2id
	3S8+zt+F2XAp3ikF92nmddn4AtuRnRszSrCiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJ2v5R0/yIkL1zoYMGKM3NhjCtHMRuh/
	cf/3GkiJilnENUv8H6UvR1SFeAI7vdoXXEcpRu4+kQoYORO/z7BYQmRCc4c1M7Q+
	lB56I+OfJWYSqDFrnWKAzNFHosFZk5Yne7fkF6IXbPTSrwPO8BsZvbgKgbe6MP4X
	72cgezBRiiQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 791FE42A4A;
	Fri, 20 Mar 2015 23:45:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E920F42A49;
	Fri, 20 Mar 2015 23:45:07 -0400 (EDT)
In-Reply-To: <1426897692-18322-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAFE980E-CF7C-11E4-B9F6-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266003>

Stefan Beller <sbeller@google.com> writes:

> oldlines is allocated earlier in the function and also freed on the
> successful code path.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/apply.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 65b97ee..e152c4d 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2776,6 +2776,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
>  		default:
>  			if (apply_verbosely)
>  				error(_("invalid start of line: '%c'"), first);
> +			free(oldlines);
>  			return -1;

Good.

By the way, aren't the following also leaking here?

 - the strbuf newlines that starts out as "size"
 - line[] arrays of preimage and postimage




>  		}
>  		if (added_blank_line) {

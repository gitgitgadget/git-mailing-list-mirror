From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] ident.c: cleanup wrt ident's source
Date: Thu, 04 Feb 2016 13:33:27 -0800
Message-ID: <xmqqd1scgnyw.fsf@gitster.mtv.corp.google.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
	<1454577160-24484-4-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:33:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRRWw-00032C-BK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 22:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933466AbcBDVda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 16:33:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754455AbcBDVd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 16:33:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17C2642281;
	Thu,  4 Feb 2016 16:33:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0516d4G/4WPYqgTmTwJjdOdFH4Y=; b=avPdEz
	WcRQrToFtUCUxlaFkOefKtUmWFIOjstfZzM6RTfTa9ON27GADwmfqq4p4WRB0IM9
	sRLX7Wsx57AxBp0FKTDwQ66+DnYt64QYvGujf1rrbmuWdhcyF7GTfU+Xr3R853jK
	YhXsOFy/qbmAsG1U4Fm0awMjxGHDPSSav9n4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kEUjbx8PxCY5NnZEPtzniGINYAnCp+z4
	Oc5YNQun4Z+e06Z3rZ7exsIAmYRo3VX6A0RNwOF85H84fM/DYYprmrvXftHnzFCF
	HYz+RKyMfAVD8u5+bo4pmpUYP4Y6y1XYMSyh2C7PZSOU1g8PI+U75jt9XFxeMzzK
	k/FrH2iV3E8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E36F42280;
	Thu,  4 Feb 2016 16:33:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DC114227F;
	Thu,  4 Feb 2016 16:33:28 -0500 (EST)
In-Reply-To: <1454577160-24484-4-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Thu, 4 Feb 2016 11:12:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE1860F0-CB86-11E5-9ADA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285495>

Dan Aloni <alonid@gmail.com> writes:

>  * Condense the variables that tells where we got the user's
>    ident into single enum, instead of a collection of booleans.
>  * Have {committer,author}_ident_sufficiently_given directly
>    probe the environment and the afformentioned enum instead of
>    relying on git_{committer,author}_info to do so.

That looks quite different from how we write our proposed log
messages.

>
> Signed-off-by: Dan Aloni <alonid@gmail.com>
> ---
>  ident.c | 122 ++++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 77 insertions(+), 45 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 1216079d0b0d..b9aad38e0621 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -10,17 +10,19 @@
>  static struct strbuf git_default_name = STRBUF_INIT;
>  static struct strbuf git_default_email = STRBUF_INIT;
>  static struct strbuf git_default_date = STRBUF_INIT;
> -static int default_email_is_bogus;
> -static int default_name_is_bogus;
> +
> +enum ident_source {
> +	IDENT_SOURCE_UNKNOWN = 0,
> +	IDENT_SOURCE_CONFIG,
> +	IDENT_SOURCE_ENVIRONMENT,
> +	IDENT_SOURCE_GUESSED,
> +	IDENT_SOURCE_GUESSED_BOGUS,
> +};

No trailing comma after the last enum (some compliers choke on this
IIRC).

I skimmed the remainder of the patch but I am no the fence--I cannot
quite see how this improves the readability of the result.

Thanks.

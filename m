From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/12] add range clone functions
Date: Sun, 27 Jun 2010 12:54:39 -0700
Message-ID: <7veifsfdz4.fsf@alter.siamese.dyndns.org>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
 <1277558857-23103-7-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:54:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxwR-0002pC-70
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab0F0Tyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:54:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab0F0Tyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:54:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D30A3BFE87;
	Sun, 27 Jun 2010 15:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5eUrEAQYilm9pslS5XJ0Lr5gmZo=; b=kbduU6
	OfrrGn3/VIMmQdwPYqlFX0zeituWRkTal9YCcnUUKszpsUS1ZuyuSG/JgtvkhFV9
	Iz1XwCJsYxsDG8e5MQC6JQIxVYmzO+04HpZHF/rJYJlEpQw0gBYrqboabo/qEQCg
	XYYECPvfR2bRgiGiyq6SYzpNiXB8xp3LFpAUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GS4z9AexHc3IQbEmj+ubQOdy3ctdfQQ1
	s1w2nC0TlU6cLyVjWaj9wQTd77n4ezgHfUuld2DL0XD1Rf+kMwqAY1U4qcmhz+Dz
	w7WrRu250dh5ZenOeRvL5BwEDZ+nD926Hr8E2+NRBbTqlkH2jHX7M1FHck40rZ0D
	oljEaI9ean4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BBDEBFE83;
	Sun, 27 Jun 2010 15:54:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63AA0BFE81; Sun, 27 Jun
 2010 15:54:41 -0400 (EDT)
In-Reply-To: <1277558857-23103-7-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Sat\, 26 Jun 2010 06\:27\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6DF2F0A-8225-11DF-9D67-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149807>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Both single range clone and deeply clone are supported.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  line.c |   35 +++++++++++++++++++++++++++++++++++
>  line.h |    4 ++++
>  2 files changed, 39 insertions(+), 0 deletions(-)
>
> diff --git a/line.c b/line.c
> index 7b7f3f3..f765a03 100644
> --- a/line.c
> +++ b/line.c
> @@ -370,6 +370,41 @@ void diff_line_range_append(struct diff_line_range *r, const char *arg)
>  	r->ranges[r->nr - 1].arg = arg;
>  }
>  
> +struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
> +{
> +	struct diff_line_range *ret = xmalloc(sizeof(*ret));
> +
> +	DIFF_LINE_RANGE_INIT(ret);
> +	ret->ranges = xcalloc(sizeof(struct range), r->nr);

Please don't break the calloc(nmemb, size-of-one-member) convention.

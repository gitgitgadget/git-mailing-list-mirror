From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] string_list: add two new functions for splitting
 strings
Date: Mon, 10 Sep 2012 15:00:36 -0700
Message-ID: <7vlighlerf.fsf@alter.siamese.dyndns.org>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
 <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 00:00:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBC2B-00030U-F9
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 00:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab2IJWAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 18:00:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab2IJWAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 18:00:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26AC58793;
	Mon, 10 Sep 2012 18:00:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sknb+b+XbUn6+uAcu8HoTbEhVJY=; b=sl/+kh
	vnEZ1Fb50CCVQWUGtftkKUO1mYrgmQI2kwTN+8UtKrm7bNrDYSDT4Xhzr/KjGWsv
	+mvswq5KIt6EpSWN3EpoZRleVD48bsYBNNuzZdpUjCbFkiLEbKGbslKhVfnE/IjG
	D8BU72aqASIbA4p3YWigRhIfv2qQQrOMM+fB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ThlT9qvvnW2trzjLwdcLMllQ7ZRR96S6
	b0rudDiUCsVZj6T7jdZRhnLciM3i4nvktslUufiX6foUj9LbD/V/wAOACZjXgOtL
	uSzJ+UVGF1wqZ5xE8cpcOnYU2j7iI9NLdHYC+xzOJ6XnHGytme/cgHuGHfch8ikf
	YJRPpLUuhys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 152BD8792;
	Mon, 10 Sep 2012 18:00:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 731F28791; Mon, 10 Sep 2012
 18:00:37 -0400 (EDT)
In-Reply-To: <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Mon, 10 Sep 2012 23:18:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3F8D5EE-FB92-11E1-BE32-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205200>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> diff --git a/string-list.c b/string-list.c
> index 5594b7d..f9051ec 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -204,3 +204,52 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
>  	list->items[i] = list->items[list->nr-1];
>  	list->nr--;
>  }
> +
> +int string_list_split(struct string_list *list, const char *string,
> +		      int delim, int maxsplit)
> +{
> +	int count = 0;
> +	const char *p = string, *end;
> +
> +	assert(list->strdup_strings);

This may be a taste thing, but I'd prefer to see assert() only for
verification of pre-condition by internal callers to catch stupid
programming errors.  For a library-ish function like sl_split() that
expects to be called from anybody outside the string-list API, a
violation of this pre-condition is a usage error of the API, and
should trigger a runtime error (even without NDEBUG), no?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] string_list: add function
 string_list_append_nodup()
Date: Mon, 10 Sep 2012 14:56:15 -0700
Message-ID: <7vpq5tleyo.fsf@alter.siamese.dyndns.org>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
 <1347311926-5207-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBy0-0008Qj-RK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab2IJV4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:56:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756931Ab2IJV4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:56:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A19ED8647;
	Mon, 10 Sep 2012 17:56:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zwx8YAohEia0X+joXkUCq2Bnhxk=; b=qC+Fvs
	dHWmBbwT2nhZ1JgajRdB+g6rMkPjRdVgdec/62AAHzczR+/uAYdUFExKh2/iHe4y
	5+8UP7fEK/vonJeSh4ZFnM/pq06ggD6KAS5q6hEq45oNLbhTE1hqlXP7hTMfGxnZ
	FQ1Y/CphFiiGdM4GRict2+ekxUX1gMkBc/jzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CvMfrHk9rv64I/Xfi7BwEynlecJOeJs3
	YRoKxsSJ2/wdBC3/n/dW/Es0nvOIPtFpc7rec7r+rhXd0l1XjeY3raijtzuRMxy+
	sBu0gYVBqSTI0QrkcGU3OWVhJPazYrXBtPVm7xy2MeJZ/LB67KZeLYIVmVsTNv2x
	3z4Ry+0h3t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6A98646;
	Mon, 10 Sep 2012 17:56:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EECA08645; Mon, 10 Sep 2012
 17:56:16 -0400 (EDT)
In-Reply-To: <1347311926-5207-2-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Mon, 10 Sep 2012 23:18:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58B4B170-FB92-11E1-B16D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205197>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> diff --git a/string-list.c b/string-list.c
> index d9810ab..5594b7d 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -148,13 +148,23 @@ void print_string_list(const struct string_list *p, const char *text)
>  		printf("%s:%p\n", p->items[i].string, p->items[i].util);
>  }
>  
> -struct string_list_item *string_list_append(struct string_list *list, const char *string)
> +struct string_list_item *string_list_append_nodup(struct string_list *list,
> +						  char *string)
>  {
> +	struct string_list_item *retval;
>  	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
> -	list->items[list->nr].string =
> -		list->strdup_strings ? xstrdup(string) : (char *)string;
> -	list->items[list->nr].util = NULL;
> -	return list->items + list->nr++;
> +	retval = &list->items[list->nr++];
> +	retval->string = (char *)string;

Do you still need this cast, now the function takes non-const "char *string"?

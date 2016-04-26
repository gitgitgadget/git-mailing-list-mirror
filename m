From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] string_list: add string_list_duplicate
Date: Tue, 26 Apr 2016 15:37:11 -0700
Message-ID: <xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:37:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBbt-0004FE-St
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbcDZWh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:37:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753330AbcDZWhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:37:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58FDC155B1;
	Tue, 26 Apr 2016 18:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iv0s5PifS08gFuZeXyRavE1jQgY=; b=oKK/0r
	lVCcugsgwQe/1NyDp1nhOGHzfRKkiSXry0qW4hyg5RJsU4EK4OYzjX2ZAB9PWJ78
	QYtiMpupEMTLmUlznyV/JnrJztAnzuUIw9nyGquPusgAPCqCLwBTxIoVPTM+d1UE
	3zO2MeYsl9cTiAta0JsOayzLPOuNbC0BEsRsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2PEvZ94Nz/68rJuCnEtwpEeOOkMmD4W
	JhKKWNN2rLDPOracYrUG5BxxrUXb8cvpXnFWiikkEJJQR3hRWDSH2NMnUdRZPGtl
	uqqmlttU1ikVnEKdTnu1oAYhl1DjGI1pCZ85NqDo9YEnLb8RKilyv2f0qrNqoWAY
	p/l0rhcn/Xs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F0B0155B0;
	Tue, 26 Apr 2016 18:37:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACEC1155AF;
	Tue, 26 Apr 2016 18:37:12 -0400 (EDT)
In-Reply-To: <1461703833-10350-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B5D76E6-0BFF-11E6-B0DE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292691>

Stefan Beller <sbeller@google.com> writes:

> The result of git_config_get_value_multi do not seem to be stable and
> may get overwritten. Have an easy way to preserve the results of that
> query.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

This morning I reviewed a patch that adds something whose name ends
with _copy(), and this may want to follow suit.

Should strdup_strings() be a separate parameter, or should it follow
what src->strdup_strings has?

"Do not seem to be stable" does not build confidence in the code,
making it sound as if the developer is basing his work on guess not
analysis, and makes it hard to tell if this is a wrong workaround to
a valid issue (e.g. it could be "making the result stable" is what
we want in the longer term) or a valid solution to a problem that
would be common across callers of that API.

>  string-list.c | 18 ++++++++++++++++++
>  string-list.h |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/string-list.c b/string-list.c
> index 2a32a3f..f981c8a 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -7,6 +7,24 @@ void string_list_init(struct string_list *list, int strdup_strings)
>  	list->strdup_strings = strdup_strings;
>  }
>  
> +struct string_list *string_list_duplicate(const struct string_list *src,
> +					  int strdup_strings)
> +{
> +	struct string_list *list;
> +	struct string_list_item *item;
> +
> +	if (!src)
> +		return NULL;
> +
> +	list = xmalloc(sizeof(*list));
> +	string_list_init(list, strdup_strings);
> +	for_each_string_list_item(item, src)
> +		string_list_append(list, item->string);
> +
> +	return list;
> +}
> +
> +
>  /* if there is no exact match, point to the index where the entry could be
>   * inserted */
>  static int get_entry_index(const struct string_list *list, const char *string,
> diff --git a/string-list.h b/string-list.h
> index d3809a1..1a5612f 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -19,6 +19,8 @@ struct string_list {
>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>  
>  void string_list_init(struct string_list *list, int strdup_strings);
> +struct string_list *string_list_duplicate(const struct string_list *src,
> +					  int strdup_strings);
>  
>  void print_string_list(const struct string_list *p, const char *text);
>  void string_list_clear(struct string_list *list, int free_util);

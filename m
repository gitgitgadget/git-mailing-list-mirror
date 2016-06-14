From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] Don't free remote->name after fetch
Date: Tue, 14 Jun 2016 11:49:11 -0700
Message-ID: <xmqqvb1b8v2w.fsf@gitster.mtv.corp.google.com>
References: <1465928936-68866-1-git-send-email-kmcguigan@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: kmcguigan@twopensource.com
X-From: git-owner@vger.kernel.org Tue Jun 14 20:49:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCtOv-0004pP-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbcFNStV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:49:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbcFNStU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:49:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE2CF209E2;
	Tue, 14 Jun 2016 14:49:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pXLOLa+HJk0FbhdjGIFNhpIOckc=; b=SN6XI+
	x6hOspjiar9NdEf41YeiZsJ4XDKI8Sto/IMZ8F67x9DPxtwscBR8eQqFjNJ5x5g0
	uiPmQNkfAtAYvyT2tWayfFdEppwkWiJ1J/DUDGLo9pY714hi8MT4LfLi8nR1hhfU
	QUZJNqYHMYGAxwTu+In7hWWPoFV6op5DxL/dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0ujj6OoK+ZIRUy4txxYhc0RtQgAEt0v
	Lw4SPWk4a6o5xNR6OCdy5ctrc67NwZ9u33fN1yXs7o3i06G/SazIB1GFaTMNPYNh
	JpuFKQnk0HUZYX+/nbG81GfUDyyMLlZoSre4ogn8XDfToS0pSbPbmqCW7l7EoZ2m
	dintdVGWqGA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6D1C209E1;
	Tue, 14 Jun 2016 14:49:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 306D3209E0;
	Tue, 14 Jun 2016 14:49:13 -0400 (EDT)
In-Reply-To: <1465928936-68866-1-git-send-email-kmcguigan@twopensource.com>
	(kmcguigan@twopensource.com's message of "Tue, 14 Jun 2016 14:28:56
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFFAFA9E-3260-11E6-9065-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297319>

kmcguigan@twopensource.com writes:

> From: Keith McGuigan <kmcguigan@twopensource.com>
>
> Make fetch's string_list of remote names owns all of its string items
> (strdup'ing when necessary) so that it can deallocate them safely when
> clearing.
>
> ---

OK.

When I pointed out the call to string_list_append() in
get_remote_group() as one example, I did not check if there are
others that need similar adjustment.  I just skimmed through the
file again and it seems there is none, so this change looks good.

I assume you meant to sign this off, too?

>  builtin/fetch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 630ae6a1bb78..1b4e924bd222 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1071,7 +1071,7 @@ static int get_remote_group(const char *key, const char *value, void *priv)
>  			size_t wordlen = strcspn(value, " \t\n");
>  
>  			if (wordlen >= 1)
> -				string_list_append(g->list,
> +				string_list_append_nodup(g->list,
>  						   xstrndup(value, wordlen));
>  			value += wordlen + (value[wordlen] != '\0');
>  		}
> @@ -1261,7 +1261,7 @@ done:
>  int cmd_fetch(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> -	struct string_list list = STRING_LIST_INIT_NODUP;
> +	struct string_list list = STRING_LIST_INIT_DUP;
>  	struct remote *remote;
>  	int result = 0;
>  	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
> @@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		argv_array_clear(&options);
>  	}
>  
> -	/* All names were strdup()ed or strndup()ed */
> -	list.strdup_strings = 1;
>  	string_list_clear(&list, 0);
>  
>  	close_all_packs();

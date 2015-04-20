From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: plug small leak of commit buffer
Date: Mon, 20 Apr 2015 14:35:28 -0700
Message-ID: <xmqqoamijxen.fsf@gitster.dls.corp.google.com>
References: <xmqqegnljd80.fsf@gitster.dls.corp.google.com>
	<xmqqa8y9jd06.fsf@gitster.dls.corp.google.com>
	<20150415221431.GA27566@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:35:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkJLr-00021U-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 23:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbDTVfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 17:35:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbbDTVfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 17:35:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5F4149BE8;
	Mon, 20 Apr 2015 17:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X6wem5IpA3oiq5dHkliDed/2pa0=; b=Nvtz4S
	DyhoV0eLyVBL01nVl0+94SOc277GvkjbLw3KPsOP7OI2NiYOmKOBmvgw8WUxdwlJ
	aZQx9dNeDGyRzAEQmrgTTr+/FwOCatyOO4ozSHehKd3s7JEZnKfhYcaYxIHaR277
	bS1L+a0ftAljSaalweUeoOVGIReMqH1jbYFIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fqx6VemkrXhSFtzPwPVY1oSY9BZ8KDAj
	K5cq0rJhx7UdRglTcIqprKzq/Qgb8X3pZzOPYz5T/40Usz57OKabulDgUniw8CBC
	fd+2ZOmIOQmX67sEN6vkGaFWRv5eJ2VLJ/+dR4DrzB3sfSiaQ8VnnB2qagdZSTXy
	BJmEerl+uPs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF28049BE6;
	Mon, 20 Apr 2015 17:35:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53ADC49BE5;
	Mon, 20 Apr 2015 17:35:29 -0400 (EDT)
In-Reply-To: <20150415221431.GA27566@peff.net> (Jeff King's message of "Wed,
	15 Apr 2015 18:14:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A517BE0-E7A5-11E4-AC20-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267502>

Jeff King <peff@peff.net> writes:

> I note that record_person does not seem to care about the commit at all,
> so an alternative fix would be:
>
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 1d962dc..9f0e608 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -223,16 +223,14 @@ static void add_branch_desc(struct strbuf *out, const char *name)
>  
>  #define util_as_integral(elem) ((intptr_t)((elem)->util))
>  
> -static void record_person(int which, struct string_list *people,
> -			  struct commit *commit)
> +static void record_person_from_buf(int which, struct string_list *people,
> +				   const char *buffer)
>  {
> -	const char *buffer;
>  	char *name_buf, *name, *name_end;
>  	struct string_list_item *elem;
>  	const char *field;
>  
>  	field = (which == 'a') ? "\nauthor " : "\ncommitter ";
> -	buffer = get_commit_buffer(commit, NULL);
>  	name = strstr(buffer, field);
>  	if (!name)
>  		return;
> @@ -245,7 +243,6 @@ static void record_person(int which, struct string_list *people,
>  	if (name_end < name)
>  		return;
>  	name_buf = xmemdupz(name, name_end - name + 1);
> -	unuse_commit_buffer(commit, buffer);
>  
>  	elem = string_list_lookup(people, name_buf);
>  	if (!elem) {
> @@ -256,6 +253,14 @@ static void record_person(int which, struct string_list *people,
>  	free(name_buf);
>  }
>  
> +static void record_person(int which, struct string_list *people,
> +			  struct commit *commit)
> +{
> +	const char *buf = get_commit_buffer(commit, NULL);
> +	record_person_from_buf(which, people, buf);
> +	unuse_commit_buffer(commit, buf);
> +}
> +
>  static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
>  {
>  	const struct string_list_item *a = a_, *b = b_;
>
>
> This has the slight advantage that it adapts naturally if record_person
> grows more exits, but I don't think it is a big deal either way (it only
> matters if the new exit fails to copy the surrounding code and use "goto
> leave").

Yeah, let me steal that from you.

Thanks.

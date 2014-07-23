From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] add line number and file name info to `config_set`
Date: Wed, 23 Jul 2014 15:24:31 -0700
Message-ID: <xmqqy4vjbtnk.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-5-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:24:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4xu-0002ti-0D
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 00:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933830AbaGWWYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 18:24:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60786 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933386AbaGWWYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 18:24:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B84D2BFA8;
	Wed, 23 Jul 2014 18:24:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jPJlyHm4mICtqJ8bMIYE6IPjOEI=; b=btwMfY
	QSTBWfbT2fw/ILHRMJvl0DE1TwnIDCDjxt19YtmFe1TI3UIG9Kgta9M8WguGDcwP
	PoG5yPxJP5Hlsj93tdoIjfmsc2LA2KBMUUll7RNJRI5pfCRlZBdmvn1mkFEB8C0b
	lvLhPa5HGhI1H7MVZAd/GH1xlGsBzwLRDcjnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QRPUAEEoRqU/lBWv7a6Mby8zJy5MyKlK
	EzRQX5pIXd7JzOHc3jJpiMlNbUZgupq49MuvfYufvwcTxcC/gCzYwBmCMdy74lNa
	aY7id6THFuCqjmfbeKx9CpniVia4djotXLIeOCW9eyqQkXPD0IprNEvFO6vGq1jM
	PeDuN0mcABA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 606B92BFA7;
	Wed, 23 Jul 2014 18:24:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D9E02BFA0;
	Wed, 23 Jul 2014 18:24:33 -0400 (EDT)
In-Reply-To: <1406140978-9472-5-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F1DA37E-12B8-11E4-A8D9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254134>

Tanay Abhra <tanayabh@gmail.com> writes:

> @@ -1287,6 +1300,8 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
>  static int configset_add_value(struct config_set *cs, const char *key, const char *value)
>  {
>  	struct config_set_element *e;
> +	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
> +	struct string_list_item *si;

I have this suspicion that we may want to eventually build a custom
"config_value_list" API that is very similar to what string_list
does, with the only difference from string_list being that the util
item of config_value_item (i.e. a parallel to string_list_item)
would not be a "void *" that points at anything, but is "struct
key_value_info" embedded within, so that we do not have to waste a
pointer and fragmented allocation.

I suspect such a config_value_list API must be built on top of a
kind of generics which C does not allow, which would mean we would
be doing some preprocessor macro tricks (similar to the way how
commit-slab.h allows different kinds of payload) that lets us build
a templated "string-list" API, discarding the existing
"string-list.[ch]" and replacing them with something like these two
liners:

    declare_generic_string_list(string_list, void *); /* in string-list.h */
    define_generic_string_list(string_list, void *); /* in string-list.c */

And at that point,

    declare_generic_string_list(config_value_list, struct key_value);
    define_generic_string_list(config_value_list, struct key_value);

would give us an API declaration and implementation that parallel
that of string-list, but with "struct key_value" in the util field
of each item.

But that kind of clean-up can come much later after this series
settles, and what this patch has is fine for now.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/11] trailer: read and process config information
Date: Fri, 07 Mar 2014 13:24:32 -0800
Message-ID: <xmqqmwh1u2gf.fsf@gitster.dls.corp.google.com>
References: <20140306221409.29648.10706.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM2G2-00077G-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 22:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaCGVYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 16:24:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbaCGVYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 16:24:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B215D715E0;
	Fri,  7 Mar 2014 16:24:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hiuiiv3S1Q4yVULQtoIRRlOQvPE=; b=SVdHFl
	iicdMn1kyVT8qeb1fnh3fIueEiXf/6Ru8EMBSQbGbVrvXnavw/mrYgrYUxA1COln
	UFDURN818mn9DIVioSMhZV+yXcis6cvOVkPwQ0+rbJWqXkXJOw9/2vc2Me/WS+W3
	ptKUr/B3G1RRS8S0PlInRQHeOheyi9lCR/0WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P3bBLFugKI+qBeopkmlLThLevG2E5RN7
	dtYuFSU9D1RxFRFlbTdh0kfCZI9eNlpId66RvdF83XL5ClZxgRuT9WBxYxMSscdm
	84CRK1zv1nvssIcTSuXAHYGY0pCXoNP3+6ZIZnYxgrjidsL7ebAhzo9Ylheipz3R
	gv+jAJWBnls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813CA715DE;
	Fri,  7 Mar 2014 16:24:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D45C715D4;
	Fri,  7 Mar 2014 16:24:35 -0500 (EST)
In-Reply-To: <20140306221409.29648.10706.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Mar 2014 23:14:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E19494D0-A63E-11E3-A241-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243629>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch implements reading the configuration
> to get trailer information, and then processing
> it and storing it in a doubly linked list.

"Read and process the ...", perhaps?

> The config information is stored in the list
> whose first item is pointed to by:
>
> static struct trailer_item *first_conf_item;

If feels somewhat strange if a doubly linked list has only the first
pointer without the last pointer, unless the previous field of the
first one by convention points at the last one, forming a cycle
(which I think is a reasonable thing to do, as a desire for a quick
access to the top and the bottom is often a reason to use doubly
linked list---I didn't check if you implement it that way, though).

> +static int set_where(struct conf_info *item, const char *value)
> +{
> +	if (!strcasecmp("after", value))
> +		item->where = WHERE_AFTER;
> +	else if (!strcasecmp("before", value))
> +		item->where = WHERE_BEFORE;
> +	else
> +		return 1;

Please follow the usual convention of returning a negative value
upon error, unless there is a compelling reason not to do so.

Do we really want to do "strcasecmp" here?  Are some values case
sensitive and we only allow "after", "AfTer", "AFTER", etc. as case
insensitive keywords?  If all values are expected to be case
insensitive, wouldn't it be better to downcase in the caller (just
like we do in the config parser) and use strcmp() against lower case
constants?

All of the comments applies equally to other functions.

> +enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
> +			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
> +
> +static int set_name_and_type(const char *conf_key, const char *suffix,
> +			     enum trailer_info_type type,
> +			     char **pname, enum trailer_info_type *ptype)
> +{
> +	int ret = ends_with(conf_key, suffix);
> +	if (ret) {
> +		*pname = xstrndup(conf_key, strlen(conf_key) - strlen(suffix));
> +		*ptype = type;
> +	}
> +	return ret;
> +}

This implementation, together with the caller that makes many calls
to it, looks overly inefficient (both runtime- and reviewtime-wise),
doesn't it?

How about having the caller upfront find the last dot before
checking the name-and-type to avoid calling ends_with() so many
times unnecessarily?

Also, wouldn't it be better to make the caller more table-driven,
i.e.

	static struct {
        	const char *name;
                enum trailer_kinfo_type type;
	} trailer_config_items[] = {
		{ "key", TRAILER_KEY },
                ...
        };

in the caller's scope, and then

	const char *trailer_item, *variable_name;

        trailer_item = skip_prefix(conf_key, "trailer.");
        if (!trailer_item)
		return 0;

	variable_name = strrchr(trailer_item, '.');
        if (!variable_name) {
		... trailer_item is a two-level variable name.
        	... Handle it in whatever way.
		return 0;
        }

        variable_name++;
        for (i = 0; i < ARRAY_SIZE(trailer_config_items); i++) {
		if (strcmp(trailer_config_items[i].name, variable_name))
			continue;
		name = xstrdup(...);
                type = trailer_config_items[i].type;
		goto found;
	}

        /* Unknown trailer.<item>.variable_name */
        return 0;

found:
	... do whatever depending on the type ...

or something?

> +static struct trailer_item *get_conf_item(const char *name)
> +{
> +	struct trailer_item *item;
> +	struct trailer_item *previous;
> +
> +	/* Look up item with same name */
> +	for (previous = NULL, item = first_conf_item;
> +	     item;
> +	     previous = item, item = item->next) {
> +		if (!strcasecmp(item->conf.name, name))
> +			return item;
> +	}
> +
> +	/* Item does not already exists, create it */
> +	item = xcalloc(sizeof(struct trailer_item), 1);
> +	item->conf.name = xstrdup(name);
> +
> +	if (!previous)
> +		first_conf_item = item;
> +	else {
> +		previous->next = item;
> +		item->previous = previous;
> +	}
> +
> +	return item;
> +}
> +
> +static int git_trailer_config(const char *conf_key, const char *value, void *cb)
> +{
> +	if (starts_with(conf_key, "trailer.")) {
> +		const char *orig_conf_key = conf_key;
> +		struct trailer_item *item;
> +		struct conf_info *conf;
> +		char *name;
> +		enum trailer_info_type type;
> +
> +		conf_key += 8;
> +		if (!set_name_and_type(conf_key, ".key", TRAILER_KEY, &name, &type) &&
> +		    !set_name_and_type(conf_key, ".command", TRAILER_COMMAND, &name, &type) &&
> +		    !set_name_and_type(conf_key, ".where", TRAILER_WHERE, &name, &type) &&
> +		    !set_name_and_type(conf_key, ".ifexists", TRAILER_IF_EXISTS, &name, &type) &&
> +		    !set_name_and_type(conf_key, ".ifmissing", TRAILER_IF_MISSING, &name, &type))
> +			return 0;
> +
> +		item = get_conf_item(name);
> +		conf = &item->conf;
> +		free(name);
> +
> +		switch (type) {
> +		case TRAILER_KEY:
> +			if (conf->key)
> +				warning(_("more than one %s"), orig_conf_key);
> +			conf->key = xstrdup(value);
> +			break;
> +		case TRAILER_COMMAND:
> +			if (conf->command)
> +				warning(_("more than one %s"), orig_conf_key);
> +			conf->command = xstrdup(value);
> +			break;
> +		case TRAILER_WHERE:
> +			if (set_where(conf, value))
> +				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
> +			break;
> +		case TRAILER_IF_EXISTS:
> +			if (set_if_exists(conf, value))
> +				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
> +			break;
> +		case TRAILER_IF_MISSING:
> +			if (set_if_missing(conf, value))
> +				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
> +			break;
> +		default:
> +			die("internal bug in trailer.c");
> +		}
> +	}
> +	return 0;
> +}

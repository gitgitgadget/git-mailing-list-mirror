From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] submodule-config: check if submodule a submodule is in a group
Date: Tue, 26 Apr 2016 15:58:24 -0700
Message-ID: <xmqq37q8c6zz.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:03:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avC0b-00053F-0P
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 01:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbcDZXDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 19:03:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753723AbcDZW62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:58:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2E9116BC7;
	Tue, 26 Apr 2016 18:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3X/P/OWOwvj12CsmfM8Yd8N9W4c=; b=Kuwn5X
	0fQsy3PaonDG1j8IXIcT79w5dyoEQUvkf4BQ+vmMin6P01h61wwD9LB+uIgXFyRG
	8Pz0/5W/c+Fxx36bP7AH/w5PKVRHDwSlIR3MFI6lO8a+pwMnlrmk8m1TWqlWWvxg
	YF9XVp6aKhSpW6mfW1xglmZraAFgjaJzB2Z9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lyUDsPCJbJRrFRVW4RgjQSr+yqSbptcp
	so/mzNV7R6xOArtySzPjGZMScLUyMZWaezIkBg+gycoqDzd6q3tx0AcExLBAPpIp
	2LmLRMrh2ppnx+6SPuJpbevkqFPgnAbYdT9jQ6PSOkDJyncUMAlygQpb3o77ylXn
	eG2I55VWFxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA87216BC5;
	Tue, 26 Apr 2016 18:58:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D46416BC4;
	Tue, 26 Apr 2016 18:58:26 -0400 (EDT)
In-Reply-To: <1461703833-10350-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 627E31DE-0C02-11E6-95CC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292696>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b6d4f27..23d7224 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -814,6 +814,46 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +int in_group(int argc, const char **argv, const char *prefix)

It is inconceivable that "submodule group" will be the only user of
the concept whose name is "group".  Please do not give such a
generic name to a helper function that is specific to "submodule
group" and make it global.  Naming a file-scope static helper
function as in_group() is perfectly fine; it is clear that such a
function in submodule--helper.c is about submodule group.

> +	if (!group)
> +		list = git_config_get_value_multi("submodule.defaultGroup");
> +	else {
> +		string_list_split(&actual_list, group, ',', -1);
> +		list = &actual_list;

Hmm, where did this syntax to use comma-separated things come from?
Did I miss it in 02/15?

> +	if (sub->labels) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, sub->labels) {
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "*%s", item->string);
> +			if (string_list_has_string(group, sb.buf)) {
> +				matched = 1;
> +				break;
> +			}
> +		}
> +	}
> +	if (sub->path) {
> +		/*
> +		 * NEEDSWORK: This currently works only for
> +		 * exact paths, but we want to enable
> +		 * inexact matches such wildcards.
> +		 */
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "./%s", sub->path);
> +		if (string_list_has_string(group, sb.buf))
> +			matched = 1;
> +	}
> +	if (sub->name) {
> +		/*
> +		 * NEEDSWORK: Same as with path. Do we want to
> +		 * support wildcards or such?
> +		 */
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, ":%s", sub->name);
> +		if (string_list_has_string(group, sb.buf))
> +			matched = 1;
> +	}
> +	strbuf_release(&sb);

I see room for bikeshedding here, but the material to bikeshed
around is not even documented yet ;-)

 * a token prefixed with '*' is a label.
 * a token prefixed with './' is a path.
 * a token prefixed with ':' is a name.

Hopefully I will see some description like that in later patches.
I'll read on.

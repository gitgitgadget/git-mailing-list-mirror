From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set API
Date: Thu, 31 Jul 2014 14:17:00 -0700
Message-ID: <xmqqtx5xw7n7.fsf@gitster.dls.corp.google.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>
	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>
	<vpqr411bhd5.fsf@anie.imag.fr> <53DA7C23.3090603@gmail.com>
	<vpqa97p8koq.fsf@anie.imag.fr> <53DA8A54.6060208@gmail.com>
	<vpqoaw55q16.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:17:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxit-00015E-S6
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaGaVRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:17:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62018 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaGaVRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:17:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E0112D2C1;
	Thu, 31 Jul 2014 17:17:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D9ZqKZEj7chSBa85SQdcLo6gXwA=; b=poa5xr
	YIvGixHzXwNQ1ZeElkfmg0OyUMP2sKmG0KL/OdtwLZi6riCAmdm6sdb6tn3+a2dR
	Fo4rg0aFdrPJrzkXeG+EW8h3rTIOEu72J8hutufCWDgzNiDBZZlbkIpMm5lVsMI/
	nYoWyRJjY9E5j/QPIIpjWJ2N2xhCclJUfjTPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXrGNGsnmE/rLH6LOgn+Cfs2cl1X9NEM
	Q3UiVhmX7OtKTIi9zkf5WNtD/XxsJofDKXgoKXJZz8majREAEXGbUs5WvuI+dPky
	8uN1GH5/pC27c9SnUZaSryNSrcuqF1WSx/3h0Ycz0onO49C+5/h6SXs7wvJvqwmg
	G64SsBmDypQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0948A2D2BC;
	Thu, 31 Jul 2014 17:17:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6BE442D2B2;
	Thu, 31 Jul 2014 17:17:02 -0400 (EDT)
In-Reply-To: <vpqoaw55q16.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	31 Jul 2014 20:41:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 03E93EBA-18F8-11E4-A1AE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254601>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> On 7/31/2014 11:39 PM, Matthieu Moy wrote:
>>
>>> This is the part I find weird. You're calling git_die_config_exact() on
>>> the first boggus value, and git_die_config_exact() will notify an error
>>> at the line of the last boggus value.
>>
>> Hmn, we may have some confusion here. I meant the implementation of
>> git_config_exact() to look like this,
>>
>> void git_die_config_exact(const char *key, const char *value)
>> {
>> 	int i;
>> 	const struct string_list *values;
>> 	struct key_value_info *kv_info;
>> 	values = git_config_get_value_multi(key);
>> 	for (i = 0; i < values.nr; i++) {
>> 		kv_info = values->items[i].util;
>> 		/* A null check will be here also */
>> 		if (!strcmp(value, values->items[i].string)) {
>> 			if (!kv_info->linenr)
>> 				die(_("unable to parse '%s' from command-line config"), key);
>> 			else
>> 				die(_("bad config variable '%s' at file line %d in %s"),
>> 					key,
>> 					kv_info->linenr,
>> 					kv_info->filename);
>> 		}
>> 	}
>> }
>>
>> The above code would print the info on first bogus value.
>
> OK, I got confused because git_die_config() errors out at the first
> error. So, your version works, but I do not see any added value in this
> extra complexity.

Hmm, I am still confused ;-)

Can there be more than one 'i' whose value->items[i].string is the
same as the given value?  IOW, if you have "[user] name<EOL>" in
both .git/config and ~/.gitconfig, don't we want to make sure that
we complain on the one in .git/config, which would have taken
precedence if it were spelled correctly?

Your version below makes it very clear that you only complain on the
last one, no matter how many identical copies of the value for the
given key are defined incorrectly the same way, which is easier to
understand what is going on.

> To be cleary, my version would be
>
> NORETURN static /* not sure about the "static" */
> void git_die_config_linenr(const char *key,
>                            const char *filename, int linenr)
> {
> 	if (!linenr)
> 		die(_("unable to parse '%s' from command-line config"), key);
> 	else
> 		die(_("bad config variable '%s' at file line %d in %s"),
> 			key,
> 			linenr,
> 			filename);
> }
>
> (hmm, I actually do not need the value, it's not printed)
>
> NORETURN
> void git_die_config(const char *key)
> {
> 	const struct string_list *values;
> 	struct key_value_info *kv_info;
> 	values = git_config_get_value_multi(key);
> 	kv_info = values->items[values->nr - 1].util;
> 	git_die_config_linenr(key, kv_info->linenr, kv_info->filename);
> }
>
> (we forgot the NORETURN in previous version BTW. It should be there in
> both functions here and in the .h file)
>
> In my version, git_die_config uses git_die_config_linenr, and there's no
> issue with first/last boggus value. Callers of git_die_config_linenr
> have all the information to call it directly.
>
> There are 3 code path that leads to the final die() calls, and having
> this little helper allows making sure the messages are the same for
> every callers, by construction (as opposed to cut-and-pasting).
>
> Really, I don't see any reason to do anything more complex.

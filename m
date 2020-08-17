Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC5C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8198920674
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eaSpHr4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgHQVZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:25:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51056 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHQVZb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:25:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12465DC45D;
        Mon, 17 Aug 2020 17:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rspGXnzfOgkGQn19wIW7LTbSCoU=; b=eaSpHr
        4iKdr+QtRV2eGL7hArbsWmqyKHVuc0TF5zE7xtCyfWZGDCMgwEyeyE5H1a3QRL5J
        BJy6aeLYnAuwM131w1/RQNxLaFKi0ssuGqqFcI1QTablgkIS3aERpU9MW7sXhClS
        HgpHyoRQcHn6OkRwiV6E/AO/oI8qRqhyudjHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TjbZcH8DyY4CBn7NfgOTlK38UwYOJYUp
        CBn7w68taQlNIS/mecPtAvnyjvOUtX11WFQsoGVmpFfAtaF4/RoV+vJZJiqOxf+/
        z4TBIoMNSOWwcxwXaHB3tl6Tul0xNZi8XcQdxA1fssKPshPBf8smxp447dU3MUuO
        y/2tQJAz8iw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A62DDC45C;
        Mon, 17 Aug 2020 17:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 086D9DC45B;
        Mon, 17 Aug 2020 17:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v17 07/10] receive-pack: new config receive.procReceiveRefs
References: <20200518094039.757-1-worldhello.net@gmail.com>
        <20200815171740.6257-8-worldhello.net@gmail.com>
Date:   Mon, 17 Aug 2020 14:25:22 -0700
In-Reply-To: <20200815171740.6257-8-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 15 Aug 2020 13:17:37 -0400")
Message-ID: <xmqqtux1yngd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29647FAA-E0D0-11EA-9EB9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index a687218167..b7e4ee1483 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -98,6 +98,16 @@ static int keepalive_in_sec = 5;
>  
>  static struct tmp_objdir *tmp_objdir;
>  
> +static struct proc_receive_ref {
> +	unsigned int want_add:1,
> +		     want_delete:1,
> +		     want_modify:1;
> +	char *ref_prefix;
> +	struct proc_receive_ref *next;
> +} *proc_receive_ref = NULL;

Let BSS do its job here.

> +static void proc_receive_ref_append(const char *prefix);
> +
>  static enum deny_action parse_deny_action(const char *var, const char *value)
>  {
>  	if (value) {
> @@ -230,6 +240,13 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (strcmp(var, "receive.procreceiverefs") == 0) {

We may want to fix the style of this function in a preliminary clean-up,
but not in the middle of the series, so let's agree to let this pass.

> @@ -325,6 +342,84 @@ struct command {
>  	char ref_name[FLEX_ARRAY]; /* more */
>  };
>  
> +static void proc_receive_ref_append(const char *prefix)
> +{
> +	struct proc_receive_ref *ref_pattern;
> +	char *p;
> +	int len;
> +
> +	ref_pattern = xcalloc(1, sizeof(struct proc_receive_ref));
> +	p = strchr(prefix, ':');

A colon ':' is not a valid character in a refname, so the use of it
as a separator for the prefix would be reasonable.

> +	if (p) {
> +		while (prefix < p) {
> +			if (*prefix == 'a')
> +				ref_pattern->want_add = 1;
> +			else if (*prefix == 'd')
> +				ref_pattern->want_delete = 1;
> +			else if (*prefix == 'm')
> +				ref_pattern->want_modify = 1;
> +			prefix++;
> +		}
> +		prefix++;
> +	} else {
> +		ref_pattern->want_add = 1;
> +		ref_pattern->want_delete = 1;
> +		ref_pattern->want_modify = 1;
> +	}
> +	ref_pattern->next = NULL;


> +	ref_pattern->ref_prefix = xstrdup(prefix);
> +	len = strlen(ref_pattern->ref_prefix);
> +	while (len && ref_pattern->ref_prefix[len - 1] == '/')
> +		ref_pattern->ref_prefix[--len] = '\0';

Why not count "size_t len" before you make a copy of prefix with
tail adjustment, so that you can do xmemdupz() at the end without
need for potential overallocation? 

> +	if (proc_receive_ref == NULL) {

Style:
	if (!proc_receive_ref) {

like you did below.

> +static int proc_receive_ref_matches(struct command *cmd)
> +{
> +	struct proc_receive_ref *p;
> +
> +	if (!proc_receive_ref)
> +		return 0;
> +
> +	for (p = proc_receive_ref; p; p = p->next) {
> +		const char *match = p->ref_prefix;
> +		int neg = 0;
> +		const char *remains;
> +
> +		if (!p->want_add && is_null_oid(&cmd->old_oid))
> +			continue;
> +		else if (!p->want_delete && is_null_oid(&cmd->new_oid))
> +			continue;
> +		else if (!p->want_modify &&
> +			 !is_null_oid(&cmd->old_oid) &&
> +			 !is_null_oid(&cmd->new_oid))
> +			continue;
> +
> +		if (*match == '!') {
> +			neg = 1;
> +			match++;
> +		}

Shouldn't the "negate" bit be jsut another field that has
want_{add,delete,modify}, so that proc_receive_ref_append()
can parse it only once without these four lines?


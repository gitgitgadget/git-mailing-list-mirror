Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB0A20229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbcKJXcS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:32:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52800 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934845AbcKJXcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:32:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B46784F5C4;
        Thu, 10 Nov 2016 18:32:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2o4LLFHZyqa9d5fwZCoqcKzNH8I=; b=FtgrIL
        pXJHvSSy6AHy97XV6QWd7uHgo6c9t1nZj4yHo0Z3ZmIYQn7/95psholyzNbrjM92
        +fCGJ0Kc70yaGTXQ8Q8oaAvv1Ok9vkttu0uZfT2PaTk0rzF/z2E1yU77BBcH43sM
        h8Cl1qF4p7ABD2uUuYxPm7/8GnPME2wIvOawc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NgcgC2UX6S0SFINbVy7/DecU5ZvT5eRA
        MobzUwI9pVFC40vhullGyKLQxoAICdrpnEUnW6+K+ECew7IH3+nXgMNxDzV5PjW2
        11AxKdqNkRvw0yegoJGIiIdVCxHyiWI4DBYMg1DVRwGkZENl4uj4fhnzwqzqiYHB
        1dFYmR1qfBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A99D64F5C3;
        Thu, 10 Nov 2016 18:32:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 194954F5C2;
        Thu, 10 Nov 2016 18:32:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH v7 04/17] ref-filter: modify "%(objectname:short)" to take length
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-5-Karthik.188@gmail.com>
Date:   Thu, 10 Nov 2016 15:32:14 -0800
In-Reply-To: <20161108201211.25213-5-Karthik.188@gmail.com> (Karthik Nayak's
        message of "Wed, 9 Nov 2016 01:41:58 +0530")
Message-ID: <xmqqk2ca52td.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E98985B6-A79D-11E6-8824-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>  	else if (!strcmp(arg, "short"))
> -		atom->u.objectname = O_SHORT;
> -	else
> +		atom->u.objectname.option = O_SHORT;
> +	else if (skip_prefix(arg, "short=", &arg)) {
> +		atom->u.objectname.option = O_LENGTH;
> +		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
> +		    atom->u.objectname.length == 0)
> +			die(_("positive value expected objectname:short=%s"), arg);
> +		if (atom->u.objectname.length < MINIMUM_ABBREV)
> +			atom->u.objectname.length = MINIMUM_ABBREV;
> +	} else
>  		die(_("unrecognized %%(objectname) argument: %s"), arg);
>  }

Users who want to use the default-abbrev, i.e. the autoscaling one
introduced recently, must use "short", not "short=-1", with this
code (especially with the "must be at least MINIMUM_ABBREV" logic),
but I do not think it is a problem, so I think this is good.


> @@ -591,12 +601,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
>  			   struct atom_value *v, struct used_atom *atom)
>  {
>  	if (starts_with(name, "objectname")) {
> -		if (atom->u.objectname == O_SHORT) {
> +		if (atom->u.objectname.option == O_SHORT) {
>  			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>  			return 1;
> -		} else if (atom->u.objectname == O_FULL) {
> +		} else if (atom->u.objectname.option == O_FULL) {
>  			v->s = xstrdup(sha1_to_hex(sha1));
>  			return 1;
> +		} else if (atom->u.objectname.option == O_LENGTH) {
> +			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
> +			return 1;


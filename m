Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E44720C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbdK0XSe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:18:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60713 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753033AbdK0XSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:18:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 953BCBEC04;
        Mon, 27 Nov 2017 18:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ag3kjDyxuyXLimzoZP/B6pAfJgU=; b=cgXQ1A
        YyXo7QX7t/hZixXGkxKHrKS/FKCwmobVDVhsRfO0Q9egDp5E7XTKfO9apGEjwTkc
        gywOGJiq12QywsZuYemU00lbTjxLw80XxK8xOnkyrxiw1f5/9olDz7COoUJYpMia
        MUQXzFKQNxlXKjxGbzwiaGq6vMCl8hbJLM2O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r7i33YxweoQXK/doG25MF3OizsewdKF+
        hpS2yZU5lOrAsTRV1iHrXwIq7dBuYhsCYoplYT5cRSrLpKjPrXDH8WfwL4+9MiEH
        A6Tp3T8gXCOCQ0kxUjARUXU2oqLfBm8XXiDaKDW/gZJnrmAF9YRmKo9e/Q07SshL
        PiUgVoOjRbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1C7BEC03;
        Mon, 27 Nov 2017 18:18:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E382CBEC02;
        Mon, 27 Nov 2017 18:18:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user input
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
Date:   Tue, 28 Nov 2017 08:18:30 +0900
In-Reply-To: <20171127134716.69471-1-lars.schneider@autodesk.com> (lars
        schneider's message of "Mon, 27 Nov 2017 14:47:16 +0100")
Message-ID: <xmqqefojb9a1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48BA4504-D3C9-11E7-80CE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> diff to v2:
>     - shortened and localized the "waiting" message
>     - detect "emacsclient" and suppress "waiting" message

Thanks for moving this forward.


> +		static const char *close_notice = NULL;

Because this thing is "static", the variable is NULL when the first
call to this function is made, and the value left in the variable
when a call returns will be seen by the next call.

> +		if (isatty(2) && !close_notice) {

Declaring a "static" variable initialized to NULL and checking its
NULL-ness upfront is a common pattern to make sure that the code
avoids repeated computation of the same thing.  The body of the if
statement is run only when standard error stream is a tty (hinting
an interactive session) *and* close_notice is (still) NULL.

> +			char *term = getenv("TERM");
> +
> +			if (term && strcmp(term, "dumb"))
> +				/*
> +				 * go back to the beginning and erase the
> +				 * entire line if the terminal is capable
> +				 * to do so, to avoid wasting the vertical
> +				 * space.
> +				 */
> +				close_notice = "\r\033[K";
> +			else if (term && strstr(term, "emacsclient"))
> +				/*
> +				 * `emacsclient` (or `emacsclientw` on Windows) already prints
> +				 * ("Waiting for Emacs...") if a file is opened for editing.
> +				 * Therefore, we don't need to print the editor launch info.
> +				 */
> +				;
> +			else
> +				/* otherwise, complete and waste the line */
> +				close_notice = _("done.\n");
> +		}

It assigns a non-NULL value to close_notice unless the editor is
emacsclient (modulo the bug that "emacsclient" is to be compared
with EDITOR, GIT_EDITOR, core.editor etc. -- git_editor() can be
used to pick the right one).  For a user of that particular editor,
it is left as NULL.  Because it is unlikely that EDITOR etc. would
change across calls to this function, for them, and only for them,
the above is computed to yield the same result every time this
function is called.

That feels a bit uneven, doesn't it?

There are two possible solutions:

1. drop "static" from the declaration to stress the fact that the
   variable and !close_notice in the upfront if() statement is not
   avoiding repeated computation of the same thing, or

2. arrange that "emacsclient" case also participates in "avoid
   repeated computation" dance.  While at it, swap the order of
   checking isatty(2) and !close_notice (aka "have we done this
   already?)--because we do not expect us swapping file descriptor
   #2 inside this single process, we'd be repeatedly asking
   isatty(2) for the same answer.

The former may be simpler and easier, as an editor invocation would
not be a performance critical codepath.

If we want to do the latter, a cleaner way may be to have another
static "static int use_notice_checked = 0;" declared, and then

	if (!use_notice_checked && isatty(2)) {
		... what you currently have, modulo the
		... fix for the editor thing, and set
		... close_notice to a string (or NULL).
                use_notice_checked = 1;
	}

The users of close_notice after this part that use !close_notice
as "do not give the notice at all" flag and also as "this is the
string to show after editor comes back" can stay the same if you go
this route.  That would be solution 2a.

Of course, you can instead use close_notice = "" (empty string) as a
signal "we checked and we know that we are not using the notice
thing".  If you go that route, then the users after this if statement
that sets up close_notice upon the first call would say !*close_notice
instead of !close_notice when they try to see if the notice is in use.
That would be solution 2b.

I personally think any one of 1., 2a., or 2b. is fine.


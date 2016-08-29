Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0D41FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbcH2RPW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:15:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53859 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754013AbcH2RPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:15:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F41CF3A495;
        Mon, 29 Aug 2016 13:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jbM8H7VgTJpuxAthv261RW/2JFw=; b=Siqh8H
        UPnCX9/I8heT/fiBeXx048d30lj4LQ//XxJMMdM5BU/fhW7EbPPPEQFEpZGR15UW
        1vCXwBqCEc8R3HOF1wfhwK3dh9KStXNogO29cy1JUdJBCUxuvQyOCximQzxLEMw1
        hS/QomYgvGa8QVm1dVIobov5VttoSXc0WBvvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bURO1OJ+6GUY3hE8E2C3J5FzAVysDg4Q
        d7O0MKCNMUw8JVn0PdRO9Pux/BZQuNGC+dPQguWr7cUn7epAByv1fIc63LvYNXdd
        PCb5ALiDkVAQAGPm/axWQLaJWtJaCjSp7bbNO4rpNRphVGz1fHYHlh+nVsgw/WIG
        0hUVUhMAG1M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB46A3A494;
        Mon, 29 Aug 2016 13:15:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 537473A493;
        Mon, 29 Aug 2016 13:15:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 12/27] bisect--helper: `get_terms` & `bisect_terms` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6b3-3ccd9de5-604d-4e7d-919d-a3adae869ebf-000000@eu-west-1.amazonses.com>
        <xmqqmvk0n2pl.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPNTkgbFz-tcnLiaW9qvRSUoHgeNMzjnCjx7EwMHG71Niw@mail.gmail.com>
Date:   Mon, 29 Aug 2016 10:15:17 -0700
In-Reply-To: <CAFZEwPNTkgbFz-tcnLiaW9qvRSUoHgeNMzjnCjx7EwMHG71Niw@mail.gmail.com>
        (Pranit Bauva's message of "Sat, 27 Aug 2016 15:18:14 +0530")
Message-ID: <xmqqk2ezcx96.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2955F29A-6E0C-11E6-86AD-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>>> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>>> +{
>>> +     int i;
>>> +
>>> +     if (get_terms(terms)) {
>>> +             fprintf(stderr, _("no terms defined\n"));
>>> +             return -1;
>>> +     }
>>> +     if (argc == 0) {
>>> +             printf(_("Your current terms are %s for the old state\nand "
>>> +                    "%s for the new state.\n"), terms->term_good.buf,
>>> +                    terms->term_bad.buf);
>>> +             return 0;
>>> +     }
>>> +
>>> +     for (i = 0; i < argc; i++) {
>>> +             if (!strcmp(argv[i], "--term-good"))
>>> +                     printf("%s\n", terms->term_good.buf);
>>> +             else if (!strcmp(argv[i], "--term-bad"))
>>> +                     printf("%s\n", terms->term_bad.buf);
>>> +             else
>>> +                     printf(_("invalid argument %s for 'git bisect "
>>> +                               "terms'.\nSupported options are: "
>>> +                               "--term-good|--term-old and "
>>> +                               "--term-bad|--term-new."), argv[i]);
>>> +     }
>>
>> The original took only one and gave one answer (and errored out when
>> the user asked for more), but this one loops.  I can see either way
>> is OK and do not think of a good reason to favor one over the other;
>> unless there is a strong reason why you need this extended behaviour
>> that allows users to ask multiple questions, I'd say we should keep
>> the original behaviour.
>
> True! I can just use return error() instead of printf. Also I noticed
> that this is printing to stdout while the original printed it to
> stderr. Thanks!

The original you removed because the above can take it over is this
in your patch.

-bisect_terms () {
-	get_terms
-	if ! test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		die "$(gettext "no terms defined")"
-	fi
-	case "$#" in
-	0)
-		gettextln "Your current terms are $TERM_GOOD for the old state
-and $TERM_BAD for the new state."
-		;;
-	1)
-		arg=$1
-		case "$arg" in
-			--term-good|--term-old)
-				printf '%s\n' "$TERM_GOOD"
-				;;
-			--term-bad|--term-new)
-				printf '%s\n' "$TERM_BAD"
-				;;
-			*)
-				die "$(eval_gettext "invalid argument \$arg for 'git bisect terms'.
-Supported options are: --term-good|--term-old and --term-bad|--term-new.")"
-				;;
-		esac
-		;;
-	*)
-		usage ;;
-	esac
-}
-

The fprintf() that says "no terms defined" can be made error().  The
"invalid argument" message used to be die in the original, and
should be sent to the standard error stream as you noticed.

But a bigger difference is that the original made sure that the
caller asked one question at a time.  "terms --term-good --term-bad"
was responded with a "usage".  That is no longer true in the
rewrite.


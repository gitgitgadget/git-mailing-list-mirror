Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2901A2055E
	for <e@80x24.org>; Thu, 26 Oct 2017 02:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbdJZCXO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 22:23:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52445 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751921AbdJZCXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 22:23:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03D499983D;
        Wed, 25 Oct 2017 22:23:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bL+VLC59D3Cbp9eGEZ+PjFC5QuE=; b=STMI7a
        vcPKgIR+MyvmtWExRnNJb0JoBb24323X5QSFwRZQAJHcwe2RhmCDbKFpIZCw9dZK
        qdWLGNx39cpMwAT4pgIYyklF+m8XzXyEK2vunxsPqJZj56joe/YD+W4gfg6YnhMM
        GE106+7EdFhoBQwdR37RLSJAePW9irouVSw60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VEWQoXw/1Q3QtGOYgFRUMrrUI49FRWrE
        LU+5S9a7jvEBmsqHMyOZISeRFhHI6GkVkHVHEhKOuK3U3hKe4tI5pSEszTardpWB
        B4OAjx1Xhkr8NfJsGw5rQ3lLp2hdwxPJMQiATgAP2GrEcYq19xseG69SsjsXrNw+
        Cy9WzBFovig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE6B89983C;
        Wed, 25 Oct 2017 22:23:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E8449983B;
        Wed, 25 Oct 2017 22:23:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        peff@peff.net
Subject: Re: [PATCH 2/2] diff.c: get rid of duplicate implementation
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
        <20171025184912.21657-1-sbeller@google.com>
        <20171025184912.21657-3-sbeller@google.com>
Date:   Thu, 26 Oct 2017 11:23:10 +0900
In-Reply-To: <20171025184912.21657-3-sbeller@google.com> (Stefan Beller's
        message of "Wed, 25 Oct 2017 11:49:12 -0700")
Message-ID: <xmqqy3nyfy0h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CF735D0-B9F4-11E7-968C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The implementations in diff.c to detect moved lines needs to compare
> strings and hash strings, which is implemented in that file, as well
> as in the xdiff library.
>
> Remove the rather recent implementation in diff.c and rely on the well
> exercised code in the xdiff lib.
> ...
>  static int moved_entry_cmp(const struct diff_options *diffopt,
>  			   const struct moved_entry *a,
>  			   const struct moved_entry *b,
>  			   const void *keydata)
>  {
> -	const char *ap = a->es->line, *ae = a->es->line + a->es->len;
> -	const char *bp = b->es->line, *be = b->es->line + b->es->len;
> - ...
> +	return !xdiff_compare_lines(a->es->line, a->es->len,
> +				    b->es->line, b->es->len,
> +				    diffopt->xdl_opts);
>  }

OK, xdiff's xdl_recmatch() takes counted strings, and line[len] is
one byte beyond the end of the line (where LF typically sits), which
is the same convention as how "emitted_symbol" represents a line, so
not just the implementation replaced with a known-working one, but
also the code calls the helper with correct calling convention ;-)

> -	ret->ent.hash = get_string_hash(l, o);
> +	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);

Likewise.  Looks good.

Will queue.

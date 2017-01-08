Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A18E205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 23:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbdAHXmf (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 18:42:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751936AbdAHXmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 18:42:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 667116086F;
        Sun,  8 Jan 2017 18:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2fcklzuVlJVsGiEZ8Cc8cY9WOlM=; b=UmJqYc
        GSOmbWJwr+kLApElu/HL59h9xbKd5Fd9j2uFyqmknxE/EJUjYjqyim5EPqRDQDMP
        MJke+ELjDIrMy1pvGcHSOz2n5vnXLE+ZS23AZywqfqFl4omA5+1IkZWLDx1G+gZS
        Ys7JBZqqEGSjBuUl0sv67M8HV4IJi9zGHhJiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ky8kGxf0bV0zPNQDxTWSXBfrbFBPVEQx
        5X5JJGE6U1JUd9KGoJ6HtHsB6uyQMHJU1UPgMOTuuKOZQYi3hUWzfli64sjhxK7R
        lCy0Gmybbq6/zcT+l2cs93bCp+EdkKnpWLaOCifWib9ZS/5R6YpQhSYYgIlgRbwa
        ftI80AiIhh0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A73F6086E;
        Sun,  8 Jan 2017 18:42:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 976F86086D;
        Sun,  8 Jan 2017 18:42:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, e@80x24.org, jnareb@gmail.com
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
References: <20170108191736.47359-1-larsxschneider@gmail.com>
Date:   Sun, 08 Jan 2017 15:42:30 -0800
In-Reply-To: <20170108191736.47359-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sun, 8 Jan 2017 20:17:36
        +0100")
Message-ID: <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F6216EE-D5FC-11E6-847C-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Some `clean` / `smudge` filters might require a significant amount of
> time to process a single blob. During this process the Git checkout
> operation is blocked and Git needs to wait until the filter is done to
> continue with the checkout.
>
> Teach the filter process protocol (introduced in edcc858) to accept the
> status "delayed" as response to a filter request. Upon this response Git
> continues with the checkout operation and asks the filter to process the
> blob again after all other blobs have been processed.

Hmm, I would have expected that the basic flow would become

	for each paths to be processed:
		convert-to-worktree to buf
		if not delayed:
			do the caller's thing to use buf
		else:
			remember path

	for each delayed paths:
		ensure filter process finished processing for path
		fetch the thing to buf from the process
		do the caller's thing to use buf

and that would make quite a lot of sense.  However, what is actually
implemented is a bit disappointing from that point of view.  While
its first part is the same as above, the latter part instead does:

	for each delayed paths:
		checkout the path

Presumably, checkout_entry() does the "ensure that the process is
done converting" (otherwise the result is simply buggy), but what
disappoints me is that this does not allow callers that call
"convert-to-working-tree", whose interface is obtain the bytestream 
in-core in the working tree representation, given an object in the
object-db representation in an in-core buffer, to _use_ the result
of the conversion.  The caller does not have a chance to even see
the result as it is written straight to the filesystem, once it
calls checkout_delayed_entries().

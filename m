Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E55FF20958
	for <e@80x24.org>; Wed, 29 Mar 2017 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932765AbdC2Uok (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 16:44:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752944AbdC2UnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 16:43:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BAB187F27;
        Wed, 29 Mar 2017 16:43:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DEucaYI4FLm2hA18XZEspaf3WvQ=; b=xfvXfR
        fY1rvw8CdcOeONa9I2M4Cjww/zylLSAaKg8KaHahTvhS1W4BhyzhHBoJouAbFAj5
        NirNELefr0U6STww4c7OVl8PlIlWEPBaCupbQVOZjCtDPCA5MeGBd8zqbYTWNBd5
        wEVak5J9H2pnPDlPtv0nkiDGQxle45diZKb4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MvFxziJZ6JXdNEdqeBOtnQyq8Ik8yxks
        +NVZGr5DI43oDKARchWvMnACO5VbtfAsLzKgR5IV9rlKIRnyBmSPfPjPs36b5h6U
        8dnaFSats11mTRmZ7mfE7VasDKNXvVmY9wKStYYPaxf0i/1mxFAXBVFsOUqfzPGI
        wzfZq/lvb5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94ADE87F26;
        Wed, 29 Mar 2017 16:43:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB3CD87F25;
        Wed, 29 Mar 2017 16:43:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 7/8] sub-process: move sub-process functions into separate files
References: <20170329155330.12860-1-benpeart@microsoft.com>
        <20170329155330.12860-8-benpeart@microsoft.com>
Date:   Wed, 29 Mar 2017 13:43:08 -0700
In-Reply-To: <20170329155330.12860-8-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 29 Mar 2017 11:53:29 -0400")
Message-ID: <xmqqmvc3ak6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52050EA0-14C0-11E7-9A4A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> +Types
> +-----
> +
> +'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
> +
> +	User-supplied function to initialize the sub-process.  This is
> +	typically used to negoiate the interface version and capabilities.
> +
> +
> +Functions
> +---------
> +
> +`subprocess_start`::
> +
> +	Start a subprocess and add it to the subprocess hashmap.
> +
> +`subprocess_stop`::
> +
> +	Kill a subprocess and remove it from the subprocess hashmap.
> +
> +`subprocess_find_entry`::
> +
> +	Find a subprocess in the subprocess hashmap.
> +
> +`subprocess_get_child_process`::
> +
> +	Get the underlying `struct child_process` from a subprocess.
> +
> +`subprocess_read_status`::
> +
> +	Helper function to read packets looking for the last "status=<foo>"
> +	key/value pair.

OK.

> diff --git a/sub-process.c b/sub-process.c
> new file mode 100644
> index 0000000000..2c4d27c193
> --- /dev/null
> +++ b/sub-process.c
> @@ -0,0 +1,116 @@
> +/*
> + * Generic implementation of background process infrastructure.
> + */
> +#include "sub-process.h"
> +#include "sigchain.h"
> +#include "pkt-line.h"
> + ...
> +void subprocess_exit_handler(struct child_process *process)
> +{

This is not only undocumented in the above, but it does not seem to
be necessary to be a public function.  The only thing that uses this
is subprocess_start(), which is in this file.  Perhaps make it static?

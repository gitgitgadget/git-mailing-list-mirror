Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EB31FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 19:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938625AbcLTTeI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 14:34:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964850AbcLTTeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 14:34:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00D8A59F2D;
        Tue, 20 Dec 2016 14:34:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gpbBAwjPVHSdxOuad8FqMxc94pI=; b=ZtoZiO
        SSx8mrHiolSV71F0l2Mg5QR/ZEsUq7vqwWEAWrmHnNgGlGhezlWTPp5bT8IJ2UWb
        an67CEZ4HRHgKmvaJlrBbFECNLfUxT3Y3bIsFYgMNCZgiMo9Nre5A6Ltj7bw/bJT
        XVY5x0raH9dFakb68TYlevAjfdOHR7f5fPgEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B6VffcK6i3rqDM2VeatH/pzPAeECwJIW
        TYXZ7bQ1GctYZEj5d0vCfz12OpnalGOdGZWpSBoVEOeqNhw3LQEcXgJ502vufxJM
        bJtrzmbm3M0+gDg+falDULVTs+BeMYCHiR9KzvGCJkonaatsHt5llnLq/UPwesC5
        jm3I+QSHMDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED71C59F2C;
        Tue, 20 Dec 2016 14:34:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7382759F2B;
        Tue, 20 Dec 2016 14:34:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, johan@herland.net
Subject: Re: [PATCH] fast-import: properly fanout notes when tree is imported
References: <20161219021212.15978-1-mh@glandium.org>
Date:   Tue, 20 Dec 2016 11:34:04 -0800
In-Reply-To: <20161219021212.15978-1-mh@glandium.org> (Mike Hommey's message
        of "Mon, 19 Dec 2016 11:12:12 +0900")
Message-ID: <xmqqk2aujsyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44C69EDE-C6EB-11E6-A616-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> In typical uses of fast-import, trees are inherited from a parent
> commit. In that case, the tree_entry for the branch looks like:
> ...
> +# Create another notes tree from the one above
> +cat >>input <<INPUT_END
> +...
> +M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) 

There is a trailing SP that cannot be seen by anybody.

Don't do this.  It makes it very easy to miss what is going on and
wastes reviewers' time.

Protect it by doing something like:

	sed -e 's/Z$//' >>input <<INPUT_END
	...
	M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) Z

Thanks.

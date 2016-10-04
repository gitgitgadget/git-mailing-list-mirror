Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD6920986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbcJDTaw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:30:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55175 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752140AbcJDTav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:30:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9169842029;
        Tue,  4 Oct 2016 15:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ln6x5ze2vnr+018QxV/9WMZPRw4=; b=D6empV
        VXOJwhjjjToHDu+jlDwLf7x0UxzZ+YQYDYORyebcN1zbO0yEXfxTwDmEXevNuJr5
        vVUByPOOblOMdFBsH1yRoox6Wu0LQkbJZw1g3v4YmhJmS+ujEH9iz5sjxCWwgDeU
        Y7/HfYZ13uhaQwtF6UVjItEFM3nT6MHn0uyuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iDDx3BahWdgLi2S4+utt7A4rv3+igHFt
        djil5vEFTVf/PNNiegWa7cZ8VxnEhGBk4+oMbza2aSk8JdsXTx3iKsKOGnPGeCZk
        d9tijVdeuLRCHEMH21PzBKvOva5jOIAooZUjwo76Xb4vFbKnJ1P+bLgqm+K+hUrC
        OsBr6AFZP7Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 866BB42028;
        Tue,  4 Oct 2016 15:30:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D96EB42025;
        Tue,  4 Oct 2016 15:30:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 04/14] run-command: add wait_on_exit
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-5-larsxschneider@gmail.com>
Date:   Tue, 04 Oct 2016 12:30:47 -0700
In-Reply-To: <20161004125947.67104-5-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Tue, 4 Oct 2016 14:59:37
        +0200")
Message-ID: <xmqqh98rud20.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E6EBA10-8A69-11E6-BF0F-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The flag 'clean_on_exit' kills child processes spawned by Git on exit.
> A hard kill like this might not be desired in all cases.
>
> Add 'wait_on_exit' which closes the child's stdin on Git exit and waits
> until the child process has terminated.
>
> The flag is used in a subsequent patch.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  run-command.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
>  run-command.h |  3 +++
>  2 files changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 3269362..96c54fe 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -21,6 +21,9 @@ void child_process_clear(struct child_process *child)
>
>  struct child_to_clean {
>  	pid_t pid;
> +	char *name;
> +	int stdin;
> +	int wait;
>  	struct child_to_clean *next;
>  };
>  static struct child_to_clean *children_to_clean;
> @@ -28,12 +31,33 @@ static int installed_child_cleanup_handler;
>
>  static void cleanup_children(int sig, int in_signal)
>  {
> +	int status;
> +	struct child_to_clean *p = children_to_clean;
> +
> +	/* Close the the child's stdin as indicator that Git will exit soon */
> +	while (p) {
> +		if (p->wait)
> +			if (p->stdin > 0)
> +				close(p->stdin);
> +		p = p->next;
> +	}

This part and the "stdin" field feels a bit too specific to the
caller you are adding.  Allowing the user of the API to specify what
clean-up cation needs to be taken in the form of a callback function
may not be that much more effort and would be more flexible and
useful, I would imagine?

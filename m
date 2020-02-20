Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B42C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2795420801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FtBf8O7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgBTUr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:47:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65119 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgBTUr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:47:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B40C2470F5;
        Thu, 20 Feb 2020 15:47:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IxHqO/4BmrgPMVNXmCngejyS+6Q=; b=FtBf8O
        7Ui10oYSen3vEHGn94Y5PV0/TTUcRd7cLzhP7ha58tMdTxXg6oX0hwilg5KwcBnF
        K4aD92c9j6aY2CgM9khjOhxbzBPLE2SkoSg4Gik+9roGeCC0ttgAjI/BHp1BL2ZS
        bvZ/BZwcmQcabcB7zpK2Pn4FiVf8ozwhLYGDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q8nNk/qI30WrKztz7iOQNPTWtmCALb8O
        29YSOcZ5m51R9G3EjTg5nKCREJ83Kke9iiL8GnkG1uQ6U/JOE7ELhUpC+WDTV1aE
        1bsTwCm/e/xMX1762OuWjxV6pHTXk48pnvMTFMaEJpA/U4A1HjeRSzzgiCMFvW4G
        aVeVC9GQyz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC399470F4;
        Thu, 20 Feb 2020 15:47:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12BD1470F3;
        Thu, 20 Feb 2020 15:47:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 10/15] bugreport: add config values from safelist
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-11-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 12:47:24 -0800
In-Reply-To: <20200220015858.181086-11-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:53 -0800")
Message-ID: <xmqqimk19ear.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33AF33F0-5422-11EA-BBF9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -94,6 +120,7 @@ int cmd_main(int argc, const char **argv)
>  	char *option_output = NULL;
>  	char *option_suffix = "%F-%H%M";
>  	struct stat statbuf;
> +	int nongit_ok = 0;
>  
>  	const struct option bugreport_options[] = {
>  		OPT_STRING('o', "output-directory", &option_output, N_("path"),
> @@ -102,6 +129,10 @@ int cmd_main(int argc, const char **argv)
>  			   N_("specify a strftime format suffix for the filename")),
>  		OPT_END()
>  	};
> +
> +	/* Prerequisite for hooks and config checks */
> +	setup_git_directory_gently(&nongit_ok);

Now this starts to break "-o" option when the command is run from a
subdirectory of a git working tree, I suspect.

The setup() will discover that you are in a Git controlled working
tree, goes up to the top-level of the working tree, so a user may
expect

	cd t && git bugreport -o frotz

to create a new directory t/frotz, but it would instead create the
directory frotz next to t/, no?

Using OPT_FILENAME and feeding correct prefix to parse_options()
will correct this.

>  	argc = parse_options(argc, argv, "", bugreport_options,
>  			     bugreport_usage, 0);

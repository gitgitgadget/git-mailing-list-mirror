Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979A61FF40
	for <e@80x24.org>; Thu, 15 Dec 2016 00:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934807AbcLOAC5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 19:02:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53126 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933775AbcLOACi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 19:02:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAC7B57264;
        Wed, 14 Dec 2016 18:56:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aNgR3kCDrSPwnjgnDOv+8jGoZ+Q=; b=SuZvoO
        jIpVGCxeN27mQTsmuOKQ9SBez+hpK6sjCgZIIErrluQnHWxUNVZcvI5HBQ0BioYA
        gbCfXmSxOVakcmlZe8caiVG6EADEoWBMlVpcN/ydqpqQdREiZqo2d2vOP7gYVsA8
        6C4pKY18pPmpQ1DQIFPSwYLJMi3RdWKRMUehc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IgCvVrvwaW6T3R6zXRSIgixVf2fnajda
        2K7gA8QUKhRZWvwwYJjfk18ChuQ8X63p9YNEfJCC91rmvQjZWsWncItFQemugY5e
        lzsT0oWKfLUYX2BfOOWuzWK0ypQKmPeMetjJGgyfNtlDl22BVcrUojCTmnsr7baP
        ouRyhGJBA08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7958A57263;
        Wed, 14 Dec 2016 18:56:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C38BE57260;
        Wed, 14 Dec 2016 18:55:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv3 4/4] rm: add absorb a submodules git dir before deletion
References: <20161214224101.6211-1-sbeller@google.com>
        <20161214224101.6211-5-sbeller@google.com>
Date:   Wed, 14 Dec 2016 15:55:58 -0800
In-Reply-To: <20161214224101.6211-5-sbeller@google.com> (Stefan Beller's
        message of "Wed, 14 Dec 2016 14:41:01 -0800")
Message-ID: <xmqqlgvivze9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCC47950-C258-11E6-B243-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  			if (list.entry[i].is_submodule) {
>  				if (is_empty_dir(path)) {
> +					if (rmdir(path))
> +						die_errno("git rm: '%s'", path);
> +				} else if (file_exists(path))
> +					/* non empty directory: */

Lose colon?

> +					remove_directory_or_die(path);

... otherwise?  I.e.

				else
					???

If we are running "git rm -f <path>", then the path could be a
submodule in the index and on the filesystem, it could be (1)
already missing, as the user removed an empty submodule directory
she is not interested in, (2) a non-directory, e.g. a file or a
symbolic link, perhaps because she was trying to reorganize the
superproject working tree but decided against it, or (3) something
else?

(1) is perfectly OK; we end up with a result without the path, which
is what "git rm -f" wanted to do anyway.  I am not sure what should
happen in (2), and what other corner cases there are for (3), though.

And use of file_exists(path) in the above patch may trigger a
strange error message in case (2), as remove_directory_or_die()
would say "path is not a directory", to which the user will say "Yes
I know, I wanted you to remove it with 'git rm -f'".




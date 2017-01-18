Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B793020C2E
	for <e@80x24.org>; Wed, 18 Jan 2017 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbdARUQu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:16:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55675 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750890AbdARUQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:16:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8092603D5;
        Wed, 18 Jan 2017 15:11:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QAIvfmui97NfMVN7DmISkzpwXx4=; b=S1GK0f
        JikK548rcG1Yrf4KD3M7OqbLrzpZ6d4oqkKej6czpAJd1tVb/tP+RyUZSwWojs2i
        iIGPaBOopOponqZc6GhcnWvju41u9D1QsC/3RpBGT7FK+BXR7XZdfYXa6E9CaGP6
        iNsOsTMsvf54NLIFQeK3ORga/QPrwGKABlQ3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DEHkdHbVIh3Z4l9GNnuxmCzxw9GxiGno
        7D6ZPXZMc33xpUF5S7x+wkJS7XWwd/QAnz6RQA3bRl5KKhMCAKBcpA+5m6FYu51Y
        URb45+f9wVGTMyYKlBuBlswLfRekj+fO04Aeppv/TCf4ZQi1dUleUGm7+ZMIbjA9
        jkJALfDSYII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FCBF603D4;
        Wed, 18 Jan 2017 15:11:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01E4E603D3;
        Wed, 18 Jan 2017 15:11:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 3/5] name-rev: add support to exclude refs by pattern match
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-4-jacob.e.keller@intel.com>
Date:   Wed, 18 Jan 2017 12:11:27 -0800
In-Reply-To: <20170118000930.5431-4-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 17 Jan 2017 16:09:28 -0800")
Message-ID: <xmqqtw8w86xc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C0213F0-DDBA-11E6-B264-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Extend name-rev further to support matching refs by adding `--exclude`
> patterns. These patterns will limit the scope of refs by excluding any
> ref that matches at least one exclude pattern. Checking the exclude refs
> shall happen first, before checking the include --refs patterns.

I do not think we should have this "exclude first and then include"
written down here, as it is an irrelevant implementation detail.
The desired end result is that only refs that match at least one
include and none of the exclude survive.  You could implement it by
first checking with include and then further narrowing that set by
filtering those that match exclude (I am not saying that "include
first then exclude" is better---I am saying that it is far less
important than "at least one include and none of the exclude" to
mention the order of application).

> +--exclude=<pattern>::
> +	Do not use any ref whose name matches a given shell pattern. The
> +	pattern can be one of branch name, tag name or fully qualified ref
> +	name. If given multiple times, exclude refs that match any of the given
> +	shell patterns. Use `--no-exclude` to clear the list of exclude
> +	patterns.

Perhaps insert

    When used together with --refs, only those that match at least
    one of the --refs patterns and none of the --exclude patterns
    are used.

before "Use `--no-exclude` to clear"?


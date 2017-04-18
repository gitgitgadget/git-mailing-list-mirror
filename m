Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF6E1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 02:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757311AbdDRCDI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 22:03:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61145 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757306AbdDRCDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 22:03:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BD91738FE;
        Mon, 17 Apr 2017 22:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IkoEQAogIso5bXSgjJKctqWvHcI=; b=nT2u82
        MTXsM3lTvviodnlLj080yztyGGasgWN0rRz2WukS4jtiMLz/W0Oh3c2rNID7lpYJ
        3wdQYnXwP0ust2NElVI4iELCmX2zgFhLWbp6CkEft/C+QnIs8dzEA6O5nAynqjT8
        LG7ZBRjp67oF8kwrdDymeiygu2uvZxEIPNWRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j5LmmQGmgoanyyoK0SLowhDnhofx9h3b
        RLllEBLqqFkFjD3DhqE0IPnP/Jbbl7ST5bbsi3nhFXifa3bbMGr84Sda4BB71GDC
        9XfBqSiz2L6Mrl28rCVNAB4uxgVfV2McVghdOufUA0kLxZ7d9Esy2PH2POT47ISV
        CI5ZmPmpxhI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B43738FD;
        Mon, 17 Apr 2017 22:03:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD8FE738FC;
        Mon, 17 Apr 2017 22:03:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: fix path used when recursing into submodules
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
        <20170413171224.3537-1-jacob.e.keller@intel.com>
        <20170413171224.3537-2-jacob.e.keller@intel.com>
Date:   Mon, 17 Apr 2017 19:03:04 -0700
In-Reply-To: <20170413171224.3537-2-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 13 Apr 2017 10:12:24 -0700")
Message-ID: <xmqqk26ih3qf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2962DE12-23DB-11E7-917F-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Don't assume that the current working directory is the root of the
> repository. Correctly generate the path for the recursing child
> processes by building it from the work_tree() root instead. Otherwise if
> we run ls-files using --git-dir or --work-tree it will not work
> correctly as it attempts to change directory into a potentially invalid
> location. Best case, it doesn't exist and we produce an error. Worst
> case we cd into the wrong location and unknown behavior occurs.
>
> Add a new test which highlights this possibility.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I'm not sure that I'm convinced by this method of solving the problem as
> I suspect it has some corner cases (what about when run inside a
> subdirectory? It seems to work for me but I'm not sure...) Additionally,
> it felt weird that there's no helper function for creating a toplevel
> relative path.

Is this a similar issue as discussed in a nearby thread e.g.

  <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>

I do think it is a bug that sometimes we do not go to the root of
the working tree when we know the repository is not a bare one.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F0B20756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdATXQu (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:16:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54389 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752392AbdATXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 18:16:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C81B61401;
        Fri, 20 Jan 2017 18:11:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DihW4zRfM3BiNsjpPsoKKe9MDl0=; b=TtvST5
        hxpOUiVKVUmSqbMmjPMJGSdCZfSJI0e8ZVg/ORpswLdz8OpOgo1jiMzGzYcrVd16
        WoEZdwgVCE++kX/+XwoMEqBF7zBufUSWLzrI3UBiHCpT7OCWta3COyfqpsBtWfTX
        yLAa/lA5pr1bily6W9vF5R8ksenC8G8qqRv4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MhKtdz2PA9UDtdq2SZE3t5bCv1lA9yxi
        NBnX0jV0+qFyDCuSg2v6i1l1ixaY61GZJ7BjqebhgIAJMPTBAKPC3AIakGjfmGcl
        hJFJY9GPVKVyxMkpoFIhGfEXVLJPGz9aLzXbZtrfZEa9rFh0QBTkPSmzDdVguI7w
        LCJ1HKUwbxU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 351DF61400;
        Fri, 20 Jan 2017 18:11:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A3F9613FC;
        Fri, 20 Jan 2017 18:11:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 0/2] grep: make output consistent with revision syntax
References: <20170120171126.16269-1-stefanha@redhat.com>
Date:   Fri, 20 Jan 2017 15:11:52 -0800
In-Reply-To: <20170120171126.16269-1-stefanha@redhat.com> (Stefan Hajnoczi's
        message of "Fri, 20 Jan 2017 17:11:24 +0000")
Message-ID: <xmqq1svxwclj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D55E6D04-DF65-11E6-ACFE-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> v2:
>  * Use obj->type instead of re-parsing name for delimiter
>    (Followed Brandon's suggestion but named the variable 'delim' since that
>    name is used in other places and 'del' is used for deletion.)
>  * Add tests
>  * Update Patch 1 commit description with a more relevant example
>  * PATCH instead of RFC, now works with all documented git-rev-parse(1) syntax
>
> git-grep(1)'s output is not consistent with git-rev-parse(1) revision syntax.

While I was queuing this series (which I think should become a
single patch in the final version), I was trying to see how it
should be described in the release note (aka an entry in the
periodicall "What's cooking" report).  Here is how I explained it.
You may want to borrow some parts of the description, especially the
part that talks about <tree-ish>:<path> being a way to name a blob,
when updating the commit log message.

     "git grep", when fed a tree-ish as an input, shows each hit
     prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
     almost always either a commit or a tag that points at a commit,
     the early part of the output "<tree-ish>:<path>" can be used as
     the name of the blob and given to "git show".  

     When <tree-ish> is a tree given in the extended SHA-1 syntax
     (e.g. "<commit>:", or "<commit>:<dir>"), however, this results
     in a string that does not name a blob (e.g. "<commit>::<path>"
     or "<commit>:<dir>:<path>").  "git grep" has been taught to be
     a bit more intelligent about these cases and omit a colon (in
     the former case) or use slash (in the latter case) to produce
     "<commit>:<path>" and "<commit>:<dir>/<path>" that can be used
     as the name of a blob.

As a release note entry is written in a style different from the
commit log message, you would need to adjust the voice of the last
sentence (i.e. "Teach 'git grep' to ..." to give an order to the
codebase), but otherwise the above would make an understandable
justification for the change suitable in a log message.


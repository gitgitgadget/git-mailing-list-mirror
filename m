Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B143202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdGFQxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 12:53:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56797 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751654AbdGFQxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 12:53:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F19895817
        for <git@vger.kernel.org>; Thu,  6 Jul 2017 12:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=i
        3cIfgHEiR1NGmNtPWK0efyWd48=; b=R63pHvJHtVk1jQz0YxbU01xQMs9m2F3Qo
        Jr1+uOOGwAoiAn9ywChB2JDR1RtYBjZNqe6Tad9GWto1GZtRBs7jUtMFTlwN6oz+
        i5vMU2sE1rtHH1URR1SvybSAO8SqEdvnVNhTaTu7q41qeQTpAuKBTaa0We+BExyN
        CUF8EsMGa4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9897B95816
        for <git@vger.kernel.org>; Thu,  6 Jul 2017 12:53:26 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 152EE95815
        for <git@vger.kernel.org>; Thu,  6 Jul 2017 12:53:26 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: name-rev: anchor pattern without --exclude?
Date:   Thu, 06 Jul 2017 12:53:25 -0400
Message-ID: <87k23ltsl6.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A10B0B00-626B-11E7-86FF-61520C78B957-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=mesmtp;
 bh=i3cIfgHEiR1NGmNtPWK0efyWd48=;
 b=ZCLXfbyJhsEJzO9rzua5fmnHWXI7WdBgDNR3o3CkodTWLT79La4QnwUiaGF15HJ/DGTVrTRUyptisB/acG2KS4fJYZjjpOUY0ir6HlMJFZ/013RYtB0eXQQ5FKS6x3yNvuSBuJbTMbhxqkm17P1CkWxLQybhhxcd3MdkoYjB1Jg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to restrict name-rev's output to a ref whose name begins with
the supplied pattern [*].  Looking at "man git-name-rev",
builtin/name-rev.c, and wildmatch.c, I don't see a way to accomplish
this with "--refs=<pattern>".

Say, for example, that I want to limit name-rev's output to a ref in the
"refs/heads/" namespace.

    * cc8f7dc (master) c
    * ad6d6f0 b
    | * 49a2156 (refs/wip/wtree/refs/heads/master) d
    |/  
    * b91f97a a

    --------------------------------------------------

    $ git name-rev b91f97a
    b91f97a wip/wtree/refs/heads/master~1

    $ git name-rev --refs="refs/heads/*" b91f97a
    b91f97a wip/wtree/refs/heads/master~1

    $ git name-rev --refs="^refs/heads/*" b91f97a
    b91f97a undefined

Starting with v2.13.0, I can get my desired output using the --exclude
option.

    $ git name-rev --refs="refs/heads/*" --exclude="*/refs/heads/*" b91f97a
    b91f97a master~2

But, unfortunately, I'm trying to find a solution that works with
earlier Git versions (back to v1.9.4).

Am I overlooking a way to do this without the --exclude option?


[*] A bit more information on why I'm trying to do this: In Magit, we
    have a work-in-progress feature that takes "snapshots" of changes
    before they are committed.  These snapshots are stored as
    "refs/wip/{wtree,index}/<full refname>".

    We want to use name-rev to map a commit to a name in "refs/heads/",
    ignoring these snapshot refs.

-- 
Kyle

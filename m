Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F339201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 03:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbdBQD6g (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 22:58:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754965AbdBQD6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 22:58:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A7716A015;
        Thu, 16 Feb 2017 22:58:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=2xx2
        AujAPhB0bily48UIR+IGAGo=; b=l9uZt6VgT2Zztf3ohu9112ij3pMMxB6dUFIV
        wOootpGzr72u1i6GRsnDqsDvj60dIgVYnEuV67g4EsToLkx/UcMqxlzlUSUFDfDR
        oncJzc9/skrvSUCcQ4NlIfxjm33LVsE1bMtCmBbNLCL6hi+IBlnGNMjMKPCPp7vm
        kDhNKs4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 703796A014;
        Thu, 16 Feb 2017 22:58:33 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C90626A013;
        Thu, 16 Feb 2017 22:58:32 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 0/3] delete_ref(): support reflog messages
Date:   Thu, 16 Feb 2017 22:57:57 -0500
Message-Id: <20170217035800.13214-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
X-Pobox-Relay-ID: 5989FA70-F4C5-11E6-B9F1-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=2xx2AujAPhB0bily48UIR+IGAGo=;
 b=LoUchcQ+72mqv5/iusw8TNwoFrOYD1tdE5hCuRLvSj3W06HB/fubveB1IgSSfz9rlObSVRMXZJ8KPb4+bOIM4jAnt9V2gICJ7GXoIY2qsHa4PPG0AKPq7FkL+WQc6ANueqk028r93/2NLgjfhjD5+I89KK/I0TDXk00p36xQTP0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Sorry for the slow response.]

Jeff King <peff@peff.net> writes:

> On Mon, Jan 16, 2017 at 06:17:29PM -0500, Kyle Meyer wrote:

[...]

>>    $ cat .git/logs/refs/heads/new-master
>>    00000... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	commit (initial): Add file.txt
>>    68730... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	Branch: renamed refs/heads/master to refs/heads/new-master
>> 
>>    $ cat .git/logs/HEAD
>>    00000... 68730... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500	commit (initial): Add file.txt
>>    68730... 00000... Kyle Meyer <kyle@kyleam.com> 1484607020 -0500
>> 
>> I expected the second line of .git/logs/HEAD to mirror the second line
>> of .git/logs/refs/heads/new-master.  Are the empty message and null sha1
>> in HEAD's entry intentional?
>
> The null sha1 is correct, I think. The branch we were on went away, and
> we use the null sha1 to indicate "no value" in both the creation and
> deletion cases.

I see, thanks.

> I'd say there are two potential improvements:
>
>   - delete_ref() should take a reflog message argument, in case it
>     updates the HEAD reflog (as a bonus, this will future-proof us for a
>     day when we might keep reflogs for deleted refs).

I've tried to do this in the following patches.

>   - "git branch -m" does seem to realize when we are renaming HEAD,
>     because it updates HEAD to point to the new branch name. But it
>     should probably insert another reflog entry mentioning the rename
>     (we do for "git checkout foo", even when "foo" has the same sha1 as
>     the current HEAD).

I haven't worked out how to do this part yet.  I'm guessing the change
will involve modifying split_head_update().

If this is added, should it be instead of, rather than in addition to,
the deletion entry?  If a "Branch: renamed ..." entry is present, it
doesn't seem like the deletion entry is providing any additional
information.

  delete_refs(): accept a reflog message argument
  update-ref: pass reflog message argument to delete_refs
  rename_ref: replace empty deletion message in HEAD's log

 builtin/am.c           |  4 ++--
 builtin/branch.c       |  2 +-
 builtin/notes.c        |  4 ++--
 builtin/remote.c       |  4 ++--
 builtin/replace.c      |  2 +-
 builtin/reset.c        |  2 +-
 builtin/symbolic-ref.c |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  2 +-
 fast-import.c          |  2 +-
 refs.c                 |  4 ++--
 refs.h                 |  2 +-
 refs/files-backend.c   | 12 +++++++++---
 t/t1400-update-ref.sh  |  9 +++++++++
 t/t3200-branch.sh      |  4 ++++
 transport.c            |  2 +-
 16 files changed, 39 insertions(+), 20 deletions(-)

-- 
Kyle

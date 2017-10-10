Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31C320372
	for <e@80x24.org>; Tue, 10 Oct 2017 04:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbdJJEGI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 00:06:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62145 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750734AbdJJEGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 00:06:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83FDAAC875;
        Tue, 10 Oct 2017 00:06:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=jYUf
        mSTDM9c7HHSWubEZJSAh7w8=; b=wnpuQoXqZDeJMdvAsiBXeJYV2Fryj1Dd8axL
        JXxypT9AbTSbFdfI8czzBkK4tpeKSoBPEHdQZ0qdnLxHV3FeN8pBp21mxobVjDFM
        A4V8UW5NH/y487lGzLpJSUQWigTb22dkHk1I+0okLS2zI+bQAnK7NFsPsGeSdxKU
        O9eFVlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=grN8eH
        NQeUqzH9uWskawi2rTj2ndgySJksP7P4fwHnTDiKJh51CcS+bHF5iFzk6n4aAXEM
        yeTdJyOVUsZAmkm/wLUksennXZQFAOMCzsHNUlSAjAn2xtcudHckG0o+Jk6HyhHJ
        afeKeZxPLGL726V3hMRC+ZHrbbXrD7kATutgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DB38AC874;
        Tue, 10 Oct 2017 00:06:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02AFDAC873;
        Tue, 10 Oct 2017 00:06:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] Do not call cmd_*() as a subroutine
Date:   Tue, 10 Oct 2017 13:06:02 +0900
Message-Id: <20171010040604.26029-1-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc0-209-g4adfc7b6b1
In-Reply-To: <xmqqr2vlbgyk.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2vlbgyk.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 56ADBAD0-AD70-11E7-B34D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches are for a recent #leftoverbits topic.

https://public-inbox.org/git/xmqqr2vlbgyk.fsf@gitster.mtv.corp.google.com/

The cmd_foo() function is a moral equivalent of 'main' for a Git
subcommand 'git foo', and as such, it is allowed to do many things
that make it unsuitable to be called as a subroutine, including

 - call exit(3) to terminate the process;

 - allocate resource held and used throughout its lifetime, without
   releasing it upon return/exit;

 - rely on global variables being initialized at program startup,
   and update them as needed, making another clean invocation of the
   function impossible.

Correcting two callers by using helper API calls is not so hard.

Junio C Hamano (2):
  describe: do not use cmd_*() as a subroutine
  merge-ours: do not use cmd_*() as a subroutine

 builtin/describe.c   | 15 +++++++++++----
 builtin/merge-ours.c | 16 +++++++---------
 2 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.15.0-rc0-203-g4c8d0e28b1


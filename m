Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBDE2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 11:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdBYL73 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 06:59:29 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:51309 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdBYL72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 06:59:28 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id hb0Tcdgqn0Kuvhb0TcxKGK; Sat, 25 Feb 2017 11:59:21 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=yPCof4ZbAAAA:8
 a=clbsBA0K9W4MtGXOd3MA:9 a=wPNLvfGTeEIA:10 a=2lfDSYhZ3Z6b8uxcDO-Z:22
Message-ID: <E14B054C79E1450F8B41E6477D1D7CD1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Michal Zalewski" <lcamtuf@google.com>,
        "Vegard Nossum" <vegard.nossum@oracle.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty files
Date:   Sat, 25 Feb 2017 11:59:22 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMiUsyqwS7OF5BQtfLDgUh6X/FupnDaeg4wZvBafV0Fc9NgGin+w73eUngq4/DalNV3co1m/MA8ANjisCWjqdxl0sIoboPZbLAWFSz+2Y8euNZjzxRZZ
 3pI9G8SRcgZ7qK7IQWMhb5BuQ0x5yRPWAytgnPzaqUF9YTig2KXvDzxR2spXcZ15MrBxjOcnxo67ZUti6s6xvC+jOKxzDYpqv1O2d8gWgrn+3gu+8PdQALNG
 D0tauAn6jqvX0RieFtvt3n9KD9dfPv1thZIaVO5tV6/LBHRaQ/sDVLO/AFzUJGyXl3QsVMr8TVjLhiBrCi9DZ7SVdbxdNARvQASphNimTus=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Vegard Nossum" <vegard.nossum@oracle.com>
> If we have a patch like the one in the new test-case, then we will

"the one in the new test-case" needs a clearer reference to the particular 
case so that future readers will know what it refers to. Noticed while 
browsing the commit message..

..reads further; Maybe it's "AFL (American fuzzy lop) found a failure. Add a 
new test case and fix the fault"?

[same for patch 2]

> try to rename a non-existant empty file, i.e. patch->old_name will
> be NULL. In this case, a NULL entry will be added to fn_table, which
> is not allowed (a subsequent binary search will die with a NULL
> pointer dereference).
>
> The patch file is completely bogus as it tries to rename something
> that is known not to exist, so we can throw an error for this.
>
> Found using AFL.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
> apply.c                     |  3 ++-
> t/t4154-apply-git-header.sh | 15 +++++++++++++++
> 2 files changed, 17 insertions(+), 1 deletion(-)
> create mode 100755 t/t4154-apply-git-header.sh
>
> diff --git a/apply.c b/apply.c
> index 0e2caeab9..cbf7cc7f2 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1585,7 +1585,8 @@ static int find_header(struct apply_state *state,
>  patch->old_name = xstrdup(patch->def_name);
>  patch->new_name = xstrdup(patch->def_name);
>  }
> - if (!patch->is_delete && !patch->new_name) {
> + if ((!patch->is_delete && !patch->new_name) ||
> +     (patch->is_rename && !patch->old_name)) {
>  error(_("git diff header lacks filename information "
>       "(line %d)"), state->linenr);
>  return -128;
> diff --git a/t/t4154-apply-git-header.sh b/t/t4154-apply-git-header.sh
> new file mode 100755
> index 000000000..d651af4a2
> --- /dev/null
> +++ b/t/t4154-apply-git-header.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +test_description='apply with git/--git headers'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'apply old mode / rename new' '
> + test_must_fail git apply << EOF
> +diff --git a/1 b/1
> +old mode 0
> +rename new 0
> +EOF
> +'
> +
> +test_done
> -- 
> 2.12.0.rc0
--
Philip 


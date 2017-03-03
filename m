Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BEF20133
	for <e@80x24.org>; Fri,  3 Mar 2017 23:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdCCX2d (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 18:28:33 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:28586 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdCCX2c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 18:28:32 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id jwbwcVDOUxR4bjwbwcINJ2; Fri, 03 Mar 2017 23:27:45 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=lIb7LMJwnlYBHqQ_TQoA:9 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <D9E30A61FAC84D3B90981B388C9699D0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
References: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
Subject: Re: bisect-helper: we do not bisect --objects
Date:   Fri, 3 Mar 2017 23:27:45 -0000
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
X-CMAE-Envelope: MS4wfAqonaCBijBwgg3QgCAF8iLImltsblTbHrcpUSXthktN0bZ+M5DJfeZ9WHNSv5vygpp8QUGHG76qtg605X9bI9wBEhGsNipYkakGYRMDJuQVP3R5sCLh
 xSQFz4PyF9O6uraHatPG+YQAK3fk2Luvss02yjexWgyzHIquVifJcvGIeybbJYE8l8Ze+NEfQprAK+GYAH1cJ+d1SrUbAoPZ3eFtsEFuqhBO/Xv/X647MQ0M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Ever since "bisect--helper" was introduced in 1bf072e366
> ("bisect--helper: implement "git bisect--helper"", 2009-03-26),
> after setting up the "rev-list $bad --not $good_ones" machinery, the
> code somehow prepared to mark the trees and blobs at the good boundary
> as uninteresting, only when --objects option was given.  This was kept
> across a bit of refactoring done by 2ace9727be ("bisect: move common
> bisect functionality to "bisect_common"", 2009-04-19) and survives
> to this day.
>
> However, "git bisect" does not care about tree/blob object
> reachability at all---it purely works at the commit DAG level and
> nobody passes (and nobody should pass) "--objects" option to the
> underlying rev-list machinery.  Remove the dead code.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> * Christian, do you recall what we were thinking when we added this
>   mark_edges_uninteresting() call in this program?  If you don't,
>   don't worry--this was done more than 8 years ago.  I am just
>   being curious and also a bit being cautious in case I am missing
>   something.
>

Bikeshedding: If the given boundary is a tag, it could be tagging a blob or 
tree rather than a commit. Would that be a scenario that reaches this part 
of the code? I thought I read previous comments that there is a case in the 
Linux tree.
--
Philip

>   Thanks.
>
> bisect.c | 2 --
> 1 file changed, 2 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 30808cadf7..86c5929a23 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -634,8 +634,6 @@ static void bisect_common(struct rev_info *revs)
> {
>  if (prepare_revision_walk(revs))
>  die("revision walk setup failed");
> - if (revs->tree_objects)
> - mark_edges_uninteresting(revs, NULL);
> }
>
> static void exit_if_skipped_commits(struct commit_list *tried,
> 


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D58C1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbdDLVZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 17:25:15 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:51106 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdDLVZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 17:25:14 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id yPlHcCVqsxR4byPlHcrHjQ; Wed, 12 Apr 2017 22:25:12 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=B_Y78o2058XGELlzKBMA:9 a=wPNLvfGTeEIA:10
Message-ID: <64236D980AD8478AA295BD7C263479FF@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, <bmwill@google.com>
Cc:     <git@vger.kernel.org>, <jrnieder@gmail.com>, <gitster@pobox.com>,
        "Stefan Beller" <sbeller@google.com>
References: <20170411234923.1860-1-sbeller@google.com> <20170411234923.1860-2-sbeller@google.com>
Subject: Re: [PATCH 1/4] entry.c: submodule recursing: respect force flag correctly
Date:   Wed, 12 Apr 2017 12:28:51 +0100
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
X-CMAE-Envelope: MS4wfCqgy2NQcT8g+b3uPaKkPzUTdAMgl7jlU9esGJ2KFdNQUCNSutpzymLGMgFw3e1UuaM4JwdK3zkoYvPWNOZr8zj//3mki+9ixigvelmebNvkJUCuiN1i
 fqmOq53OvebYriEk5cMKWY7sR/HoLkP1qJB5JfezUtzmgYWi7fUGUDErI9lEzl1TG5BQG3hVA4vy13sN79mrQODWUlIHODKYhnAiKkl4hatdQw4ty7X+hYXc
 uhMxrY/0zkfqOlDzLXRhWPGyfZGCG6ajQwSnv/j4lQlFJT5mJ7MdOQFFecVZWpxToiuu7clFpp0/kl1Aen9RpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> In case of a non-forced worktree update, the submodule movement is tested
> in a dry run first, such that it doesn't matter if the actual update is
> done via the force flag. However for correctness, we want to give the
> flag is specified by the user. All callers have been inspected and updated
s/flag is/flag as/

> if needed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
--
Philip


> entry.c        | 8 ++++----
> unpack-trees.c | 7 ++++++-
> 2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index d2b512da90..d6b263f78e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -208,7 +208,8 @@ static int write_entry(struct cache_entry *ce,
>  sub = submodule_from_ce(ce);
>  if (sub)
>  return submodule_move_head(ce->name,
> - NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
> + NULL, oid_to_hex(&ce->oid),
> + state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>  break;
>  default:
>  return error("unknown file mode for %s in index", path);
> @@ -282,12 +283,11 @@ int checkout_entry(struct cache_entry *ce,
>  unlink_or_warn(ce->name);
>
>  return submodule_move_head(ce->name,
> - NULL, oid_to_hex(&ce->oid),
> - SUBMODULE_MOVE_HEAD_FORCE);
> + NULL, oid_to_hex(&ce->oid), 0);
>  } else
>  return submodule_move_head(ce->name,
>  "HEAD", oid_to_hex(&ce->oid),
> - SUBMODULE_MOVE_HEAD_FORCE);
> + state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>  }
>
>  if (!changed)
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8333da2cc9..7316ca99c2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -252,14 +252,18 @@ static int check_submodule_move_head(const struct 
> cache_entry *ce,
>       const char *new_id,
>       struct unpack_trees_options *o)
> {
> + unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
>  const struct submodule *sub = submodule_from_ce(ce);
>  if (!sub)
>  return 0;
>
> + if (o->reset)
> + flags |= SUBMODULE_MOVE_HEAD_FORCE;
> +
>  switch (sub->update_strategy.type) {
>  case SM_UPDATE_UNSPECIFIED:
>  case SM_UPDATE_CHECKOUT:
> - if (submodule_move_head(ce->name, old_id, new_id, 
> SUBMODULE_MOVE_HEAD_DRY_RUN))
> + if (submodule_move_head(ce->name, old_id, new_id, flags))
>  return o->gently ? -1 :
>  add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
>  return 0;
> @@ -308,6 +312,7 @@ static void unlink_entry(const struct cache_entry *ce)
>  case SM_UPDATE_CHECKOUT:
>  case SM_UPDATE_REBASE:
>  case SM_UPDATE_MERGE:
> + /* state.force is set at the caller. */
>  submodule_move_head(ce->name, "HEAD", NULL,
>      SUBMODULE_MOVE_HEAD_FORCE);
>  break;
> -- 
> 2.12.2.603.g7b28dc31ba
>
> 


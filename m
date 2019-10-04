Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E894C1F4BE
	for <e@80x24.org>; Fri,  4 Oct 2019 02:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfJDCvQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 22:51:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33566 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbfJDCvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 22:51:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4B05D1F4BD;
        Fri,  4 Oct 2019 02:51:15 +0000 (UTC)
Date:   Fri, 4 Oct 2019 02:51:15 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
Message-ID: <20191004025115.GA26605@dcvr>
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-19-e@80x24.org>
 <xmqqr23t8g0t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr23t8g0t.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > In the future, list iterator macros (e.g. list_for_each_entry)
> > may also be implemented using OFFSETOF_VAR to save hackers the
> > trouble of using container_of/list_entry macros and without
> > relying on non-portable `__typeof__'.
> 
> Can we add something like this as a preliminary preparation step
> before the series?
> 
> Subject: [PATCH] treewide: initialize pointers to hashmap entries
> 
> There are not strictly necessary, but some compilers (e.g. clang
> 6.0.1) apparently have trouble in construct we will use in the
> OFFSETOF_VAR() macro, i.e.
> 
>     ((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
> 
> when the ptr is uninitialized.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  attr.c                              | 2 +-
>  blame.c                             | 4 ++--
>  builtin/describe.c                  | 2 +-
>  builtin/difftool.c                  | 2 +-
>  config.c                            | 2 +-
>  merge-recursive.c                   | 6 +++---
>  revision.c                          | 4 ++--
>  submodule-config.c                  | 2 +-
>  t/helper/test-hashmap.c             | 2 +-
>  t/helper/test-lazy-init-name-hash.c | 4 ++--
>  10 files changed, 15 insertions(+), 15 deletions(-)

That seems too tedious.  I'm learning towards just initializing
var = NULL in the start of the for-loop:

@@ -449,7 +449,8 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
  * containing a @member which is a "struct hashmap_entry"
  */
 #define hashmap_for_each_entry(map, iter, var, member) \
-	for (var = hashmap_iter_first_entry_offset(map, iter, \
+	for (var = NULL /* squelch uninitialized warnings for OFFSETOF_VAR */, \
+		var = hashmap_iter_first_entry_offset(map, iter, \
 						OFFSETOF_VAR(var, member)); \
 		var; \
 		var = hashmap_iter_next_entry_offset(iter, \


(But I'm running on fumes all week, so not sure I trust it)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B7C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 03:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiFODs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 23:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFODsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 23:48:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7B4F1F8
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 20:48:21 -0700 (PDT)
Received: (qmail 7199 invoked by uid 109); 15 Jun 2022 03:48:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jun 2022 03:48:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Tue, 14 Jun 2022 23:48:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Message-ID: <YqlWhKDFX3KESY0h@coredump.intra.peff.net>
References: <xmqqfskdieqz.fsf@gitster.g>
 <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
 <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
 <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
 <Yqk9uMS5kxHD6o7l@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yqk9uMS5kxHD6o7l@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 10:02:32PM -0400, Taylor Blau wrote:

> --- >8 ---
> 
> diff --git a/string-list.h b/string-list.h
> index d5a744e143..425abc55f4 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -143,7 +143,7 @@ int for_each_string_list(struct string_list *list,
> 
>  /** Iterate over each item, as a macro. */
>  #define for_each_string_list_item(item,list)            \
> -	for (item = (list)->items;                      \
> +	for (item = (list) ? (list)->items : NULL;      \
>  	     item && item < (list)->items + (list)->nr; \
>  	     ++item)
> 
> --- 8< ---
> 
> > but even with your suggestion, I get this compiler error:
> 
> ...so did I. Though I'm not sure I understand the compiler's warning
> here. Surely the thing being passed as list in the macro expansion
> _won't_ always evaluate to non-NULL, will it?

In the general case, no, but in this specific expansion of the macro, it
is passing the address of a local variable (&cpath), which will never be
NULL. The compiler is overeager here; the check is indeed pointless in
this expansion, but warning on useless macro-expanded code isn't
helpful, since other macro users need it.

Hiding it in a function seems to work, even with -O2 inlining, like:

diff --git a/string-list.h b/string-list.h
index d5a744e143..b28b135e11 100644
--- a/string-list.h
+++ b/string-list.h
@@ -141,9 +141,14 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t func, void *cb_data);
 
+static inline struct string_list_item *string_list_first_item(const struct string_list *list)
+{
+	return list ? list->items : NULL;
+}
+
 /** Iterate over each item, as a macro. */
 #define for_each_string_list_item(item,list)            \
-	for (item = (list)->items;                      \
+	for (item = string_list_first_item(list);       \
 	     item && item < (list)->items + (list)->nr; \
 	     ++item)
 

-Peff

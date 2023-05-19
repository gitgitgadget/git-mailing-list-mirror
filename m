Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653F8C77B7D
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjESAzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjESAzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:55:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67019A6
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:54:52 -0700 (PDT)
Received: (qmail 6583 invoked by uid 109); 19 May 2023 00:54:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:54:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27168 invoked by uid 111); 19 May 2023 00:54:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:54:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:54:47 -0400
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce
 '[--[no-]separator|--separator=<paragraph-break>]' option
Message-ID: <20230519005447.GA2955320@coredump.intra.peff.net>
References: <cover.1684411136.git.dyroneteng@gmail.com>
 <820dda0458994fdf7ff37870736ce6ed7871720c.1684411136.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <820dda0458994fdf7ff37870736ce6ed7871720c.1684411136.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 08:02:09PM +0800, Teng Long wrote:

> +static void insert_separator(struct strbuf *message, size_t pos)
> +{
> +	if (!separator)
> +		return;
> +	else if (separator[strlen(separator) - 1] == '\n')
> +		strbuf_insertstr(message, pos, separator);
> +	else
> +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> +}

This function causes UBSan to complain on 'next' (though curiously only
with clang, not with gcc[1]). The version in next seems to be from your
v9, but it's largely the same except for the "if (!separator)"
condition.

The problem is in the middle condition here. If "separator" is non-NULL,
but is an empty string, then strlen() will return 0, and we will look at
the out-of-bounds byte just before the string.

We'd probably want something like this:

diff --git a/builtin/notes.c b/builtin/notes.c
index 3215bce19b..a46d6dac5c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -231,7 +231,8 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 
 static void insert_separator(struct strbuf *message, size_t pos)
 {
-	if (separator[strlen(separator) - 1] == '\n')
+	size_t sep_len = strlen(separator);
+	if (sep_len && separator[sep_len - 1] == '\n')
 		strbuf_addstr(message, separator);
 	else
 		strbuf_insertf(message, pos, "%s%s", separator, "\n");

to fix it, though I am not 100% clear on what is supposed to happen for
an empty separator here.

I was also confused that applying the fix on top of the culprit in
'next', 3993a53a13 (notes.c: introduce '--separator=<paragraph-break>'
option, 2023-04-28), still leads to test failures in t3301. But I think
that is independent of this fix. It fails even without my patch above
(and without UBSan) in test 66, "append: specify separator with line
break". But the failure goes away in the following patch, ad3d1f8feb
(notes.c: append separator instead of insert by pos, 2023-04-28).

I haven't been following this series enough to know what's going on, but
you may want to figure out where the failure is coming from in
3993a53a13. If the change in ad3d1f8feb is merely papering over it, then
we'd need to find and fix the true cause. If the bug is really fixed by
ad3d1f8feb, we might want to squash those two together to avoid broken
bisections.

-Peff

[1] To reproduce, I did:

      git checkout 3993a53a13
      make SANITIZE=address,undefined CC=clang
      cd t && ./t3301-notes.sh -v -i

    I'm using clang-14 on a Debian machine.

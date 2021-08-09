Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B930C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5391960231
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhHIVBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:01:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:42770 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233102AbhHIVBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:01:16 -0400
Received: (qmail 3255 invoked by uid 109); 9 Aug 2021 21:00:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 21:00:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2457 invoked by uid 111); 9 Aug 2021 21:00:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 17:00:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 17:00:54 -0400
From:   Jeff King <peff@peff.net>
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: improve java regex for generic return types
Message-ID: <YRGXhqW0BmKQdeZu@coredump.intra.peff.net>
References: <20210809203308.30128-1-tsdh@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210809203308.30128-1-tsdh@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 09, 2021 at 10:33:08PM +0200, Tassilo Horn wrote:

> Currently, the git diff hunk headers show the wrong method signature if the
> method has a generic return type because the regex doesn't allow < and > in the
> return type.  This patch adds those.

Thanks. It has been long enough since I used Java that there were no
generics back then, but I will take your word that this is what they
look like. ;)

The patch itself looks OK to me, but...

> when adding the number 6 to the Arrays.asList() call in secondMethod(), the git
> diff one gets is
> 
> --8<---------------cut here---------------start------------->8---
> diff --git a/src/main/java/MyExample.java b/src/main/java/MyExample.java
> index a0f1a6b..ea37a98 100644
> --- a/src/main/java/MyExample.java
> +++ b/src/main/java/MyExample.java
> @@ -14,6 +14,6 @@ public void firstMethod() {
>          // followed by this,
>          // and that,
>          // and even more.
> -        return Arrays.asList(1, 2, 3, 4, 5);
> +        return Arrays.asList(1, 2, 3, 4, 5, 6);
>      }
>  }
> --8<---------------cut here---------------end--------------->8---

...this diff in the commit message will screw up git-am. The usual
procedure is to omit the scissors lines and just indent it.

But...

>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

...even better than explaining it is adding a regression test, perhaps
like this one:

diff --git a/t/t4018/java-return-generic b/t/t4018/java-return-generic
new file mode 100644
index 0000000000..d030c26184
--- /dev/null
+++ b/t/t4018/java-return-generic
@@ -0,0 +1,10 @@
+class MyExample {
+    public void firstMethod() {
+        // Whatever...
+    }
+
+    public List<String> secondMethod(String RIGHT[]) {
+        // Whatever...
+        return Arrays.asList("ChangeMe");
+    }
+}

(the "ChangeMe" line will be changed, and we'll expect that the line
with "RIGHT" on it is found. We use -U1 to reduce the need for filler).

-Peff

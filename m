Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600CC7EE23
	for <git@archiver.kernel.org>; Wed, 24 May 2023 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjEXW6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEXW6K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 18:58:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B831899
        for <git@vger.kernel.org>; Wed, 24 May 2023 15:58:08 -0700 (PDT)
Received: (qmail 25875 invoked by uid 109); 24 May 2023 22:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 May 2023 22:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28951 invoked by uid 111); 24 May 2023 22:58:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 May 2023 18:58:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 May 2023 18:58:07 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] builtin/submodule--helper.c: handle missing submodule
 URLs
Message-ID: <20230524225807.GA904398@coredump.intra.peff.net>
References: <ZG4jcceXn2G6Xic0@nand.local>
 <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2023 at 12:02:26PM -0400, Taylor Blau wrote:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6bf8d666ce..a7b7ea374f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2024,8 +2024,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "submodule.%s.url", sub->name);
>  	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
> -		if (starts_with_dot_slash(sub->url) ||
> -		    starts_with_dot_dot_slash(sub->url)) {
> +		if (sub->url && (starts_with_dot_slash(sub->url) ||
> +				 starts_with_dot_dot_slash(sub->url))) {
>  			url = resolve_relative_url(sub->url, NULL, 0);
>  			need_free_url = 1;
>  		} else

Oh, btw, this need_free_url made me look at the memory handling for the
other side of the else. I think it is all good, but it would be a little
simpler using an extra pointer instead of a boolean:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6a16208e8a..6b7849b828 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1984,7 +1984,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 						      ud->super_prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-	int need_free_url = 0;
+	char *to_free_url = NULL;
 
 	if (ce_stage(ce)) {
 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
@@ -2025,10 +2025,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (sub->url && (starts_with_dot_slash(sub->url) ||
-				 starts_with_dot_dot_slash(sub->url))) {
-			url = resolve_relative_url(sub->url, NULL, 0);
-			need_free_url = 1;
-		} else
+				 starts_with_dot_dot_slash(sub->url)))
+			url = to_free_url = resolve_relative_url(sub->url, NULL, 0);
+		else
 			url = sub->url;
 	}
 
@@ -2089,8 +2088,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 cleanup:
 	free(displaypath);
 	strbuf_release(&sb);
-	if (need_free_url)
-		free((void*)url);
+	free(to_free_url);
 
 	return needs_cloning;
 }

Probably at this point that is just churn, but I thought I'd throw it
out there.

-Peff

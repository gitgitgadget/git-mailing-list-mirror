Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64326C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjFLDNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFLDND (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:13:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE01E67
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:12:44 -0700 (PDT)
Received: (qmail 21613 invoked by uid 109); 12 Jun 2023 03:12:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:12:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11583 invoked by uid 111); 12 Jun 2023 03:12:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:12:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:12:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 01/11] rev-parse: fix a leak with --abbrev-ref
Message-ID: <20230612031239.GA306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <dc821efb-bf2a-10bb-4547-98d4ba11dbb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc821efb-bf2a-10bb-4547-98d4ba11dbb3@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:49:17PM +0200, Rubén Justo wrote:

> To handle "--abbrev-ref" we use shorten_unambiguous_ref().  This
> function takes a refname and returns a shortened refname, which is a
> newly allocated string that needs to be freed.
> 
> Unfortunately, the refname variable is reused to receive the shortened
> one.  Therefore, we lose the original refname, which needs to be freed
> as well, producing a leak.

Makes sense, but...

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 852e49e340..9fd7095431 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -141,7 +141,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
>  	if ((symbolic || abbrev_ref) && name) {
>  		if (symbolic == SHOW_SYMBOLIC_FULL || abbrev_ref) {
>  			struct object_id discard;
> -			char *full;
> +			char *full, *to_free = NULL;
>  
>  			switch (repo_dwim_ref(the_repository, name,
>  					      strlen(name), &discard, &full,
> @@ -156,9 +156,11 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
>  				 */
>  				break;
>  			case 1: /* happy */
> -				if (abbrev_ref)
> +				if (abbrev_ref) {
> +					to_free = full;
>  					full = shorten_unambiguous_ref(full,
>  						abbrev_ref_strict);
> +				}
>  				show_with_type(type, full);
>  				break;
>  			default: /* ambiguous */
> @@ -166,6 +168,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
>  				break;
>  			}
>  			free(full);
> +			free(to_free);
>  		} else {
>  			show_with_type(type, name);
>  		}

The lifetime of "to_free" is much longer than it needs to be here. We'd
usually use a "to_free" pattern when the memory is aliased to another
(usually const) pointer, and the allocation needs to live as long as
that other pointer. But here, nobody cares about the old value as soon
as we replace it. We could almost just free() it ahead of time, but of
course we also need to pass it to the shortening function. So maybe:

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e340..6dc8548e1f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -156,9 +156,12 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 				 */
 				break;
 			case 1: /* happy */
-				if (abbrev_ref)
-					full = shorten_unambiguous_ref(full,
+				if (abbrev_ref) {
+					char *old = full;
+					full = shorten_unambiguous_ref(old,
 						abbrev_ref_strict);
+					free(old);
+				}
 				show_with_type(type, full);
 				break;
 			default: /* ambiguous */

-Peff

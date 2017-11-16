Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5887C202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 19:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933514AbdKPT5Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 14:57:24 -0500
Received: from avasout04.plus.net ([212.159.14.19]:39263 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751140AbdKPT5X (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2017 14:57:23 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id FQHoeX0zczbmWFQHpe9WIS; Thu, 16 Nov 2017 19:57:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=6f9Tyc_Vhj3ZW55LlUkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 07/10] introduce fetch-object: fetch one promisor
 object
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
References: <20171116181257.61673-1-git@jeffhostetler.com>
 <20171116181257.61673-8-git@jeffhostetler.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e7b5e42f-b13c-50c8-501c-0100d8c48d00@ramsayjones.plus.com>
Date:   Thu, 16 Nov 2017 19:57:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171116181257.61673-8-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGW4b1NOJf5BKENQ2EkkRL5XS2fk4YMsaIKb6hNsf6jZdvxFQ3xRYQbKtE9Fu6MQODQNeZzZ7BVTgREpCWg5Aly6Sn4hq2w6Tp37cC6raZkvhPPK6PRs
 MnasTjkxCmpf5c1QkjHUqYOVIe2c+GN+SfdKKO7agMBOsU62NJQpXejkMkTuVH0iehT6UOqNUZgeaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/11/17 18:12, Jeff Hostetler wrote:
> From: Jonathan Tan <jonathantanmy@google.com>
> 
> Introduce fetch-object, providing the ability to fetch one object from a
> promisor remote.
> 
> This uses fetch-pack. To do this, the transport mechanism has been
> updated with 2 flags, "from-promisor" to indicate that the resulting
> pack comes from a promisor remote (and thus should be annotated as such
> by index-pack), and "no-haves" to suppress the sending of "have" lines.
> 
> This will be tested in a subsequent commit.
> 
> NEEDSWORK: update this when we have more information about protocol v2,
> which should allow a way to suppress the ref advertisement and
> officially allow any object type to be "want"-ed.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/gitremote-helpers.txt |  6 ++++++
>  Makefile                            |  1 +
>  builtin/fetch-pack.c                |  8 ++++++++
>  builtin/index-pack.c                | 16 +++++++++++++---
>  fetch-object.c                      | 23 +++++++++++++++++++++++
>  fetch-object.h                      |  6 ++++++
>  fetch-pack.c                        |  8 ++++++--
>  fetch-pack.h                        |  2 ++
>  remote-curl.c                       | 14 +++++++++++++-
>  transport.c                         |  8 ++++++++
>  transport.h                         |  8 ++++++++
>  11 files changed, 94 insertions(+), 6 deletions(-)
>  create mode 100644 fetch-object.c
>  create mode 100644 fetch-object.h
> 
[snip]
> diff --git a/fetch-object.c b/fetch-object.c
> new file mode 100644
> index 0000000..f89dbba
> --- /dev/null
> +++ b/fetch-object.c
> @@ -0,0 +1,23 @@
> +#include "cache.h"
> +#include "packfile.h"
> +#include "pkt-line.h"
> +#include "strbuf.h"
> +#include "transport.h"

I note that this still does not #include "fetch_object.h".
[If you recall, this suppresses a sparse warning].

> +
> +void fetch_object(const char *remote_name, const unsigned char *sha1)
> +{
> +	struct remote *remote;
> +	struct transport *transport;
> +	struct ref *ref;
> +
> +	remote = remote_get(remote_name);
> +	if (!remote->url[0])
> +		die(_("Remote with no URL"));
> +	transport = transport_get(remote, remote->url[0]);
> +
> +	ref = alloc_ref(sha1_to_hex(sha1));
> +	hashcpy(ref->old_oid.hash, sha1);
> +	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
> +	transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
> +	transport_fetch_refs(transport, ref);
> +}
> diff --git a/fetch-object.h b/fetch-object.h
> new file mode 100644
> index 0000000..f371300
> --- /dev/null
> +++ b/fetch-object.h
> @@ -0,0 +1,6 @@
> +#ifndef FETCH_OBJECT_H
> +#define FETCH_OBJECT_H
> +
> +extern void fetch_object(const char *remote_name, const unsigned char *sha1);
> +
> +#endif

ATB,
Ramsay Jones



Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E99FC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 12:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiBIMsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIMsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 07:48:17 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DBC05CB96
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 04:48:18 -0800 (PST)
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nHmON-0002DP-Do; Wed, 09 Feb 2022 12:48:16 +0000
Message-ID: <e21c4f77-061c-d125-97cb-1a8cb7692e56@iee.email>
Date:   Wed, 9 Feb 2022 12:48:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_fetch_=e2=80=94object-info-format=3a?=
 =?UTF-8?Q?_client_option_for_object-info?=
Content-Language: en-GB
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
References: <20220208231911.725273-1-calvinwan@google.com>
 <20220208235631.732466-1-calvinwan@google.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220208235631.732466-1-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/02/2022 23:56, Calvin Wan wrote:
> Add ‘—object-info-format’ option to fetch. This option allows
> the client to make an object-info [1] command request to a server
> that supports protocol v2.
>
> The transport implementation uses vtables [2], similar to how Git
> fetches refs, to determine whether a process needs to be taken over
> before sending the object-info request. Different protocols
> require different setups for making requests.
>
> [1] https://lore.kernel.org/git/20210420233830.2181153-1-bga@google.com/
> [2] https://lore.kernel.org/git/26f276956001a120cc9105b0071762c2fd4a45c5.15=
> 13287544.git.jonathantanmy@google.com/
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
>
> ---
> Please ignore the patch above. It was sent with a stale patch message.
>  builtin/fetch.c              | 26 ++++++++++++
>  fetch-pack.c                 | 53 +++++++++++++++++++++++
>  fetch-pack.h                 |  7 ++++
>  t/t5583-fetch-object-info.sh | 81 ++++++++++++++++++++++++++++++++++++
>  transport-helper.c           | 12 ++++++
>  transport-internal.h         |  1 +
>  transport.c                  | 59 ++++++++++++++++++++++++++
>  transport.h                  |  1 +
>  8 files changed, 240 insertions(+)
>  create mode 100755 t/t5583-fetch-object-info.sh
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5f06b21f8e..b48d9e93d0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -29,6 +29,9 @@
>  #include "commit-graph.h"
>  #include "shallow.h"
>  #include "worktree.h"
> +#include "protocol.h"
> +#include "pkt-line.h"
> +#include "connect.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -37,6 +40,7 @@ static const char * const builtin_fetch_usage[] = {
>  	N_("git fetch [<options>] <group>"),
>  	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
>  	N_("git fetch --all [<options>]"),
> +	N_("git fetch --object-info-format=[<arguments>] <remote> [<object-ids>]"),
>  	NULL
>  };

Doesn't this also need a matching Documentarian update for the option?
--
Philip

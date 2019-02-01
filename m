Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903A71F453
	for <e@80x24.org>; Fri,  1 Feb 2019 15:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfBAPqI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 10:46:08 -0500
Received: from avasout05.plus.net ([84.93.230.250]:42326 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfBAPqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 10:46:06 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id pb10gccD3yTttpb12gCN0f; Fri, 01 Feb 2019 15:46:04 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=XuzUx2N9 c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=d5Xu0gnGMx4Q3oPxdcYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 5/8] evolve: add the change-table structure
To:     sxenos@google.com, git@vger.kernel.org
References: <20190201030925.177124-1-sxenos@google.com>
 <20190201030925.177124-5-sxenos@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f9c093bb-0225-1e0a-94ed-3854fa1f9ee2@ramsayjones.plus.com>
Date:   Fri, 1 Feb 2019 15:46:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201030925.177124-5-sxenos@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL7fQfypEjlP6spB/dIlJUNBnIESJ7DQrHpOk6tEgProYeXegD9ERNysLTSHlpEjqGEn+B83RyOF2rd3eePyekrAD2OzqDrMo6uQMb6DQ4sQYwUtDQ4D
 k5g7Ma9P7jXz+H/QZ4BaK2C7gCvTSCY8U+7gHA7IIzQX8DOME44hnqd6LQYDlsFHaL00xH3IDveunA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/02/2019 03:09, sxenos@google.com wrote:
> From: Stefan Xenos <sxenos@google.com>
> 
> A change table stores a list of changes, and supports efficient lookup
> from a commit hash to the list of changes that reference that commit
> directly.
> 
> It can be used to look up content commits or metacommits at the head
> of a change, but does not support lookup of commits referenced as part
> of the commit history.
> 
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> ---
>  Makefile       |   1 +
>  change-table.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
>  change-table.h | 127 +++++++++++++++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 change-table.c
>  create mode 100644 change-table.h
> 

[snip]

> diff --git a/change-table.h b/change-table.h
> new file mode 100644
> index 0000000000..023bca37d1
> --- /dev/null
> +++ b/change-table.h
> @@ -0,0 +1,127 @@
> +#ifndef CHANGE_TABLE_H
> +#define CHANGE_TABLE_H
> +
> +#include "oidmap.h"
> +
> +struct commit;
> +struct ref_filter;
> +
> +/*
> + * This struct holds a list of change refs. The first element is stored inline,
> + * to optimize for small lists.
> + */
> +struct change_list {
> +	/* Ref name for the first change in the list, or null if none.
> +	 *
> +	 * This field is private. Use for_each_change_in to read.
> +	 */
> +	const char* first_refname;
> +	/* List of additional change refs. Note that this is empty if the list
> +	 * contains 0 or 1 elements.
> +	 *
> +	 * This field is private. Use for_each_change_in to read.
> +	 */
> +	struct string_list additional_refnames;
> +};
> +
> +/*
> + * Holds information about the head of a single change.
> + */
> +struct change_head {
> +	/*
> +	 * The location pointed to by the head of the change. May be a commit or a
> +	 * metacommit.
> +	 */
> +	struct object_id head;
> +	/*
> +	 * The content commit for the latest commit in the change. Always points to a
> +	 * real commit, never a metacommit.
> +	 */
> +	struct object_id content;
> +	/*
> +	 * Abandoned: indicates that the content commit should be removed from the
> +	 * history.
> +	 *
> +	 * Hidden: indicates that the change is an inactive change from the
> +	 * hiddenmetas namespace. Such changes will be hidden from the user by
> +	 * default.
> +	 *
> +	 * Deleted: indicates that the change has been removed from the repository.
> +	 * That is the ref was deleted since the time this struct was created. Such
> +	 * entries should be ignored.
> +	 */
> +	int abandoned:1,
> +		hidden:1,
> +		remote:1,
> +		deleted:1;

This causes sparse to issue errors about 'dubious one-bit signed
bitfield' for each of these fields (and for each file which #includes
this header file).

The field type should be 'unsigned int', thus:

-- >8 --
diff --git a/change-table.h b/change-table.h
index 85bb19c3bf..1c385e076e 100644
--- a/change-table.h
+++ b/change-table.h
@@ -50,10 +50,10 @@ struct change_head {
         * That is the ref was deleted since the time this struct was created. Such
         * entries should be ignored.
         */
-       int abandoned:1,
-               hidden:1,
-               remote:1,
-               deleted:1;
+       unsigned int abandoned:1,
+                       hidden:1,
+                       remote:1,
+                       deleted:1;
 };
 
 /*
-- >8 --

[Note: this diff was against the v3 series].

ATB,
Ramsay Jones


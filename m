Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6802E1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 20:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeHKXXp (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:23:45 -0400
Received: from avasout06.plus.net ([212.159.14.18]:38790 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHKXXp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 19:23:45 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id oao8fy73qWLW2oao9fN3AB; Sat, 11 Aug 2018 21:48:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=u4tT1PhwpFZb8IjNPuEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bc9f21c6-b362-2e3f-1820-7da93a76a7c8@ramsayjones.plus.com>
Date:   Sat, 11 Aug 2018 21:48:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBQH/lGl7nz7NzT/BBPjTaUTnSOJRNfcmCSsTYvXF7lxmaopf0pMbXJojKge27d55nyJu7o0kJB16nFgNQB7IkFsnT8+LFha+jSOPNEPpADFO7DURjdt
 33ZWi40NZl0dbax8dqnEB5sUI+WRn1je4Jiheknmziy0DTnNP+hENWvh8SJFdpK/PxpBG39NzcuTQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/08/18 16:47, René Scharfe wrote:
> Object IDs to skip are stored in a shared static oid_array.  Lookups do
> a binary search on the sorted array.  The code checks if the object IDs
> are already in the correct order while loading and skips sorting in that
> case.
> 
> Simplify the code by using an oidset instead.  Memory usage is a bit
> higher, but lookups are done in constant time and there is no need to
> worry about any sort order.
> 
> Embed the oidset into struct fsck_options to make its ownership clear
> (no hidden sharing) and avoid unnecessary pointer indirection.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  fsck.c | 23 ++---------------------
>  fsck.h |  8 +++++---
>  2 files changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/fsck.c b/fsck.c
> index 83f4562390..9246afee22 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -10,7 +10,6 @@
>  #include "fsck.h"
>  #include "refs.h"
>  #include "utf8.h"
> -#include "sha1-array.h"
>  #include "decorate.h"
>  #include "oidset.h"
>  #include "packfile.h"
> @@ -182,19 +181,10 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
>  
>  static void init_skiplist(struct fsck_options *options, const char *path)
>  {
> -    static struct oid_array skiplist = OID_ARRAY_INIT;
> -    int sorted;
>      FILE *fp;
>      struct strbuf sb = STRBUF_INIT;
>      struct object_id oid;
>  
> -    if (options->skiplist)
> -        sorted = options->skiplist->sorted;
> -    else {
> -        sorted = 1;
> -        options->skiplist = &skiplist;
> -    }
> -
>      fp = fopen(path, "r");
>      if (!fp)
>          die("Could not open skip list: %s", path);
> @@ -202,17 +192,10 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>          const char *p;
>          if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>              die("Invalid SHA-1: %s", sb.buf);
> -        oid_array_append(&skiplist, &oid);
> -        if (sorted && skiplist.nr > 1 &&
> -                oidcmp(&skiplist.oid[skiplist.nr - 2],
> -                       &oid) > 0)
> -            sorted = 0;
> +        oidset_insert(&options->skiplist, &oid);
>      }
>      fclose(fp);
>      strbuf_release(&sb);
> -
> -    if (sorted)
> -        skiplist.sorted = 1;
>  }
>  
>  static int parse_msg_type(const char *str)
> @@ -317,9 +300,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
>  
>  static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
>  {
> -    if (opts && opts->skiplist && obj)
> -        return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
> -    return 0;
> +    return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
>  }
>  
>  __attribute__((format (printf, 4, 5)))
> diff --git a/fsck.h b/fsck.h
> index c3cf5e0034..26120e6186 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -1,6 +1,8 @@
>  #ifndef GIT_FSCK_H
>  #define GIT_FSCK_H
>  
> +#include "oidset.h"
> +
>  #define FSCK_ERROR 1
>  #define FSCK_WARN 2
>  #define FSCK_IGNORE 3
> @@ -34,12 +36,12 @@ struct fsck_options {
>      fsck_error error_func;
>      unsigned strict:1;
>      int *msg_type;
> -    struct oid_array *skiplist;
> +    struct oidset skiplist;
>      struct decoration *object_names;
>  };
>  
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }

Note that a NULL initialiser, for the object_names field, is missing
(not introduced by this patch). Since you have bumped into the 80th
column, you may not want to add that NULL to the end of these macros
(it is not _necessary_ after all). However, ... :-D

Otherwise, LGTM.

Thanks!

ATB,
Ramsay Jones

>  
>  /* descend in all linked child objects
>   * the return value is:

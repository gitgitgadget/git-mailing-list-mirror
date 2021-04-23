Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253AC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A4F61422
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbhDWOhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:37:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:33446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242583AbhDWOhp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 10:37:45 -0400
Received: (qmail 7559 invoked by uid 109); 23 Apr 2021 14:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 14:37:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9104 invoked by uid 111); 23 Apr 2021 14:37:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 10:37:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 10:37:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 5/6] fsck: report invalid types recorded in objects
Message-ID: <YILbk34nwqCPmxGQ@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
 <patch-5.6-5fb6ac4faee-20210413T093734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-5fb6ac4faee-20210413T093734Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 11:43:08AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Continue the work in the preceding commit and improve the error on:
> 
>     $ git hash-object --stdin -w -t garbage --literally </dev/null
>     $ git fsck
>     error: hash mismatch for <OID_PATH> (expected <OID>)
>     error: <OID>: object corrupt or missing: <OID_PATH>
>     [ other fsck output ]
> 
> To instead emit:
> 
>     $ git fsck
>     error: <OID>: object is of unknown type 'garbage': <OID_PATH>
>     [ other fsck output ]

Sounds good.

> @@ -92,7 +93,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  	switch (opt) {
>  	case 't':
>  		oi.type_name = &sb;
> -		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
> +		ret = oid_object_info_extended(the_repository, &oid, &oi, flags);
> +		if (!unknown_type && ret < 0)
>  			die("git cat-file: could not get object info");
>  		if (sb.len) {
>  			printf("%s\n", sb.buf);

Surprised to see changes to cat-file here, since the commit message is
all about fsck. Did the semantics of oid_object_info_extended() change?
I.e., this hunk implies to me that it is now returning -1 when we said
unknown types were OK, and we got one. But in that case, how do we
distinguish that from a real error?

Or more concretely, this patch causes this:

  $ git cat-file -t 1234567890123456789012345678901234567890
  fatal: git cat-file: could not get object info

  $ git.compile cat-file --allow-unknown-type -t 1234567890123456789012345678901234567890
  fatal: git cat-file 1234567890123456789012345678901234567890: bad file

Or much worse, from the next hunk:

  $ git cat-file -s 1234567890123456789012345678901234567890
  fatal: git cat-file: could not get object info

  $ git cat-file --allow-unknown-type -s 1234567890123456789012345678901234567890
  140732113568960

That seems wrong (so I think my "this hunk implies" is not true, but
then I am left with: what is the point of this hunk?).

-Peff

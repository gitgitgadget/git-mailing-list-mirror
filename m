Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18236C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhKVRFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:05:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:36370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234435AbhKVRFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:05:22 -0500
Received: (qmail 20594 invoked by uid 109); 22 Nov 2021 17:02:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 17:02:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21134 invoked by uid 111); 22 Nov 2021 17:02:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 12:02:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 12:02:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 2/5] upload-archive: use regular "struct child_process"
 pattern
Message-ID: <YZvNFhpHDImF8g19@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 05:04:04PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This pattern added [1] in seems to have been intentional, but since
> [2] and [3] we've wanted do initialization of what's now the "struct
> strvec" "args" and "env_array" members. Let's not trample on that
> initialization here.

Yes, I came across this one, too, while looking at the same topic. I
think this is a good change, but:

>  int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>  {
> -	struct child_process writer = { argv };
> +	struct child_process writer = CHILD_PROCESS_INIT;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(upload_archive_usage);
> @@ -92,6 +92,9 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>  	argv[0] = "upload-archive--writer";

You can drop this assignment over argv[0] now.

>  	writer.out = writer.err = -1;
>  	writer.git_cmd = 1;
> +	strvec_push(&writer.args, "upload-archive--writer");
> +	if (argc > 1)
> +		strvec_pushv(&writer.args, &argv[1]);

The "argc > 1" isn't necessary. If it is not true, strvec_pushv() will
see the terminating NULL in the list and just become a noop.

(I'd also spell it "argv + 1" to make it more obvious that we are
interested in the list and not a single element, but that may be a
matter of taste).

-Peff

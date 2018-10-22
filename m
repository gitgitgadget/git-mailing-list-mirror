Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53EF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeJWG4F (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:56:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:49910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726457AbeJWG4F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:56:05 -0400
Received: (qmail 17712 invoked by uid 109); 22 Oct 2018 22:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Oct 2018 22:35:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11716 invoked by uid 111); 22 Oct 2018 22:34:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Oct 2018 18:34:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2018 18:35:36 -0400
Date:   Mon, 22 Oct 2018 18:35:36 -0400
From:   Jeff King <peff@peff.net>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] archive: initialize archivers earlier
Message-ID: <20181022223536.GB19019@sigill.intra.peff.net>
References: <cover.1539990488.git.steadmon@google.com>
 <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 02:48:11PM -0700, steadmon@google.com wrote:

> Initialize archivers as soon as possible when running git-archive and
> git-upload-archive. Various non-obvious behavior depends on having the
> archivers initialized, such as determining the desired archival format
> from the provided filename.
> 
> Since 08716b3c11 ("archive: refactor file extension format-guessing",
> 2011-06-21), archive_format_from_filename() has used the registered
> archivers to match filenames (provided via --output) to archival
> formats. However, when git-archive is executed with --remote, format
> detection happens before the archivers have been registered. This causes
> archives from remotes to always be generated as TAR files, regardless of
> the actual filename (unless an explicit --format is provided).
> 
> This patch fixes that behavior; archival format is determined properly
> from the output filename, even when --remote is used.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> Helped-by: Jeff King <peff@peff.net>

Thanks, this looks good overall.

A few minor comments (that I'm not even sure are worth re-rolling for):

> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 25d9116356..3f35ebcfe8 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -43,6 +43,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	/* parse all options sent by the client */
> +	init_archivers();
>  	return write_archive(sent_argv.argc, sent_argv.argv, prefix,
>  			     the_repository, NULL, 1);
>  }

This seems to separate the comment from what it describes. Any reason
not to just init_archivers() closer to the top of the function here
(probably after the enter_repo() call)?

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 2a97b27b0a..3e95fdf660 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -206,6 +206,12 @@ test_expect_success 'git archive with --output, override inferred format' '
>  	test_cmp_bin b.tar d4.zip
>  '
>  
> +test_expect_success GZIP 'git archive with --output and --remote uses expected format' '
> +	git archive --output=d5.tgz --remote=. HEAD &&
> +	gzip -d -c < d5.tgz > d5.tar &&
> +	test_cmp_bin b.tar d5.tar
> +'

This nicely tests the more-interesting tgz case. But unfortunately it
won't run on machines without the GZIP prerequisite. I'd think that
would really be _most_ machines, but is it worth having a separate zip
test to cover machines without gzip? I guess that just creates the
opposite problem: not everybody has ZIP.

-Peff

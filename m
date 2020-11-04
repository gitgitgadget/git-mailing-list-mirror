Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB668C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49669205ED
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgKDT0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:26:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:47720 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbgKDT0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 14:26:47 -0500
Received: (qmail 10923 invoked by uid 109); 4 Nov 2020 19:26:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 19:26:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13882 invoked by uid 111); 4 Nov 2020 19:26:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 14:26:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 14:26:45 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Postler <johannes.postler@txture.io>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: [PATCH v2] format-patch --output
Message-ID: <20201104192645.GA3059114@coredump.intra.peff.net>
References: <CAO9fQ5pm2vCGrnj59QZg-fJ8VpnrsNoaVXRqd_Lsuw6rEaN3XQ@mail.gmail.com>
 <20201104132428.GA2491189@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104132428.GA2491189@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 08:24:28AM -0500, Jeff King wrote:

> The issue is that "--output" was never supposed to work with
> format-patch. But a subtle change in the option parsing a while back
> caused it to be respected. And as you noticed, the documentation
> mistakenly mentions the option, since format-patch includes the standard
> diff-options text.
> 
> So one obvious fix would be to forbid it and adjust the documentation.
> But because of the way the option parsers interact, it's surprisingly
> hard to do so cleanly. It's actually easier to just make it do something
> useful (i.e., behave like --stdout but sent to a file). So I did that
> instead.
> 
>   [1/3]: format-patch: refactor output selection
>   [2/3]: format-patch: tie file-opening logic to output_directory
>   [3/3]: format-patch: support --output option

Here's a re-roll taking into account the comments from Eric. The only
thing I didn't do is rewrite --output as a format-patch option. As I
said in the thread, I'd rather keep parity with how git-log works here
(though I don't mind if somebody wants to do further clean up on top).

  [1/3]: format-patch: refactor output selection
  [2/3]: format-patch: tie file-opening logic to output_directory
  [3/3]: format-patch: support --output option

 builtin/log.c           | 37 ++++++++++++++++++++++---------------
 t/t4014-format-patch.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 15 deletions(-)


Range diff from v1:

1:  49e8b54549 ! 1:  9206d6852b format-patch: refactor output selection
    @@ Commit message
         slightly easier to follow now, and also will keep things sane when we
         add another output mode in a future patch.
     
    +    We'll add a few tests as well, covering the mutual exclusion and the
    +    fact that we are not confused by a configured output directory.
    +
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## builtin/log.c ##
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
     -	if (!output_directory && !use_stdout)
     -		output_directory = config_output_directory;
     +	if (use_stdout + !!output_directory > 1)
    -+		die(_("specify only one of --stdout, --output, and --output-directory"));
    ++		die(_("--stdout and --output-directory are mutually exclusive"));
      
     -	if (!use_stdout)
     -		output_directory = set_outdir(prefix, output_directory);
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		/*
      		 * We consider <outdir> as 'outside of gitdir', therefore avoid
      		 * applying adjust_shared_perm in s-c-l-d.
    +
    + ## t/t4014-format-patch.sh ##
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch -o overrides format.outputDirectory' '
    + 	test_path_is_dir patchset
    + '
    + 
    ++test_expect_success 'format-patch forbids multiple outputs' '
    ++	rm -fr outdir &&
    ++	test_must_fail \
    ++		git format-patch --stdout --output-directory=outdir
    ++'
    ++
    ++test_expect_success 'configured outdir does not conflict with output options' '
    ++	rm -fr outfile outdir &&
    ++	test_config format.outputDirectory outdir &&
    ++	git format-patch --stdout &&
    ++	test_path_is_missing outdir
    ++'
    ++
    + test_expect_success 'format-patch --base' '
    + 	git checkout patchid &&
    + 
2:  884c06861d ! 2:  9dc30924b2 format-patch: tie file-opening logic to output_directory
    @@ Commit message
         format-patch: tie file-opening logic to output_directory
     
         In format-patch we're either outputting to stdout or to individual files
    -    in an output directory (which maybe just "./"). Our logic for whether to
    -    open a new file for each patch is checked with "!use_stdout", but it is
    -    equally correct to check for a non-NULL output_directory.
    +    in an output directory (which may be just "./"). Our logic for whether
    +    to open a new file for each patch is checked with "!use_stdout", but it
    +    is equally correct to check for a non-NULL output_directory.
     
         The distinction will matter when we add a new single-stream output in a
         future patch, when only one of the three methods will want individual
3:  8befceb150 ! 3:  2b0fab9b50 format-patch: support --output option
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		load_display_notes(&rev.notes_opt);
      
     -	if (use_stdout + !!output_directory > 1)
    +-		die(_("--stdout and --output-directory are mutually exclusive"));
     +	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
    - 		die(_("specify only one of --stdout, --output, and --output-directory"));
    ++		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
      
      	if (use_stdout) {
      		setup_pager();
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success 'format-patch -o overrides format.outputDirectory' '
    - 	test_path_is_dir patchset
    - '
    - 
    -+test_expect_success 'format-patch forbids multiple outputs' '
    -+	rm -fr outfile outdir &&
    + test_expect_success 'format-patch forbids multiple outputs' '
    + 	rm -fr outdir &&
    + 	test_must_fail \
    +-		git format-patch --stdout --output-directory=outdir
    ++		git format-patch --stdout --output-directory=outdir &&
     +	test_must_fail \
     +		git format-patch --stdout --output=outfile &&
     +	test_must_fail \
    -+		git format-patch --stdout --output-directory=outdir &&
    -+	test_must_fail \
     +		git format-patch --output=outfile --output-directory=outdir
    -+'
    -+
    -+test_expect_success 'configured outdir does not conflict with output options' '
    -+	rm -fr outfile outdir &&
    -+	test_config format.outputDirectory outdir &&
    -+	git format-patch --stdout &&
    + '
    + 
    + test_expect_success 'configured outdir does not conflict with output options' '
    + 	rm -fr outfile outdir &&
    + 	test_config format.outputDirectory outdir &&
    + 	git format-patch --stdout &&
     +	test_path_is_missing outdir &&
     +	git format-patch --output=outfile &&
    -+	test_path_is_missing outdir
    -+'
    -+
    + 	test_path_is_missing outdir
    + '
    + 
     +test_expect_success 'format-patch --output' '
     +	rm -fr outfile &&
     +	git format-patch -3 --stdout HEAD >expect &&

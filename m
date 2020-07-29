Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A2C433E4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44632207FC
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgG2AWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:22:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:40774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgG2AWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:22:33 -0400
Received: (qmail 31873 invoked by uid 109); 29 Jul 2020 00:22:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 00:22:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31704 invoked by uid 111); 29 Jul 2020 00:22:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 20:22:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 20:22:31 -0400
From:   Jeff King <peff@peff.net>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/18] maintenance: add commit-graph task
Message-ID: <20200729002231.GA1636139@coredump.intra.peff.net>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <04552b1d2ed751a11eb7c50f6898cbc078b552b4.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04552b1d2ed751a11eb7c50f6898cbc078b552b4.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:27PM +0000, Derrick Stolee via GitGitGadget wrote:

> +static int run_write_commit_graph(void)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +
> +	argv_array_pushl(&cmd, "commit-graph", "write",
> +			 "--split", "--reachable", NULL);
> +
> +	if (opts.quiet)
> +		argv_array_push(&cmd, "--no-progress");
> +
> +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +	argv_array_clear(&cmd);
> +
> +	return result;
> +}

This is a pretty minor nit, but since I happened to be looking at the
merge of all of the recent argv_array callers today... :)

You can write this a bit more succinctly by reusing the argv_array
provided by the child_process:

  struct child_process cmd = CHILD_PROCESS_INIT;

  cmd.git_cmd = 1;
  argv_array_pushl(&cmd.args, "commit-graph", "write",
                   "--split", "--reachable", NULL);

  if (opts.quiet)
          argv_array_push(&cmd.args, "--no-progress");

  return run_command(&cmd);

Then you don't have to worry about freeing the argv memory, because it's
handled automatically.

Like I said, quite minor, but it looks like this pattern appears in a
few places, so it might be worth tweaking. And it would still work with
the "pushf" people recommended to avoid extra strbufs (I saw another one
in fetch_remote(), too).

-Peff

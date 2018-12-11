Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68F420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 09:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLKJ46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 04:56:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:37834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbeLKJ46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 04:56:58 -0500
Received: (qmail 12523 invoked by uid 109); 11 Dec 2018 09:56:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 09:56:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3593 invoked by uid 111); 11 Dec 2018 09:56:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 04:56:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 04:56:33 -0500
Date:   Tue, 11 Dec 2018 04:56:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: silent_exec_failure when calling gpg
Message-ID: <20181211095633.GC31588@sigill.intra.peff.net>
References: <CAJdN7Kj5RaAsTstx_G14a_bR5Y92M3rtWAiMNPnQWgmz4JgEOg@mail.gmail.com>
 <xmqqlg4wlocc.fsf@gitster-ct.c.googlers.com>
 <xmqqh8fkln5q.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8fkln5q.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 01:09:37PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > John Passaro <john.a.passaro@gmail.com> writes:
> >
> >> I've noticed that in v2.19.1, when using git to pretty print
> >> information about the signature, if git cannot find gpg (e.g. "git
> >> config gpg.program nogpg"), it prints an error to stderr:
> >>
> >> $ git show -s --pretty=%G?
> >> fatal: cannot run nogpg: No such file or directory
> >> N
> >
> > I think the uninteded behaviour change was in 17809a98 ("Merge
> > branch 'jk/run-command-notdot'", 2018-10-30).
> 
> Perhaps something like this.  There needs an additional test added
> for this codepath, which I haven't done yet, though.

Thanks, both, for the report and the patch.

> diff --git a/run-command.c b/run-command.c
> index d679cc267c..e2bc18a083 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -728,6 +728,8 @@ int start_command(struct child_process *cmd)
>  	if (prepare_cmd(&argv, cmd) < 0) {
>  		failed_errno = errno;
>  		cmd->pid = -1;
> +		if (!cmd->silent_exec_failure)
> +			error_errno("cannot run %s", cmd->argv[0]);
>  		goto end_of_spawn;
>  	}

Yes, I think this is the right fix. For a test, I think we could just
do:

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index cf932c8514..866268dfd1 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -33,7 +33,8 @@ test_expect_success 'run_command is restricted to PATH' '
 	write_script should-not-run <<-\EOF &&
 	echo yikes
 	EOF
-	test_must_fail test-tool run-command run-command should-not-run
+	test_must_fail test-tool run-command run-command should-not-run 2>err &&
+	grep should-not-run err
 '
 
 test_expect_success !MINGW 'run_command can run a script without a #! line' '


I assume you'll wrap that up into a real commit?

-Peff

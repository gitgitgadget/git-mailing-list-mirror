Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BD7207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965363AbcIZVcS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:32:18 -0400
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:33955 "HELO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932653AbcIZVcR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 17:32:17 -0400
Received: (qmail 27362 invoked by uid 0); 26 Sep 2016 21:32:12 -0000
Received: from unknown (HELO cmgw2) (10.0.90.83)
  by gproxy8.mail.unifiedlayer.com with SMTP; 26 Sep 2016 21:32:12 -0000
Received: from box531.bluehost.com ([74.220.219.131])
        by cmgw2 with 
        id oMY61t00b2qhmhE01MY9rT; Mon, 26 Sep 2016 15:32:10 -0600
X-Authority-Analysis: v=2.1 cv=F4vEKMRN c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=GW1xBdLrtEIA:10 a=_tKueNvEydmk28CtiAgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID;
        bh=jgTx/50ml1V42jpgt/BLk21lNMkIi/j9xPbVGJ7FdiU=; b=Le/7ETveYuzLE21MoqMhTTjWr8
        MfopXNMhLFw+NjnbNa4XXW8mPbQ2caS04TtzIfChr+m42gwlTXWzT7kh43WfyLkmwp0Hsmayu5q98
        RwFzeYkDuYDWcHUDpv71vyPu9;
Received: from [64.238.138.90] (port=52008 helo=pdsdesk)
        by box531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1bodVQ-0004FJ-0J
        for git@vger.kernel.org; Mon, 26 Sep 2016 15:32:08 -0600
Message-ID: <1474925524.4270.35.camel@mad-scientist.net>
Subject: git 2.9.2: is RUNTIME_PREFIX supposed to work?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Mon, 26 Sep 2016 17:32:04 -0400
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-0ubuntu1~ubuntu16.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box531.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 64.238.138.90
X-Exim-ID: 1bodVQ-0004FJ-0J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [64.238.138.90]:52008
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTMxLmJsdWVob3N0LmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.  I'm trying to create a relocatable installation of Git 2.9.2,
so I can copy it anywhere and it continues to run without any problem.
This is on GNU/Linux systems, FWIW.

Looking through the code (for some other reason) I discovered the
RUNTIME_PREFIX setting which appears to attempt to set up the system
paths based on a prefix determined from the directory containing the
git command.  That looks like exactly what I want.

If I set RUNTIME_PREFIX=YesPlease and gitexecdir=libexec/git-core on
the make invocation, it appears to do the right thing when I invoke
.../libexec/git-core/git, even if I move it around.  Cool!

Except, when it doesn't.  And when it doesn't is all the situations
where Git runs subcommands: for example, "git pull" which wants to
invoke fetch and merge-base commands.

When RUNTIME_PREFIX is defined, it's a requirement that the argv[0] for
the process be a fully-qualified pathname: if it's not, then git will
assert at exec_cmd.c:23 in system_path():

	assert(argv0_path);

The argv0_path variable is set based on argv[0] passed in to main().
When I invoke top-level Git commands, that value is a fully-qualified
path just as you'd expect.  However, when Git itself invokes
subcommands it does so in a weird way where argv[0] is the command it
wants to invoke, using the magical execv() facility that lets you
invoke a command while providing a different value as argv[0].

For example my core dump from the assert of the merge-base shows:

  (gdb) p argv[0]
  $2 = 0x7fffd70c338e "merge-base"
  (gdb) p argv[1]
  $3 = 0x7fffd70c3399 "--fork-point"
  (gdb) p argv[2]
  $4 = 0x7fffd70c33a6 "refs/remotes/origin/master"
  (gdb) p argv[3]
  $5 = 0x7fffd70c33c1 "master"

Looking at builtin/pull.c I see get_rebase_fork_point() calls
capture_command() with this Git command, which calls start_command(),
which calls execv_git_command(), which calls sane_execvp(), which
invokes "git" as the filename but with argv[0] as "merge-base":

        sane_execvp("git", (char **)nargv.argv);
           ...calls sane_execvp():
        if (!execvp(file, argv))
                return 0; /* cannot happen ;-) */

This causes the assert.

So, my question is: is this a bug in RUNTIME_PREFIX support?  Or is
RUNTIME_PREFIX no longer supported, or maybe not supported at all on
UNIX-type operating systems?

Cheers!

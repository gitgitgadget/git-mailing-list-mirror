Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221B81FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbcK3X74 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:59:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:49400 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbcK3X7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:59:55 -0500
Received: (qmail 27218 invoked by uid 109); 30 Nov 2016 23:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:59:55 +0000
Received: (qmail 27309 invoked by uid 111); 1 Dec 2016 00:00:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 19:00:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 18:59:52 -0500
Date:   Wed, 30 Nov 2016 18:59:52 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 06:46:36PM -0500, Jeff King wrote:

> > For now the work around could be to just pass "-C <dir>" to the child
> > process instead of relying on run-command to chdir.
> 
> Yeah, that would push it after the exec. I just don't understand why
> that would be necessary.

Hmm. It still seems to fail, even with the workaround (the patch in
run-command is there to make sure there's not some other call that we're
not catching):

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef49..3323a3e7f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -553,6 +553,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
 			 name);
+	argv_array_pushl(&cp.args, "-C", gs->path, NULL);
 	argv_array_push(&cp.args, "grep");
 
 	/*
@@ -586,7 +587,6 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	}
 
 	cp.git_cmd = 1;
-	cp.dir = gs->path;
 
 	/*
 	 * Capture output to output buffer and check the return code from the
diff --git a/run-command.c b/run-command.c
index 5a4dbb66d..d040f4f77 100644
--- a/run-command.c
+++ b/run-command.c
@@ -393,6 +393,8 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
+		if (cmd->dir && git_env_bool("GIT_NO_CHDIR", 0))
+			die("temporarily disallowing chdir");
 		if (cmd->dir && chdir(cmd->dir))
 			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
 			    cmd->dir);
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 050777186..591ff74ed 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -175,7 +175,7 @@ test_expect_success 'grep recurse submodule colon in name' '
 	fi:le:foobar
 	su:b/fi:le:foobar
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	GIT_NO_CHDIR=1 strace -o foo.out -f git -C parent grep -e "foobar" --recurse-submodules >actual &&
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&


So I think there is some other chdir(). I'm not sure if there is an easy
way to get a backtrace on every call to chdir() in every thread. I'm
sure somebody more clever than me could figure out how to make gdb do it
automatically, but it might be workable manually. I think the chdir was
in the main thread.

-Peff

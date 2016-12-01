Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895E41FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 00:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbcLAAEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 19:04:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:49405 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbcLAAEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 19:04:40 -0500
Received: (qmail 27615 invoked by uid 109); 1 Dec 2016 00:04:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 00:04:40 +0000
Received: (qmail 27338 invoked by uid 111); 1 Dec 2016 00:05:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 19:05:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 19:04:38 -0500
Date:   Wed, 30 Nov 2016 19:04:38 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161201000437.altjlcsn4u7rwe5c@sigill.intra.peff.net>
References: <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
 <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 06:59:52PM -0500, Jeff King wrote:

> So I think there is some other chdir(). I'm not sure if there is an easy
> way to get a backtrace on every call to chdir() in every thread. I'm
> sure somebody more clever than me could figure out how to make gdb do it
> automatically, but it might be workable manually. I think the chdir was
> in the main thread.

Ah, that turned out to be quite easy. The culprit is probably:

(gdb) bt
#0  chdir () at ../sysdeps/unix/syscall-template.S:84
#1  0x00005555555fe259 in real_path_internal (path=0x5555559f6b30 "su:b/../.git/modules/su:b", die_on_error=1)
    at abspath.c:84
#2  0x00005555555fe48a in real_path (path=0x5555559f6b30 "su:b/../.git/modules/su:b") at abspath.c:135
#3  0x00005555556d09e6 in read_gitfile_gently (path=0x5555559f6ac0 "su:b/.git", return_error_code=0x0)
    at setup.c:555
#4  0x00005555556d19cf in resolve_gitdir (suspect=0x5555559f6ac0 "su:b/.git") at setup.c:1021
#5  0x00005555556e7e34 in is_submodule_populated (path=0x5555559f5ec8 "su:b") at submodule.c:244
#6  0x00005555555a0f05 in grep_submodule (opt=0x7fffffffd8b0, sha1=0x0, filename=0x5555559f5ec8 "su:b", 
    path=0x5555559f5ec8 "su:b") at builtin/grep.c:619
#7  0x00005555555a12ac in grep_cache (opt=0x7fffffffd8b0, pathspec=0x7fffffffd880, cached=0) at builtin/grep.c:700
#8  0x00005555555a36cb in cmd_grep (argc=0, argv=0x7fffffffdf40, prefix=0x0) at builtin/grep.c:1257
#9  0x000055555556603b in run_builtin (p=0x5555559b3ad8 <commands+984>, argc=4, argv=0x7fffffffdf40) at git.c:373
#10 0x00005555555662bc in handle_builtin (argc=4, argv=0x7fffffffdf40) at git.c:572
#11 0x000055555556641a in run_argv (argcp=0x7fffffffddfc, argv=0x7fffffffddf0) at git.c:630
#12 0x00005555555665a8 in cmd_main (argc=4, argv=0x7fffffffdf40) at git.c:702
#13 0x00005555555fde47 in main (argc=7, argv=0x7fffffffdf28) at common-main.c:40

So is_submodule_populated() needs to take a lock. But what's really
gross is that the _other_ threads need to lock just to call lstat().
Presumably it could be done as a reader/writer type of lock where many
"reader" threads can take the "I need to lstat()" lock simultaneously,
but block when an "I'm going to chdir()" writer holds it.

-Peff

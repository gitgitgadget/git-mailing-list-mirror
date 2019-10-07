Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511EC1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfJGLGr (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 07:06:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53877 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfJGLGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 07:06:47 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHQqj-0005m5-Qo; Mon, 07 Oct 2019 13:06:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHQqj-0003CA-CO; Mon, 07 Oct 2019 13:06:45 +0200
Date:   Mon, 7 Oct 2019 13:06:45 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        entwicklung@pengutronix.de
Subject: Regression in v2.23
Message-ID: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

With git 2.23.0 I have:

	uwe@taurus:~/tmp/rangediff-segfault$ git init
	Initialized empty Git repository in /home/uwe/tmp/rangediff-segfault/.git/
	uwe@taurus:~/tmp/rangediff-segfault$ echo root > root
	uwe@taurus:~/tmp/rangediff-segfault$ git add root
	uwe@taurus:~/tmp/rangediff-segfault$ git commit -m root
	[master (root-commit) b0feddb2dee8] root
	 1 file changed, 1 insertion(+)
	 create mode 100644 root
	uwe@taurus:~/tmp/rangediff-segfault$ echo content > file
	uwe@taurus:~/tmp/rangediff-segfault$ chmod +x file
	uwe@taurus:~/tmp/rangediff-segfault$ git add file
	uwe@taurus:~/tmp/rangediff-segfault$ git commit -m file
	[master 45b547c57acd] file
	 1 file changed, 1 insertion(+)
	 create mode 100755 file
	uwe@taurus:~/tmp/rangediff-segfault$ chmod -x file
	uwe@taurus:~/tmp/rangediff-segfault$ git add file
	uwe@taurus:~/tmp/rangediff-segfault$ git commit -m 'chmod -x'
	[master eaa5d3b98caa] chmod -x
	 1 file changed, 0 insertions(+), 0 deletions(-)
	 mode change 100755 => 100644 file
	uwe@taurus:~/tmp/rangediff-segfault$ git range-diff @~2..@~ @~2..
	Segmentation fault (core dumped)

Bisecting points to b66885a30cb84fc61986bc4eea805a31fdbea79a, current master
(b744c3af07a15aaeb1b82fab689995fd5528f120) segfaults in the same way.

This is somehow similar to
https://public-inbox.org/git/20190923101929.GA18205@kitsune.suse.cz/ but
the patch by Johannes Schindelin sent in
https://public-inbox.org/git/pull.373.git.gitgitgadget@gmail.com/
doesn't help me.

For me the segfault also happens in

	strbuf_addstr(&buf, patch.new_name);

with patch.new_name being NULL.

The matching backtrace and patch object looks as follows:

	(gdb) bt
	#0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:65
	#1  0x0000555cc448949c in strbuf_addstr (s=<optimized out>, sb=0x7ffcd1d9ef00)
	    at strbuf.h:292
	#2  read_patches (range=range@entry=0x555cc5dc2b70 "@~2..", 
	    list=list@entry=0x7ffcd1d9f280) at range-diff.c:126
	#3  0x0000555cc44898a8 in show_range_diff (range1=0x555cc5dc2b50 "@~2..@~", 
	    range2=0x555cc5dc2b70 "@~2..", creation_factor=60, dual_color=1, 
	    diffopt=diffopt@entry=0x7ffcd1d9f680) at range-diff.c:507
	#4  0x0000555cc4397aa6 in cmd_range_diff (argc=<optimized out>, 
	    argv=<optimized out>, prefix=<optimized out>) at builtin/range-diff.c:80
	#5  0x0000555cc4328494 in run_builtin (argv=<optimized out>, 
	    argc=<optimized out>, p=<optimized out>) at git.c:445
	#6  handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:674
	#7  0x0000555cc4329554 in run_argv (argv=0x7ffcd1d9f9e0, argcp=0x7ffcd1d9f9ec)
	    at git.c:741
	#8  cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:872
	#9  0x0000555cc432803a in main (argc=4, argv=0x7ffcd1d9fc78)
	    at common-main.c:52
	(gdb) up 2
	#2  read_patches (range=range@entry=0x555cc5dc2b70 "@~2..", 
	    list=list@entry=0x7ffcd1d9f280) at range-diff.c:126
	126	range-diff.c: No such file or directory.
	(gdb) print patch
	$1 = {new_name = 0x0, old_name = 0x0, def_name = 0x555cc5dc98c0 "file", 
	  old_mode = 33261, new_mode = 33188, is_new = 0, is_delete = 0, rejected = 0, 
	  ws_rule = 0, lines_added = 0, lines_deleted = 0, score = 0, 
	  extension_linenr = 0, is_toplevel_relative = 0, inaccurate_eof = 0, 
	  is_binary = 0, is_copy = 0, is_rename = 0, recount = 0, 
	  conflicted_threeway = 0, direct_to_threeway = 0, crlf_in_old = 0, 
	  fragments = 0x0, result = 0x0, resultsize = 0, 
	  old_oid_prefix = '\000' <repeats 64 times>, 
	  new_oid_prefix = '\000' <repeats 64 times>, next = 0x0, threeway_stage = {{
	      hash = '\000' <repeats 31 times>}, {hash = '\000' <repeats 31 times>}, {
	      hash = '\000' <repeats 31 times>}}}

I guess you are able to work out the details with this information. If you need
more input, please Cc: me on replies.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

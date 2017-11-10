Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186591F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 12:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdKJMhR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 07:37:17 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:33441 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbdKJMhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 07:37:16 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id vAACbDGc011997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 Nov 2017 13:37:13 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id vAACbCwu011994;
        Fri, 10 Nov 2017 13:37:12 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Fri, 10 Nov 2017 13:37:12 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Jeff King <peff@peff.net>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: cherry-pick very slow on big repository
In-Reply-To: <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se> <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 10 Nov 2017 13:37:13 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King:

> Can you get a backtrace? I'd do something like:

Seems that it spends most time in diffcore_count_changes(), that is 
where it hits whenever I hit Ctrl+C (various line numbers 199-207 in 
diffcore-delta.c; this is on the v2.15.0 tag).

(gdb) bt
#0  diffcore_count_changes (src=src@entry=0x55555db99970,
     dst=dst@entry=0x55555d6a4810,
     src_count_p=src_count_p@entry=0x55555db99998,
     dst_count_p=dst_count_p@entry=0x55555d6a4838,
     src_copied=src_copied@entry=0x7fffffffd3e0,
     literal_added=literal_added@entry=0x7fffffffd3f0)
     at diffcore-delta.c:203
#1  0x00005555556dee1a in estimate_similarity (minimum_score=30000,
     dst=0x55555d6a4810, src=0x55555db99970) at diffcore-rename.c:193
#2  diffcore_rename (options=options@entry=0x7fffffffd4f0)
     at diffcore-rename.c:560
#3  0x0000555555623d83 in diffcore_std (
     options=options@entry=0x7fffffffd4f0) at diff.c:5846
#4  0x000055555564ab46 in get_renames (o=o@entry=0x7fffffffd850,
     tree=tree@entry=0x5555559d1b98,
     o_tree=o_tree@entry=0x5555559d1bc0,
     a_tree=a_tree@entry=0x5555559d1b98,
     b_tree=b_tree@entry=0x5555559d1b70,
     entries=entries@entry=0x555559351d20) at merge-recursive.c:554
#5  0x000055555564e7d9 in merge_trees (o=o@entry=0x7fffffffd850,
     head=head@entry=0x5555559d1b98, merge=<optimized out>,
     merge@entry=0x5555559d1b70, common=<optimized out>,
     common@entry=0x5555559d1bc0, result=result@entry=0x7fffffffd830)
     at merge-recursive.c:1985
#6  0x000055555569b2cc in do_recursive_merge (opts=0x7fffffffdf70,
     msgbuf=0x7fffffffd810, head=0x7fffffffd7f0,
     next_label=<optimized out>, base_label=<optimized out>,
     next=<optimized out>, base=0x5555559c1ba0) at sequencer.c:459
#7  do_pick_commit (command=TODO_PICK,
     commit=commit@entry=0x5555559c1b60,
     opts=opts@entry=0x7fffffffdf70, final_fixup=final_fixup@entry=0)
     at sequencer.c:1088
#8  0x000055555569e324 in single_pick (opts=0x7fffffffdf70,
     cmit=0x5555559c1b60) at sequencer.c:2306
#9  sequencer_pick_revisions (opts=0x7fffffffdf70)
     at sequencer.c:2355
#10 0x00005555555d4097 in run_sequencer (argc=1, argc@entry=3,
     argv=argv@entry=0x7fffffffe320, opts=<optimized out>,
     opts@entry=0x7fffffffdf70) at builtin/revert.c:200
#11 0x00005555555d449a in cmd_cherry_pick (argc=3,
     argv=0x7fffffffe320, prefix=<optimized out>)
     at builtin/revert.c:225
#12 0x0000555555567a38 in run_builtin (argv=<optimized out>,
     argc=<optimized out>, p=<optimized out>) at git.c:346
#13 handle_builtin (argc=3, argv=0x7fffffffe320) at git.c:554
#14 0x0000555555567cf6 in run_argv (argv=0x7fffffffe0e0,
     argcp=0x7fffffffe0ec) at git.c:606
#15 cmd_main (argc=<optimized out>, argv=<optimized out>)
     at git.c:683
#16 0x0000555555566e01 in main (argc=4, argv=0x7fffffffe318)
     at common-main.c:43

-- 
\\// Peter - http://www.softwolves.pp.se/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7341FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 08:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbcLMIq7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 03:46:59 -0500
Received: from praxis.kevinlocke.name ([205.185.125.39]:42680 "EHLO
        praxis.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbcLMIq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 03:46:59 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Dec 2016 03:46:58 EST
Received: from kevinolos (host-98-127-248-171.bln-mt.client.bresnan.net [98.127.248.171])
        (Authenticated sender: kevin@kevinlocke.name)
        by praxis.kevinlocke.name (Postfix) with ESMTPSA id 426603120443
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 01:41:53 -0700 (MST)
Received: by kevinolos (Postfix, from userid 1000)
        id 5DFB14A1D23; Tue, 13 Dec 2016 01:41:51 -0700 (MST)
Date:   Tue, 13 Dec 2016 01:41:51 -0700
From:   Kevin Locke <kevin@kevinlocke.name>
To:     git@vger.kernel.org
Subject: log: range_set_append: Assertion failed with -L:funcname:
Message-ID: <20161213084151.vwzl56n7ryf7pxfc@kevinolos>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="enpqbrz5rl3s3qwy"
Content-Disposition: inline
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--enpqbrz5rl3s3qwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I encountered the following assertion failure when running in a local
clone of the https://github.com/nodejs/node.git repository:

$ git log -L:writeFileSync:lib/fs.js -L:appendFileSync:lib/fs.js aa67b1^..aa67b1
git: line-log.c:71: range_set_append: Assertion `rs->nr == 0 || rs->ranges[rs->nr-1].end <= a' failed.
Aborted

I was able to provoke the same assertion failure in the git repository
with the following:

$ git log -L:print_one_push_status:transport.c -L:transport_summary_width:transport.c f9db0c^..f9db0c

(FWIW, f9db0c is a merge commit while aa67b1 is not.)

I was able to reproduce the error with git built from 13b8f6 (the
commit which introduced git log -L:pattern:file) as well as current
next (91ed5b).  The backtrace from next is attached.

Any assistance to avoid or fix the error would be greatly appreciated.

Thanks,
Kevin

P.S.  Please CC me in replies as I am not subscribed to this ML.

-- 
Kevin Locke  |  kevin@kevinlocke.name    | XMPP: kevin@kevinlocke.name
             |  https://kevinlocke.name  | IRC:   kevinoid on freenode

--enpqbrz5rl3s3qwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="backtrace.txt"

#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:58
#1  0x00007ffff6fa040a in __GI_abort () at abort.c:89
#2  0x00007ffff6f97e47 in __assert_fail_base (fmt=<optimized out>, 
    assertion=assertion@entry=0x555555754400 "rs->nr == 0 || rs->ranges[rs->nr-1].end <= a", file=file@entry=0x5555557543eb "line-log.c", line=line@entry=71, 
    function=function@entry=0x555555754730 <__PRETTY_FUNCTION__.29201> "range_set_append") at assert.c:92
#3  0x00007ffff6f97ef2 in __GI___assert_fail (
    assertion=0x555555754400 "rs->nr == 0 || rs->ranges[rs->nr-1].end <= a", 
    file=0x5555557543eb "line-log.c", line=71, 
    function=0x555555754730 <__PRETTY_FUNCTION__.29201> "range_set_append")
    at assert.c:101
#4  0x00005555556677dd in range_set_append (rs=0x7fffffffd320, a=421, b=434)
    at line-log.c:71
#5  0x00005555556686f8 in range_set_shift_diff (out=0x7fffffffd320, 
    rs=0x7fffffffd330, diff=0x7fffffffd3a0) at line-log.c:442
#6  0x00005555556687aa in range_set_map_across_diff (out=0x7fffffffd3c0, 
    rs=0x555555ad9698, diff=0x7fffffffd3a0, touched_out=0x7fffffffd410)
    at line-log.c:465
#7  0x000055555566a33e in process_diff_filepair (rev=0x7fffffffd5f0, 
    pair=0x555555a60830, range=0x555555ad9680, diff_out=0x7fffffffd410)
    at line-log.c:1036
#8  0x000055555566a4ec in process_all_files (range_out=0x555555a5ba10, 
    rev=0x7fffffffd5f0, queue=0x555555a078a0, range=0x555555a347a0)
    at line-log.c:1076
#9  0x000055555566a852 in process_ranges_merge_commit (rev=0x7fffffffd5f0, 
    commit=0x555555a19f70, range=0x555555a347a0) at line-log.c:1158
#10 0x000055555566aa37 in process_ranges_arbitrary_commit (rev=0x7fffffffd5f0, 
    commit=0x555555a19f70) at line-log.c:1202
#11 0x000055555566ab4b in line_log_filter (rev=0x7fffffffd5f0)
    at line-log.c:1236
#12 0x00005555556c59f1 in prepare_revision_walk (revs=0x7fffffffd5f0)
    at revision.c:2773
#13 0x00005555555ac8a9 in cmd_log_walk (rev=0x7fffffffd5f0)
    at builtin/log.c:347
#14 0x00005555555ad9e1 in cmd_log (argc=4, argv=0x7fffffffe0d8, prefix=0x0)
    at builtin/log.c:682
#15 0x0000555555566079 in run_builtin (p=0x5555559b5ba0 <commands+1152>, 
    argc=4, argv=0x7fffffffe0d8) at git.c:373
#16 0x00005555555662fa in handle_builtin (argc=4, argv=0x7fffffffe0d8)
    at git.c:572
#17 0x0000555555566534 in cmd_main (argc=4, argv=0x7fffffffe0d8) at git.c:677
#18 0x00005555555fd6bf in main (argc=4, argv=0x7fffffffe0d8)
    at common-main.c:40

--enpqbrz5rl3s3qwy--

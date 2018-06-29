Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CFC1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 10:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeF2KSq (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 06:18:46 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40378 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932288AbeF2KSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 06:18:45 -0400
X-Greylist: delayed 2068 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2018 06:18:44 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1fYpwr-0002am-6L
        for git@vger.kernel.org; Fri, 29 Jun 2018 18:44:13 +0900
Date:   Fri, 29 Jun 2018 18:44:13 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: fast-import slowness when importing large files with small
 differences
Message-ID: <20180629094413.bgltep6ntlza6vhz@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed some slowness when fast-importing data from the Firefox mercurial
repository, where fast-import spends more than 5 minutes importing ~2000
revisions of one particular file. I reduced a testcase while still
using real data. One could synthesize data with kind of the same
properties, but I figured real data could be useful.

To reproduce:
$ git clone https://gist.github.com/b6b8edcff2005cc482cf84972adfbba9.git foo
$ git init bar
$ cd bar
$ python ../foo/import.py ../foo/data.gz | git fast-import --depth=2000

(--depth=2000 to minimize the pack size)

The python script doesn't have much overhead:
$ time python ../foo/import.py ../foo/data.gz > /dev/null

real	0m14.564s
user	0m9.813s
sys	0m4.703s

It generates about 26GB of data from that 4.2MB data.gz.

$ python ../foo/import.py ../foo/data.gz | time git fast-import --depth=2000
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:       5000
Total objects:         1868 (       133 duplicates                  )
      blobs  :         1868 (       133 duplicates       1867 deltas of       1868 attempts)
      trees  :            0 (         0 duplicates          0 deltas of          0 attempts)
      commits:            0 (         0 duplicates          0 deltas of          0 attempts)
      tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
Total branches:           0 (         0 loads     )
      marks:           1024 (         0 unique    )
      atoms:              0
Memory total:          2282 KiB
       pools:          2048 KiB
     objects:           234 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 35184372088832
pack_report: pack_used_ctr            =          0
pack_report: pack_mmap_calls          =          0
pack_report: pack_open_windows        =          0 /          0
pack_report: pack_mapped              =          0 /          0
---------------------------------------------------------------------

321.61user 6.60system 5:50.08elapsed 93%CPU (0avgtext+0avgdata 83192maxresident)k
0inputs+10568outputs (0major+38689minor)pagefaults 0swaps

(The resulting pack is 5.3MB, fwiw)

Obviously, sha1'ing 26GB is not going to be free, but it's also not the
dominating cost, according to perf:

    63.52%  git-fast-import  git-fast-import     [.] create_delta_index
    17.46%  git-fast-import  git-fast-import     [.] sha1_compression_states
     9.89%  git-fast-import  git-fast-import     [.] ubc_check
     6.23%  git-fast-import  git-fast-import     [.] create_delta
     2.49%  git-fast-import  git-fast-import     [.] sha1_process

That's a whole lot of time spent on create_delta_index.

FWIW, if delta was 100% free (yes, I tested that), the fast-import would
take 1:40 with the following profile:

    58.74%  git-fast-import  git-fast-import     [.] sha1_compression_states
    32.45%  git-fast-import  git-fast-import     [.] ubc_check
     8.25%  git-fast-import  git-fast-import     [.] sha1_process

I toyed with the idea of eliminating common head and tail before
creating the delta, and got some promising result: a fast-import taking
3:22 instead of 5:50, with the following profile:

    34.67%  git-fast-import  git-fast-import     [.] create_delta_index
    30.88%  git-fast-import  git-fast-import     [.] sha1_compression_states
    17.15%  git-fast-import  git-fast-import     [.] ubc_check
     7.25%  git-fast-import  git-fast-import     [.] store_object
     4.47%  git-fast-import  git-fast-import     [.] sha1_process
     2.72%  git-fast-import  git-fast-import     [.] create_delta2

The resulting pack is however much larger (for some reason, many objects
are left non-deltaed), and the deltas are partly broken (they don't
apply cleanly), but that just tells the code is not ready to be sent. I
don't expect working code would be much slower than this. The remaining
question is whether this is beneficial for more normal cases.

I also seemed to remember when I tested a while ago, that somehow xdiff
handles those files faster than diff-delta, and I'm wondering if it
would make sense to to make the pack code use xdiff. So I tested
replacing diff_delta with a call to xdi_diff_outf with a callback that
does nothing and zeroed out xpparam_t and xdemitconf_t (not sure that's
best, though, I haven't looked very deeply), and that finished in 5:15
with the following profile (without common head trimming,
xdiff-interface apparently does common tail trimming):

    32.99%  git-fast-import  git-fast-import     [.] xdl_prepare_ctx.isra.0
    20.42%  git-fast-import  git-fast-import     [.] sha1_compression_states
    15.26%  git-fast-import  git-fast-import     [.] xdl_hash_record
    11.65%  git-fast-import  git-fast-import     [.] ubc_check
     3.09%  git-fast-import  git-fast-import     [.] xdl_recs_cmp
     3.03%  git-fast-import  git-fast-import     [.] sha1_process
     2.91%  git-fast-import  git-fast-import     [.] xdl_prepare_env

So maybe it would make sense to consolidate the diff code (after all,
diff-delta.c is an old specialized fork of xdiff). With manual trimming
of common head and tail, this gets down to 3:33.

I'll also note that Facebook has imported xdiff from the git code base
into mercurial and improved performance on it, so it might also be worth
looking at what's worth taking from there.

Cheers,

Mike

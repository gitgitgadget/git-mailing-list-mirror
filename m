Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36441F453
	for <e@80x24.org>; Fri, 15 Feb 2019 03:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfBODrl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 22:47:41 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:55310
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730813AbfBODrl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Feb 2019 22:47:41 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id uUTPgDpGOjKhiuUTSg0jjy; Thu, 14 Feb 2019 20:47:40 -0700
Date:   Fri, 15 Feb 2019 05:47:35 +0200
From:   Max Kirillov <max@max630.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Max Kirillov' <max@max630.net>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1 (stack
 traces inside)
Message-ID: <20190215034735.GF3064@jessie.local>
References: <005b01d4c4bd$c5026ac0$4f074040$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005b01d4c4bd$c5026ac0$4f074040$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfL37a4gDS7jEEZmx3z+RoNnRKlW7dcq615rovizYdt0wBETfyblyucUG0pSUus0z3Shsv3cA8s9OGQdnZJ+WmaN+TkIWBWx14PKAW1QSJ5+H5E2G/CXx
 3ON4GqIjcDVizqSsLf73O7Lb3dpi1kW8009seW1OkHVxOgdF/835vlmUXb4JRQzrleJzcGVfg5eNvBY4rYc/fiHdP9oEJ7fg3wBrKe7GpKj/mIQQs7ae0t+z
 hz4lb9hIUcjX/rxpr1NjR62Qug1G2k0MxtVDPA0GVHDc/lgQwVYRjPjF5k8axpPu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 06:33:56PM -0500, Randall S. Becker wrote:
> Here is the full set of traces (from subtest 6, which just hung). There are
> no I/O errors reported on any pipe or file descriptor. There is one git
> process waiting for a read to occur but no one is doing any writing. Most
> processes are sitting in waitpid, except for the initiating git, which is
> waiting on a read that never receives data, so everyone is asleep and hung.
> The git process sitting in read is reading from a PIPE, not a file.
> 
> There are no other processes involved in the test that I can see.
> 
> Perl (waiting for output to be read):
>   waitpid + 0x130 (SLr)
>   $n_EnterPriv + 0x280 (Milli)
>   Perl_wait4pid + 0x130 (UCr)
>   Perl_my_pclose + 0x4C0 (UCr)
>   Perl_io_close + 0x180 (UCr)
>   Perl_do_close + 0x620 (UCr)
>   Perl_pp_close + 0xA70 (UCr)
>   Perl_runops_standard + 0xF0 (UCr)
>   S_run_body + 0x870 (UCr)
>   perl_run + 0x2D0 (UCr)
>   main + 0x3D0 (UCr)
> 
> git-http-backend:
>   waitpid + 0x320 (SLr)
>   $n_EnterPriv + 0x280 (Milli)
>   cleanup_children + 0x5D0 (UCr)
>   cleanup_children_on_exit + 0x70 (UCr)
>   git_atexit_dispatch + 0x200 (UCr)
>   __process_atexit_functions + 0xA0 (DLL zcredll)
>   CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
>   exit + 0x2A0 (DLL zcrtldll)
>   die_webcgi + 0x240 (UCr)
>   die_errno + 0x360 (UCr)
>   write_or_die + 0x1C0 (UCr)
>   end_headers + 0x1A0 (UCr)
>   die_webcgi + 0x220 (UCr)
>   die + 0x320 (UCr)
>   inflate_request + 0x520 (UCr)
>   run_service + 0xC20 (UCr)
>   service_rpc + 0x530 (UCr)
>   cmd_main + 0xD00 (UCr)
>   main + 0x190 (UCr)
> 
> git (one of them):
>   read64_ + 0x140 (SLr)
>   $n_EnterPriv + 0x280 (Milli)
>   xread + 0x130 (UCr)
>   read_in_full + 0x130 (UCr)
>   get_packet_data + 0x4B0 (UCr)
>   packet_read_with_status + 0x230 (UCr)
>   packet_reader_read + 0x310 (UCr)
>   receive_needs + 0x300 (UCr)
>   upload_pack + 0x680 (UCr)
>   cmd_upload_pack + 0x830 (UCr)
>   run_builtin + 0x980 (UCr)
>   handle_builtin + 0x570 (UCr)
>   run_argv + 0x210 (UCr)
>   cmd_main + 0x710 (UCr)
>   main + 0x190 (UCr)
> 
> bash:
>   waitpid + 0x130 (SLr)
>   $n_EnterPriv + 0x280 (Milli)
>   waitchld + 0x1F0 (UCr)
>   wait_for + 0xFD0 (UCr)
>   execute_command_internal + 0x1990 (UCr)
>   execute_command + 0xC0 (UCr)
>   reader_loop + 0x4F0 (UCr)
>   main + 0x1140 (UCr)
> 
> git (the other one):
>   waitpid + 0x130 (SLr)
>   $n_EnterPriv + 0x280 (Milli)
>   wait_or_whine + 0xE0 (UCr)
>   finish_command + 0x100 (UCr)
>   run_command + 0x1F0 (UCr)
>   execv_dashed_external + 0x800 (UCr)
>   run_argv + 0x250 (UCr)
>   cmd_main + 0x710 (UCr)
>   main + 0x190 (UCr)

This list does not say which process whose child but it
seems like #3 is child of #2 and #2 waits for #3, but #3
does not exit. Which is strange because it should have send
SIGTERM to it. Could the git-upload-pack somehow be masking
SIGTERM?

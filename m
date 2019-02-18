Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5321F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfBRUqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:46:48 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58040 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfBRUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:46:47 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1IKkfAb080687
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 15:46:42 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Max Kirillov'" <max@max630.net>
References: <pull.126.git.gitgitgadget@gmail.com>        <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com> <005901d4c4b9$3b9a2a60$b2ce7f20$@nexbridge.com> <nycvar.QRO.7.76.6.1902182139490.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902182139490.45@tvgsbejvaqbjf.bet>
Subject: RE: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Date:   Mon, 18 Feb 2019 15:46:34 -0500
Message-ID: <005001d4c7cb$0cc4ce60$264e6b20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJRGauSxHI8crErjTmvoq3vRhvADwFUx24oAWoQp5kCOMthgQH1BI6TpLX8W2A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 18, 2019 15:41, Johannes Schindelin wrote:
> On Thu, 14 Feb 2019, Randall S. Becker wrote:
> 
> > On February 14, 2019 17:39, Junio C Hamano wrote:
> > > To: Randall S. Becker <rsbecker@nexbridge.com>
> > > Cc: 'Johannes Schindelin via GitGitGadget' <gitgitgadget@gmail.com>;
> > > git@vger.kernel.org; 'Max Kirillov' <max@max630.net>
> > > Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in
> > > v2.21.0-rc1
> > >
> > > "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > >
> > > > Unfortunately, subtest 13 still hangs on NonStop, even with this
> > > > patch, so our Pipeline still hangs. I'm glad it's better on Azure,
> > > > but I don't think this actually addresses the root cause of the
hang.
> > >
> > > Sigh.
> > >
> > > > possible this is not the test that is failing, but actually the
> > > > git-http-backend? The code is not in a loop, if that helps. It is
> > > > not consuming any significant cycles. I don't know that part of
> > > > the code at all, sadly. The code is here:
> > > >
> > > > * in the operating system from here up *
> > > >   cleanup_children + 0x5D0 (UCr)
> > > >   cleanup_children_on_exit + 0x70 (UCr)
> > > >   git_atexit_dispatch + 0x200 (UCr)
> > > >   __process_atexit_functions + 0xA0 (DLL zcredll)
> > > >   CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
> > > >   exit + 0x2A0 (DLL zcrtldll)
> > > >   die_webcgi + 0x240 (UCr)
> > > >   die_errno + 0x360 (UCr)
> > > >   write_or_die + 0x1C0 (UCr)
> > > >   end_headers + 0x1A0 (UCr)
> > > >   die_webcgi + 0x220 (UCr)
> > > >   die + 0x320 (UCr)
> > > >   inflate_request + 0x520 (UCr)
> > > >   run_service + 0xC20 (UCr)
> > > >   service_rpc + 0x530 (UCr)
> > > >   cmd_main + 0xD00 (UCr)
> > > >   main + 0x190 (UCr)
> > > >
> > > > Best guess is that a signal (SIGCHLD?) is possibly getting eaten
> > > > or neglected somewhere between the test, perl, and git-http-backend.
> > >
> > > So we are trying to die(), which actually happens in die_webcgi(),
> > > and
> > then try
> > > to write some message _but_ notice an error inside
> > > write_or_dir() and try to exit because we do not want to recurse
> > > forever trying to die, giving a message to say how/why we died, and
> > > die because failing to give that message, forever.
> > >
> > > But in our attempt to exit(), we try to "cleanup children" and that
> > > is
> > what gets
> > > stuck.
> > >
> > > One big difference before and after the /dev/zero change is that the
> > process
> > > is now on a downstream of the pipe.  If we prepare a large file with
> > > a
> > finite
> > > size full of NULs and replace /dev/null with it, instead of feeding
> > > NULs
> > from
> > > the pipe, would it change the equation?
> >
> > Doubtful. The processes are still around, and are waiting on read but
> > not actively reading (CPU time is not going up, so we're not reading
> > an infinite stream). To me, this is a pipe situation where there is
> > simply nothing waiting on the pipe (maybe a flush missing?). I'm
> > grasping are straws without knowing the actual process architecture of
the
> test to debug it.
> 
> So could you try with this patch?
> 
> -- snipsnap --
> diff --git a/http-backend.c b/http-backend.c index d5cea0329a..7c1b4a2555
> 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -427,6 +427,7 @@ static void inflate_request(const char *prog_name,
> int out, int buffer_input, ss
> 
>  done:
>  	git_inflate_end(&stream);
> +	close(0);
>  	close(out);
>  	free(full_request);
>  }

In isolation or with the other fixes associated with t5562? Or, which
baseline commit should I use? 8989e1950a or d92031209a or some other?


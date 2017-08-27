Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9E620285
	for <e@80x24.org>; Sun, 27 Aug 2017 18:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbdH0Sxi (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 14:53:38 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:46246 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdH0Sxh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 14:53:37 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id v7RIrRCW032434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 27 Aug 2017 14:53:28 -0400
Reply-To: "Jeff King" <peff@peff.net>, <git@vger.kernel.org>,
          "Johannes Schindelin" <johannes.schindelin@gmx.de>,
          "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
          "Adam Dinwoodie" <adam@dinwoodie.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Adam Dinwoodie'" <adam@dinwoodie.org>
Cc:     "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>
References: <20170825112529.GA10378@dinwoodie.org> <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net> <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com> <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net> <20170826211104.GC10378@dinwoodie.org> <c5f3fe2d-6d76-7c08-2a50-fb10c66adc48@ramsayjones.plus.com> <20170827113358.GF10378@dinwoodie.org> <0822303f-63b1-13e2-be43-8e2e4dab478e@ramsayjones.plus.com>
In-Reply-To: <0822303f-63b1-13e2-be43-8e2e4dab478e@ramsayjones.plus.com>
Subject: RE: cat-file timing window on Cygwin
Date:   Sun, 27 Aug 2017 14:53:27 -0400
Organization: PD Inc
Message-ID: <C7EA6E1174C3400B98A9F64FF0E8DEC4@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdMfS9bDyi6bYKMmQsSR4lPqlcikeAAF90ww
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Ramsay Jones
> Sent: Sunday, August 27, 2017 11:48 AM
> To: Adam Dinwoodie
> Cc: Jeff King; git@vger.kernel.org; Johannes Schindelin
> Subject: Re: cat-file timing window on Cygwin
> 
> 
> 
> On 27/08/17 12:33, Adam Dinwoodie wrote:
> > On Sun, Aug 27, 2017 at 03:06:31AM +0100, Ramsay Jones wrote:
> >> On 26/08/17 22:11, Adam Dinwoodie wrote:
> >>> On Sat, Aug 26, 2017 at 11:53:37AM -0700, Jeff King wrote:
> >>>> Interesting. I find it a little hard to believe there's 
> so obvious 
> >>>> a bug as "fflush(NULL) flushes stdin", but well...that's 
> what it seems like.
> >>>>
> >>>> If that's truly what it is, this is the minimal 
> reproduction I came 
> >>>> up
> >>>> with:
> >>>>
> >>>> -- >8 --
> >>>> #include <stdio.h>
> >>>>
> >>>> int main(void)
> >>>> {
> >>>> 	char buf[256];
> >>>> 	while (fgets(buf, sizeof(buf), stdin)) {
> >>>> 		fprintf(stdout, "got: %s", buf);
> >>>> 		fflush(NULL);
> >>>> 	}
> >>>> 	return 0;
> >>>> }
> >>>> -- 8< --
> >>>>
> >>>> If this really is the bug, then doing something like 
> "seq 10 | ./a.out"

Tests good on latest snapshot. Fails on 

Cygwin DLL version info:
        DLL version: 2.8.2
        DLL epoch: 19
        DLL old termios: 5
        DLL malloc env: 28
        Cygwin conv: 181
        API major: 0
        API minor: 313
        Shared data: 5
        DLL identifier: cygwin1
        Mount registry: 3
        Cygwin registry name: Cygwin
        Installations name: Installations
        Cygdrive default prefix:
        Build date:
        Shared id: cygwin1S5


> >>>> would drop some of the input lines.
> >>>
> >>> ...yep.  It does.  Specifically, I consistently only get 
> the firsts
> >>> line:
> >>>
> >>>     $ seq 10 | ./a.exe
> >>>     got: 1
> >>>     
> >>>     $
> >>>
> >>> If I introduce a delay between the lines of stdin (which 
> I tested by 
> >>> just typing stdin from the keyboard), it works as expected.
> >>>
> >>> Looks like this one will need to go to the Cygwin mailing 
> list; I'll 
> >>> take it there shortly.  Thank you all for your help 
> getting this far!
> >>
> >> This is apparently fixed in cygwin v2.8.3 [see commit 78ade082fe, 
> >> ('Revert "errno: Stop using _impure_ptr->_errno completely"', 
> >> 19-07-2017), commit 9cc89b0438 ("cygwin: Use errno instead of 
> >> _impure_ptr->_errno", 19-07-2017), commit a674199fc9 
> ("cygwin: Bump 
> >> DLL version to 2.8.3",
> >> 19-07-2017) and commit d2ae2f00b8 ("cygwin: add fflush fix 
> to release 
> >> notes", 19-07-2017)].
> >>
> >> I haven't had a chance to try v2.8.3 yet (it's 3am and I'm 
> about to 
> >> go get some sleep).
> > 
> > Cygwin 2.8.3 hasn't been released yet,
> 
> Heh, yes, I found that out myself this afternoon. ;-)
> 
> >                                         but I've just tested the 
> > latest development snapshot with Jeff's simple test case, 
> and it works 
> > as expected, so I'm going to assume the Git test will start passing 
> > once that version of the Cygwin DLL is released too.
> 
> Hmm, I'm not keen on installing "snapshot"(s), so I think I 
> will wait for the release to test it. (However, as a matter 
> of interest, how would I obtain/install/test this snapshot 
> release - is it a 'low-risk' exercise?)

Using https://cygwin.com/snapshots/x86_64/cygwin-20170823.tar.xz

D:\inst\cygwin\cygwin-20170823>usr\bin\bash.exe
bash-4.4$ seq 10 | ./a.exe
got: 1
got: 2
got: 3
got: 4
got: 5
got: 6
got: 7
got: 8
got: 9
got: 10
bash-4.4$ cat cygcheck.out

Cygwin Configuration Diagnostics
Current System Time: Sun Aug 27 14:35:25 2017

Windows 10 Professional Ver 10.0 Build 14393

    Cygwin DLL version info:
        DLL version: 2.9.0
        DLL epoch: 19
        DLL old termios: 5
        DLL malloc env: 28
        Cygwin conv: 181
        API major: 0
        API minor: 317
        Shared data: 5
        DLL identifier: cygwin1
        Mount registry: 3
        Cygwin registry name: Cygwin
        Installations name: Installations
        Cygdrive default prefix:
        Build date:
        Snapshot date: 20170823-15:44:28
        Shared id: cygwin1S5

bash-4.4$

v/r,

Jason Pyeron

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 


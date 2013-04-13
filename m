Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 32648 invoked by uid 107); 13 Apr 2013 01:02:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Fri, 12 Apr 2013 21:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab3DMA7w (ORCPT <rfc822;peff@peff.net>);
	Fri, 12 Apr 2013 20:59:52 -0400
Received: from plane.gmane.org ([80.91.229.3]:52361 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973Ab3DMA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 20:59:52 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UQoop-0003Pd-00
	for git@vger.kernel.org; Sat, 13 Apr 2013 02:59:51 +0200
Received: from ip68-227-87-145.sb.sd.cox.net ([68.227.87.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 02:59:50 +0200
Received: from richard_hubbe11 by ip68-227-87-145.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 02:59:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: segfault in git-remote-http
Date:	Fri, 12 Apr 2013 18:01:35 -0700
Organization: " "
Message-ID: <20130412180135.ab642b784f754ff627bd6602@lavabit.com>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
	<20130409084718.587e99aa7a935296867a84a1@lavabit.com>
	<20130409171623.GE21972@sigill.intra.peff.net>
	<20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
	<20130409174735.GA23494@sigill.intra.peff.net>
	<20130409124044.908c160c718cc357a139354e@lavabit.com>
	<20130410043030.GD795@sigill.intra.peff.net>
	<20130410090850.bacd762ad52eb3643ca99927@lavabit.com>
	<20130410185114.GA18084@sigill.intra.peff.net>
	<20130410191103.GA22914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-227-87-145.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: encrypt
X-Operating-System: Barebones_6.1
X-Gmane-NNTP-Posting-Host: 192.168.1.1
X-NNTP-Posting-Host: 192.168.1.1
Mail-Copies-To:	never
X-Archive: expiry=17
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 10 Apr 2013 15:11:03 -0400
Jeff King <peff@peff.net> wrote:

> On Wed, Apr 10, 2013 at 02:51:14PM -0400, Jeff King wrote:
> 
> > As for why dmesg reports git-remote-http, I'm not sure. If you
> > "strace -f" the command, you can see that git is running
> > git-remote-https. Why the kernel chooses to report
> > "git-remote-http", I don't know; you'd have to look into how the
> > kernel makes that decision. But I doubt it is related to the reason
> > for the segfault in the first place.
> 
> Ah, I see. The hard links are a red herring. The kernel's message uses
> task->comm, which is presumably set by truncating the basename of the
> program to 15 characters (16 bytes with a trailing NUL).
> 
>   3.6 /proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
>   --------------------------------------------------------
>   These files provide a method to access a tasks comm value. It also
>   allows for a task to set its own or one of its thread siblings comm
>   value. The comm value is limited in size compared to the cmdline
>   value, so writing anything longer then the kernel's TASK_COMM_LEN
>   (currently 16 chars) will result in a truncated comm value.
> 
> Try:
> 
>   $ echo 'int main() { sleep(5); *(int *)0=0; }' >foo.c
>   $ gcc -o 12345678901234567890 foo.c
>   $ ./123* &
>   $ cat /proc/$!/comm
>   123456789012345
>   $ sleep 5; dmesg | tail -n 1
>   [2602639.353584] 123456789012345[23062]: segfault at 0 ip
> 0000000000400524 sp 00007fff46bb0700 error 6 in 12345678901234567890
> [400000+1000]
> 
> In both cases we only get the first 15 bytes of the program name. And
> indeed, "git-remote-http" is exactly 15 bytes. So it is dumb luck that
> the limit is such that truncating the name makes it look like another
> program.

I realize this is not real critical but these three would all suffer the same fate
on segfault. i.e. the kernel would report git-credential- as the app that suffered
the seg fault.

git-credential-cache  
git-credential-cache--daemon  
git-credential-store

For sake of completeness on this thread if nothing else.


From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sun, 12 Aug 2012 21:39:35 +0200
Message-ID: <2007117.uOeClQJdrW@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1636924.tANzCnKezB@flobuntu> <20120812161258.GA3829@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0e0n-0000qF-T4
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 21:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab2HLTjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 15:39:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48064 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2HLTjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 15:39:40 -0400
Received: by bkwj10 with SMTP id j10so1101010bkw.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=qdKpSOaP11b4X0muFLZtLh+/fePPzp7WLWm7wpgQGh0=;
        b=YvbYIOiGwoGWty6gSAS0mRWmmocBU0B38FOOrDqHISK12S/4yzEC9N5X8jDpN1MzQ3
         ee/dhXIpc1RhrwCMGsmcBdv2GiX++bK7HwMhuZhe57nx2icFLjxmedpMSVDg0FMWa/6+
         a6w5C91bRaLozdkNrQ4W6RPkYoUgLxa0HEYon69ZY78v/xXASfxmydxXPOxiupvAQp5Q
         W5TDitDxiXZpaMUdmDYlJak2Gfcv8wwjOfMV7s7b03y/9EqVvN/UdG5LEiXtnrgjc2sl
         phmwSyZcWFeKmn1uAuwcXqCA6J0nZyojLM9T3X6l+Yb/cYbwlPW0uf8i40CRPMYeOXrW
         l4Rw==
Received: by 10.205.118.138 with SMTP id fq10mr3427411bkc.58.1344800378853;
        Sun, 12 Aug 2012 12:39:38 -0700 (PDT)
Received: from flobuntu.localnet (93-82-156-166.adsl.highway.telekom.at. [93.82.156.166])
        by mx.google.com with ESMTPS id t23sm1710082bks.4.2012.08.12.12.39.36
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 12:39:37 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120812161258.GA3829@mannheim-rule.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203316>

On Sunday 12 August 2012 09:12:58 Jonathan Nieder wrote:
> Hi again,
> 
> Florian Achleitner wrote:
> > back to the pipe-topic.
> 
> Ok, thanks.
> 
> [...]
> 
> >> The way it's supposed to work is that in a bidi-import, the remote
> >> helper reads in the entire list of refs to be imported and only once
> >> the newline indicating that that list is over arrives starts writing
> >> its fast-import stream.
> 
> [...]
> 
> > This would require all existing remote helpers that use 'import' to be
> > ported to the new concept, right? Probably there is no other..
> 
> You mean all existing remote helpers that use 'bidi-import', right?
> There are none.

Ok, it would not affect the existing import command.
> 
> [...]
> 
> > I still don't believe that sharing the input pipe of the remote helper is
> > worth the hazzle.
> > It still requires an additional pipe to be setup, the one from fast-import
> > to the remote-helper, sharing one FD at the remote helper.
> 
> If I understand correctly, you misunderstood how sharing the input
> pipe works.  Have you tried it?

Yes wrote a test program, sharing works, that's not the problem.

> 
> It does not involve setting up an additional pipe.  Standard input for
> the remote helper is already a pipe.  That pipe is what allows
> transport-helper.c to communicate with the remote helper.  Letting
> fast-import share that pipe involves passing that file descriptor to
> git fast-import.  No additional pipe() calls.
> 
> Do you mean that it would be too much work to implement?  This
> explanation just doesn't make sense to me, given that the version
> using pipe() *already* *exists* and is *tested*.

Yes, that was the first version I wrote, and remote-svn-alpha uses.

> 
> I get the feeling I am missing something very basic.  I would welcome
> input from others that shows what I am missing.
> 

This is how I see it, probably it's all wrong:
I thought the main problem is, that we don't want processes to have *more than 
three pipes attached*, i.e. stdout, stdin, stderr, because existing APIs don't 
allow it.
When we share stdin of the remote helper, we achieve this goal for this one 
process, but fast-import still has an additional pipe:
stdout  --> shell;
stderr --> shell; 
stdin <-- remote-helper; 
additional_pipe --> remote-helper.

That's what I wanted to say: We still have more than three pipes on fast-
import.
And we need to transfer that fourth file descriptor by inheritance and it's 
number as a command line argument. 
So if we make the remote-helper have only three pipes by double-using stdin, 
but fast-import still has four pipes, what problem does it solve?

Using fifos would remove the requirement to inherit more than three pipes. 
That's my point.

[..]
> 
> Meanwhile it would:
> 
>  - be 100% functionally equivalent to the solution where fast-import
>    writes directly to the remote helper's standard input.  Two programs
>    can have the same pipe open for writing at the same time for a few
>    seconds and that is *perfectly fine*.  On Unix and on Windows.
> 
>    On Windows the only complication with the pipe()-based  is that we
> haven't wired up the low-level logic to pass file descriptors other than
> stdin, stdout, stderr to child processes; and if I have understood earlier
> messages correctly, the operating system *does* have a
>    concept of that and this is just a todo item in msys
>    implementation.

I digged into MSDN and it seems it's not a problem at all on the windows api 
layer. Pipe handles can be inherited. [1]
If the low-level logic once supports passing more than 3 fds, it will work on 
fast-import as well as remote-helper.

> 
>  - be more complicated than the code that already exists for this
>    stuff.
> 
> So while I presented this as a compromise, I don't see the point.
> 
> Is your goal portability, a dislike of the interface, some
> implementation detail I have missed, or something else?  Could you
> explain the problem as concisely but clearly as possible (perhaps
> using an example) so that others like Sverre, Peff, or David can help
> think through it and to explain it in a way that dim people like me
> understand what's going on?

It all started as portability-only discussion. On Linux, my first version would 
have worked. It created an additional pipe before forking using pipe(). Runs 
great, it did it like remote-svn-alpha.sh.

I wouldn't have started to produce something else or start a discussion on my 
own. But I was told, it's not good because of portability. This is the root of 
this endless story. (you already know the thread, I think). Since weeks nobody 
of them is interested in that except you and me.
 
So if we accept having more than three pipes on a process, we have no more 
problem.
We can dig out that first version, as well as write the one proposed by you.
While your version saves some trouble by not requiring an additional pipe() 
call and not requiring the prexec_cb, but adding a little complexity with the 
re-using of stdin.

Currently I have the implemented the original pipe version, the original fifo 
version, the fifo version described a mail ago. I'm going to implement the 
stdin-sharing version now..

[1] http://msdn.microsoft.com/en-
us/library/windows/desktop/aa365782(v=vs.85).aspx

> 
> Puzzled,
> Jonathan

Piped,
Florian ;)

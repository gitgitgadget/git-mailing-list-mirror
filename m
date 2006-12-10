X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: Easy shell question: how to make a script killing all his childs when killed?
Date: Sun, 10 Dec 2006 15:25:58 +0100
Message-ID: <20061210142558.GA4836@steel.home>
References: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com> <20061209173703.GA12373@steel.home> <e5bfff550612090951l43a83a00o7ea2e244ca562c77@mail.gmail.com> <20061209213937.GB12373@steel.home> <e5bfff550612091506g41e40e87n6356b8ddd5e16a5d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 14:26:19 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612091506g41e40e87n6356b8ddd5e16a5d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: SOp2-6ZC8eS7q+qKICmQdh+wFX53x90rMQWvQx+XrMgVfFKoPufAEL
X-TOI-MSGID: 4855a39b-ac69-4186-8497-d7cfeb30d795
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33891>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtPd8-0004cO-4X for gcvg-git@gmane.org; Sun, 10 Dec
 2006 15:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760798AbWLJO0L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 09:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760802AbWLJO0L
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 09:26:11 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:52103 "EHLO
 mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760798AbWLJO0J (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 09:26:09 -0500
Received: from fwd30.aul.t-online.de  by mailout06.sul.t-online.com with smtp
  id 1GtPd2-0001c8-01; Sun, 10 Dec 2006 15:26:08 +0100
Received: from tigra.home
 (SOp2-6ZC8eS7q+qKICmQdh+wFX53x90rMQWvQx+XrMgVfFKoPufAEL@[84.163.113.204]) by
 fwd30.sul.t-online.de with esmtp id 1GtPct-0DmMxE0; Sun, 10 Dec 2006 15:25:59
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 2399A277AF; Sun, 10 Dec 2006 15:25:59 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GtPcs-0001ke-2w; Sun, 10 Dec 2006 15:25:58 +0100
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba, Sun, Dec 10, 2006 00:06:34 +0100:
> On 12/9/06, Alex Riesen <fork0@t-online.de> wrote:
> >
> >Why do you need to save it in temporary file at all? Why don't you
> >read the output like gitk does?  You can take a look at popen(3). It's
> >known to be portable among operating systems and libc's.  Or, BTW, why
> >don't you just read qprocess.h, use processIdentifier()/pid(),
> >read*()-methods and the like?  (though, looking at the QProcess in
> >qt3, I wouldn't really blame you)
> >
> 
> Well, I _used_ QProcess interface until last week. It's socket based
> and it's quite fast (much more then gitk BTW), but due to some
> internal buffering not so fast as reading from a file (in my last post
> regarding git-rev-list access there are some performance numbers to
> document this). It seems that socket/pipe based IPC is not as fast as
> file write/read. Of course we are talking of OS cached files, no disk
> access must be involved to keep the speed.

Oh, I see now ("Fast access git-rev-list output...").

BTW, I just cannot reproduce that at all (on Linux):

    time { git rev-list --all > /tmp/ggg; cat /tmp/ggg >/dev/null; }

tends to be somewhat slower than

    time git rev-list --all | cat >/dev/null

QProcess must be doing something stupid.

> Regarding gitk we are at least one order of magnitude faster both with
> QProcess and, more, with temporary files, so it's not a useful
> reference in this case.

Dunno. It's hard to assess on "small" repos, like kernel. They feel
almost equally fast (maybe because qgit checks working directory too).
Haven't tried QGit on Windows yet (does it work there?).

> P.S: I didn't experiment with popen(). Thanks for the hint, I will
> give it a try ;-)

popen(3) usually uses pipe(2). It's also awkward with regard to
shell metacharacters and signals (as system(3) is). You can use your'
own buffers (setvbuf) so that could be a win against QProcess.

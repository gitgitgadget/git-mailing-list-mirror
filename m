From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Mon, 9 Mar 2015 21:37:25 -0400
Message-ID: <CAH8BJxHQnMkXq1J_wMi2KktTH5uHjj+vd69ihXuYGRfq9cOt=g@mail.gmail.com>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
	<20150309075302.GB31866@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 02:37:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV96y-0003uQ-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 02:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbbCJBh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 21:37:28 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:43364 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbCJBh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 21:37:27 -0400
Received: by wggx12 with SMTP id x12so18654304wgg.10
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XkKn+0i/bL0ARAjRhe/gqPNAqxciRypy/sOKrGH9K+c=;
        b=nl9+PUJLyWQMe/kmoqxZePqx25/McK9cFyMkHzVEXfJHSwjcSkgkwlMTyqh0bQMYmB
         s6CJpBBiZk9MDY/VxIvtEuy9MamBelrU74dUBjH6B5QAvHNvGyANKTPlN/+npvhAuoEB
         nOk+fp9BPCe3BHaAveidG/rKD9Crog9SpV1geL6MJfV2xTO60ff1flpbQRzS5rdxtjdB
         yLYJmwPiNhz0IW3zRu9MBiDCo5Xsw29sUTTgVgtfIgWyQqzTh3g7Usv4AEFYq8Nhf1Dy
         QzcxSmhGVTQU6Mxxp6DZs5LNlqNGZqlTVEUb97h+aUtnv/PAUGFvReG1XDeCDNiujsjf
         wt+g==
X-Received: by 10.194.236.200 with SMTP id uw8mr61666519wjc.10.1425951446031;
 Mon, 09 Mar 2015 18:37:26 -0700 (PDT)
Received: by 10.194.159.98 with HTTP; Mon, 9 Mar 2015 18:37:25 -0700 (PDT)
In-Reply-To: <20150309075302.GB31866@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265203>

Thanks Peff,

I've done an strace and here's what I see. I'll try to put relevant
information in as legible a form as possible. The operation is
cpu-bound on a single core (note that yes, delta compression is using
8 threads. so that's obviously not the bottleneck) for the duration of
the pack-objects.

Timing is tough, because it's slower when straced.

I don't know if it matters, but this push is going to a fork on the
remote end most of whose objects are in the objects/info/alternatives
location. (Which is still on the local drive of the remote, not a
network drive or anything like that.)

1.
 > GIT_TRACE=1 time time git push
12:21:28.980410 git.c:349               trace: built-in: git 'push'
12:21:29.099547 run-command.c:341       trace: run_command: 'ssh' '-p'
'7999' 'git@server.privacy' 'git-receive-pack
'\''~smorton/panos.git'\'''
12:21:42.863968 run-command.c:341       trace: run_command:
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
12:21:42.871170 exec_cmd.c:134          trace: exec: 'git'
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
12:21:42.907783 git.c:349               trace: built-in: git
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'

2. At this point, "git pack-objects" is forked

3. Not sure how long this part takes. It takes 1/3 - 1/2 of the time
when straced, but I think it's much less, as little as 10s when not
straced.
It then reads a bunch of what look like objects from filehandle 0
(presumably stdin, read from the remote end?)
It then tries to lstat() these filenames in .git/<sha1>
./git/refs/<sha1>, .git/heads/<sha>, etc. It always fails ENOENT.
It fails some 120,000 times. This could be a problem. Though I haven't
checked to see if this happens on a fast push on another machine.

This takes a lot of time when straced, but I think less time when not straced.

4. Then it just sits there for almost 1 minute. It uses up almost 100%
of a single core during this period. It spends a lot of time running
lots of brk() (memory allocation) commands and then getting (polled
by?) a SIGALRM every 1s.
About 5.5+ GB (about the repo size) of VIRT memory is allocated. Only
about 400M is ever RES.


5. Then we get to the "Counting objects" phase.
Note the number of threads specified: so it

Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
...


6. Time. Note the 121,000 pagefaults

46.08user 0.67system 0:49.47elapsed 94%CPU (0avgtext+0avgdata
1720240maxresident)k
0inputs+16outputs (0major+121199minor)pagefaults 0swaps

Steve



On Mon, Mar 9, 2015 at 3:53 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 05, 2015 at 04:03:07PM -0500, Stephen Morton wrote:
>
>> I'm experiencing very slow git pushes. On the order of 1 minute to push a
>> trivial one-line change. When I set GIT_TRACE=1, I see that it seems to be
>> taking a lot of time in the pack-objects phase.
>
> Can you tell what pack-objects is doing? Perhaps "strace -f -tt" might
> help. Or even just "time git push", which will tell us whether we're
> spinning on CPU or something else.
>
> If you watch the progress meter, where does it spend its time? In
> "counting objects", "compressing objects", or "writing objects"? Or
> after that?
>
> You said the repo is big. Is it reasonably packed (try running `git
> gc`). Pack-objects may look at objects that you know the other side has
> in order to create deltas against them. If you have some crazy situation
> (e.g., you have several thousand packfiles) that can slow down object
> access quite a bit. A minute is more than I would expect, but if VFS
> operations in your VM are slow, that could be it.
>
> -Peff

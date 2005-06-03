From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Modify git-rev-list ... [ resend to fix whitespace mangle ]
Date: Sat, 4 Jun 2005 08:34:31 +1000
Message-ID: <2cfc40320506031534456c8619@mail.gmail.com>
References: <20050602154957.29316.qmail@blackcubes.dyndns.org>
	 <7v8y1rkrxk.fsf@assigned-by-dhcp.cox.net>
	 <2cfc4032050603153419b72444@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jun 04 00:32:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeKhN-0002xb-Ls
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 00:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFCWem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 18:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFCWem
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 18:34:42 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:64247 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261152AbVFCWec convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 18:34:32 -0400
Received: by rproxy.gmail.com with SMTP id i8so906435rne
        for <git@vger.kernel.org>; Fri, 03 Jun 2005 15:34:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rvjYsLavr63+KXjZbPFWIiGgC4H89aqEvG49+JkVxDKKFwP0nHdqjEQDnQi0bbUTQiBKJPd3EtURW+pgRV5aWbsBZWt+0sCr6yya5XCn83eKsRw0szJ9Cp9J8hosKXhhJNcVmSOBFpbg1H2pAAlv5+S3DxbMp62vyEqV25lfARc=
Received: by 10.38.11.34 with SMTP id 34mr1138203rnk;
        Fri, 03 Jun 2005 15:34:31 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 3 Jun 2005 15:34:31 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc4032050603153419b72444@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/4/05, Junio C Hamano <junkio@cox.net> wrote:
> I only fast-forwarded over maths on your website about the epoch
> ordering, but what the patch tries to do sounds right to me.
>
> One nitpick request I have is to name its test t6000 series, to
> match the naming convention Pasky came up with?
>
>         First digit tells the family:
>
>                 0 - the absolute basics and global stuff
>                 1 - the basic commands concerning database
>                 2 - the basic commands concerning the working tree
>                 3 - the other basic commands (e.g. ls-files)
>                 4 - the diff commands
>                 5 - the pull and exporting commands
>                 6 - the revision tree commands (even e.g. merge-base)
>

Sure. I'll modify the patch and repost.

> Also I wonder what the performance implication of this patch is.
>

It actually works quite well. I took some care to make sure the
algorithm didn't have to scan the entire tree if you only want part of
it and is roughly linear in the number of edges it actually processes.
It does this by borrowing the original heuristic of a latest date
first scan, and also by accumulating "work" to do prior to propagating
it through the network. This means that most nodes are only visited (a
small-multiple of) once.

One thing to be aware of is that it does have to scan to epoch
boundaries which, in the Linux kernel, are spaced an average of 100
commits apart. The first time you run it on a cold-cache, the output
pauses for a while after the first few commits. But run it again when
the cache is warm and the performance is, IMO, quite ok.

Here are the cold-cache stats on the Linux-2.6 tree which has 1300
commits and quite a lot of merges and forks

$ time git-rev-list --merge-order --show-breaks HEAD > out 2>err

real    0m32.283s
user    0m0.135s
sys     0m0.141s

And the warm cache stats:

$ time git-rev-list --merge-order --show-breaks HEAD > out 2>err

real    0m0.181s
user    0m0.119s
sys     0m0.040s

Compared with the standard algorithm:

$ time git-rev-list HEAD > out 2>err

real    0m0.112s
user    0m0.065s
sys     0m0.032s

So, it is perhaps 50-100% slower on a warm-cache than the standard algorithm.

jon.
--
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/

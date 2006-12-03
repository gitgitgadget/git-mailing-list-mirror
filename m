X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 14:55:47 +0100
Organization: Dewire
Message-ID: <200612031455.48032.robin.rosenberg.lists@dewire.com>
References: <20061203045953.GE26668@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 13:54:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061203045953.GE26668@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33111>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqrnX-0000k2-5m for gcvg-git@gmane.org; Sun, 03 Dec
 2006 14:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759685AbWLCNyY convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 08:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759686AbWLCNyY
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 08:54:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18183 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1759683AbWLCNyX convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 08:54:23
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id D0A85802A94; Sun,  3 Dec 2006 14:50:35 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13959-04; Sun,  3 Dec
 2006 14:50:35 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 666B380281C; Sun,  3 Dec 2006 14:50:33 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

s=F6ndag 03 december 2006 05:59 skrev Shawn Pearce:
> With the help of Robin Rosenberg I've been able to make jgit's log
> operation run (on average) within a few milliseconds of core Git.
>
> Walking the 50,000 most recent commits from the Mozilla trunk[1]:
>
>   $ time git rev-list --max-count=3D50000 HEAD >/dev/null
>
>   core Git:  1.882s (average)
>   jgit:      1.932s (average)
>
>   (times are with hot cache and from repeated executions)
Nice indeed. That was a ten-fold improvement for getting my full histor=
y.=20

So, just go on to the next case. I added filtering on filenames (yes,=20
CVS-induced brain damage, I should track the content. next version. fil=
enames=20
are so much handier to work with). That gives me 4.5s to retrieve a fil=
tered=20
history (from 10800 commits).Half of the time is spent in re-sorting tr=
ee=20
entries. Is that really necessary?

> I think that is actually pretty good given that jgit is written
> in Java using a fairly object-oriented design and has to deal with
> some of the limitations of the language.
Most of java's slowness comes from the programmers using it. (Lutz Prec=
helt.=20
Technical opinion: comparing Java vs. C/C++ efficiency differences to=20
interpersonal differences. ACM, Vol 42,#10, 1999)

> One of the biggest annoyances has been the fact that although Java=20
> 1.4 offers a way to mmap a file into the process, the overhead to
> access that data seems to be far higher than just reading the file
> content into a very large byte array, especially if we are going
> to access that file content multiple times.  So jgit performs worse
> than core Git early on while it copies everything from the OS buffer
> cache into the Java process, but then performs reasonably well once
> the internal cache is hot.  On the other hand using the mmap call
> reduces early latency but hurts the access times so much that we're
> talking closer to 3s average read times for the same log operation.

Have you tried that with difference JVM's?


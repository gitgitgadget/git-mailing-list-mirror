From: Paul Jackson <pj@sgi.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Fri, 29 Apr 2005 23:29:22 -0700
Organization: SGI
Message-ID: <20050429232922.03057aba.pj@sgi.com>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
	<20050429172235.21c1af10.pj@sgi.com>
	<Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sat Apr 30 08:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRlOR-0000ct-MB
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 08:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVD3G3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 02:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVD3G3p
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 02:29:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38823 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262535AbVD3G3b (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 02:29:31 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3U6ssbL026005;
	Fri, 29 Apr 2005 23:54:54 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3U6TP5w19886711;
	Fri, 29 Apr 2005 23:29:25 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus replied to pj:
> > Code Sample 2:
> > ...
> Didn't change anything for me. Same thing.

I don't believe you did what I did.

The source code for bash, both 2.x and 3.x versions, clearly displays a
simpler error message (no line number or redisplay of your script
commands) in the case that you set a trap.  And I tested both shells on
a multiprocessor, to verify that they behaved as I expected, running
these silly little scripts.

To labour the point, just now on a multiprocessor near me, the following
six line script:

    ======================== begin ========================
    #!/usr/people/pj/etc/bash/bash-3.0/bash
    for x in 1 2
    do
	    trap continue PIPE      # reduce broken pipe screeching
	    cat /etc/termcap        # a big text file
    done | sed 1q
    ========================= end =========================

produced the following three lines of output:

    ======================== begin ========================
    ######## TERMINAL TYPE DESCRIPTIONS SOURCE FILE
    Broken pipe
    Broken pipe
    ========================= end =========================


whereas the following five line script (no trap):

    ======================== begin ========================
    #!/usr/people/pj/etc/bash/bash-3.0/bash
    for x in 1 2
    do
	    cat /etc/termcap        # a big text file
    done | sed 1q
    ========================= end =========================


produced the following three __noisier__ lines of output:

    ======================== begin ========================
    ######## TERMINAL TYPE DESCRIPTIONS SOURCE FILE
    foo: line 2: 11663 Broken pipe             cat /etc/termcap
    foo: line 2: 11665 Broken pipe             cat /etc/termcap
    ========================= end =========================



> > just that noise, leaving whatever else was on stdout and/or stderr
> > unscathed:
> 
> It will also grep out any occurrence of "Broken pipe", so if we're talking 
> about a kernel changelog, where we fix a pipe bug...

No no no.  You didn't read the code or the comment ;).  That or my code
and comment were both unclear ... far more likely.

The following line noise is not plagarized from last years Obfuscated
Perl Contest:

    ( ( (
	...
    ) 1>&3 ) 2>&1 | grep -vxF 'Broken pipe' 1>&2 ) 3>&1

It's the magic shell incantation to run grep only on the stderr stream,
while passing through the stdout stream untouched.  Even on the stderr
stream, it only zaps lines that are exactly the eleven characters
'Broken pipe' (plus newline).

> I don't know why the bash people have that stupid pipe reporting in the 

Now there we agree.  I might speculate that they were trying to get an
early lead in the Linus Git of the Year contest. But this is relatively
mild compared to some of the crap I've seen on other projects I won't
name here.  So I too am at a loss to know why.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

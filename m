From: Paul Jackson <pj@sgi.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Mon, 2 May 2005 18:44:24 -0700
Organization: SGI
Message-ID: <20050502184424.7cb7f2a4.pj@sgi.com>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
	<20050429172235.21c1af10.pj@sgi.com>
	<Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org>
	<20050429232922.03057aba.pj@sgi.com>
	<20050430110410.GA25322@lsrfire.ath.cx>
	<20050502231743.GL20818@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx, torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 03:39:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSmMw-0007Hd-GS
	for gcvg-git@gmane.org; Tue, 03 May 2005 03:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVECBov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 21:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVECBov
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 21:44:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22987 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261282AbVECBos (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 21:44:48 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j432AMhp029344;
	Mon, 2 May 2005 19:10:25 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j431iR5w20793393;
	Mon, 2 May 2005 18:44:27 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050502231743.GL20818@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Could you elaborate on how exactly is it supposed to help?

The key code is in bash/jobs.c.

If you have a bash while or for loop feeding a pipe that shuts down
while the loop is still running commands that try to write the pipe
(perhaps you were pipe'ing to "head -1", and it exit'd, having read its
one line), then the next command to attempt to write that pipe will die,
and the bash instance that is handling that loop (and forked that
command that just died) will notice the command died with a SIGPIPE
signal.

At this point, one of three possible things happens:

 1) If your bash is compiled with DONT_REPORT_SIGPIPE defined, then
    that bash instance quietly leaves.  The concensus around here
    is that is "good(tm)."

 2) If not so compiled, then:

	2a) If you set a trap on SIGPIPE in that shell, it prints:

		fprintf (stderr, "%s", j_strsignal (termsig));

	2b) Else if you did not trap SIGPIPE, it prints:

		fprintf (stderr, "%s: line %d: ", get_name_for_error (),
				(line_number == 0) ? 1 : line_number);
		pretty_print_job (job, JLIST_NONINTERACTIVE, stderr);


The pretty_print_job() in (2b) can be a multi-line confusion.

Sample output for (2a):

	Broken pipe

Sample output in simple one line case for (2b):

	foo: line 2: 11663 Broken pipe             cat /etc/termcap

A couple of others are reporting different behaviour than what I report
above - including Linus.

So it is almost certain that I don't understand all I know about this.

What behaviour do you see?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

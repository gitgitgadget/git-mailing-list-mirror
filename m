From: Paul Jackson <pj@sgi.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Fri, 29 Apr 2005 17:22:35 -0700
Organization: SGI
Message-ID: <20050429172235.21c1af10.pj@sgi.com>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sat Apr 30 02:17:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRffQ-0003ZO-3O
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 02:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVD3AWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 20:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVD3AWw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 20:22:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59832 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263082AbVD3AWs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 20:22:48 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3U24Wlu000864;
	Fri, 29 Apr 2005 19:04:32 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3U0Mc5w19814864;
	Fri, 29 Apr 2005 17:22:38 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> bash is being an ass about SIGPIPE

You have a multiprocessor, don't you.

The following silly little shell script will provoke the bash SIGPIPE
complaint reliably on a multiprocessor.  It writes a big file, twice,
from a for-loop in a separate bash subshell through a pipe to a command
that exits after seeing one line.

Code Sample 1:

    #!/bin/bash
    for x in 1 2
    do
        cat /etc/termcap	# a big text file
    done | sed 1q

Adding a right trap _inside_ the shell loop that is _before_ the pipe
will reduce the verbosity of the complaint substantially (not show the
line number and text for each command inside the loop that is killed by
the SIGPIPE; rather just show the simple "Broken pipe" error message):

Code Sample 2:

    #!/bin/bash
    for x in 1 2
    do
	trap continue PIPE	# reduce broken pipe screeching
	cat /etc/termcap	# a big text file
    done | sed 1q

Then wrapping the entire pipeline (now that the bogus output is a
constant "Broken pipe" string) in the following manner will filter out
just that noise, leaving whatever else was on stdout and/or stderr
unscathed:

Code Sample 3:

    #!/bin/bash
    ( ( (
	for x in 1 2
	do
		trap continue PIPE      # reduce broken pipe screeching
		cat /etc/termcap        # a big text file
	done | sed 1q
    ) 1>&3 ) 2>&1 | grep -vxF 'Broken pipe' 1>&2 ) 3>&1

The following patch to bash jobs.c will enable "Code Sample 2" to do the
right thing, without depending (so much) on the DONT_REPORT_SIGPIPE
compile time flag.  With this patch, you don't have to go all the way to
the baroque code in "Code Sample 3" to shut bash up.  Just a well placed
trap is sufficient.

Whether or not this is actually worth persuing (or was even worth
reading ;) I don't know.

--- jobs.c.orig 2001-03-26 10:08:24.000000000 -0800
+++ jobs.c      2005-04-29 17:09:44.294763496 -0700
@@ -2686,11 +2686,8 @@ notify_of_job_status ()
                }
              else if (IS_FOREGROUND (job))
                {
-#if !defined (DONT_REPORT_SIGPIPE)
-                 if (termsig && WIFSIGNALED (s) && termsig != SIGINT)
-#else
-                 if (termsig && WIFSIGNALED (s) && termsig != SIGINT && termsig != SIGPIPE)
-#endif
+                 if (termsig && WIFSIGNALED (s) && termsig != SIGINT &&
+                   (termsig != SIGPIPE || signal_is_trapped (termsig) == 0))
                    {
                      fprintf (stderr, "%s", strsignal (termsig));



-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

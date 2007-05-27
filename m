From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Sun, 27 May 2007 09:17:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <87odk6y6cd.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun May 27 18:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsLS7-0000AE-1f
	for gcvg-git@gmane.org; Sun, 27 May 2007 18:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbXE0QSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756456AbXE0QSf
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 12:18:35 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:36588 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755282AbXE0QSe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2007 12:18:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4RGHxTT023263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 09:18:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4RGHwj8029507;
	Sun, 27 May 2007 09:17:59 -0700
In-Reply-To: <87odk6y6cd.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.48 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48566>



On Sun, 27 May 2007, Jim Meyering wrote:
> 
> I have to disagree.  There may be precedent for hiding EPIPE errors,
> but that is not the norm among command line tools wrt piped stdout.

.. and this is a PROBLEM. Which is why I think your patch was really 
wrong.

I don't know how many people remember all the _stupid_ problems we had 
exactly because many versions of bash are crap, crap, crap, and people 
(including you) don't realize that EPIPE is _different_ from other write 
errors.

Just do a google search for

	"broken pipe" bash

and not only will you see a lot of complaints, but the #5 entry is a 
complaint for a git issue that we had tons of problems with. See for 
example

	http://www.gelato.unsw.edu.au/archives/git/0504/2602.html

The reason? Some _idiotic_ versions of bash don't have DONT_REPORT_SIGPIPE 
on by default. 

So I do get upset when people then make the same error with git.

> Do you really want git-log to continue to do this?
> 
>     $ (trap '' PIPE; git-log; echo $? >&2 ) | :
>     0
> 
> With my patch, it does this:
> 
>     $ (trap '' PIPE; ./git-log; echo $? >&2 ) | :
>     fatal: write failure on standard output: Broken pipe
>     128

That error return is fine. The annoying error report, however, is NOT.

For _exactly_ the same reason that a bash that doesn't have 
DONT_REPORT_SIGPIPE enabled is a piece of crap.

And your arguments that "others do it wrong, so we can too" is so broken 
as to be really really sad. If you cannot see the serious problem with 
that argument, I don't know what to tell you.

Try this:

	trap '' PIPE; ./git-log | head

and dammit, if you get an error message from that, your program is BROKEN.

And if you cannot understand that, then I don't even know what to say.

But _exiting_ is fine. It's the bogus error reporting that isn't. The 
above command like should NOT cause the user to have to skip stderr - 
because no error happened!

(Whether the error code is 0 or some error, I dunno. I'd argue that if you 
ignore SIGPIPE, you'd probably also want to do "exit(0)" for EPIPE, but 
it's not nearly as annoying as writing bogus error messages to stderr.

			Linus

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sat, 28 Jul 2012 01:54:39 -0500
Message-ID: <20120728065439.GB4739@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1486896.KW3TvzfC56@flomedio>
 <20120726145426.GB3058@burratino>
 <9398008.kKbpiTCtsb@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Michalske <smichalske@gmail.com>, git@vger.kernel.org,
	David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 08:54:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv0vM-00086e-By
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 08:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab2G1Gyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 02:54:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33280 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab2G1Gyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 02:54:45 -0400
Received: by obbuo13 with SMTP id uo13so5457784obb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eBWoYRPX0h7jfKEdlkinDIGzFV3Z2BWjXkHMb4fWA18=;
        b=zrhR1sSVvV+d+BNo6fqF00K3plPm7TRZ83Xkb+nEhgTYqs2MEXgICgzihJtV2RJQJx
         4v3kZtYzKbKMsuP8W/VYCtiTlfxHXEuylfvq2HiIbdyF9/LnkgN/zaXEQZU3NjlxD23R
         hFohFAeyj5aKC0SY0a+p8Mpc9Ill+Mm8L8r8DD2WvNJYDbHqpovtItprF2U1UUE+6X1Z
         Ii4BuyJr1K+T/EGUdw3zWo/I6uh+Ke1AtYouMeAGqu+gLgWbIvirYQzq51o3TT2s/Yv7
         fIosYiqsm6wt9kVXhxYHIfvUoiEPlg2RcqJV9UmCG8MOa+Y5SPmkybGzjFrjUXHE1fRs
         s+4A==
Received: by 10.50.181.137 with SMTP id dw9mr6696724igc.45.1343458484332;
        Fri, 27 Jul 2012 23:54:44 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q1sm2373911igj.15.2012.07.27.23.54.42
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 23:54:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9398008.kKbpiTCtsb@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202406>

Hi,

Some quick details.

Florian Achleitner wrote:

>                                        Anyways, specifying cat-blob-fd is not 
> allowed via the 'option' command (see Documentation and 85c62395).
> It wouldn't make too much sense, because the file descriptor must be set up by 
> the parent.
>
> But for the fifo, it would, probably.

More precisely, requiring that the cat-blob fd go on the command line
instead of in the stream matches a model where fast-import's three
standard streams are abstract:

 - its input, using the INPUT FORMAT described in git-fast-import(1)
 - its standard output, which echoes "progress" commands
 - its backflow stream, where responses to "cat-blob" and "ls" commands go

The stream format is not necessarily pinned to a Unix model where
input and output are based on filesystems and file descriptors.  We
can imagine a fast-import backend that runs on a remote server and the
transport used for these streams is sockets; for fast-import frontends
to be usable in such a context, the streams they produce must not rely
on particular fd numbers, nor on pathnames (except for mark state
saved to relative paths with --relative-marks) representing anything
in particular.

This goes just as much for a fifo set up on the filesystem where the
fast-import backend runs as for an inherited file descriptor.  In the
current model, such backend-specific details of setup go on the
command line.

>                                       The backward channel is only used by the 
> commands 'cat-blob' and 'ls' of fast-import. If a remote helper wants to use 
> them, it would could make fast-import open the pipe by sending an 'option' 
> command with the fifo filename, otherwise it defaults to stdout (like now) and 
> is rather useless.

I'm getting confused by terminology again.  Let's see if I have the cast
of characters straight:

 - the fast-import backend (e.g., "git fast-import" or "hg-fastimport")
 - the fast-import frontend (e.g., "git fast-export" or svn-fe)
 - git's generic foreign VCS support plumbing, also known as
   transport-helper.c
 - the remote helper (e.g., "git remote-svn" or "git remote-testgit")

Why would the fast-import backend ever need to open a pipe?  If I want
it to write backflow to a fifo, I can use

	mkfifo my-favorite-fifo
	git fast-import --cat-blob-fd=3 3>my-favorite-fifo

If I want it to write backflow to a pipe, I can use (using ksh syntax)

	cat |&
	git fast-import --cat-blob-fd=3 3>&p

> This would take the fifo setup out of transport-helper. The remote-helper would 
> have to create it, if it needs it.

We can imagine transport-helper.c learning the name of a fifo set up by
the remote helper by sending it the "capabilities" command:

	git> capabilities
	helper> option
	helper> import
	helper> cat-blob-file my-favorite-fifo
	helper> refspec refs/heads/*:refs/helper/remotename/*
	helper>

transport-helper.c could then use that information to invoke
fast-import appropriately:

	git fast-import --cat-blob-fd=3 3>my-favorite-fifo

But this seems like pushing complication onto the remote helper; since
there is expected to be one remote helper per foreign VCS,
implementing the appropriate logic correctly once and for all in
transport-helper.c for all interested remote helpers to take advantage
of seems to me like a better policy.

> Apropos stdout. That leads to another idea. You already suggested that it 
> would be easiest to only use FDs 0..2. Currently stdout and stderr of fast-
> import go to the shell. We could connect stdout to the remote-helper and don't 
> need the additional channel at all.

The complication that makes this strategy not so easy is "progress"
commands in the fast-import input stream.  (Incidentally, it would be
nice to teach transport-helper.c to display specially formatted
"progress" commands using a progress bar some day.)

Hoping that clarifies,
Jonathan

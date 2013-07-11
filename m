From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Bug:  Failure if stdin is closed.
Date: Thu, 11 Jul 2013 17:39:00 +0200
Message-ID: <87r4f52jjf.fsf@linux-k42r.v.cablecom.net>
References: <201307111511.r6BFBO44010988@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 11 17:39:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxIxb-0002Ce-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 17:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab3GKPjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 11:39:05 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:23081 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885Ab3GKPjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 11:39:03 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 11 Jul
 2013 17:38:59 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 11 Jul 2013 17:39:00 +0200
In-Reply-To: <201307111511.r6BFBO44010988@freeze.ariadne.com> (Dale
	R. Worley's message of "Thu, 11 Jul 2013 11:11:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230107>

worley@alum.mit.edu (Dale R. Worley) writes:

> (The original problem and the discussion that ensued is on the
> git-users mailing list:
> https://groups.google.com/forum/#!topic/git-users/lNQ7Cn35EqA)
>
> "git commit" (and probably other operations) fail if standard input
> (fd 0) is closed when git starts.  A simple test case follows.  (The
> execution is version 1.7.7.6, but the code listed below is from a very
> recent commit.)

While you found a real bug in the use of open() below, I'm not convinced
that this scenario is something that should be guarded against.  For
example [1] says

  At program start-up, three streams shall be predefined and need not be
  opened explicitly: standard input (for reading conventional input),
  standard output (for writing conventional output), and standard error
  (for writing diagnostic output).

I haven't found a similar clause relating to the file descriptors 0--2,
but my reading of the above paragraph is that running a program without
an open stdin, stdout and stderr is, in fact, not POSIX.

Closing 2 usually has even funkier consequences if the program proceeds
to open some other file, it ends up as fd 2, and it then dies with an
error.  In that sense it might be saner to simply die whenever open()
gives an FD in the 0..2 range (and we weren't explicitly trying to
reopen one of them).

May I ask why you need this, and to what extent this problem cannot be
solved by instead redirecting from/to /dev/null?

> The fundamental error is that git_mkstemps_mode() in wrapper.c assumes
> that if open() is successful, its return value must be >0.  That is
> not true, because if fd 0 is closed, then open() can successfully
> return 0.  I have not tested it, but it looks like the fix is:
[...]
> 		 template[5] = letters[v % num_letters]; v /= num_letters;
>
> 		 fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> -		 if (fd > 0)
> +		 if (fd >= 0)
> 			 return fd;
> 		 /*
> 		  * Fatal error (EPERM, ENOSPC etc).

This is an actual bug, as you say; open() is defined to return -1 on
error, not 0.  You can turn this into a patch, and send it as per
Documentation/SubmittingPatches.

However, does it fully fix the issue you describe?  What if you then run
'git checkout -F -' to read the message from stdin?

> However, when looking at the code, I noticed that few of the functions
> have comments describing what they do, and none describe their input
> and output values.  In particular, there are no comments specifying
> what the error return values are.  This is appalling for a supposedly
> professional-quality project!

You are touching on a sore point of the git code base.  Some
contributors have made a point of adding comments where appropriate, so
we're improving, but round tuits are in short supply as always.  If you
can supply such tuits, they would be appreciated.



[1]  http://pubs.opengroup.org/onlinepubs/009695399/functions/stdin.html

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

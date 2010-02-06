From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Sat, 6 Feb 2010 23:18:59 +0100
Message-ID: <201002062318.59180.j6t@kdbg.org>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com> <201002061106.04305.j6t@kdbg.org> <40aa078e1002060401r1dec3c2ate3ddd4f5f5db1e0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 06 23:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndt0t-00087H-SO
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 23:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966Ab0BFWUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 17:20:22 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:64691 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756147Ab0BFWUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 17:20:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7D47910023;
	Sat,  6 Feb 2010 23:20:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4103B19F5F9;
	Sat,  6 Feb 2010 23:18:59 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1002060401r1dec3c2ate3ddd4f5f5db1e0c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139198>

On Samstag, 6. Februar 2010, Erik Faye-Lund wrote:
> However, I have tracked down a bit of what goes on in the client.
> There's a call to read_in_full, called from pack-write.c, line 246
> that fails in the failure-case, but not in the success-case. This is
> where the client expects "pack\tSHA-1" or "keep\tSHA-1". There "fatal:
> early EOF"-messages seems to originate from index-pack.c, line 197.
> This is the first line of code in parse_pack_header(), it's also
> AFAICT the first call-site for any read(0, <...>) (though fill()).

This looks like upload-pack died without sending enough to fill a pack header.

Try merging this branch:

  git://repo.or.cz/git/mingw/j6t.git async-in-thread

It contains your changes to start_async plus a refinement of die() when it is 
called from the async procedure (it passes t5530, for example). It is also 
converted to pthreads, and therefore also works on Unix. The new 
implementation of start_async is more careful about the file handles, though 
not so much on Windows.

If there's no change for you, then you could look into implementing 
fcntl(F_GETFD/SETFD, FD_CLOEXEC), which are currently ignored, on top of this 
branch, using Get/SetHandleInformation().

Background: On Unix, we need FD_CLOEXEC so that the fds that are meant for the 
async thread do not remain open in an unrelated child process; on Windows, we 
are just lucky and can get away without FD_CLOEXEC because our pipe()s are 
non-inheritable and async only work with pipes. But once we pass other fds to 
the async procedure, we need a working FD_CLOEXEC. Perhaps something in this 
direction is related to your problem.

You could push out your current state of the git-daemon and a recipe to 
reproduce the problem. Perhaps I find some time to look into it.

-- Hannes

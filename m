From: Bruno Santos <nayart3@gmail.com>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 23:18:58 +0000
Message-ID: <490B9262.5070905@gmail.com>
References: <20081031170704.GU14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:20:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4E4-0005aL-VA
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYKAATM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbYKAATM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:19:12 -0400
Received: from mail.av.it.pt ([193.136.92.53]:50335 "EHLO av.it.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751025AbYKAATL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:19:11 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Oct 2008 20:19:11 EDT
Received: from [84.91.33.231] (account bsantos HELO [192.168.1.100])
  by av.it.pt (CommuniGate Pro SMTP 5.1.7)
  with ESMTPA id 30317883; Fri, 31 Oct 2008 23:17:32 +0000
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081031170704.GU14786@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99690>

Shawn O. Pearce wrote:
> During the GitTogether we were kicking around the idea of a ground-up
> implementation of a Git library.  This may be easier than trying
> to grind down git.git into a library, as we aren't tied to any
> of the current global state baggage or the current die() based
> error handling.
> 
> I've started an _extremely_ rough draft.  The code compiles into a
> libgit.a but it doesn't even implement what it describes in the API,
> let alone a working Git implementation.  Really what I'm trying to
> incite here is some discussion on what the API looks like.
> 
> API Docs:
> http://www.spearce.org/projects/scm/libgit2/apidocs/html/modules.html
> 
> Source Code Clone URL:
> http://www.spearce.org/projects/scm/libgit2/libgit2.git
> 

We should take the opportunity a make it more portable. Instead of using
the posix api directly we should warp it in "git_" APIs. And be carefull
with certain APIs like fork or fork+exec and instead provided a more
generic solution: for fork one that would use the best solution in the
given platform, either by forking or threading; and for fork+exec a
generic create_process/run_command.


Here's an example, for the 'read' API, on how we can simply do this
without worries for the posix crowd:

ssize_t git_read(git_fildes_t fildes, void* buf, size_t bufsize);

Were git_fildes_t would be an int for posix and an HANDLE for win32.
For the posix case git_read can be simply inlined and we get zero overhead:

static inline ssize_t git_read(git_fildes_t fildes, void *buf,
			size_t bufsize)
{
	return read(fildes, buf, bufsize);
}

And for the win32 case it would be much more easier to implement the
equivalent, something like:

ssize_t git_read(git_fildes_t fildes, void *buf, size_t bufsize)
{
	DWORD rd;

	if (!ReadFile(fildes, buf, bufsize, &rd, NULL)) {
		//translate win32 error to errno
		return -1;
	}
	return rd;
}


Of course, there is also the issue of using the c runtime on win32, but
that problem can be easily solved outside git, provided that we don't
use a 'fileno' like API.



Bruno Santos

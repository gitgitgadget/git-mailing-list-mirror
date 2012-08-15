From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Thu, 16 Aug 2012 00:29:13 +0200
Message-ID: <20120815222911.GA44080@book.hvoigt.net>
References: <20120811070030.GA83665@book.hvoigt.net> <7vd32whgvl.fsf@alter.siamese.dyndns.org> <20120813170221.GB6418@book.hvoigt.net> <7vmx1yel9d.fsf@alter.siamese.dyndns.org> <20120815165054.GA43523@book.hvoigt.net> <7v7gt06nyk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1m6Y-00056t-DY
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 00:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094Ab2HOWaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 18:30:14 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:52208 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab2HOWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 18:30:13 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T1m5R-0001Mt-Ss; Thu, 16 Aug 2012 00:29:14 +0200
Content-Disposition: inline
In-Reply-To: <7v7gt06nyk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Aug 15, 2012 at 10:53:55AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > On Mon, Aug 13, 2012 at 10:48:14AM -0700, Junio C Hamano wrote:
> >> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >> > What do you think?
> >> 
> >> Does having the "stat()" help on Windows in any way?  Does it ever
> >> return an executable bit by itself?
> >
> > No, AFAIK it does not return anything about executability. But I think
> > the stat is still necessary to verify that the file exists and is a
> > regular file.
> 
> But if you are going to read it anyway, you can tell it from open()
> and read() of the first 2 bytes failing, no?  That will still be an
> implementation detail of platform specific "is_path_executable()".

No I am not opening the file anyway. Only when it does not have a
".exe" postfix. That at least was the intention of my previous patch in
this thread.

> So you are forcing Windows an extra and unnecessary stat() that only
> is needed on Cygwin, no?

My first patch in this thread (which lead to this extraction) is about
avoiding the open because it is possibly very costly on our git binaries
in case a virus scanner is running.

The optimized (and correct) check does only look at the given filename
if it contains a ".exe" postfix. A directory (although unlikely) could
also have such a suffix. Should we then consider that directory to be a
git command? AFAICS there is no such check in the earlier codepath.

A stat is much cheaper since it does not open the file. For scripts the
open is much cheaper than for our binaries because they are much
smaller. For clarification: All the git builtin binaries basically
contain the same code. Even though they are hardlinked, the system (or
the scanner) does still consider them like individual files and executes
a scan for each of them. That at least seems to be the case on a number
of systems.

> > @@ -1347,7 +1348,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> >  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
> >  	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
> >  		compat/win32/pthread.o compat/win32/syslog.o \
> > -		compat/win32/poll.o compat/win32/dirent.o
> > +		compat/win32/poll.o compat/win32/dirent.o \
> > +		compat/win32/executable.o
> 
> Looks sensible, even though the filename does not tell what it does
> about "executable".  is_executable.o might be a better name for them.

Agreed, I was not sure about the name anyway. is_executable.o sounds
better.

> > diff --git a/help.c b/help.c
> > index ebc2c42..d9fae3c 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -106,34 +106,8 @@ static int is_executable(const char *name)
> >  	    !S_ISREG(st.st_mode))
> >  		return 0;
> >  
> > -#if defined(WIN32) || defined(__CYGWIN__)
> > -	/* On Windows we cannot use the executable bit. The executable
> > -	 * state is determined by extension only. We do this first
> > -	 * because with virus scanners opening an executeable for
> > -	 * reading is potentially expensive.
> > -	 */
> > -	if (has_extension(name, ".exe"))
> > -		return S_IXUSR;
> > -
> > -#if defined(__CYGWIN__)
> > -if ((st.st_mode & S_IXUSR) == 0)
> > -#endif
> > -{	/* now that we know it does not have an executable extension,
> > -	   peek into the file instead */
> > -	char buf[3] = { 0 };
> > -	int n;
> > -	int fd = open(name, O_RDONLY);
> > -	st.st_mode &= ~S_IXUSR;
> > -	if (fd >= 0) {
> > -		n = read(fd, buf, 2);
> > -		if (n == 2)
> > -			/* look for a she-bang */
> > -			if (!strcmp(buf, "#!"))
> > -				st.st_mode |= S_IXUSR;
> > -		close(fd);
> > -	}
> > -}
> > -#endif
> > +	correct_executable_stat(name, &st);
> > +
> 
> Yuck.
> 
> Why should we need even a single line of the implementation of a
> function that tells if a given pathname contains an executable
> command, which we know is platform specific?  
> 
> On Posix systems, the implementation will be "stat() and check
> S_IXUSR".  On pure Windows, it will be "check .exe, or open it and
> read the first two bytes". On Cygwin, it will also be "check .exe,
> stat() and check S_IXUSR, or open it and read the first two bytes.
> 
> It is not like the caller of is_executable() needed to run stat for
> other purposes on its own and we can optimize by either borrowing
> the stat data the caller already collected for us, or returning the
> stat data we collected for later use by the caller.  The use of stat
> is entirely contained in the POSIX implementation of this function.
> 
> Why are you so dead-set to shoehorn the different semantics into
> "struct stat" that we know is not an appropriate abstraction across
> platforms?

I simply think filling in the correct information into the data
structure we use on all platforms is the most transparent approach. We
could also call this function

	correct_executable_stat_if_needed_by_platform()

but I considered that name to be too long. As explained above: To be
fully correct the stat call is still needed to make sure we are not
looking at a directory. list_commands_in_dir() from help.c is iterating
over all entries in a given directory so if we skip the stat we are not
sure whether we look at something that is not a regular file. Even
though its unlikely that there will be a directory named something.exe
in the git executable directory I would still like to keep the check in
there.

When first looking at this I also thought about extending the windows
stat replacement to do this whole logic. Then we could completely remove
this platform specific thing. But I decided against that because when
the file does not have a ".exe" postfix we would have an open call in all
stats and to my knowledge that is very expensive on Windows.

I do not know why you are against filling that information into "struct
stat". I could rephrase the above into something like this

	if (platform_is_executeable(name))
		return 1;

but its not that easy to replace to a no op by a macro anymore.

Cheers Heiko

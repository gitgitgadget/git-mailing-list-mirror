From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Mon, 13 Aug 2012 19:02:23 +0200
Message-ID: <20120813170221.GB6418@book.hvoigt.net>
References: <20120811070030.GA83665@book.hvoigt.net> <7vd32whgvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0y2I-00080R-6j
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab2HMRCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:02:32 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:32881 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab2HMRCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:02:31 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T0y24-0000zk-2u; Mon, 13 Aug 2012 19:02:24 +0200
Content-Disposition: inline
In-Reply-To: <7vd32whgvl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203343>

On Sat, Aug 11, 2012 at 09:30:06PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >  help.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/help.c b/help.c
> > index 662349d..b41fa21 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -103,10 +103,19 @@ static int is_executable(const char *name)
> >  		return 0;
> >  
> >  #if defined(WIN32) || defined(__CYGWIN__)
> > +	/* On Windows we cannot use the executable bit. The executable
> > +	 * state is determined by extension only. We do this first
> > +	 * because with virus scanners opening an executeable for
> > +	 * reading is potentially expensive.
> > +	 */
> > +	if (has_extension(name, ".exe"))
> > +		return S_IXUSR;
> > +
> >  #if defined(__CYGWIN__)
> >  if ((st.st_mode & S_IXUSR) == 0)
> >  #endif
> > -{	/* cannot trust the executable bit, peek into the file instead */
> > +{	/* now that we know it does not have an executable extension,
> > +	   peek into the file instead */
> >  	char buf[3] = { 0 };
> >  	int n;
> >  	int fd = open(name, O_RDONLY);
> > @@ -114,8 +123,8 @@ if ((st.st_mode & S_IXUSR) == 0)
> >  	if (fd >= 0) {
> >  		n = read(fd, buf, 2);
> >  		if (n == 2)
> > -			/* DOS executables start with "MZ" */
> > -			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
> > +			/* look for a she-bang */
> > +			if (!strcmp(buf, "#!"))
> >  				st.st_mode |= S_IXUSR;
> >  		close(fd);
> >  	}
> 
> Would it make sense to move this to compat/win32/, compat/cygwin.c,
> and compat/posix.c, each exporting is_executable(const char *path),
> so that we do not have to suffer the #ifdef mess?

Yes that makes sense. But that means I need to test the code on multiple
platforms. To ease the merge in msysgit (the patch is already applied there)
I would suggest to post a follow up patch which would split up the function
into the platform specific parts.

Since the code for cygwin and windows in general is almost the same I would
extract one function for them where I leave in one ifdef for cygwin.

E.g. like this:


	static int is_executable(const char *name)
	{
	        struct stat st;

	        if (stat(name, &st) || /* stat, not lstat */
	            !S_ISREG(st.st_mode))
	                return 0;

		fill_platform_stat(name, &st);

	        return st.st_mode & S_IXUSR;
	}

which I could then define to a no op on posix. That way we avoid code
duplication in the platform specific functions.

What do you think?

Cheers Heiko

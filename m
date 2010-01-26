From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Tue, 26 Jan 2010 11:59:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001261146040.4641@intel-tinevez-2-302>
References: <201001250155.47664.robin.rosenberg@dewire.com> <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302> <201001252045.28778.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-96809681-1264503597=:4641"
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZj9c-000101-VM
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 12:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0AZLAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 06:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197Ab0AZLAB
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 06:00:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:49016 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752969Ab0AZK77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 05:59:59 -0500
Received: (qmail invoked by alias); 26 Jan 2010 10:59:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp072) with SMTP; 26 Jan 2010 11:59:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183wyExsNo3Q0wSRGK7rSs93xcCuBN6ZAA1ajdZ7o
	02UqnoWljsGKyw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <201001252045.28778.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138028>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-96809681-1264503597=:4641
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

thanks for Cc:ing me this time.

On Mon, 25 Jan 2010, Robin Rosenberg wrote:

> måndagen den 25 januari 2010 18.34.01 skrev  Johannes Schindelin:
> 
> > On Mon, 25 Jan 2010, Robin Rosenberg wrote:
> > > >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00 2001
> > >
> > > From: Robin Rosenberg <robin.rosenberg@dewire.com>
> > > Date: Mon, 25 Jan 2010 01:41:03 +0100
> > > Subject: [PATCH] Handle UNC paths everywhere
> > >
> > > In Windows paths beginning with // are knows as UNC paths. They are
> > > absolute paths, usually referring to a shared resource on a server.
> > 
> > And even a simple "cd" with them does not work.
> > 
> > > Examples of legal UNC paths
> > >
> > > 	\\hub\repos\repo
> > > 	\\?\unc\hub\repos
> > > 	\\?\d:\repo
> > >
> > > Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> > > ---
> > >  cache.h           |    2 +-
> > >  compat/basename.c |    2 +-
> > >  compat/mingw.h    |    8 +++++++-
> > >  connect.c         |    2 +-
> > >  git-compat-util.h |    9 +++++++++
> > >  path.c            |    2 +-
> > >  setup.c           |    2 +-
> > >  sha1_file.c       |   20 ++++++++++++++++++++
> > >  transport.c       |    2 +-
> > >  9 files changed, 42 insertions(+), 7 deletions(-)
> > 
> > Ouch.  You should know better than to clutter non-Windows-specific parts
> > with that ugly kludge.

I did suspect that it would be better to handle unc paths differently than 
the dos prefix, but I did not have the time to form arguments like Hannes 
did.

So I think the first order of business is to add new code paths, rather 
than modify existing ones.  And then you can '#define 
network_path_prefix_length(name) 0' in git-compat-util.h so that on 
non-Windows platforms (i.e. our 1st class citizens), the code path can be 
optimized out.

> > > diff --git a/cache.h b/cache.h
> > > index 767a50e..8f63640 100644
> > > --- a/cache.h
> > > +++ b/cache.h
> > > @@ -648,7 +648,7 @@ int safe_create_leading_directories_const(const char
> > > *path);
> > >  char *enter_repo(char *path, int strict);
> > >  static inline int is_absolute_path(const char *path)
> > >  {
> > > -	return path[0] == '/' || has_dos_drive_prefix(path);
> > > +	return path[0] == '/' || has_win32_abs_prefix(path);
> > 
> > Why?  We can still keep the name.  Well, maybe not, see below.
> 
> I do think function names should imply something about their behaviour.

Actually, in this case, you do not even need to change anything, as Hannes 
pointed out.

> > > diff --git a/compat/mingw.h b/compat/mingw.h
> > > index 1b528da..d1aa8be 100644
> > > --- a/compat/mingw.h
> > > +++ b/compat/mingw.h
> > > @@ -210,7 +210,13 @@ int winansi_fprintf(FILE *stream, const char
> > > *format, ...) __attribute__((format
> > >   * git specific compatibility
> > >   */
> > >
> > > -#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] ==
> > > ':') +#define has_dos_drive_prefix(path) \
> > > +	(isalpha(*(path)) && (path)[1] == ':')
> > 
> > Why?
> 
> To avoid very long lines and format this (now) set of related macros 
> uniformely.

If you want your patch to go in (which you probably did not, you just 
forgot to prefix the subject with RFC or RFH), you need it to be reviewed.  
It is not a good idea to distract reviewers.  Such a change does so.

> > > +#define has_unc_prefix(path) \
> > > +	(is_dir_sep((path)[0]) && is_dir_sep((path)[1]))
> > > +#define has_win32_abs_prefix(path) \
> > > +	(has_dos_drive_prefix(path) || has_unc_prefix(path))
> > 
> > "c:hello.txt" is not an absolute path.
> Ok. Nevertheless that was how it was treated before, It's not relative,
> either, but some quasirelative thing. has_win32_quasi_abs_prefix?

No, none of this is good.  You should not even pretend that the unc prefix 
and the DOS drive prefix are the same.  Just leave the old code paths 
alone.

> > > diff --git a/git-compat-util.h b/git-compat-util.h
> > > index ef60803..0de9dac 100644
> > > --- a/git-compat-util.h
> > > +++ b/git-compat-util.h
> > > @@ -170,6 +170,15 @@ extern char *gitbasename(char *);
> > >  #define has_dos_drive_prefix(path) 0
> > >  #endif
> > >
> > > +#ifndef has_unc_prefix
> > > +#define has_unc_prefix(path) 0
> > > +#endif
> > > +
> > > +#ifndef has_win32_abs_prefix
> > > +#error no abs
> ouch, a leftover from trying to figure out a complation message. 

Thought so.

> > In general, I am _very_ worried about your patch.  It does not 
> > acknowledge that there is a fundamental difference between DOS drive 
> > prefixes and UNC paths, and not being able to "cd" to the latter is 
> > just a symptom.
> 
> As I said. Most programs including bash, but excluding cmd.exe can set 
> the working directory to an UNC path. I cannot fix cmd.exe and rarely 
> use it with git, but the patch helps even if you cannot cd from a UNC 
> challenged shell.

The point I tried to make is that you should treat UNC paths differently, 
and you can even leave the door open for non-Windows stuff.  Just call the 
function network_path_prefix_length() returning the length of the prefix.  
If it becomes standard, say, on Linux, to have support for smb:// style 
paths, we can always add support for that, too, and do not have to change 
the name yet again.

Plus, by having separate code paths, you can be sure that you do not break 
the existing ones.

And by defining network_path_prefix_length(path) to 0, the new code paths 
can be optimized out on platforms which do not support network paths.

> > I am also not quite sure if you can get away with having the same 
> > offset for both: if I have "C:\blah" and strip off "C:", I always have 
> > a directory separator to bounce against, whereas I do not have that if 
> > I strip off the two "\\" of a UNC path.  Besides, I maintain that the 
> > host name, and maybe even the share name, should not ever be stripped 
> > off!
> 
> When creating directoties you only strip them off for the purpose of 
> finding paths to mkdir. The server and share part you cannot mkdir 
> anyway, they must exist before attempting to create a directory, hence I 
> skip past those portions.

I must have missed that.  From what I saw, you treat the offset to be the 
same as for DOS drive paths: 2 characters, which is definitely not enough.

Unfortunately, this patch needs more revisions, so it will probably not 
make it into the upcoming Git for Windows, I am afraid.  But then, we do 
not need to let 3 months happen without a Git for Windows release.

Ciao,
Dscho

--8323329-96809681-1264503597=:4641--

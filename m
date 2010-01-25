From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 18:34:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
References: <201001250155.47664.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 18:52:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZT6s-0007nX-Hs
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 18:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab0AYRwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 12:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309Ab0AYRwS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 12:52:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:42272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750845Ab0AYRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 12:52:16 -0500
Received: (qmail invoked by alias); 25 Jan 2010 17:34:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 25 Jan 2010 18:34:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19k5gMwxcdkXhMXGPpuKn8qhuVO5Shh1NPtALLScG
	guYeDhilSYVvX9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <201001250155.47664.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137971>

Hi,

On Mon, 25 Jan 2010, Robin Rosenberg wrote:

> >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Mon, 25 Jan 2010 01:41:03 +0100
> Subject: [PATCH] Handle UNC paths everywhere
> 
> In Windows paths beginning with // are knows as UNC paths. They are
> absolute paths, usually referring to a shared resource on a server.

And even a simple "cd" with them does not work.

> Examples of legal UNC paths
> 
> 	\\hub\repos\repo
> 	\\?\unc\hub\repos
> 	\\?\d:\repo
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  cache.h           |    2 +-
>  compat/basename.c |    2 +-
>  compat/mingw.h    |    8 +++++++-
>  connect.c         |    2 +-
>  git-compat-util.h |    9 +++++++++
>  path.c            |    2 +-
>  setup.c           |    2 +-
>  sha1_file.c       |   20 ++++++++++++++++++++
>  transport.c       |    2 +-
>  9 files changed, 42 insertions(+), 7 deletions(-)

Ouch.  You should know better than to clutter non-Windows-specific parts 
with that ugly kludge.

> diff --git a/cache.h b/cache.h
> index 767a50e..8f63640 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -648,7 +648,7 @@ int safe_create_leading_directories_const(const char 
> *path);
>  char *enter_repo(char *path, int strict);
>  static inline int is_absolute_path(const char *path)
>  {
> -	return path[0] == '/' || has_dos_drive_prefix(path);
> +	return path[0] == '/' || has_win32_abs_prefix(path);

Why?  We can still keep the name.  Well, maybe not, see below.

> diff --git a/compat/mingw.h b/compat/mingw.h
> index 1b528da..d1aa8be 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -210,7 +210,13 @@ int winansi_fprintf(FILE *stream, const char *format, 
> ...) __attribute__((format
>   * git specific compatibility
>   */
>  
> -#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
> +#define has_dos_drive_prefix(path) \
> +	(isalpha(*(path)) && (path)[1] == ':')

Why?

> +#define has_unc_prefix(path) \
> +	(is_dir_sep((path)[0]) && is_dir_sep((path)[1]))
> +#define has_win32_abs_prefix(path) \
> +	(has_dos_drive_prefix(path) || has_unc_prefix(path))

"c:hello.txt" is not an absolute path.

> diff --git a/connect.c b/connect.c
> index 7945e38..9d4556c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -535,7 +535,7 @@ struct child_process *git_connect(int fd[2], const char 
> *url_orig,
>  		end = host;
>  
>  	path = strchr(end, c);
> -	if (path && !has_dos_drive_prefix(end)) {
> +	if (path && !has_win32_abs_prefix(end)) {
>  		if (c == ':') {

Why?  Do we really have to exclude UNC paths from that ":" handling?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index ef60803..0de9dac 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -170,6 +170,15 @@ extern char *gitbasename(char *);
>  #define has_dos_drive_prefix(path) 0
>  #endif
>  
> +#ifndef has_unc_prefix
> +#define has_unc_prefix(path) 0
> +#endif
> +
> +#ifndef has_win32_abs_prefix
> +#error no abs

Yeah, sure.  I do have abs, thank you very much.

In general, I am _very_ worried about your patch.  It does not acknowledge 
that there is a fundamental difference between DOS drive prefixes and UNC 
paths, and not being able to "cd" to the latter is just a symptom.

I am also not quite sure if you can get away with having the same offset 
for both: if I have "C:\blah" and strip off "C:", I always have a 
directory separator to bounce against, whereas I do not have that if I 
strip off the two "\\" of a UNC path.  Besides, I maintain that the host 
name, and maybe even the share name, should not ever be stripped off!

At least a discussion is missing from the commit message.

Ciao,
Dscho

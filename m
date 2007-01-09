From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek()
 sequence.
Date: Tue, 09 Jan 2007 21:41:41 +0000
Message-ID: <45A40C15.1070200@shadowen.org>
References: 7v1wm4kl24.fsf@assigned-by-dhcp.cox.net <11683766523955-git-send-email-> <11683766521544-git-send-email->
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 22:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Oj4-0007DU-Ge
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbXAIVlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbXAIVlo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:41:44 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1728 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbXAIVln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:41:43 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H4Oi6-00024g-5D; Tue, 09 Jan 2007 21:40:46 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: <11683766521544-git-send-email->
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36409>

Stefan-W. Hahn wrote:
> From: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> 
> Using cygwin with cygwin.dll before 1.5.22 the system call pread() is buggy.
> This patch introduces NO_PREAD. If NO_PREAD is set git uses a sequence of
> lseek()/xread()/lseek() to emulate pread.
> 
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> ---
>  Makefile          |    7 +++++++
>  compat/pread.c    |   18 ++++++++++++++++++
>  git-compat-util.h |    5 +++++
>  3 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 6c12bc6..43113e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -69,6 +69,9 @@ all:
>  #
>  # Define NO_MMAP if you want to avoid mmap.
>  #
> +# Define NO_PREAD if you have a problem with pread() system call (e.g.
> +# cygwin.dll before v1.5.22).
> +#
>  # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
>  # generally faster on your platform than accessing the working directory.
>  #
> @@ -523,6 +526,10 @@ ifdef NO_MMAP
>  	COMPAT_CFLAGS += -DNO_MMAP
>  	COMPAT_OBJS += compat/mmap.o
>  endif
> +ifdef NO_PREAD
> +	COMPAT_CFLAGS += -DNO_PREAD
> +	COMPAT_OBJS += compat/pread.o
> +endif
>  ifdef NO_FAST_WORKING_DIRECTORY
>  	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
>  endif
> diff --git a/compat/pread.c b/compat/pread.c
> new file mode 100644
> index 0000000..9183c05
> --- /dev/null
> +++ b/compat/pread.c
> @@ -0,0 +1,18 @@
> +#include "../git-compat-util.h"
> +
> +ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
> +{
> +        off_t current_offset;
> +        ssize_t rc;
> +
> +        current_offset = lseek(fd, 0, SEEK_CUR);
> +
> +        if (lseek(fd, offset, SEEK_SET) < 0)
> +                return -1;
> +
> +        rc=read_in_full(fd, buf, count);

Seems to be style inconsistancy between current_offset = and rc= I
believe the former is preferred.

> +
> +        if (current_offset != lseek(fd, current_offset, SEEK_SET))
> +                return -1;

How likely are we ever to be in the right place here?  Seems vanishingly
small putting us firmly in the four syscalls per call space.  I wonder
if git ever actually cares about the seek location.  ie if we could stop
reading and resetting it.  Probabally not worth working it out I guess
as any _sane_ system has one.

> +        return rc;
> +}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e023bf1..f8d46d5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -107,6 +107,11 @@ extern int git_munmap(void *start, size_t length);
>  #define DEFAULT_PACKED_GIT_LIMIT \
>  	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
>  
> +#ifdef NO_PREAD
> +#define pread git_pread
> +extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
> +#endif
> +
>  #ifdef NO_SETENV
>  #define setenv gitsetenv
>  extern int gitsetenv(const char *, const char *, int);

-apw

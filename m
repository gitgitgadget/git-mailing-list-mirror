From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Wed, 31 Mar 2010 11:29:23 -0500
Message-ID: <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Mar 31 18:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx0nS-0007Vy-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 18:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745Ab0CaQ3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 12:29:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39447 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635Ab0CaQ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 12:29:32 -0400
Received: by mail.nrlssc.navy.mil id o2VGTNjj018904; Wed, 31 Mar 2010 11:29:23 -0500
In-Reply-To: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
X-OriginalArrivalTime: 31 Mar 2010 16:29:23.0755 (UTC) FILETIME=[52BFE7B0:01CAD0EF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143684>

On 03/30/2010 01:22 PM, Tor Arntsen wrote:
> This patch to Makefile makes git build for me on Tru64/OSF1 V5.1 with
> the native compiler.
> 
> It needs libcurl installed either in /usr or /usr/local, and ditto for
> zlib. The zlib installed on my old Tru64 box is from the original
> 'apt-like' tachometer repository at hp.com, now gone. That version is
> pretty old, so my patch includes 'NO_DEFLATE_BOUND'. tcl/tk (included
> standard on Tru64) is 8.2 which is too old, so that one (and thus
> 'gitk') is also disabled in the patch. If someone has V5.2 or newer
> they could check tcl/tk version etc., add some $(uname_R) directives
> and adjust as necessary.
> 
> The resulting git version is fully working (as far as I can tell), and
> now in use for the Tru64 autobuilds at http://curl.haxx.se/auto/
> (which just does 'git pull' regularly). And the patch is produced
> locally on the Tru64 machine, with git, obviously.
> 
> Patch included below, as well as attached (in case of
> mailler-mangling). Please let me know if you feel there are any issues
> with it.
> 
> -Tor
> 
> From d4a5ba0727d7e3a4455320bad641cb34402d16fd Mon Sep 17 00:00:00 2001
> From: Tor Arntsen <tor@spacetec.no>
> Date: Tue, 30 Mar 2010 19:36:40 +0200
> Subject: [PATCH] Add Tru64/OSF1 support in Makefile
> 
> Tested with V5.1
> Needs libcurl and zlib in /usr/local. zlib may be e.g. the original
> Tru64 tachometer-freeware version (1.1.4) or newer.
> 
> Signed-off-by: Tor Arntsen <tor@spacetec.no>
> ---
>  Makefile |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 3a6c6ea..8041bde 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -758,6 +758,32 @@ ifeq ($(uname_S),UnixWare)
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
>  endif
> +ifeq ($(uname_S),OSF1)
> +	# Tested with V5.1 w/libcurl and zlib-1.1.4-5 in /usr/local/
> +	CC = cc
> +	CFLAGS = -O2 -g3

I wonder if the native compiler will be the most common compiler
used on this platform?  I tend to lean towards configuring the
Makefile for gcc, unless gcc is not available for a platform. The
user can set CC and CFLAGS in config.mak and on the make command
line if they desire something different.

This isn't an objection by me, I'm just mentioning it to bring
attention to the issue in case others think it is worthy for
git to have a stated policy one way or the other.

> +	SHELL_PATH = /bin/ksh

Can you run the test suite with this ksh?  If it suffers from
the same exit status behavior of ksh on IRIX and SunOS, then
I have a patch which allows the test suite to run.

Also, I wonder if it suffers from the same trap handling that
ksh has on SunOS.

> +	BASIC_CFLAGS += -D_POSIX_C_SOURCE=1 -D_OSF_SOURCE=1
> +	BASIC_CFLAGS += -pthread

There is a PTHREAD_LIBS variable and it seems there is precedent
for setting it to -pthread in the FreeBSD section.

Namely, the following shell snippet should exit 0, but does not
on SunOS's ksh:

   (atrap () { exit 0; }
    func3 () { exit 1; }
    func2 () { func3; }
    func1 () { trap atrap EXIT; func2; }
    func1)

-brandon

> +	BASIC_CFLAGS += -I/usr/local/include
> +	BASIC_LDFLAGS += -L/usr/local/lib
> +	NO_STRCASESTR = YesPlease
> +	NO_STRTOUMAX = YesPlease
> +	NO_STRTOULL = YesPlease
> +	NO_STRLCPY = YesPlease
> +	NO_MEMMEM = YesPlease
> +	NO_PYTHON = YesPlease
> +	NO_NSEC = YesPlease
> +	NO_OPENSSL = YesPlease
> +	NO_UINTMAX_T = YesPlease
> +	NO_C99_FORMAT = YesPlease
> +	NEEDS_LIBICONV = YesPlease
> +	NO_DEFLATE_BOUND = YesPlease
> +	# V5.1 has tcl/tk 8.2, which doesn't work.
> +	# V5.2 could possibly have a working version (8.4 or newer).
> +	NO_TCLTK = YesPlease
> +	NO_EXPAT = YesPlease
> +endif
>  ifeq ($(uname_S),SCO_SV)
>  	ifeq ($(uname_R),3.2)
>  		CFLAGS = -O2

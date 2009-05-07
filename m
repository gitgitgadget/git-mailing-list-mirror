From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 06 May 2009 21:23:31 -0500
Message-ID: <lY5mDJaMc8ZsUIxG3yg4tkxBAjyuVrPMXYpGwLvsJHPpUgB4geWcOw@cipher.nrlssc.navy.mil>
References: <20090506055913.GA9701@dektop> <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <fcaeb9bf0905061615v2c1b1b4fmc6ade674aabf9586@mail.gmail.com> <vmGwFm-7sqyeL1D7WrJ-qBXW02LwMMHQ7rLy7XbfdUutAtORXrswbw@cipher.nrlssc.navy.mil> <7vab5pu321.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 04:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1tGt-0003YG-GD
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 04:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761948AbZEGCXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 22:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761880AbZEGCXf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 22:23:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42003 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761440AbZEGCXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 22:23:34 -0400
Received: by mail.nrlssc.navy.mil id n472NVm0021153; Wed, 6 May 2009 21:23:32 -0500
In-Reply-To: <7vab5pu321.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 07 May 2009 02:23:32.0109 (UTC) FILETIME=[D0EB4BD0:01C9CEBA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118421>


I like it.  The PATH would still need to be set up properly
for the tests though.  Either test-lib should handle SANE_TOOL_PATH
or Makefile could export PATH like

ifdef SANE_TOOL_PATH
  PATH := $(SANE_TOOL_PATH):${PATH}

-brandon


Junio C Hamano wrote:

> I suspect you could do something like this...

>  Makefile        |   13 +++++++++++++
>  git-sh-setup.sh |    2 ++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 6e21643..081f06a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3,6 +3,11 @@ all::
>  
>  # Define V=1 to have a more verbose compile.
>  #
> +# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
> +#
> +# Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
> +# to PATH if your tools in /usr/bin are broken.
> +#
>  # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
>  # or vsnprintf() return -1 instead of number of characters which would
>  # have been written to the final string if enough space had been available.
> @@ -694,6 +699,7 @@ ifeq ($(uname_S),SunOS)
>  	NEEDS_SOCKET = YesPlease
>  	NEEDS_NSL = YesPlease
>  	SHELL_PATH = /bin/bash
> +	SANE_TOOL_PATH = /usr/xpg5/bin:/usr/xpg4/bin
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
>  	NO_HSTRERROR = YesPlease
> @@ -852,6 +858,12 @@ endif
>  -include config.mak.autogen
>  -include config.mak
>  
> +ifdef SANE_TOOL_PATH
> +BROKEN_PATH_FIX = s|^. @@PATH@@|PATH=$(SANE_TOOL_PATH)|
> +else
> +BROKEN_PATH_FIX = d
> +endif
> +
>  ifeq ($(uname_S),Darwin)
>  	ifndef NO_FINK
>  		ifeq ($(shell test -d /sw/lib && echo y),y)
> @@ -1251,6 +1263,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>  	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> +	    -e '/^# @@PATH@@/$(BROKEN_PATH_FIX)' \
>  	    $@.sh >$@+ && \
>  	chmod +x $@+ && \
>  	mv $@+ $@
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 8382339..7802581 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -11,6 +11,8 @@
>  # exporting it.
>  unset CDPATH
>  
> +# @@PATH@@:$PATH
> +
>  die() {
>  	echo >&2 "$@"
>  	exit 1
> 
> 

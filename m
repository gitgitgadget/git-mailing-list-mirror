From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Fixes for ancient versions of GNU make
Date: Fri, 17 Feb 2006 22:50:24 -0800
Message-ID: <7v1wy1upn3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602171522020.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 07:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FALvI-0007CT-Vu
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 07:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBRGu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 01:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWBRGu0
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 01:50:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15055 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750923AbWBRGu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 01:50:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218064853.VRB6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 01:48:53 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16392>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Makefile b/Makefile
> index d7d79de..b3401ac 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> +# These will be used inside ''
> +SHELL_PATH_QUOTED = $(subst ','\'',$(SHELL_PATH))
> ...
> diff --git a/t/Makefile b/t/Makefile
> index 5c5a620..d78404f 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -8,17 +8,14 @@ SHELL_PATH ?= $(SHELL)
>  TAR ?= $(TAR)
>  
>  # Shell quote;
> -# Result of this needs to be placed inside ''
> -shq = $(subst ','\'',$(1))
> -# This has surrounding ''
> -shellquote = '$(call shq,$(1))'
> +SHELL_PATH_QUOTED = '$(subst ','\'',$(SHELL_PATH))'

I am not opposed to avoiding $(call), but subst everywhere look
ugly ;-).

You inherited this problem, but these two symbols in different
Makefiles with the same name mean two completely different
things, which confused me quite badly.

So if we were to do this portability fix, how about consistently
defining it without surrounding sq pair?  Most of the places in
the main Makefile you use the symbol with other string, with the
whole thing quoted inside a sq pair, so that would make things
easier to read.

Then the one that uses it in the t/Makefile in 5/5 becomes:

        $(T):
                @echo "*** $@ ***"; '$(SHELL_PATH_QUOTED)' $@ $(GIT_TEST_OPTS)

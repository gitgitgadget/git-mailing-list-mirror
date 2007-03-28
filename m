From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Wed, 28 Mar 2007 12:48:45 -0700
Message-ID: <7vps6tf8te.fsf@assigned-by-dhcp.cox.net>
References: <20070326073250.GC44578@codelabs.ru>
	<200703261030.49382.jnareb@gmail.com>
	<7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
	<20070326100344.GV14837@codelabs.ru>
	<7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
	<20070327065940.GC51155@codelabs.ru>
	<20070327102437.GM14837@codelabs.ru>
	<7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
	<20070327110714.GA14837@codelabs.ru>
	<7vps6um8wv.fsf@assigned-by-dhcp.cox.net>
	<20070328091209.GQ14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWe8a-0002f1-J8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 21:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965717AbXC1Tss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 15:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965713AbXC1Tss
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 15:48:48 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44959 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965717AbXC1Tsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 15:48:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328194845.BEOF28126.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 15:48:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gKol1W00i1kojtg0000000; Wed, 28 Mar 2007 15:48:46 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43382>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> --with-tcltk enables the search of the Tcl/Tk interpreter. If no
> interpreter is found then Tcl/Tk dependend parts are disabled.
>
> --without-tcltk unconditionally disables Tcl/Tk dependent parts.
>
> The original behaviour is not changed: bare './configure' just
> installs the Tcl/Tk part doing no checks for the interpreter.
>
> Makefile knob named NO_TCLTK was introduced. It prevents the build
> and installation of the Tcl/Tk dependent parts.
>
> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
> ---

Thanks.

Is this supposed to be the first in the series?  I thought you
said you were going to do NO_TCLTK without anything else at all
first, and then TCLTK_PATH patch.  I am a bit lost here.

> +# Define NO_TCLTK if you do not want Tcl/Tk GUI.
> +#
> +# The TCLTK_PATH variable governs the location of the Tck/Tk interpreter.
> +# If not set it defaults to the bare 'wish'. If it is set to the empty
> +# string then NO_TCLTK will be forced (this is used by configure script).
> +#

Grumble.  If you are doing this, then there is not much point to
have two separate patches, is it?

> @@ -684,7 +696,9 @@ ifneq (,$X)
>  endif
>  
>  all::
> +ifndef NO_TCLTK
>  	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
> +endif
>  	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
>  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)

Although you were not supposed to be talking about paths, since
you've already introduced TCLTK_PATH, it should be passed down
to git-gui here, I think.

> @@ -955,11 +974,17 @@ dist: git.spec git-archive
>  	@mkdir -p $(GIT_TARNAME)
>  	@cp git.spec $(GIT_TARNAME)
>  	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
> +ifndef NO_TCLTK
>  	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
>  	$(TAR) rf $(GIT_TARNAME).tar \
>  		$(GIT_TARNAME)/git.spec \
>  		$(GIT_TARNAME)/version \
>  		$(GIT_TARNAME)/git-gui/version
> +else
> +	$(TAR) rf $(GIT_TARNAME).tar \
> +		$(GIT_TARNAME)/git.spec \
> +		$(GIT_TARNAME)/version
> +endif
>  	@rm -rf $(GIT_TARNAME)
>  	gzip -f -9 $(GIT_TARNAME).tar
>  

Why should a source distribution exclude git-gui/ directory?  I
think it is sensible to ship a source that contains all.  You
are shipping gitk even without NO_TCLTK anyway, too.

And from the part 2:

> @@ -705,6 +709,12 @@ endif
>  strip: $(PROGRAMS) git$X
>  	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
>  
> +gitk-wish: gitk GIT-GUI-VARS
> +	$(QUIET_GEN)rm -f $@ $@+ && \
> +	sed -e'1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' < gitk > $@+ && \
> +	chmod +x $@+ && \
> +	mv -f $@+ $@
> +

This subst() is a nice attention to the detail.  I like it,
although in practice I do not think anybody is insane enough to
have a pipe character in the directory name that leads to wish.

I separated your two patches into three with minor modifications
and parked them in 'pu'.  We need to arrange with Shawn when to
apply the git-gui/ parts of the patch to his tree, but we are
not in a rush.

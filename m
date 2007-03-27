From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added configure options --with-tcltk/--without-tcltk.
Date: Tue, 27 Mar 2007 03:53:33 -0700
Message-ID: <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
	<200703261030.49382.jnareb@gmail.com>
	<7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
	<20070326100344.GV14837@codelabs.ru>
	<7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
	<20070327065940.GC51155@codelabs.ru>
	<20070327102437.GM14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9J4-0004y4-2B
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbXC0Kxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbXC0Kxf
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:53:35 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49678 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXC0Kxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:53:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327105332.ZXVV748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 06:53:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fmtZ1W0061kojtg0000000; Tue, 27 Mar 2007 06:53:33 -0400
In-Reply-To: <20070327102437.GM14837@codelabs.ru> (Eygene Ryabinkin's message
	of "Tue, 27 Mar 2007 14:24:37 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43258>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Configure's options --with-tcltk and --without-tcltk were added and
> configure script teached to search for the Tcl/Tk interpreter.
>
> The default behaviour to install Tcl/Tk dependant parts is left
> intact: Tcl/Tk detection will be enabled only if --with-tcltk option
> is given to configure.
>
> Makefiles got two external options:
> - TCLTK_PATH: the path to the Tcl/Tk interpreter.
> - NO_TCLCK: disables the installation of Tcl/Tk dependend parts.
>
> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>

Thanks.

> diff --git a/Makefile b/Makefile
> index a294ec8..06b6c6b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -112,6 +112,11 @@ all::
>  #
>  # Define WITH_P4IMPORT to build and install Python git-p4import script.
>  #
> +# Define NO_TCLTK if you do not want Tcl/Tk GUI.
> +#
> +# The TCLTK_PATH variable governs the location of the Tck/Tk interpreter.
> +# If not set it defaults to the bare 'wish'.
> +#
>...
> +TCLTK_PATH ?= wish
> ...  
> +ifeq ($(TCLTK_PATH),)
> +NO_TCLTK=YesPlease
> +endif
> +

This seems to contradict the log message that makes these two
options sound as if they are not dependent of each other.

> @@ -918,10 +930,16 @@ install: all
>  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> -	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
> +ifndef NO_TCLTK
> +	sed -i .bak -e'1,3s|^exec .* "$$0"|exec '"$(TCLTK_PATH)"' "$$0"|' gitk && rm -f gitk.bak
> +	$(INSTALL) gitk '$(DESTDIR_SQ)$(bindir_SQ)'
> +endif

This is a no-no. "make $args; su make $args install" should
never cause anything built by root with the second invocation of
the make command.  Don't assume you can write into the build
directory while you are running "make install" (root user can be
mapped nobody on a nfs mounted build directory, while the local
target directory is writable by it).

Also please quote $(TCLTK_PATH) like everybody else does in the
Makefile.  For that purpose, I think the way $(SCRIPT_SH) are
built using $(SHELL_PATH_SQ) can be learned from.

I suspect that the change to allow not installing gitk/git-gui
and the change to allow using specific "wish" are two
independent tasks.  You seem to have a grip on the use of
conditional in Makefile to do the former task, and I do not
think there is any need for further commenting.

For the latter task, you can probably do something like this:

	gitk-wish: gitk 
        	rm -f $@+ $@
		sed -e '3s| wish | ...' <gitk >$@+
                mv $@+ $@

	all:: gitk-wish
	install: all
        	...
                $(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk

Also you need to rebuild gitk-wish when the builder gives
different TCLTK_PATH; I suspect the easiest way is tack it to
TRACK_CFLAGS and make gitk-wish depend on GIT-CFLAGS.

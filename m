From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added configure options --with-tcltk/--without-tcltk.
Date: Tue, 27 Mar 2007 15:07:15 +0400
Message-ID: <20070327110714.GA14837@codelabs.ru>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru> <200703261030.49382.jnareb@gmail.com> <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net> <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru> <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:07:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9WV-0003aX-Iq
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbXC0LH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXC0LH1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:07:27 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:55890 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbXC0LHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:07:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=NUJNZF559bVd01DidGTUdaCUdFnx46oQ1IDPBN73/rtlJJze/emsWk2zHUyVUIU/bI0aSzxP8D/nv9Lx3/+G2anHVnxpJFeHXZ/PVkgneDo6gn9n02+YOwK3YCp75DYX+VgI4+XpSNRhi5+L3wDLBLvIwhtJsP04nRhjIQG6bhQ=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW9WJ-000Ddx-LP; Tue, 27 Mar 2007 15:07:20 +0400
Content-Disposition: inline
In-Reply-To: <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43262>

Junio, good day.

Tue, Mar 27, 2007 at 03:53:33AM -0700, Junio C Hamano wrote:
> > +ifeq ($(TCLTK_PATH),)
> > +NO_TCLTK=YesPlease
> > +endif
> > +
> 
> This seems to contradict the log message that makes these two
> options sound as if they are not dependent of each other.

OK, will add a sentence about the dependency to the log.

> 
> > @@ -918,10 +930,16 @@ install: all
> >  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
> >  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> >  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> > -	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
> > +	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
> > +ifndef NO_TCLTK
> > +	sed -i .bak -e'1,3s|^exec .* "$$0"|exec '"$(TCLTK_PATH)"' "$$0"|' gitk && rm -f gitk.bak
> > +	$(INSTALL) gitk '$(DESTDIR_SQ)$(bindir_SQ)'
> > +endif
> 
> This is a no-no. "make $args; su make $args install" should
> never cause anything built by root with the second invocation of
> the make command.  Don't assume you can write into the build
> directory while you are running "make install" (root user can be
> mapped nobody on a nfs mounted build directory, while the local
> target directory is writable by it).
> Also please quote $(TCLTK_PATH) like everybody else does in the
> Makefile.  For that purpose, I think the way $(SCRIPT_SH) are
> built using $(SHELL_PATH_SQ) can be learned from.

OK.

> I suspect that the change to allow not installing gitk/git-gui
> and the change to allow using specific "wish" are two
> independent tasks.

But then the configure will be first teached to recognise only
'--with-tcltk/--without-tcltk' and the second modification will
add '--with-tcltk=/path/to/wish', right?

> You seem to have a grip on the use of
> conditional in Makefile to do the former task, and I do not
> think there is any need for further commenting.
> 
> For the latter task, you can probably do something like this:
> 
> 	gitk-wish: gitk 
>         	rm -f $@+ $@
> 		sed -e '3s| wish | ...' <gitk >$@+
>                 mv $@+ $@
> 
> 	all:: gitk-wish
> 	install: all
>         	...
>                 $(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
> 
> Also you need to rebuild gitk-wish when the builder gives
> different TCLTK_PATH; I suspect the easiest way is tack it to
> TRACK_CFLAGS and make gitk-wish depend on GIT-CFLAGS.

OK, will try to provide the splitted patches.
-- 
Eygene

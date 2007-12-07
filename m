From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Fri, 7 Dec 2007 06:35:17 +0100
Message-ID: <200712070635.18018.chriscool@tuxfamily.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org> <7v3aufeowe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 06:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Vm5-00023t-9r
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 06:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbXLGF26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 00:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbXLGF26
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 00:28:58 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49307 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbXLGF25 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 00:28:57 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 571231AB2CC;
	Fri,  7 Dec 2007 06:28:56 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9C4531AB2AB;
	Fri,  7 Dec 2007 06:28:55 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7v3aufeowe.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67380>

Le jeudi 6 d=E9cembre 2007, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index d886641..3e01718 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -29,6 +29,7 @@ DOC_MAN7=3D$(patsubst %.txt,%.7,$(MAN7_TXT))
> >
> >  prefix?=3D$(HOME)
> >  bindir?=3D$(prefix)/bin
> > +htmldir?=3D$(prefix)/share/doc/git-doc
> >  mandir?=3D$(prefix)/share/man
> >  man1dir=3D$(mandir)/man1
> >  man5dir=3D$(mandir)/man5
>
> Doing this and then ...
>
> > diff --git a/Makefile b/Makefile
> > index a5a40ce..9204bfe 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -807,6 +808,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
> >  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
> >  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> >  	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> > +	    -e 's|@@PREFIX@@|$(prefix_SQ)|g' \
> >  	    $@.sh >$@+ && \
> >  	chmod +x $@+ && \
> >  	mv $@+ $@
> > ...
> > diff --git a/git-browse-help.sh b/git-browse-help.sh
> > new file mode 100755
> > index 0000000..11f8bfa
> > --- /dev/null
> > +++ b/git-browse-help.sh
> > @@ -0,0 +1,154 @@
> > +#!/bin/sh
> > ...
> > +USAGE=3D'[--browser=3Dbrowser|--tool=3Dbrowser] [cmd to display] .=
=2E.'
> > +SUBDIRECTORY_OK=3DYes
> > +OPTIONS_SPEC=3D
> > +. git-sh-setup
> > +
> > +PREFIX=3D"@@PREFIX@@"
> > +GIT_VERSION=3D"@@GIT_VERSION@@"
> > +
> > +# Directories that may contain html documentation:
> > +install_html_dir=3D"$PREFIX/share/doc/git-doc"
> > +rpm_dir=3D"$PREFIX/share/doc/git-core-$GIT_VERSION"
>
> ... doing this is wrong. People can set htmldir to somewhere other th=
an
> $(prefix)/share/doc/git-doc while building and installing, but you ar=
e
> not telling the munged script where it is.

Yeah, I sent a fix for this.

> > +init_browser_path() {
> > +	browser_path=3D`git config browser.$1.path`
> > +	test -z "$browser_path" && browser_path=3D$1
> > +}
>
> Please do not contaminate the config file with something the user can
> easily use a lot more standardized way (iow $PATH) to configure to hi=
s
> taste.
>
> I'd suggest dropping this bit.

I stole this part from "git-mergetool.sh":

init_merge_tool_path() {
        merge_tool_path=3D`git config mergetool.$1.path`
        if test -z "$merge_tool_path" ; then
                case "$1" in
                        emerge)
                                merge_tool_path=3Demacs
                                ;;
                        *)
                                merge_tool_path=3D$1
                                ;;
                esac
        fi
}

So we should either drop it in "git-mergetool.sh" too or keep it in bot=
h=20
scripts.

Thanks,
Christian.

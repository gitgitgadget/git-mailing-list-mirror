From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Thu, 06 Dec 2007 09:03:45 -0800
Message-ID: <7v3aufeowe.fsf@gitster.siamese.dyndns.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 18:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0K97-0007wP-DX
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 18:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXLFRD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 12:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbXLFRD5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 12:03:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34755 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbXLFRD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 12:03:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 695722F0;
	Thu,  6 Dec 2007 12:04:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 92FD49D821;
	Thu,  6 Dec 2007 12:04:08 -0500 (EST)
In-Reply-To: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 2 Dec 2007 06:07:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67303>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d886641..3e01718 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -29,6 +29,7 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
>  
>  prefix?=$(HOME)
>  bindir?=$(prefix)/bin
> +htmldir?=$(prefix)/share/doc/git-doc
>  mandir?=$(prefix)/share/man
>  man1dir=$(mandir)/man1
>  man5dir=$(mandir)/man5

Doing this and then ...

> diff --git a/Makefile b/Makefile
> index a5a40ce..9204bfe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -807,6 +808,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>  	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> +	    -e 's|@@PREFIX@@|$(prefix_SQ)|g' \
>  	    $@.sh >$@+ && \
>  	chmod +x $@+ && \
>  	mv $@+ $@
> ...
> diff --git a/git-browse-help.sh b/git-browse-help.sh
> new file mode 100755
> index 0000000..11f8bfa
> --- /dev/null
> +++ b/git-browse-help.sh
> @@ -0,0 +1,154 @@
> +#!/bin/sh
> ...
> +USAGE='[--browser=browser|--tool=browser] [cmd to display] ...'
> +SUBDIRECTORY_OK=Yes
> +OPTIONS_SPEC=
> +. git-sh-setup
> +
> +PREFIX="@@PREFIX@@"
> +GIT_VERSION="@@GIT_VERSION@@"
> +
> +# Directories that may contain html documentation:
> +install_html_dir="$PREFIX/share/doc/git-doc"
> +rpm_dir="$PREFIX/share/doc/git-core-$GIT_VERSION"

... doing this is wrong. People can set htmldir to somewhere other than
$(prefix)/share/doc/git-doc while building and installing, but you are
not telling the munged script where it is.

> +init_browser_path() {
> +	browser_path=`git config browser.$1.path`
> +	test -z "$browser_path" && browser_path=$1
> +}

Please do not contaminate the config file with something the user can
easily use a lot more standardized way (iow $PATH) to configure to his
taste.

I'd suggest dropping this bit.

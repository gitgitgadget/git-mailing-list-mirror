From: Jeff King <peff@peff.net>
Subject: Re: Build Failure: GIT-GUI-VARS
Date: Fri, 11 May 2007 20:09:46 -0400
Message-ID: <20070512000946.GB19282@coredump.intra.peff.net>
References: <FF405582-7769-4A08-87A0-680F8CD165DC@silverinsanity.com> <7v8xbwgkia.fsf@assigned-by-dhcp.cox.net> <5F2FFEA3-0D62-432D-98F7-8BE896937067@silverinsanity.com> <7v3b23cmm5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 02:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfBq-0008Kn-ET
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760034AbXELAJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760982AbXELAJu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:09:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3024 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763019AbXELAJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:09:49 -0400
Received: (qmail 24785 invoked from network); 12 May 2007 00:09:46 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 12 May 2007 00:09:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2007 20:09:46 -0400
Content-Disposition: inline
In-Reply-To: <7v3b23cmm5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46997>

On Fri, May 11, 2007 at 10:10:26AM -0700, Junio C Hamano wrote:

> I have not been very sympathetic to config.mak from the
> beginning, although people seem to want it.  As I try to arrange
> variable overrides to be passed from the command line anyway,
> I've not used config.mak myself.
>
> [...]
>
>  (3) The volunteer cooks up an improved Makefile, using
>      config.mak "non-stock" testers have.

I wonder if we would be better served by moving these sorts of
build-time configuration decisions into the actual make dependency
tree.  E.g., something like:

  openssl.lib: mklib-openssl.sh conf-openssl
    sh mklib-openssl.sh <conf-ssl >openssl.lib

  program: main.o openssl.lib:
    cc -o "$@" main.o `cat openssl.lib`

where conf-openssl specifies the user's preference (either actual
library paths, "auto" for autodetection, or "none" not to use it at
all), and mklib-openssl is a script that converts that into the command
line options for the link.

You can of course do the same with creating a .h file to choose an
implementation (you just make a file that #define's the correct thing).

The nice thing about this approach is that:
  1. You move configuration cruft out of the Makefile, making it much
     easier to read. Instead, you have a series of very small and
     obvious shell scripts.
  2. The dependency chain is actually correct. If I edit conf-openssl,
     then that should trigger a re-link for everything which compiles
     against it.

You can also use this for portability fixes:

  program: main.o strcasestr.o
    cc -o "$@" main.o strcasestr.o

  strcasestr.o choose try_strcasestr.c compat/strcasestr.c
    sh choose try_strcasestr.c compat/strcasestr.c

where choose is a script that compiles and runs some test program and
uses the result to choose a source file to become strcasestr.c. Thus you
_always_ link against strcasestr.o, it's just that sometimes there's an
implementation of strcasestr in it (if required by the platform) and
sometimes it's empty (or an alternate implementation, etc).

I have used this technique many times, and would be happy to be involved
in changing the Makefile. However, it's going to be quite a large
change, and I recognize that this style is not familiar to most people,
so obviously that should be taken into account.

-Peff

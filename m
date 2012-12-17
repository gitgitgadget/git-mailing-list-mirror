From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: use -Wdeclaration-after-statement if
 supported
Date: Sun, 16 Dec 2012 17:52:05 -0800
Message-ID: <7vk3shphru.fsf@alter.siamese.dyndns.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
 <1355686561-1057-4-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 02:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkPso-0007lX-B7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 02:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2LQBwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 20:52:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab2LQBwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 20:52:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A36C3A2B9;
	Sun, 16 Dec 2012 20:52:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5DCtQg0gv3altFWtZSacRDfhYP8=; b=vCdXZH
	nx6aDLHT5EOEUsp3gsHMSvTUpdqvojNhhooIudKW1FQFuxdHqbAfDkXHnWbcehtX
	FcvVjRTtU+WMWYxggS1dkKFiWwO6KrJsJmJqTJ2i+4f94+T0YCPEAtzgOrSqUF8H
	kJRc8aDj1rqWTQXHyI2Eurr4NH9Obylk4oY9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AdqLp/C7zs4JJ0msDEwAqiw60nbXtjil
	d7SUhrkkgK4eFHIgM6V1/8f2+70BPlPnlQB4Cnt0RbkkauPm1FkuZ0QN2gcHPcQ/
	AtG+E0nQvY2g1kD0mjR1jt/3d4iQ8piMvoBccBHO7vnTs9Cmr7N2N3HtxBSMf2eY
	el7JfUf5zY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F04A2B7;
	Sun, 16 Dec 2012 20:52:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4FDBA2B5; Sun, 16 Dec 2012
 20:52:06 -0500 (EST)
In-Reply-To: <1355686561-1057-4-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Sun, 16 Dec 2012 19:36:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CC50836-47EC-11E2-AD9A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211621>

Adam Spiers <git@adamspiers.org> writes:

> If we adopt this approach,...
> diff --git a/Makefile b/Makefile
> index a49d1db..aae70d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -331,8 +331,13 @@ endif
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
>  CFLAGS = -g -O2 -Wall
> +GCC_DECL_AFTER_STATEMENT = \
> +	$(shell $(CC) --help -v 2>&1 | \
> +		grep -q -- -Wdeclaration-after-statement && \
> +	  echo -Wdeclaration-after-statement)
> +GCC_FLAGS = $(GCC_DECL_AFTER_STATEMENT)
> +ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS) $(GCC_FLAGS)
>  LDFLAGS =
> -ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)


Please do not do this.

People cannot disable it from the command line, like:

    $ make V=1 CFLAGS='-g -O0 -Wall'

If anything, this should be part of the default CFLAGS.

More importantly, this will run the $(shell ...) struct once for
every *.o file we produce, I think, in addition to running it twice
for the whole build.  If you add this:

@@ -345,7 +345,8 @@ CFLAGS = -g -O2 -Wall
 GCC_DECL_AFTER_STATEMENT = \
 	$(shell $(CC) --help -v 2>&1 | \
 		grep -q -- -Wdeclaration-after-statement && \
-	  echo -Wdeclaration-after-statement)
+	  echo -Wdeclaration-after-statement; \
+	  echo >&2 GCC_DECL_AFTER_STATEMENT CRUFT)
 GCC_FLAGS = $(GCC_DECL_AFTER_STATEMENT)
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS) $(GCC_FLAGS)
 LDFLAGS =

remove git.o and dir.o from a fully built tree, and then try to
rebuild these two files, you will get this:

    $ make V=1 git.o dir.o
    GCC_DECL_AFTER_STATEMENT CRUFT
    GCC_DECL_AFTER_STATEMENT CRUFT
    GCC_DECL_AFTER_STATEMENT CRUFT
    cc -o git.o -c -MF ./.depend/git.o.d -MMD -MP  -g -O2 -Wall \
    -Wdeclaration-after-statement -I.  -DHAVE_PATHS_H -DHAVE_DEV_TTY \
    -DXDL_FAST_HASH -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY \
    -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"' \
    '-DGIT_HTML_PATH="share/doc/git-doc"' '-DGIT_MAN_PATH="share/man"' \
    '-DGIT_INFO_PATH="share/info"' git.c
    GCC_DECL_AFTER_STATEMENT CRUFT
    cc -o dir.o -c -MF ./.depend/dir.o.d -MMD -MP  -g -O2 -Wall \
    -Wdeclaration-after-statement -I.  -DHAVE_PATHS_H -DHAVE_DEV_TTY \
    -DXDL_FAST_HASH -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY \
    -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"'  dir.c
    $ make V=1 git.o dir.o
    GCC_DECL_AFTER_STATEMENT CRUFT
    GCC_DECL_AFTER_STATEMENT CRUFT
    make: `dir.o' is up to date.

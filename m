From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 10 Nov 2009 07:23:15 -0500
Message-ID: <20091110122315.GA15906@coredump.intra.peff.net>
References: <1257850011-7544-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 13:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7pl4-0006EB-OH
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 13:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZKJMX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 07:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZKJMX0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 07:23:26 -0500
Received: from peff.net ([208.65.91.99]:47614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbZKJMXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 07:23:25 -0500
Received: (qmail 5666 invoked by uid 107); 10 Nov 2009 12:27:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Nov 2009 07:27:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Nov 2009 07:23:15 -0500
Content-Disposition: inline
In-Reply-To: <1257850011-7544-1-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132561>

On Tue, Nov 10, 2009 at 11:46:51AM +0100, Philippe Bruhat (BooK) wrote:

> The main Makefile defines PERL_PATH as the perl to use in the shebang
> line of git*.perl commands. This ensures this will be the perl used
> to run the tests (in case another perl appears in $PATH before the one
> defined in $PERL_PATH)

I think this "the perl used to run the tests" needs to be clarified in
the commit message.  There are really three ways we use perl in the
tests:

  1. To run to the git-* scripts themselves.

  2. To run a test snippet of perl as if we were a git-* script.

  3. To run random perl helper functions.

We already use PERL_PATH for (1). I don't think there is much point in
worrying about (3). If the perl in your PATH is so broken that it can't
be used for simple helpers, then you should fix your PATH.

Your patch seems to just fix (2), which I think is sane. But I wanted to
note it, because when I read your commit message, I wasn't sure which
you were doing.

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -730,6 +730,8 @@ esac
>  
>  test -z "$NO_PERL" && test_set_prereq PERL
>  
> +test -z "$NO_PERL" && test -z "$PERL_PATH" && export PERL_PATH=/usr/bin/perl
> +
>  # test whether the filesystem supports symbolic links
>  ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
>  rm -f y

Will this work if I just have PERL_PATH in my config.mak in the root
directory? Should we be adding PERL_PATH to the generated
GIT-BUILD-OPTIONS file in the root, which gets sourced by test-lib?

Something like the following (completely untested) patch?

diff --git a/Makefile b/Makefile
index a10a60c..b9a8145 100644
--- a/Makefile
+++ b/Makefile
@@ -1643,6 +1643,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
+	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@

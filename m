From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] gitweb: respect $GITPERLLIB
Date: Sat, 21 Jun 2008 02:46:03 -0700
Message-ID: <7vabhfazok.fsf@gitster.siamese.dyndns.org>
References: <1213929117-32037-1-git-send-email-LeWiemann@gmail.com>
 <1213990547-7585-1-git-send-email-LeWiemann@gmail.com>
 <1213990547-7585-2-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zgb-0006Hk-HR
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbYFUJqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYFUJqK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:46:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYFUJqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:46:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10B15A70C;
	Sat, 21 Jun 2008 05:46:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 08942A70B; Sat, 21 Jun 2008 05:46:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF92076A-3F76-11DD-8C7B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85699>

Lea Wiemann <lewiemann@gmail.com> writes:

> gitweb/gitweb.cgi now respects $GITPERLLIB, like the Perl-based Git
> commands.
>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
> Changed since v1: Added missing INSTLIBDIR initialization.
>
> I just noticed that as of now Gitweb isn't using any Perl modules, so
> this change is actually not necessary yet; hence I'm making it an RFC
> patch.  I'll probably squash this into a larger "gitweb: use new
> Git::Repo API" patch (which I'll publish in a few days).
>
> Comments on this change to the Makefile are still appreciated, of
> course. :)
>
> -- Lea
>
>  Makefile |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 85c0846..64eeac1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1083,7 +1083,15 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>  
>  gitweb/gitweb.cgi: gitweb/gitweb.perl
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> -	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> +	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
> +	sed -e '1{' \
> +	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> +	    -e '	h' \
> +	    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
> +	    -e '	H' \
> +	    -e '	x' \
> +	    -e '}' \
> +	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
>  	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
>  	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
>  	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \

This part seems to duplicate quite a bit of sed insn used elsewhere, and
we may want to factor the common part out, perhaps like this...

 Makefile |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 6a31c9f..d3f1bde 100644
--- a/Makefile
+++ b/Makefile
@@ -1063,25 +1063,28 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
+PERL_USE_LIB_REWRITE = \
+	-e '1{' \
+	-e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	-e '	h' \
+	-e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
+	-e '	H' \
+	-e '	x' \
+	-e '}' \
+	-e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
+	-e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g'
+
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	h' \
-	    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
-	    -e '	H' \
-	    -e '	x' \
-	    -e '}' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
+	sed $(PERL_USE_LIB_REWRITE) $@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	sed $(PERL_USE_LIB_REWRITE) \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
 	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \

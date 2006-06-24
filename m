From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/12] Git.pm: Better error handling
Date: Sat, 24 Jun 2006 01:37:25 -0700
Message-ID: <7vmzc3ymnu.fsf@assigned-by-dhcp.cox.net>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
	<20060624023442.32751.28342.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 10:37:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu3dy-0006Iq-Mw
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 10:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbWFXIh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 04:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933323AbWFXIh1
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 04:37:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45477 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S933321AbWFXIh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 04:37:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624083726.NGAC19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 04:37:26 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22493>

Petr Baudis <pasky@suse.cz> writes:

> +int
> +error_xs(const char *err, va_list params)
> +{

You said in git-compat-util.h that set_error_routine takes a
function that returns void, so this gives unnecessary type
clash.

--------------------------------
In file included from /usr/lib/perl/5.8/CORE/perl.h:756,
                 from Git.xs:15:
/usr/lib/perl/5.8/CORE/embed.h:4193:1: warning: "die" redefined
Git.xs:11:1: warning: this is the location of the previous definition
Git.xs: In function 'boot_Git':
Git.xs:57: warning: passing argument 1 of 'set_error_routine' from incompatible pointer type
Git.xs:58: warning: passing argument 1 of 'set_die_routine' makes qualified function pointer from unqualified
--------------------------------

Other troubles I saw with the v4 series while compiling:

--------------------------------
usage.c:35: warning: initialization makes qualified function pointer from unqualified
usage.c:36: warning: initialization makes qualified function pointer from unqualified

I'd fix it with this

diff --git a/usage.c b/usage.c
index b781b00..52c2e96 100644
--- a/usage.c
+++ b/usage.c
@@ -12,19 +12,19 @@ static void report(const char *prefix, c
 	fputs("\n", stderr);
 }
 
-void usage_builtin(const char *err)
+static NORETURN void usage_builtin(const char *err)
 {
 	fprintf(stderr, "usage: %s\n", err);
 	exit(129);
 }
 
-void die_builtin(const char *err, va_list params)
+static NORETURN void die_builtin(const char *err, va_list params)
 {
 	report("fatal: ", err, params);
 	exit(128);
 }
 
-void error_builtin(const char *err, va_list params)
+static void error_builtin(const char *err, va_list params)
 {
 	report("error: ", err, params);
 }

--------------------------------

(cd perl && /usr/bin/perl Makefile.PL \
                PREFIX="/home/junio/git-test" \
                DEFINE="-O2 -Wall -Wdeclaration-after-statement
                -g -DSHA1_HEADER='<openssl/sha.h>'
                -DGIT_VERSION=\\\"1.4.1.rc1.gab0df\\\"" \
                LIBS="libgit.a xdiff/lib.a -lz  -lcrypto")
Unrecognized argument in LIBS ignored: 'libgit.a'
Unrecognized argument in LIBS ignored: 'xdiff/lib.a'

Do you need to pass LIBS, and if so maybe this is not a way
Makefile.PL expects it to be passed perhaps?

--------------------------------
Makefile out-of-date with respect to Makefile.PL
Cleaning current config before rebuilding Makefile...
make -f Makefile.old clean > /dev/null 2>&1
/usr/bin/perl Makefile.PL "PREFIX=/home/junio/git-test" "DEFINE=-O2 -Wall -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>'  -DGIT_VERSION=\"1.4.1.rc1.gab0df\"" "LIBS=libgit.a xdiff/lib.a -lz  -lcrypto"
Unrecognized argument in LIBS ignored: 'libgit.a'
Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
Writing Makefile for Git
==> Your Makefile has been rebuilt. <==
==> Please rerun the make command.  <==
false
make[1]: *** [Makefile] Error 1
--------------------------------

The latter is what Perl's build mechanism does so it is not
strictly your fault, but it nevertheless is irritating that we
have to say make clean twice.

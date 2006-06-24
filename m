From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 07/12] Git.pm: Better error handling
Date: Sat, 24 Jun 2006 15:17:31 +0200
Message-ID: <20060624131731.GU21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <20060624023442.32751.28342.stgit@machine.or.cz> <7vmzc3ymnu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 15:17:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu812-0000Rn-Ls
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 15:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbWFXNRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 09:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWFXNRe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 09:17:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48292 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752233AbWFXNRd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 09:17:33 -0400
Received: (qmail 3042 invoked by uid 2001); 24 Jun 2006 15:17:31 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzc3ymnu.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22518>

Dear diary, on Sat, Jun 24, 2006 at 10:37:25AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > +int
> > +error_xs(const char *err, va_list params)
> > +{
> 
> You said in git-compat-util.h that set_error_routine takes a
> function that returns void, so this gives unnecessary type
> clash.
> 
> --------------------------------
> In file included from /usr/lib/perl/5.8/CORE/perl.h:756,
>                  from Git.xs:15:
> /usr/lib/perl/5.8/CORE/embed.h:4193:1: warning: "die" redefined
> Git.xs:11:1: warning: this is the location of the previous definition
> Git.xs: In function 'boot_Git':
> Git.xs:57: warning: passing argument 1 of 'set_error_routine' from incompatible pointer type
> Git.xs:58: warning: passing argument 1 of 'set_die_routine' makes qualified function pointer from unqualified
> --------------------------------

Oh, I forgot to fix it in the .xs. :-(

> Other troubles I saw with the v4 series while compiling:
> 
> --------------------------------
> usage.c:35: warning: initialization makes qualified function pointer from unqualified
> usage.c:36: warning: initialization makes qualified function pointer from unqualified
> 
> I'd fix it with this
...

Ah, so THAT's where you put the NORETURN thing. ;-)

> --------------------------------
> 
> (cd perl && /usr/bin/perl Makefile.PL \
>                 PREFIX="/home/junio/git-test" \
>                 DEFINE="-O2 -Wall -Wdeclaration-after-statement
>                 -g -DSHA1_HEADER='<openssl/sha.h>'
>                 -DGIT_VERSION=\\\"1.4.1.rc1.gab0df\\\"" \
>                 LIBS="libgit.a xdiff/lib.a -lz  -lcrypto")
> Unrecognized argument in LIBS ignored: 'libgit.a'
> Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
> 
> Do you need to pass LIBS, and if so maybe this is not a way
> Makefile.PL expects it to be passed perhaps?

It is harmless, but this should fix it:

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/Makefile b/Makefile
index d614f18..91bef4e 100644
--- a/Makefile
+++ b/Makefile
@@ -230,7 +230,8 @@ BUILTIN_OBJS = \
 	builtin-update-ref.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
-LIBS = $(GITLIBS) -lz
+
+EXTLIBS = -lz
 
 #
 # Platform specific tweaks
@@ -380,14 +381,14 @@ ifdef NEEDS_LIBICONV
 	else
 		ICONV_LINK =
 	endif
-	LIBS += $(ICONV_LINK) -liconv
+	EXTLIBS += $(ICONV_LINK) -liconv
 endif
 ifdef NEEDS_SOCKET
-	LIBS += -lsocket
+	EXTLIBS += -lsocket
 	SIMPLE_LIB += -lsocket
 endif
 ifdef NEEDS_NSL
-	LIBS += -lnsl
+	EXTLIBS += -lnsl
 	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_D_TYPE_IN_DIRENT
@@ -446,7 +447,7 @@ ifdef MOZILLA_SHA1
 	LIB_OBJS += mozilla-sha1/sha1.o
 else
 	SHA1_HEADER = <openssl/sha.h>
-	LIBS += $(LIB_4_CRYPTO)
+	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
 endif
@@ -469,9 +470,13 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PAT
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 GIT_PYTHON_DIR_SQ = $(subst ','\'',$(GIT_PYTHON_DIR))
 
+LIBS = $(GITLIBS) $(EXTLIBS)
+
 ALL_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
+
+
 ### Build rules
 
 all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk
@@ -601,7 +606,7 @@ perl/Makefile:	perl/Git.pm perl/Makefile
 	(cd perl && $(PERL_PATH) Makefile.PL \
 		PREFIX="$(prefix)" \
 		DEFINE="$(ALL_CFLAGS) -DGIT_VERSION=\\\"$(GIT_VERSION)\\\"" \
-		LIBS="$(LIBS)")
+		LIBS="$(EXTLIBS)")
 
 doc:
 	$(MAKE) -C Documentation all

> --------------------------------
> Makefile out-of-date with respect to Makefile.PL
> Cleaning current config before rebuilding Makefile...
> make -f Makefile.old clean > /dev/null 2>&1
> /usr/bin/perl Makefile.PL "PREFIX=/home/junio/git-test" "DEFINE=-O2 -Wall -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>'  -DGIT_VERSION=\"1.4.1.rc1.gab0df\"" "LIBS=libgit.a xdiff/lib.a -lz  -lcrypto"
> Unrecognized argument in LIBS ignored: 'libgit.a'
> Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
> Writing Makefile for Git
> ==> Your Makefile has been rebuilt. <==
> ==> Please rerun the make command.  <==
> false
> make[1]: *** [Makefile] Error 1
> --------------------------------
> 
> The latter is what Perl's build mechanism does so it is not
> strictly your fault, but it nevertheless is irritating that we
> have to say make clean twice.

What about just this?

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/Makefile b/Makefile
index 91bef4e..55c07b6 100644
--- a/Makefile
+++ b/Makefile
@@ -731,7 +731,8 @@ clean:
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
-	[ ! -e perl/Makefile ] || $(MAKE) -C perl/ clean
+	# Try twice in case the Makefile has been rebuilt
+	[ ! -e perl/Makefile ] || $(MAKE) -C perl/ clean || $(MAKE) -C perl/ clean
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 	rm -f GIT-VERSION-FILE GIT-CFLAGS

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.

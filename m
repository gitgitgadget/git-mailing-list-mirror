From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Wed, 18 Jan 2012 20:54:38 +0100
Message-ID: <20120118195438.GA18892@blimp.dmz>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <7vfwfervt9.fsf@alter.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-15?Q?=C6var_Arnfj=F6r=F0?= Bjarmason 
	<avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 18 21:01:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnbgk-0003ap-Lz
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 21:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566Ab2ARUAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 15:00:50 -0500
Received: from h877881.serverkompetenz.net ([85.214.60.77]:41924 "EHLO
	h877881.serverkompetenz.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757309Ab2ARUAt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 15:00:49 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jan 2012 15:00:48 EST
Received: from tigra.home (krlh-5f723295.pool.mediaWays.net [95.114.50.149])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h877881.serverkompetenz.net (Postfix) with ESMTPSA id 1E1468C054E;
	Wed, 18 Jan 2012 20:54:40 +0100 (CET)
Received: from blimp.localdomain (unknown [192.168.0.100])
	by tigra.home (Postfix) with ESMTP id 3EF629FE2F;
	Wed, 18 Jan 2012 20:54:39 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id C85E51A0; Wed, 18 Jan 2012 20:54:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfwfervt9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188759>

Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
It is very unexpected.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Junio C Hamano, Tue, Jan 17, 2012 20:08:34 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
> > It is very unexpected.
> >
...
> 
> But the result of the patch looks almost unreadable. could we restructure
> the script like this instead?
> ...

Done. I simplified the commentary on "poison" a little.

 Makefile       |    1 +
 git-sh-i18n.sh |  102 +++++++++++++++++++++++++++-----------------------------
 2 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/Makefile b/Makefile
index a782409..d82ea6a 100644
--- a/Makefile
+++ b/Makefile
@@ -1887,6 +1887,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+    -e 's/@@NO_GETTEXT@@/$(NO_GETTEXT)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
 endef
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b4575fb..1902fb1 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -16,61 +16,44 @@ else
 fi
 export TEXTDOMAINDIR
 
-if test -z "$GIT_GETTEXT_POISON"
+GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
+if test -n "@@NO_GETTEXT@@$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+then
+	: no probing necessary
+elif test -n "$GIT_GETTEXT_POISON"
 then
-	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh >/dev/null 2>&1
-	then
-		# This is GNU libintl's gettext.sh, we don't need to do anything
-		# else than setting up the environment and loading gettext.sh
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		# Try to use libintl's gettext.sh, or fall back to English if we
-		# can't.
-		. gettext.sh
-
-	elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettext -h 2>&1)" = "-h"
-	then
-		# We don't have gettext.sh, but there's a gettext binary in our
-		# path. This is probably Solaris or something like it which has a
-		# gettext implementation that isn't GNU libintl.
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=solaris
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		# Solaris has a gettext(1) but no eval_gettext(1)
-		eval_gettext () {
-			gettext "$1" | (
-				export PATH $(git sh-i18n--envsubst --variables "$1");
-				git sh-i18n--envsubst "$1"
-			)
-		}
-
-	else
-		# Since gettext.sh isn't available we'll have to define our own
-		# dummy pass-through functions.
-
-		# Tell our tests that we don't have the real gettext.sh
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		gettext () {
-			printf "%s" "$1"
-		}
-
-		eval_gettext () {
-			printf "%s" "$1" | (
-				export PATH $(git sh-i18n--envsubst --variables "$1");
-				git sh-i18n--envsubst "$1"
-			)
-		}
-	fi
-else
-	# Emit garbage under GETTEXT_POISON=YesPlease. Unlike the C tests
-	# this relies on an environment variable
-
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
-	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+elif test -n type gettext.sh >/dev/null 2>&1
+then
+	# This is GNU libintl's gettext.sh, we don't need to do anything
+	# else than setting up the environment and loading gettext.sh
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
+elif test "$(gettext -h 2>&1)" = "-h"
+then
+	# We don't have gettext.sh, but there's a gettext binary in our
+	# path. This is probably Solaris or something like it which has a
+	# gettext implementation that isn't GNU libintl.
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=solaris
+fi
+export GIT_INTERNAL_GETTEXT_SH_SCHEME
 
+case "$GIT_INTERNAL_GETTEXT_SH_SCHEME" in
+gnu)
+	# Try to use libintl's gettext.sh, or fall back to English if we
+	# can't.
+	. gettext.sh
+	;;
+solaris)
+	# Solaris has a gettext(1) but no eval_gettext(1)
+	eval_gettext () {
+		gettext "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+poison)
+	# Used in tests
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
@@ -78,7 +61,20 @@ else
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
-fi
+	;;
+*)
+	gettext () {
+		printf "%s" "$1"
+	}
+
+	eval_gettext () {
+		printf "%s" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+esac
 
 # Git-specific wrapper functions
 gettextln () {
-- 
1.7.9.rc0.84.g0aa6c

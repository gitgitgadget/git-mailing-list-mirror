From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/20] gettext: add GETTEXT_POISON support for shell scripts
Date: Tue,  7 Sep 2010 16:47:45 +0000
Message-ID: <1283878065-19349-6-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1O3-0004K7-2V
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758040Ab0IGQsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:12 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43039 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758024Ab0IGQsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:09 -0400
Received: by wwi17 with SMTP id 17so177949wwi.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=orKBjxStbaCGDjXIA3+rt1K39MXj5TkqnniReW184bU=;
        b=s87k1QHZ5v2v4W6VLVasA9l8mnqaEzJmDxdJH/I1MVq+KAzpfZ7vvPfq05L0knEHrA
         EWc9mraezLLxXU8iXiVAZqyFuJ+P/Y7gh3Qm6p+A8IxPJ7v5ZBYTyYxVlI6vdFKwmH2U
         vVxr5n9UQ7znw5dCqlsumMnHrAZmX/qnCM5U4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KdSb8UKK9kFfTbP2F5RECNmhfyLjHpbOsbO4X8XTnaf94AF0rWHZYwiPLsotdGaJxF
         gWwpJoTEtMPSOrfUmUSQ70UPxzCX6py7pzGxy0wabBHVy/VG3peXSEZIAPRU1xizc/WM
         BCfcioz8yA+iaxUlSR5priYtJCwOefn6GuS5Y=
Received: by 10.227.148.5 with SMTP id n5mr692004wbv.191.1283878088111;
        Tue, 07 Sep 2010 09:48:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5895402wbe.23.2010.09.07.09.48.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155716>

Expand the existing GETTEXT_POISON=3DYesPlease support to support shell
scripts. Analogous the existing C support this is needed to test that
changes to the output of the shell scripts don't break the plumbing
output.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-sh-i18n.sh               |   73 ++++++++++++++++++++++++++--------=
--------
 t/t0201-gettext-fallbacks.sh |   12 +++---
 t/test-lib.sh                |    8 ++++-
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 698a000..b8b645a 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -28,44 +28,61 @@ else
 fi
 export TEXTDOMAINDIR
=20
-if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh >=
/dev/null 2>&1
+if test -z "$GIT_INTERNAL_GETTEXT_GETTEXT_POISON"
 then
-	# This is GNU libintl's gettext.sh, we don't need to do anything
-	# else than setting up the environment and loading gettext.sh
-	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
-	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh =
>/dev/null 2>&1
+	then
+		# This is GNU libintl's gettext.sh, we don't need to do anything
+		# else than setting up the environment and loading gettext.sh
+		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
+		export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
-	# Try to use libintl's gettext.sh, or fall back to English if we
-	# can't.
-	. gettext.sh
-elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettext=
 -h 2>&1)" =3D "-h"
-then
-	# We don't have gettext.sh, but there's a gettext binary in our
-	# path. This is probably Solaris or something like it which has a
-	# gettext implementation that isn't GNU libintl.
-	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
-	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+		# Try to use libintl's gettext.sh, or fall back to English if we
+		# can't.
+		. gettext.sh
+	elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettex=
t -h 2>&1)" =3D "-h"
+	then
+		# We don't have gettext.sh, but there's a gettext binary in our
+		# path. This is probably Solaris or something like it which has a
+		# gettext implementation that isn't GNU libintl.
+		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
+		export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
-	# Solaris has a gettext(1) but no eval_gettext(1)
-	eval_gettext () {
-		gettext_out=3D$(gettext "$1")
-		gettext_eval=3D"printf '%s' \"$gettext_out\""
-		printf "%s" "`eval \"$gettext_eval\"`"
-	}
+		# Solaris has a gettext(1) but no eval_gettext(1)
+		eval_gettext () {
+			gettext_out=3D$(gettext "$1")
+			gettext_eval=3D"printf '%s' \"$gettext_out\""
+			printf "%s" "`eval \"$gettext_eval\"`"
+		}
+	else
+		# Since gettext.sh isn't available we'll have to define our own
+		# dummy pass-through functions.
+
+		# Tell our tests that we don't have the real gettext.sh
+		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
+		export GIT_INTERNAL_GETTEXT_SH_SCHEME
+
+		gettext () {
+			printf "%s" "$1"
+		}
+
+		eval_gettext () {
+			gettext_eval=3D"printf '%s' \"$1\""
+			printf "%s" "`eval \"$gettext_eval\"`"
+		}
+	fi
 else
-	# Since gettext.sh isn't available we'll have to define our own
-	# dummy pass-through functions.
+	# Emit garbage under GETTEXT_POISON=3DYesPlease. Unlike the C tests
+	# this relies on an environment variable
=20
-	# Tell our tests that we don't have the real gettext.sh
-	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dpoison
 	export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
 	gettext () {
-		printf "%s" "$1"
+		printf "%s" "# GETTEXT POISON #"
 	}
=20
 	eval_gettext () {
-		gettext_eval=3D"printf '%s' \"$1\""
-		printf "%s" "`eval \"$gettext_eval\"`"
+		printf "%s" "# GETTEXT POISON #"
 	}
 fi
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.s=
h
index 47ce4f6..7a85d9b 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -10,19 +10,19 @@ export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS
=20
 . ./lib-gettext.sh
=20
-test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (=
to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
+test_expect_success NO_GETTEXT_POISON "sanity: \$GIT_INTERNAL_GETTEXT_=
SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
     test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
 '
=20
-test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is s=
et' '
+test_expect_success NO_GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_T=
EST_FALLBACKS is set' '
     test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 '
=20
-test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallt=
hrough' '
+test_expect_success NO_GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_S=
H_SCHEME" is fallthrough' '
     test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D "fallthrough"
 '
=20
-test_expect_success 'gettext: our gettext() fallback has pass-through =
semantics' '
+test_expect_success NO_GETTEXT_POISON 'gettext: our gettext() fallback=
 has pass-through semantics' '
     printf "test" >expect &&
     gettext "test" >actual &&
     test_cmp expect actual &&
@@ -31,7 +31,7 @@ test_expect_success 'gettext: our gettext() fallback =
has pass-through semantics'
     test_cmp expect actual
 '
=20
-test_expect_success 'eval_gettext: our eval_gettext() fallback has pas=
s-through semantics' '
+test_expect_success NO_GETTEXT_POISON 'eval_gettext: our eval_gettext(=
) fallback has pass-through semantics' '
     printf "test" >expect &&
     eval_gettext "test" >actual &&
     test_cmp expect actual &&
@@ -40,7 +40,7 @@ test_expect_success 'eval_gettext: our eval_gettext()=
 fallback has pass-through
     test_cmp expect actual
 '
=20
-test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables' '
+test_expect_success NO_GETTEXT_POISON 'eval_gettext: our eval_gettext(=
) fallback can interpolate variables' '
     printf "test YesPlease" >expect &&
     eval_gettext "test \$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" >actual =
&&
     test_cmp expect actual
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b297ef6..5a9f989 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -963,7 +963,13 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
-test -z "$GETTEXT_POISON" && test_set_prereq NO_GETTEXT_POISON
+if test -z "$GETTEXT_POISON"
+then
+	test_set_prereq NO_GETTEXT_POISON
+else
+	GIT_INTERNAL_GETTEXT_GETTEXT_POISON=3DYesPlease
+	export GIT_INTERNAL_GETTEXT_GETTEXT_POISON
+fi
=20
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
--=20
1.7.2.3.313.gcd15

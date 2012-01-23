From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git-sh-i18n: restructure the logic to compute gettext.sh
 scheme
Date: Mon, 23 Jan 2012 14:02:55 -0800
Message-ID: <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:03:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpRyh-0006If-Kh
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab2AWWC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:02:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab2AWWC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:02:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D286576EA;
	Mon, 23 Jan 2012 17:02:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=at8Iy5r5R0DFRpGVPDLXpBdCFRk=; b=eE58sN
	AuNc7aBeQkw356s7KairJLoxAgT8H7Cg6f7CyA3UCiPvKlm+tsS4f5O/9/UefbUg
	XUHYsCHu1/mkPkUllI9t9nlxy203KVTcsvY3uVPBx83n3WzU9kSSsM0LfkmoCx0z
	Zi2lssRMbMywNsWKRIMI11ieicb3PJ03Y27SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwrxBCwmTqTzdYLqcoHizlbcf9MLBMBy
	bA6HvkmfLlc2DDoESLdsHeg7cm95Jb5RoYnqIQrxXHqcyADK9spSsIf5QDYRHbE9
	vodGEnhAYXUEuc013yDDcEM/FORLKbiIRL01A4Iomr2HPxMcgjzPoxROQXvbuDB/
	okXREU6sEIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3B576E9;
	Mon, 23 Jan 2012 17:02:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28A5D76E8; Mon, 23 Jan 2012
 17:02:57 -0500 (EST)
In-Reply-To: <7v1uqq84es.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jan 2012 14:01:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01D0E610-460E-11E1-81BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189015>

Instead of having a single long and complex chain of commands to decide
what to do and carry out the decision, split the code so that we first
decide which scheme to use, and in the second section define what exactly
is done by the chosen scheme. It makes the code much easier to follow and
update.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-sh-i18n.sh |  103 +++++++++++++++++++++++++++-----------------------------
 1 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b4575fb..6648bd3 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -16,61 +16,45 @@ else
 fi
 export TEXTDOMAINDIR
 
-if test -z "$GIT_GETTEXT_POISON"
+# First decide what scheme to use...
+GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
+if test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
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
+elif type gettext.sh >/dev/null 2>&1
+then
+	# GNU libintl's gettext.sh
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
+elif test "$(gettext -h 2>&1)" = "-h"
+then
+	# gettext binary exists but no gettext.sh. likely to be a gettext
+	# binary on a Solaris or something that is not GNU libintl and
+	# lack eval_gettext.
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=gettext_without_eval_gettext
+fi
+export GIT_INTERNAL_GETTEXT_SH_SCHEME
 
+# ... and then follow that decision.
+case "$GIT_INTERNAL_GETTEXT_SH_SCHEME" in
+gnu)
+	# Use libintl's gettext.sh, or fall back to English if we can't.
+	. gettext.sh
+	;;
+gettext_without_eval_gettext)
+	# Solaris has a gettext(1) but no eval_gettext(1)
+	eval_gettext () {
+		gettext "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+poison)
+	# Emit garbage so that tests that incorrectly rely on translatable
+	# strings will fail.
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
@@ -78,7 +62,20 @@ else
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
1.7.9.rc2.48.g92994

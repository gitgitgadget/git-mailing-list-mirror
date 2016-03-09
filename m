From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Wed, 09 Mar 2016 12:26:55 -0800
Message-ID: <xmqqvb4vgzxs.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
	<56DEC4B4.2000902@web.de> <56DED770.4050603@drmicha.warpmail.net>
	<20160308143556.GA10153@sigill.intra.peff.net>
	<xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.10.1603082127230.2674@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:27:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adkhG-0000h9-1A
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 21:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbcCIU1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 15:27:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753847AbcCIU06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 15:26:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E06EF4C774;
	Wed,  9 Mar 2016 15:26:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=heH3Cy9TxuBcqNU9ww3VK1slYkA=; b=kaYonn
	ghngEErjn9ovoFKDhjV/iawN3gOCVd4SK7YGKJdp4iV8IxPBiKZ6FD8ATT8j4CtT
	k3nmvMYvDZxACDvPZ0ex8uExXPbo3AFsvBcU1AssmfM9kgAlfv3Kkv7pcq5Qkcc2
	jzMilGeweD51MO13U/1SBngx56mIoQJWntg4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZTDpikgo1fPdd2BOtq8SYsNje319mpC0
	n/9lebC7IxHH4XTsQymnBCSX2v6unxTkX2szJKUEvgtvJ2Iv62Wh4cJ1yUOFmC8A
	SsMac+950oUT42u/uAJHCEQqDi1MZKb6rOlJ/yhvk+dBrBiJCcG0abzG2Ff89t35
	zkJujNruFag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D81C44C773;
	Wed,  9 Mar 2016 15:26:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 522F44C770;
	Wed,  9 Mar 2016 15:26:56 -0500 (EST)
In-Reply-To: <alpine.DEB.2.10.1603082127230.2674@buzzword-bingo.mit.edu>
	(Anders Kaseorg's message of "Tue, 8 Mar 2016 21:31:01 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 449D62E0-E635-11E5-A4D9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288572>

Anders Kaseorg <andersk@mit.edu> writes:

> The autoconf support you committed as 67f1790a has a small bug (the else 
> cause should omit -a):

Thanks.  To summarize the discussion, here is what I ended up with.

-- >8 --
Subject: [PATCH] sane_grep: pass "-a" if grep accepts it

Newer versions of GNU grep is reported to be pickier when we feed a
non-ASCII input and break some Porcelain scripts.  As we know we do
not feed random binary file to our own sane_grep wrapper, allow us
to always pass "-a" by setting SANE_TEXT_GREP=-a Makefile variable
to work it around.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         | 6 +++++-
 config.mak.uname | 1 +
 configure.ac     | 7 +++++++
 git-sh-setup.sh  | 4 ++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 37e2d9e..62d759d 100644
--- a/Makefile
+++ b/Makefile
@@ -266,6 +266,9 @@ all::
 #
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
+# Define SANE_TEXT_GREP to "-a" if you use recent versions of GNU grep
+# and egrep that are picker when their input contains non-ASCII data.
+#
 # The TCL_PATH variable governs the location of the Tcl interpreter
 # used to optimize git-gui for your system.  Only used if NO_TCLTK
 # is not set.  Defaults to the bare 'tclsh'.
@@ -1728,7 +1731,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ)
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1740,6 +1743,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+    -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
     $@.sh >$@+
 endef
 
diff --git a/config.mak.uname b/config.mak.uname
index 943c439..a706474 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	HAVE_GETDELIM = YesPlease
+	SANE_TEXT_GREP=-a
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/configure.ac b/configure.ac
index 1f55009..6fd7b8e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -471,6 +471,13 @@ if test -n "$ASCIIDOC"; then
 	esac
 fi
 
+if grep -a ascii configure.ac >/dev/null; then
+  AC_MSG_RESULT([Using 'grep -a' for sane_grep])
+  SANE_TEXT_GREP=-a
+else
+  SANE_TEXT_GREP=
+fi
+GIT_CONF_SUBST([SANE_TEXT_GREP])
 
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4691fbc..c48139a 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -168,11 +168,11 @@ git_pager() {
 }
 
 sane_grep () {
-	GREP_OPTIONS= LC_ALL=C grep "$@"
+	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
 }
 
 sane_egrep () {
-	GREP_OPTIONS= LC_ALL=C egrep "$@"
+	GREP_OPTIONS= LC_ALL=C egrep @@SANE_TEXT_GREP@@ "$@"
 }
 
 is_bare_repository () {
-- 
2.8.0-rc1-141-gbaa22e3

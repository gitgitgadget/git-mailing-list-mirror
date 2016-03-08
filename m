From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 08 Mar 2016 15:20:26 -0800
Message-ID: <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
	<56DEC4B4.2000902@web.de> <56DED770.4050603@drmicha.warpmail.net>
	<20160308143556.GA10153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, Anders Kaseorg <andersk@mit.edu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 00:20:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adQva-0002la-PG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 00:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbcCHXUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 18:20:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbcCHXU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 18:20:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 594FC4AC16;
	Tue,  8 Mar 2016 18:20:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+hVcy2bvaqne7i3lpaOFrjaMZFk=; b=OsuBsf
	AeNxMU/s71s0MaamQA7CFzSyf1d/r1kN8eppHQJxzeLifM3X7E1tOl8hBqwhSwXF
	VyoZ84Xs9tChaRqUgM+mRxUM2LxJQlFSTSjQ/AQPt96zOIzjQa6ImmWcGA+fEixh
	NYZY1qAj5VJpa/ikYiwg7GMcuEG3qIqdm1bZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKL61Cvu3UrkYByfu425fxtI6qfKUIbu
	LGHkwnLxYkRL6XjolnslWo1vkzo43iHoBqQIG/zPyXc0sLgex6wbXflmau14kH6U
	4yRk5l+U0kkokv+8dm0T25RR58HGNfzo/dnuUSPGRuGeY/Pnuwh1GD55auqlPLBc
	p+Mo/d/JI90=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4EF894AC15;
	Tue,  8 Mar 2016 18:20:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6E984AC14;
	Tue,  8 Mar 2016 18:20:27 -0500 (EST)
In-Reply-To: <20160308143556.GA10153@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Mar 2016 09:35:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57EEC67E-E584-11E5-92B1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288459>

Jeff King <peff@peff.net> writes:

> I actually wonder if we should have a build-time knob to put "grep -a"
> into sane_grep(). We do not ever plan to feed it binary data, so that
> will do what, provided the system grep handles "-a". And on those that
> do not know about "-a", one imagines that they do not suffer from this
> problem in the first place (which is really limited to recent versions
> of GNU grep).

Something along this line, you mean?  I'll leave it as a
low-hanging-fruit to add autoconf support ;-)

 Makefile        | 4 ++++
 git-sh-setup.sh | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 24bef8d..1187498 100644
--- a/Makefile
+++ b/Makefile
@@ -264,6 +264,9 @@ all::
 #
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
+# Define SANE_TEXT_GREP to "-a" if you use recent versions of GNU grep
+# and egrep that are picker when their input contains non-ASCII data.
+#
 # The TCL_PATH variable governs the location of the Tcl interpreter
 # used to optimize git-gui for your system.  Only used if NO_TCLTK
 # is not set.  Defaults to the bare 'tclsh'.
@@ -1752,6 +1755,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+    -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
     $@.sh >$@+
 endef
 
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

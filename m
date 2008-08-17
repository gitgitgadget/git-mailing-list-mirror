From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Always provide a fallback when hardlinks fail
Date: Sun, 17 Aug 2008 04:03:59 -0700
Message-ID: <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
References: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 13:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUg4U-00053j-Cx
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 13:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYHQLEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 07:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYHQLEL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 07:04:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbYHQLEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 07:04:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 911205D000;
	Sun, 17 Aug 2008 07:04:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A7A35CFFF; Sun, 17 Aug 2008 07:04:02 -0400 (EDT)
In-Reply-To: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de> (Andreas
 =?utf-8?Q?F=C3=A4rber's?= message of "Sun, 17 Aug 2008 11:00:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 36E8B322-6C4C-11DD-A645-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92598>

Andreas F=C3=A4rber <andreas.faerber@web.de> writes:

> BFS does not support hardlinks, so suppress the resulting error
> messages.

Hmm, this is not specific to BFS.  I would have preferred if you brough=
t
up much earlier.

Your patch seems to be whitespace damaged.  Here is an alternative.

Note.

We currently install $(bindir)/git to $(gitexecdir)/git, make hardlinks=
 to
"git-<cmd>" from "git" inside $(gitexecdir), and then finally remove "g=
it"
in $(gitexecdir).

We could avoid this ugliness by:

 (1) install "$(gitexecdir)/git-add" (or any other single built-in) by
     trying hardlink "$(bindir)/git", and if it fails by copying;

 (2) for the rest of built-ins, install "$(gitexecdir)/git-<cmd>" by tr=
ying
     ln "$(gitexecdir)/git-add" "$(gitexecdir)/git-<cmd>", then
     ln -s "git-add" "$(gitexecdir)/git-<cmd>", then finally
     cp "$(gitexecdir)/git-add" "$(gitexecdir)/git-<cmd>".

That is not what I did, but it should be the right thing to do.  It is
already very late in the release cycle, and this whole thing can be don=
e
after 1.6.0 final; we do not have to hurry.

---
=46rom: Andreas F=C3=A4rber <andreas.faerber@web.de>
Date: Sun, 17 Aug 2008 11:00:51 +0200
Subject: [PATCH] Makefile: always provide a fallback when hardlinks fai=
l

We make hardlinks from "git" to "git-<cmd>" built-ins and have been
careful to avoid cross-device links when linking "git-<cmd>" to gitexec=
dir.

However, we were not prepared to deal with a build directory that is
incapable of making hard links within itself.  This patch corrects it.

While at it, avoid 100+ error messages from hardlink failures when we a=
re
going to fall back to "cp" by redirecting the standard error to /dev/nu=
ll.

Signed-off-by: Andreas F=C3=A4rber <andreas.faerber@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..53112bb 100644
--- a/Makefile
+++ b/Makefile
@@ -1098,7 +1098,10 @@ help.o: help.c common-cmds.h GIT-CFLAGS
 		'-DGIT_INFO_PATH=3D"$(infodir_SQ)"' $<
=20
 $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
+	$(QUIET_BUILT_IN)$(RM) $@ && \
+	ln git$X $@ 2>/dev/null || \
+	ln -s git$X $@ 2>/dev/null || \
+	cp git$X $@
=20
 common-cmds.h: ./generate-cmdlist.sh command-list.txt
=20
@@ -1365,10 +1368,12 @@ endif
 	execdir=3D$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	if test "z$$bindir" !=3D "z$$execdir"; \
 	then \
-		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
-		cp "$$bindir/git$X" "$$execdir/git$X"; \
+		$(RM) "$$execdir/git$X" && \
+		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
+		ln -s "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
+		cp "$$bindir/git$X" "$$execdir/git$X" || exit; \
 	fi && \
-	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git=
$X" "$$execdir/$p" ;) } && \
+	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git=
$X" "$$execdir/$p" 2>/dev/null || cp "$$execdir/git$X" "$$execdir/$p" |=
| exit;) } && \
 	if test "z$$bindir" !=3D "z$$execdir"; \
 	then \
 		$(RM) "$$execdir/git$X"; \
--=20
1.6.0.rc3.22.g053f

From: Jeff King <peff@peff.net>
Subject: [PATCH] mailinfo: avoid violating strbuf assertion
Date: Tue, 19 Aug 2008 13:28:24 -0400
Message-ID: <20080819172824.GA9886@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVV1Q-0001lp-AM
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYHSR22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYHSR22
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:28:28 -0400
Received: from peff.net ([208.65.91.99]:4638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbYHSR22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:28:28 -0400
Received: (qmail 2677 invoked by uid 111); 19 Aug 2008 17:28:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 13:28:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 13:28:24 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92884>

In handle_from, we calculate the end boundary of a section
to remove from a strbuf using strcspn like this:

  el = strcspn(buf, set_of_end_boundaries);
  strbuf_remove(&sb, start, el + 1);

This works fine if "el" is the offset of the boundary
character, meaning we remove up to and including that
character. But if the end boundary didn't match (that is, we
hit the end of the string as the boundary instead) then we
want just "el". Asking for "el+1" caught an out-of-bounds
assertion in the strbuf library.

This manifested itself when we got a 'From' header that had
just an email address with nothing else in it (the end of
the string was the end of the address, rather than, e.g., a
trailing '>' character), causing git-mailinfo to barf.

Signed-off-by: Jeff King <peff@peff.net>
---
> It's the From header actually. The patch below should fix
> it (though it sure makes that line of code ugly --
> improvements are welcome).

I thought it would be more readable to conditionally
increment 'el' when we set, but we actually need it in the
unincremented form on the previous line. So this is the fix
that I posted before, but with a test and a few commit
message cleanups.

 builtin-mailinfo.c       |    2 +-
 t/t5100-mailinfo.sh      |   11 +++++++++++
 t/t5100/info-from.expect |    5 +++++
 t/t5100/info-from.in     |    8 ++++++++
 4 files changed, 25 insertions(+), 1 deletions(-)
 create mode 100644 t/t5100/info-from.expect
 create mode 100644 t/t5100/info-from.in

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 26d3e5d..e890f7a 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -107,7 +107,7 @@ static void handle_from(const struct strbuf *from)
 	el = strcspn(at, " \n\t\r\v\f>");
 	strbuf_reset(&email);
 	strbuf_add(&email, at, el);
-	strbuf_remove(&f, at - f.buf, el + 1);
+	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
 
 	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
 	 * or "john.doe@xz (John Doe)", but we have removed the
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 3b6c3a9..fe14589 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -44,4 +44,15 @@ test_expect_success 'Preserve NULs out of MIME encoded message' '
 
 '
 
+test_expect_success 'mailinfo on from header without name works' '
+
+	mkdir info-from &&
+	git mailsplit -oinfo-from "$TEST_DIRECTORY"/t5100/info-from.in &&
+	test_cmp "$TEST_DIRECTORY"/t5100/info-from.in info-from/0001 &&
+	git mailinfo info-from/msg info-from/patch \
+	  <info-from/0001 >info-from/out &&
+	test_cmp "$TEST_DIRECTORY"/t5100/info-from.expect info-from/out
+
+'
+
 test_done
diff --git a/t/t5100/info-from.expect b/t/t5100/info-from.expect
new file mode 100644
index 0000000..c31d2eb
--- /dev/null
+++ b/t/t5100/info-from.expect
@@ -0,0 +1,5 @@
+Author: bare@example.com
+Email: bare@example.com
+Subject: testing bare address in from header
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/info-from.in b/t/t5100/info-from.in
new file mode 100644
index 0000000..4f08209
--- /dev/null
+++ b/t/t5100/info-from.in
@@ -0,0 +1,8 @@
+From 667d8940e719cddee1cfe237cbbe215e20270b09 Mon Sep 17 00:00:00 2001
+From: bare@example.com
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing bare address in from header
+
+commit message
+---
+patch
-- 
1.6.0.96.g2fad1.dirty

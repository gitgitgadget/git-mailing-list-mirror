From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Sun, 20 Jul 2008 16:12:18 -0700
Message-ID: <7v7ibg2lrh.fsf@gitster.siamese.dyndns.org>
References: <200807202111.48332.johannes.sixt@telecom.at>
 <200807202334.36506.johannes.sixt@telecom.at>
 <7vzloc2odx.fsf@gitster.siamese.dyndns.org>
 <7vhcak2mip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKi5m-0004zt-T4
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbYGTXM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbYGTXM2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:12:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYGTXM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:12:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D5C637D49;
	Sun, 20 Jul 2008 19:12:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9DE2037D48; Sun, 20 Jul 2008 19:12:22 -0400 (EDT)
In-Reply-To: <7vhcak2mip.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jul 2008 15:55:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50D50C14-56B1-11DD-8AA6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89262>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps we should apply a variant of your patch to allow linking from
> compat/ routines to git-shell, so that people affected by the compat layer
> functions that call outside compat layer have incentive to fix them.

So the previous one will be queued in 'pu' as...

    Link shell with compat layer functions
    
    This in the short term will break on platforms that use compat implemenations
    that call outside compat layer, but that is exactly what we want.  To give
    incentive to fix things for people who are affected and more importantly have
    environment to test their fixes.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

and here is an example to fix pread for you, even I do not need it,
though.

-- >8 --
Move read_in_full() and write_in_full() to wrapper.c

A few compat/* layer functions call these functions, but we would really
want to keep them thin, without depending too much on the libgit proper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c      |   38 ++++++++++++++++++++++++++++++++++++++
 write_or_die.c |   38 --------------------------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 4e04f76..93562f0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -133,6 +133,44 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
+ssize_t read_in_full(int fd, void *buf, size_t count)
+{
+	char *p = buf;
+	ssize_t total = 0;
+
+	while (count > 0) {
+		ssize_t loaded = xread(fd, p, count);
+		if (loaded <= 0)
+			return total ? total : loaded;
+		count -= loaded;
+		p += loaded;
+		total += loaded;
+	}
+
+	return total;
+}
+
+ssize_t write_in_full(int fd, const void *buf, size_t count)
+{
+	const char *p = buf;
+	ssize_t total = 0;
+
+	while (count > 0) {
+		ssize_t written = xwrite(fd, p, count);
+		if (written < 0)
+			return -1;
+		if (!written) {
+			errno = ENOSPC;
+			return -1;
+		}
+		count -= written;
+		p += written;
+		total += written;
+	}
+
+	return total;
+}
+
 int xdup(int fd)
 {
 	int ret = dup(fd);
diff --git a/write_or_die.c b/write_or_die.c
index e4c8e22..4c29255 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -45,44 +45,6 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 	}
 }
 
-ssize_t read_in_full(int fd, void *buf, size_t count)
-{
-	char *p = buf;
-	ssize_t total = 0;
-
-	while (count > 0) {
-		ssize_t loaded = xread(fd, p, count);
-		if (loaded <= 0)
-			return total ? total : loaded;
-		count -= loaded;
-		p += loaded;
-		total += loaded;
-	}
-
-	return total;
-}
-
-ssize_t write_in_full(int fd, const void *buf, size_t count)
-{
-	const char *p = buf;
-	ssize_t total = 0;
-
-	while (count > 0) {
-		ssize_t written = xwrite(fd, p, count);
-		if (written < 0)
-			return -1;
-		if (!written) {
-			errno = ENOSPC;
-			return -1;
-		}
-		count -= written;
-		p += written;
-		total += written;
-	}
-
-	return total;
-}
-
 void fsync_or_die(int fd, const char *msg)
 {
 	if (fsync(fd) < 0) {

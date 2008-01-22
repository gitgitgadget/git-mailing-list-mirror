From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 17:34:43 -0800
Message-ID: <7vy7aive18.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
	<47946F67.5060601@gbarbier.org>
	<7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
	<47947399.3000507@gbarbier.org>
	<7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801211212010.5731@racer.site>
	<7vejcbx795.fsf@gitster.siamese.dyndns.org>
	<20080121202953.GA18440@glandium.org>
	<alpine.LSU.1.00.0801220056080.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>,
	=?utf-8?Q?Gr=C3=A9goire?= Barbier <devel@gbarbier.org>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH83H-0008RX-2S
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbYAVBfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbYAVBfQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:35:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbYAVBfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 20:35:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B51B65FC7;
	Mon, 21 Jan 2008 20:35:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D2E5FC6;
	Mon, 21 Jan 2008 20:35:00 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801220056080.5731@racer.site> (Johannes
	Schindelin's message of "Tue, 22 Jan 2008 00:58:50 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71395>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I am half-convinced that http-push w/o CURL_MULTI was broken since long 
> ago (pre 1.5.3).

Sigh, but Ok.  Then let's do this.

-- >8 --
Clarify that http-push being temporarily disabled with older cURL

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes-1.5.4.txt |   14 ++++++++++++--
 Documentation/git-http-push.txt  |    3 +++
 http.h                           |    8 ++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index 9c864c9..b3cc5e0 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -10,8 +10,18 @@ Removal
  * As git-commit and git-status have been rewritten, "git runstatus"
    helper script lost all its users and has been removed.
 
- * Curl library older than 7.10 is not supported by "git http-push",
-   as it does not work without CURLM.
+
+Temporarily Disabled
+--------------------
+
+ * "git http-push" is known not to work well with cURL library older
+   than 7.16, and we had reports of repository corruption.  It is
+   disabled on such platforms for now.  Unfortunately, 1.5.3.8 shares
+   the same issue.  In other words, this does not mean you will be
+   fine if you stick to an older git release.  For now, please do not
+   use http-push from older git with cURL older than 7.16 if you
+   value your data. A proper fix will hopefully materialize in
+   later versions.
 
 
 Deprecation notices
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index cca77f1..0b82722 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -15,6 +15,9 @@ DESCRIPTION
 Sends missing objects to remote repository, and updates the
 remote branch.
 
+*NOTE*: This command is temporarily disabled if your cURL
+library is older than 7.16, as the combination has been reported
+not to work and sometimes corrupts repository.
 
 OPTIONS
 -------
diff --git a/http.h b/http.h
index aeba930..9bab2c8 100644
--- a/http.h
+++ b/http.h
@@ -8,6 +8,14 @@
 
 #include "strbuf.h"
 
+/*
+ * We detect based on the cURL version if multi-transfer is
+ * usable in this implementation and define this symbol accordingly.
+ * This is not something Makefile should set nor users should pass
+ * via CFLAGS.
+ */
+#undef USE_CURL_MULTI
+
 #if LIBCURL_VERSION_NUM >= 0x071000
 #define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
-- 
1.5.4.rc4.11.g7422b

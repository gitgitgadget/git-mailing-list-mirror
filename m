From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] compat/mingw: Support a timeout in the poll emulation if
 no fds are given
Date: Tue, 23 Sep 2008 08:52:16 +0200
Message-ID: <48D89220.6080802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 08:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki1m7-0008Ki-5a
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 08:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbYIWGwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 02:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYIWGwV
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 02:52:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39592 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbYIWGwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 02:52:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ki1kv-00012H-2h; Tue, 23 Sep 2008 08:52:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9E603AFCC; Tue, 23 Sep 2008 08:52:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96528>

From: Johannes Sixt <johannes.sixt@telecom.at>

Our poll() emulation did not support the timeout argument. With this patch
we support it for the simple case where poll() does not need to wait on
file descriptors as well because this case amounts to a mere Sleep().

This is needed if the user sets help.autocorrect is set to a positive
value.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ccfa2a0..7eed60d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -263,8 +263,13 @@ int poll(struct pollfd *ufds, unsigned int nfds, int timeout)
 {
 	int i, pending;

-	if (timeout != -1)
+	if (timeout >= 0) {
+		if (nfds == 0) {
+			Sleep(timeout);
+			return 0;
+		}
 		return errno = EINVAL, error("poll timeout not supported");
+	}

 	/* When there is only one fd to wait for, then we pretend that
 	 * input is available and let the actual wait happen when the
-- 
1.6.0.2.1220.gd1ae.dirty

From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (MINGW) Resend] Windows: Make OpenSSH properly detect tty detachment.
Date: Sun, 2 Nov 2008 20:11:13 +0300
Organization: HOME
Message-ID: <200811022011.13970.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 18:16:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwgYc-0005uD-Cb
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 18:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbYKBRO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 12:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYKBRO3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 12:14:29 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:3339 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbYKBRO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 12:14:28 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2376960fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7vQ4id8kcfCu6HsM3TwyRtdY8RKRit0eZ6jGc/T9sW4=;
        b=asf/x40Z6kZHTKMMq1d0nCAOCatG3MasEJR2XqqpvWoUm+YzxByMmn/SOcH8y+V5dy
         Sjm85d/EUSS/8GW5UBKgNKRl8EfABsvB4mG+Nl1MDCciBAEvVQbMkpyMs9OQzdssszOn
         AIrx/M0YXOWVwS0ri4xTXzGxGNYlQsuHRu4zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=U2ilkWhz3ZpThGtMQFlbdDI0aPRcCAuHfESBfCN3HkjJLAKtVNJE40acPr5tXaD/7y
         c/SY9g9JRTiHTJ7CmiKOfbdofRnqofQuLG5QEVEz8d3nkFvipvG4R7mFh182ec1FGIDk
         e+ffnnW7in3i019vbXzSHOlAP6B8JZiorRnEg=
Received: by 10.181.146.11 with SMTP id y11mr3899700bkn.60.1225645989330;
        Sun, 02 Nov 2008 09:13:09 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm8342486fkt.3.2008.11.02.09.13.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 09:13:08 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99856>

Apparently, CREATE_NO_WINDOW makes the OS tell the process
that it has a console, but without actually creating the
window. As a result, when git is started from GUI, ssh
tries to ask its questions on the invisible console.

This patch uses DETACHED_PROCESS instead, which clearly
means that the process should be left without a console.
The downside is that if the process manually calls
AllocConsole, the window will appear. A similar thing
might occur if it calls another console executable.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
---

	This patch appears to have been overlooked, so I	resend
	it just in case. It fixes a long standing problem in msysgit.

	-- Alexander

 compat/mingw.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1e29b88..b6fcf69 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -586,12 +586,16 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 		 * would normally create a console window. But
 		 * since we'll be redirecting std streams, we do
 		 * not need the console.
+		 * It is necessary to use DETACHED_PROCESS
+		 * instead of CREATE_NO_WINDOW to make ssh
+		 * recognize that it has no console.
 		 */
-		flags = CREATE_NO_WINDOW;
+		flags = DETACHED_PROCESS;
 	} else {
 		/* There is already a console. If we specified
-		 * CREATE_NO_WINDOW here, too, Windows would
+		 * DETACHED_PROCESS here, too, Windows would
 		 * disassociate the child from the console.
+		 * The same is true for CREATE_NO_WINDOW.
 		 * Go figure!
 		 */
 		flags = 0;
-- 
1.6.0.2.1256.ga12f0

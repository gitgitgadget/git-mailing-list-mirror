From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,MINGW) 3/3] Windows: Make OpenSSH properly detect tty detachment.
Date: Mon, 20 Oct 2008 20:02:20 +0400
Message-ID: <1224518540-23782-4-git-send-email-angavrilov@gmail.com>
References: <1224518540-23782-1-git-send-email-angavrilov@gmail.com>
 <1224518540-23782-2-git-send-email-angavrilov@gmail.com>
 <1224518540-23782-3-git-send-email-angavrilov@gmail.com>
Cc: msysgit@googlegroups.com, Johannes Sixt <johannes.sixt@telecom.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 20:53:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxGU-0006X3-3i
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbYJTQEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYJTQEW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:04:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:46649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYJTQET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:04:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1444220fgg.17
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RfmPDw3gzpO8p9O4F5Glz1eQrWjsi5pl1KpsVpeTa5k=;
        b=dCVxl4eQBX9n/1Mbeuiiai8ZHcztkovTSTf0/qEEDsjCoWULXOBAQpEDLOz08LuYJf
         ELsB1GlU0SSlbjWONFh1aQY/ht1Q5Xrzdgh8ezb7i5DKLEXXm+Ea55dX6Cq4J9Gmyg31
         2bPpEvZnnKiz3ULdzFcW2IA1LjYZdzBdtka00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I/XZK3dl8amVXX8+AiFDGbs4/nzXMbsyPMxNgUjJoRHwkx025LwnK5G21XWiRUY0gL
         e7O9HG+TB+xmXprSL0LHMBeZoi9/BsbntOjZQXwroUJ33N/DGCe3uVTIhHnbqN7Con4r
         /0URyvycsbx0ZDL+INxXH/dTaPHt+W+Dim+X0=
Received: by 10.181.219.15 with SMTP id w15mr1675078bkq.90.1224518656507;
        Mon, 20 Oct 2008 09:04:16 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm7985073fka.14.2008.10.20.09.04.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 09:04:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1224518540-23782-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98690>

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

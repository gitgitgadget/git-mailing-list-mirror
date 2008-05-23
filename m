From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] gitk - restore operation of git-reset on Cygwin
Date: Thu, 22 May 2008 23:00:36 -0400
Message-ID: <1211511636-3552-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri May 23 05:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzNXT-0007me-JE
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 05:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760437AbYEWDAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 23:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760361AbYEWDAr
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 23:00:47 -0400
Received: from ti-out-0910.google.com ([209.85.142.189]:55173 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760050AbYEWDAq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 23:00:46 -0400
Received: by ti-out-0910.google.com with SMTP id b6so393085tic.23
        for <git@vger.kernel.org>; Thu, 22 May 2008 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=r8cpXMOlxVt0YaVZhFburGlkFof/D6+cyiPmX1Zxr5g=;
        b=PDCJaq9TretrApp0krMWQWIBvGaLf5lXnvqxECLhDvgSQekW6rd/qK80mNnAJxrzYA9ckjJB7vmG8SefTjCrtz1tjpPCnfBcmNVTO7g9gTrixRJ1Pc/INS7+IsGL0NFChs0DpzKugcqpLO5bvoQ9CMZEyjC5BjBDVxwbRrv0j3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P+ak2R8wWQnRk978DR3bFhs9Bv45OHGwRkUPNVoKLIsVs1pmStq7vFtoSbVq/zPzoLKvQrcVhtQ2t28WILdDMlj1U9qPFIcXLbELObIwjfAgz4l+PZTibtAeJSJ0g/Q/wVcPqCGfHrIa2qathQB8GrTaab8e7LZCHznQ7dTs2BU=
Received: by 10.150.197.9 with SMTP id u9mr1197976ybf.83.1211511643877;
        Thu, 22 May 2008 20:00:43 -0700 (PDT)
Received: from localhost.localdomain ( [71.126.133.203])
        by mx.google.com with ESMTPS id 33sm7017220yxr.3.2008.05.22.20.00.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 May 2008 20:00:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.333.gd69f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82675>

Commit 6df7403a98737 modified the call to git-reset to invoke git
directly rather than using "sh -c", but is redirecting stderr to stdout.
This does not work on Cygwin, probably because the Tcl/Tk package is
a windows program rather than Cygwin. The result is always an error
message proclaiming 'can not find channel named "1"'. This restores
invocation through sh -c.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
Note - this applies to Paul's tree, please let me know if you prefer
one that applies to Junio's instead (gitk-git/gitk rather than gitk).

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 22bcd18..aa70911 100755
--- a/gitk
+++ b/gitk
@@ -7617,7 +7617,7 @@ proc resethead {} {
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
-	    [list | git reset --$resettype $rowmenuid 2>@1] r]} err]} {
+	    [list | sh -c "git reset --$resettype $rowmenuid 2>&1"] r]} err]} {
 	error_popup $err
     } else {
 	dohidelocalchanges
--
1.5.5.1.333.gd69f4

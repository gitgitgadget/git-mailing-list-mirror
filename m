From: Tony Finch <dot@dotat.at>
Subject: [PATCH v2] git-prompt: preserve value of $? inside shell prompt
Date: Mon, 22 Dec 2014 18:09:25 +0000
Message-ID: <alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk>
References: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 19:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37QD-0007yR-F1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbaLVSJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:09:29 -0500
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39336 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbaLVSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:09:28 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:52333)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Y37Q6-0006xs-D3 (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 22 Dec 2014 18:09:26 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Y37Q5-00066J-W1 (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 22 Dec 2014 18:09:25 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261661>

If you have a prompt which displays the command exit status,
__git_ps1 without this change corrupts it, although it has
the correct value in the parent shell:

	~/src/git (master) 0 $ set | grep ^PS1
	PS1='\w$(__git_ps1) $? \$ '
	~/src/git (master) 0 $ false
	~/src/git (master) 0 $ echo $?
	1
	~/src/git (master) 0 $

There is a slightly ugly workaround:

	~/src/git (master) 0 $ set | grep ^PS1
	PS1='\w$(x=$?; __git_ps1; exit $x) $? \$ '
	~/src/git (master) 0 $ false
	~/src/git (master) 1 $

This change makes the workaround unnecessary.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 contrib/completion/git-prompt.sh | 4 ++++
 1 file changed, 4 insertions(+)

I hope that explains it properly :-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c5473dc..5fe69d0 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -288,6 +288,7 @@ __git_eread ()
 # In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
 __git_ps1 ()
 {
+	local exit=$?
 	local pcmode=no
 	local detached=no
 	local ps1pc_start='\u@\h:\w '
@@ -511,4 +512,7 @@ __git_ps1 ()
 	else
 		printf -- "$printf_format" "$gitstring"
 	fi
+
+	# preserve exit status
+	return $exit
 }
-- 
2.2.1.68.g56d9796

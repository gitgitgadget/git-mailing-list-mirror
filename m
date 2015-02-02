From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 1/2] Fixes _is_git
Date: Mon,  2 Feb 2015 12:24:42 -0500
Message-ID: <1422897883-11036-1-git-send-email-remirampin@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
Cc: Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 18:25:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIKk9-00022M-WF
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 18:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbbBBRY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 12:24:57 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:41382 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbBBRY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 12:24:56 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so31222422qcz.6
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 09:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcMJ2Be/lDpD/QvcuWnzzIPmW2L2043FPnrBFd9Brgg=;
        b=M92CwgcACdXE6uVMtFRYhy10Lk8jRbMk+/gC2rrc73k6IAZ1AeO0ZNCQO7HvdRRLUb
         LLVXQvcIbupWOc4MHJEyRU28Hr6WSI8OTVYkrEr7l5Vabg8Nyk7TyIcBMwMPOuMBb8y2
         Ww/VPMT3gPvTmx0MOOWqksXATQ0ZFdAw7iXmhtMnooHVLiMLuK0GrGOYVBfzkwPtLtwl
         jfNVVVWR5Q5nHvQmpsqBvyO68vWrFtCbAqvsNwWEfgVYjCzGPTOEPMKRjNBjNLj3DwNv
         92qI/tXUZjxD+Xw6nFfjLNeVkDOZr56v0363cx6dH17LNbV3iurocXEKSgHQSo8eieMz
         4tfg==
X-Received: by 10.224.55.71 with SMTP id t7mr43838218qag.53.1422897896289;
        Mon, 02 Feb 2015 09:24:56 -0800 (PST)
Received: from vebian.poly.edu (remram.poly.edu. [128.238.102.168])
        by mx.google.com with ESMTPSA id r10sm9950101qan.42.2015.02.02.09.24.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Feb 2015 09:24:55 -0800 (PST)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263263>

Function _git_dir would previously fail to accept a "gitdir: ..." file
as a valid Git repository.
---
 lib/choose_repository.tcl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 92d6022..49ff641 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -339,6 +339,16 @@ method _git_init {} {
 }
 
 proc _is_git {path} {
+	if {[file isfile $path]} {
+		set fp [open $path r]
+		gets $fp line
+		close $fp
+		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
+			return [_is_git [file join [file dirname $path] $link_target]]
+		}
+		return 0
+	}
+
 	if {[file exists [file join $path HEAD]]
 	 && [file exists [file join $path objects]]
 	 && [file exists [file join $path config]]} {
-- 
1.9.5.msysgit.0

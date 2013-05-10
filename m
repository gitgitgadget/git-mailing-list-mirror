From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/8] rebase: prepare to do generic housekeeping
Date: Fri, 10 May 2013 19:56:41 +0530
Message-ID: <1368196005-5354-5-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:26:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGl-0007jS-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233Ab3EJOZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:45 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32781 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab3EJOZT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:19 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so2981433pad.2
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OQ/jlsF9aSHpId8bQDhB5VMTDczKUEHEozRkg58vDPI=;
        b=bMUZLo9lZwQTSGELlAVYLifZm688o6nZBs+a3h5VYqzcqBNtqJSACPEB4I85ThCCoH
         l4Kv9URdxc9i7ymqdB4AXNXHDvOszJPTtmrqJhWft+k5KgLSCpawTC9DR6sdNCpgJrzC
         q/1nhYzo99BTCYm3OFzsgk7BYOBbaDr7p/4fIkXctimGoSy8Ba3uoO2YT5wKjhqyfDHU
         2YINCpBFGhwGpYgZC+zbopMoHBuscMoU+E2xS5eBvA88IOxn74x8IIw3z7BNZa6iP0dI
         PnYnWnzvbaGF1jbFFmQ6zqc+KIVu776sHVVZurw8tjimjUNnM9F2SHR/WzhXqogSRKkn
         /+kw==
X-Received: by 10.66.149.227 with SMTP id ud3mr18443814pab.33.1368195918466;
        Fri, 10 May 2013 07:25:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223846>

On successful completion of a rebase in git-rebase--$backend.sh, the
$backend script cleans up on its own and exits.  The cleanup routine
is however, independent of the $backend, and each $backend script
unnecessarily duplicates this work:

    rm -rf "$state_dir"
    git gc --auto

Prepare git-rebase.sh for later patches that return control from each
$backend script back to us, for performing this generic cleanup
routine.

Another advantage is that git-rebase.sh can implement a generic
finish_rebase() to possibly do additional tasks in addition to the
cleanup.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2c692c3..84dc7b0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -150,6 +150,13 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
+	ret=$?
+	if test $ret = 0
+	then
+		git gc --auto &&
+		rm -rf "$state_dir"
+	fi
+	exit $ret
 }
 
 run_pre_rebase_hook () {
-- 
1.8.3.rc1.52.gc14258d

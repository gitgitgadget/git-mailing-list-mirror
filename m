From: Matt Korostoff <mkorostoff@gmail.com>
Subject: [PATCH] contrib/completion: suppress stderror in bash completion of git remotes
Date: Mon,  9 Feb 2015 15:58:28 -0500
Message-ID: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com>
Cc: Matt Korostoff <MKorostoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:58:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvPC-0003vd-4j
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760851AbbBIU6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:58:00 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46116 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759959AbbBIU5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 15:57:49 -0500
Received: by mail-qa0-f50.google.com with SMTP id f12so4631422qad.9
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 12:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=N4NaFVUXuVBq4CBYj1w1i5De+58p2Jd9Y0G5H+YFkh0=;
        b=qFieU5FW/YvWBVlcT7XurSjgyEnOug9pahEv6Ws+WCOG+8wvWP4bTR9HRfuBquZSvl
         bRoX9Mk3+/DytcW+VftlbXaPwd5aOBMvtMbhDT1ppjD9k1MQxgrj3xd9Gmpd0Cza45/Q
         BoWD6qYE3KhOhH/8lU8c5Io9AqtmjuYejIkaSjoCZow80M8WQcBKWDfzOCazw9bFh6nf
         8oMbVWNZk30DlLs7w/12TJELkjCFLLoAYztvhn0DiZyufTggJpH4x7kWenO+9L0/GTxF
         pmLJg/QZXw8870DDT6VtzDTp5m6bn1hsB/81WktupRW0jYd5rBUbDUMdmqiunBAlEfpQ
         4oWg==
X-Received: by 10.224.22.72 with SMTP id m8mr32299979qab.66.1423515468553;
        Mon, 09 Feb 2015 12:57:48 -0800 (PST)
Received: from localhost.localdomain (static-71-172-38-122.nwrknj.fios.verizon.net. [71.172.38.122])
        by mx.google.com with ESMTPSA id f9sm7768326qgf.17.2015.02.09.12.57.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Feb 2015 12:57:48 -0800 (PST)
X-Google-Original-From: Matt Korostoff <MKorostoff@gmail.com>
X-Mailer: git-send-email 1.7.10.2 (Apple Git-33)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263598>

In some system configurations there is a bug with the
__git_remotes function.  Specifically, there is a problem
with line 415, `test -d "$d/remotes" && ls -1 "$d/remotes"`.
While `test -d` is meant to prevent listing the remotes
directory if it does not exist, in some system, `ls` will
run regardless.

This results in an error in which typing `git push or` + `tab`
prints out `ls: .git/remotes: No such file or directory`.
This can be fixed by simply directing stderror of this line
to /dev/null.
---
 contrib/completion/git-completion.bash |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fece98..72251cc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -412,7 +412,7 @@ __git_refs_remotes ()
 __git_remotes ()
 {
 	local i IFS=$'\n' d="$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
+	test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
 	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
 		i="${i#remote.}"
 		echo "${i/.url*/}"
-- 
1.7.10.2 (Apple Git-33)

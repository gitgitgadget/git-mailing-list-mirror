From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Mon, 30 Dec 2013 20:22:17 +0530
Message-ID: <1388415138-11011-4-git-send-email-artagnon@gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 15:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxeCa-00065x-Kn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 15:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab3L3OwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 09:52:13 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55713 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab3L3OwB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 09:52:01 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so11690971pbb.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ry/BuzAWveVFT9pnPaZYUhsYGicw1r0P+DyaWkTGMb4=;
        b=FvhDJVepQrbIx0I/s/U69QAYKP88Wni8z41c9Q5fOs2zVOzleay+bCWGFsDUVsZGlt
         GRKmok/vCth4WV+wfxgseK4eGqCzFv9M4WdtrR7QcNQ85BFB8KnH3EXMar9ovjPFBlGn
         zI+IAQMmqL72VIMpEEoFrREatSaD6at0cpOPnWjAdpIFyGXf4FdyeZXEbfH0lOjS/BNn
         ftdH0lfIZSenzSCCs/poGnmTGP3OFmbV9JWfpJB3d0FM6JyS67L2Rtm16U02NBOkYQWO
         lNAOJyTN2tzyJashHvBbLkrzCJLdO3+lvbV8vhgYKbYN2wh6yquP234jgjTCha/B4KEw
         sVug==
X-Received: by 10.68.230.137 with SMTP id sy9mr68928501pbc.126.1388415121272;
        Mon, 30 Dec 2013 06:52:01 -0800 (PST)
Received: from localhost.localdomain ([122.164.121.180])
        by mx.google.com with ESMTPSA id vn10sm82123744pbc.21.2013.12.30.06.51.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2013 06:52:00 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239805>

When attempting to complete

  $ git config branch.auto<TAB>

'autosetupmerge' and 'autosetuprebase' don't come up. This is because
"$cur" is matched with "branch.*" and a list of branches are
completed. Add 'autosetup(merge|rebase)' to the list of branches using
__gitcomp_2 ().

Also take care to not complete

  $ git config branch.autosetupmerge.<TAB>
  $ git config branch.autosetuprebase.<TAB>

with the usual branch.<name>. candidates.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64b20b8..0bda757 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1851,12 +1851,18 @@ _git_config ()
 		;;
 	branch.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
+		if [ "$pfx" == "branch.autosetupmerge." ] ||
+			[ "$pfx" == "branch.autosetuprebase." ]; then
+			return
+		fi
 		__gitcomp "remote pushremote merge mergeoptions rebase" "$pfx" "$cur_"
 		return
 		;;
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_2 "$(__git_heads)" "
+			autosetupmerge autosetuprebase
+			" "$pfx" "$cur_" "."
 		return
 		;;
 	guitool.*.*)
-- 
1.8.5.2.227.g53f3478

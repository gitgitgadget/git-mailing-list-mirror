From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 27/45] rebase: cherry-pick: fix command invocations
Date: Sun,  9 Jun 2013 11:40:39 -0500
Message-ID: <1370796057-25312-28-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulij0-00074a-6M
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab3FIQoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:10 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47441 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3FIQoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:08 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so9072073obb.14
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Itrz0y/zHLjc2Z+i/EQhhvmU+udg2cpvoeOhzBwkbOk=;
        b=SOFrq2brpZhzJWDfWilEY31AfI/KbvJNK9tTH1eTN6sQuDOO+lE7asHPSBT0x2oPOh
         b/FGhFAoaGM8sDygAIexxdMdlL5PtG9z417q2fRUYnInRSvzKHewlD/qYqwfjo06YtT4
         cswIjFBwZ78sP8BsM+Er+lUYPLfmXppQOTj2v5Ruc0Uvnzy1UJ51pSwqkAfQC/5EW0ue
         R//kdgbXT8eZJJC5cdzQv3lER2sVrycsRsoctGAXP+tRl50eYJJoqbM7JbruROR3cEO2
         PLgV69lKGKO5RmI3zboNnBIJjktmp+NPOov8NxnwLTAiYJ3DEqiSlK/vyBHm76kq+vBV
         Bjpg==
X-Received: by 10.182.108.132 with SMTP id hk4mr5456673obb.14.1370796247592;
        Sun, 09 Jun 2013 09:44:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c10sm15206030oej.1.2013.06.09.09.44.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226995>

So that all the tests pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index d8d32fe..e9ecccc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -21,7 +21,22 @@ test -n "$rebase_root" && root_flag=--root
 mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 : > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
 
-git cherry-pick --allow-empty "$revisions"
+if test -n "$rebase_root"
+then
+	revisions="$onto...$orig_head"
+else
+	revisions="$upstream...$orig_head"
+fi
+
+if test -n "$keep_empty"
+then
+	extra="--allow-empty"
+else
+	extra="--skip-empty --cherry-pick"
+fi
+test -n "$GIT_QUIET" && extra="$extra -q"
+test -z "$force_rebase" && extra="$extra --ff"
+git cherry-pick --no-merges --right-only --topo-order --do-walk $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.3.698.g079b096

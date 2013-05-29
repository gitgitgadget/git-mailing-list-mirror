From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 5/8] rebase: cherry-pick: fix command invocations
Date: Tue, 28 May 2013 23:16:37 -0500
Message-ID: <1369801000-3705-6-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqT-0002Lk-Da
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934810Ab3E2ESh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:37 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58141 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab3E2ESg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:36 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so2959552obb.22
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tZlgjDEzlgLM2NjNIRcW7hUDsE7clJkgVPBJKZypOvs=;
        b=WjPSoo7Ywz/ooJJtI9lWNWLyavcnHOsmQNW1pJVQEMuULU2w3WFQE9xXH5gZzRfrS6
         TypUDsOwwUd/xmze/HNBpBlYH7kgh8PI/5leBPtl91LdlY+8oiJDu9+6KfM7BuzvkJ9Z
         MaD1/Hri3mYATBolmszSiCccrO8Gt8D5acgkiKZA98EGY7riBNIIRIizNWaJ3XQT7g/f
         xUQvTpaPw2QfRphV53uZ7OSb5mYAmofcOzN4ja+c8jb2Wai6PEHwP4Yj7/+/wL0txR/G
         /3ZfkPqAZuZUu8HaarkRxkAox/Wuzn+p4/rlWeVYEYyQ6Z1rCS4Xbze9anFGO+0kFWiG
         5O7w==
X-Received: by 10.182.16.170 with SMTP id h10mr559144obd.17.1369801115975;
        Tue, 28 May 2013 21:18:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm39316617oes.6.2013.05.28.21.18.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225728>

So that all the tests pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 2fa4993..ab892e6 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -23,11 +23,26 @@ test -n "$rebase_root" && root_flag=--root
 mkdir "$state_dir" || die "Could not create temporary $state_dir"
 : > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
 
+if test -n "$rebase_root"
+then
+	revisions="$onto...$orig_head"
+else
+	revisions="$upstream...$orig_head"
+fi
+
 # we have to do this the hard way.  git format-patch completely squashes
 # empty commits and even if it didn't the format doesn't really lend
 # itself well to recording empty patches.  fortunately, cherry-pick
 # makes this easy
-git cherry-pick --allow-empty "$revisions"
+if test -n "$keep_empty"
+then
+	extra="--allow-empty"
+else
+	extra="--skip-empty --cherry-pick"
+fi
+test -n "$GIT_QUIET" && extra="$extra -q"
+test -z "$force_rebase" && extra="$extra --ff"
+git cherry-pick --no-merges --right-only --topo-order --do-walk --copy-notes $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.3.rc3.312.g47657de

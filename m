From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv3] submodule update: allow custom update command
Date: Tue,  2 Jul 2013 22:12:54 +1200
Message-ID: <1372759974-19765-1-git-send-email-judge.packham@gmail.com>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org>
Cc: Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 12:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtxaT-0007r0-QN
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 12:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504Ab3GBKN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 06:13:26 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36069 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab3GBKNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 06:13:25 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so6052942pab.7
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OOzpFFKHFQXvQSqr2ttfjeQSy3Eogh/Q8XjxPXYJogg=;
        b=0gw6b+y0/5RTuHZDCZKZPwrFoGDJzL5w6DGZH0amk1Sc8ws/mXqkgiPXHi8ofBsZnv
         1dxl3Qr7FGVBJ4uNXh6JlyWnmBc1tQ5SKaLPLQnBaPiyokKw5FRNxv4OA3pjpfo7Go7W
         1IqywtnQvvUsjr6xv9nRvqSgrX3fjNdvIxE+PTG3sA2fqCe3521Zy2GdiHzx2A4Z1Jjj
         GO88ms7TmOZyFJfp77PhBfnU76xZXljvFN4+CDbBYJnqlD+X2IOlYvo04x3xDrxgFuFW
         MMNRFVlHVXysRsO7mN11bDlW7pWQ95pIcmnrq/8SJzQvFhMuDjgI84FrWuSdrUsMKrXu
         lRxA==
X-Received: by 10.68.182.130 with SMTP id ee2mr13262252pbc.26.1372760004657;
        Tue, 02 Jul 2013 03:13:24 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc ([202.36.163.2])
        by mx.google.com with ESMTPSA id td4sm14900393pac.20.2013.07.02.03.13.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Jul 2013 03:13:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.644.gfaf2af3
In-Reply-To: <7vehbii6un.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229389>

Users can set submodule.$name.update to '!command' which will cause
'command' to be run instead of checkout/merge/rebase.  This allows the
user some finer grained control over how the update is done. The primary
motivation for this was interoperability with stgit however being able
to intercept the submodule update process may prove useful for
integrating or extending other tools.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
v3 updated as per Junio's review.

Still needs tests. Any suggestions? I've been manually testing by setting
submodule.$name.update to '!echo'. I haven't looked to see if there are
existing 'submodule update' tests yet.

 Documentation/git-submodule.txt | 5 ++++-
 git-submodule.sh                | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..0befc20 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -159,7 +159,9 @@ update::
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
 	`rebase`, `merge` or `none`. `none` can be overridden by specifying
-	`--checkout`.
+	`--checkout`. Setting the key `submodule.$name.update` to `!command`
+	will cause `command` to be run. `command` can be any arbitrary shell
+	command that takes a single argument, namely the sha1 to update to.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -172,6 +174,7 @@ If `--force` is specified, the submodule will be checked out (using
 `git checkout --force` if appropriate), even if the commit specified in the
 index of the containing repository already matches the commit checked out in
 the submodule.
++
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
diff --git a/git-submodule.sh b/git-submodule.sh
index eb58c8e..a7c2375 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
+			!*)
+				command="${update_module#!}"
+				die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+				must_die_on_failure=yes
+				;;
 			*)
 				command="git checkout $subforce -q"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
-- 
1.8.3.1.644.gfaf2af3

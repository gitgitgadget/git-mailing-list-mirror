From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv4] submodule update: allow custom update command
Date: Wed,  3 Jul 2013 21:02:02 +1200
Message-ID: <1372842122-15568-1-git-send-email-judge.packham@gmail.com>
References: <51D3064C.80901@web.de>
Cc: Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 11:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIxG-0002pB-36
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab3GCJCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:02:22 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50836 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab3GCJCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:02:21 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so7201333pbc.12
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C2JQSVS1YoyaDHB1umh/d/ZJLTNFoIT/kAhPsWt+dKA=;
        b=YNMiBy+oNzTrDsUlJ203kJXofqlu+y73+oK+vggXJ2W4WAOlYdGKmtNodkv5BJs20K
         2tkk9RsGHFPpCCLeo9iIM4KiZ/z1RYL/G4Yastj5Gm5ahPnmTGP296UpljiuiNk5pnB0
         8oMyLAnYZ4atCygd5TG0iXq0ZkfTTg2rsd1kU4Ji92axGwPB28rh66qYW6pAGaATmTeA
         y696lwNO532gGYDYfKKTGQvO5SnSw48ZAjYvTl6RUGoXr8VfoZSRHx6tYnAX7CuL/XfM
         NdNXNwmySrdgq4wlTJ1bWBmBLx12uvEFrC1FxLJTqWhFkUCHAdPmU+imLtj8KPm8s8pW
         3wAA==
X-Received: by 10.68.217.38 with SMTP id ov6mr32952297pbc.9.1372842140508;
        Wed, 03 Jul 2013 02:02:20 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc ([202.36.163.2])
        by mx.google.com with ESMTPSA id kq2sm33018168pab.19.2013.07.03.02.02.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 02:02:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.644.ge86575b
In-Reply-To: <51D3064C.80901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229472>

Users can set submodule.$name.update to '!command' which will cause
'command' to be run instead of checkout/merge/rebase.  This allows the
user some finer grained control over how the update is done. The primary
motivation for this was interoperability with stgit however being able
to intercept the submodule update process may prove useful for
integrating with or extensions to other tools.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
v4 adds a couple of simple tests - an equivalent of update=checkout and a test
to make sure we detect a failure reported by the update command.

 Documentation/git-submodule.txt |  4 +++-
 git-submodule.sh                |  6 ++++++
 t/t7406-submodule-update.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..2f18f7d 100644
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
diff --git a/git-submodule.sh b/git-submodule.sh
index eb58c8e..e7579f0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
+			!*)
+				command="${update_module#!}"
+				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+				must_die_on_failure=yes
+				;;
 			*)
 				command="git checkout $subforce -q"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a4ffea0..48d1279 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -279,6 +279,35 @@ test_expect_success 'submodule update - checkout in .git/config' '
 	)
 '
 
+test_expect_success 'submodule update - command in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.update "!git checkout"
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD^
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 ! compare_head
+	)
+'
+
+test_expect_success 'submodule update - command in .git/config catches failure' '
+	(cd super &&
+	 git config submodule.submodule.update "!false"
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD^
+	) &&
+	(cd super &&
+	 test_must_fail git submodule update submodule
+	)
+'
+
 test_expect_success 'submodule init picks up rebase' '
 	(cd super &&
 	 git config -f .gitmodules submodule.rebasing.update rebase &&
-- 
1.8.3.1.644.ge86575b

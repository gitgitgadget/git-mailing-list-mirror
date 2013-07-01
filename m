From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2] submodule: add ability to configure update command
Date: Mon,  1 Jul 2013 22:11:34 +1200
Message-ID: <1372673494-24286-1-git-send-email-judge.packham@gmail.com>
References: <51D04F06.9000400@web.de>
Cc: Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 12:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utb5R-0002dH-1q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 12:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab3GAKLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 06:11:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34697 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab3GAKLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 06:11:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so4871590pad.33
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OilaOd3cXUg/gAcjDpIpcrO9loDUA2kNejjrsQp163g=;
        b=R79CblVBZ0nBsasBmZZaRn//IvvZwUnre9QBO9i9OEdRLvPaNNznpCNv2JGOj45aOM
         SVM1xCdIqE+zdAWrS7Tps3zgJ0XlQj2YkYNx4gm85EhrfufMyis3D5ip1vC7U5oJhB+6
         2M6oFB1d21WxDk2D6IyIROpMxkM6ht32hJ9aX1g4vLZMH4Erbp+Eh08/F40Y3TXYo18P
         HsnCej2rOcy8duRva8lIchNz7OWpH2n81uTsN+8SwFEbZHG8d68wdEPGq+NA2q/WkS3d
         Kc5P/fdzPrTHm5hTPkhmQtwjJ1fNGPVOKDoyyzj6kvpzaXAvgMMSWcWou531SFX9DQge
         onxA==
X-Received: by 10.66.160.74 with SMTP id xi10mr6734180pab.8.1372673511631;
        Mon, 01 Jul 2013 03:11:51 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc ([202.36.163.2])
        by mx.google.com with ESMTPSA id ue9sm23205788pab.7.2013.07.01.03.11.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 03:11:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.644.g533062f.dirty
In-Reply-To: <51D04F06.9000400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229298>

Users can set submodule.$name.update to '!command' which will cause
'command' to be run instead of checkout/merge/rebase.  This allows the
user some finer grained control over how the update is done. The primary
motivation for this was interoperability with stgit however being able
to intercept the submodule update process may prove useful for
integrating or extending other tools.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

On 01/07/13 03:30, Jens Lehmann wrote:
>
> Hmm, if we go that route, why not do the same we do for aliases? If
> the submodule.*.update setting is prefixed with a '!', we just execute
> the shell command following. This would give everyone the freedom to
> do arbitrary stuff if the current none, checkout, merge & rebase won't
> do the trick without having to add another config option.
>

And here's an implementation of this. Actually I like this a lot better
to the v1 patch. Still lacks tests but if there is enough interest I can
add some.

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
index eb58c8e..680cb68 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
+			!*)
+				command="$(expr "$update_module" : '!\(.*\)')"
+				die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"
+				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+				must_die_on_failure=yes
+				;;
 			*)
 				command="git checkout $subforce -q"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
-- 
1.8.3.1.644.g533062f.dirty

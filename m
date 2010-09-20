From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/37] t6022: Add paired rename+D/F conflict: (two/file, one/file) -> (one, two)
Date: Mon, 20 Sep 2010 02:28:40 -0600
Message-ID: <1284971350-30590-8-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjQ-0005rH-LU
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab0ITI1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63516 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0ITI1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:45 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070478pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uyWuf13u3PZg+Qkw0F1eNfvvLoCjs4wBxbrJv6etbr4=;
        b=Fp6UqYmQwoCpnh7m1F9Gws9Vfg0OVrK5l8dm9l2uvaHshHz4QfvK/DjdnbnlOFr/OM
         ZedcUh9NN1r5akaxubw7Mo2vVdXshNzcHCaUjDyjfNLAXPl/JlP7QOiBMvEWtf6ByLEY
         f1spqT/w0DmuRwhLgNSiamwIWlLNqaRMcAwK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GSCx2YiAoJIWLj4YfeMOFatmu/whE41sTDPdrPtcyQZM1wwU8S8X9S+bmSUY98bqfj
         OdRFWCMluzeScvk1c3phRBadBuXncWgLW3HJzV5sU2S8Ofc0tR1PYR2ryTygIonxs4U6
         sdynfDHkTO/qE36S2QMrlukLTeEqHB6OKqxeg=
Received: by 10.142.223.8 with SMTP id v8mr7344740wfg.287.1284971265618;
        Mon, 20 Sep 2010 01:27:45 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156562>

An interesting testcase is having two files each in their own subdirectory
getting renamed to the toplevel at the directory pathname of the other.
Questions arise as to whether the order of operations matters and whether
the directories can correctly get out of the way and make room for the
new files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 2af863c..a38b383 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -565,4 +565,67 @@ test_expect_failure 'both rename source and destination involved in D/F conflict
 	test "stuff" = "$(cat destdir~HEAD)"
 '
 
+test_expect_success 'setup pair rename to parent of other (D/F conflicts)' '
+	git reset --hard &&
+	git checkout --orphan rename-two &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	mkdir one &&
+	mkdir two &&
+	echo stuff >one/file &&
+	echo other >two/file &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git rm -rf one &&
+	git mv two/file one &&
+	git commit -m "Rename two/file -> one" &&
+
+	git checkout -b rename-one HEAD~1 &&
+	git rm -rf two &&
+	git mv one/file two &&
+	rm -r one &&
+	git commit -m "Rename one/file -> two"
+'
+
+test_expect_failure 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
+	git checkout -q rename-one^0 &&
+	mkdir one &&
+	test_must_fail git merge --strategy=recursive rename-two &&
+
+	test 2 = "$(git ls-files -u | wc -l)" &&
+	test 1 = "$(git ls-files -u one | wc -l)" &&
+	test 1 = "$(git ls-files -u two | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+
+	test 4 = $(find . | grep -v .git | wc -l) &&
+
+	test -d one &&
+	test -f one~rename-two &&
+	test -f two &&
+	test "other" = $(cat one~rename-two) &&
+	test "stuff" = $(cat two)
+'
+
+test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean start' '
+	git reset --hard &&
+	git clean -fdqx &&
+	test_must_fail git merge --strategy=recursive rename-two &&
+
+	test 2 = "$(git ls-files -u | wc -l)" &&
+	test 1 = "$(git ls-files -u one | wc -l)" &&
+	test 1 = "$(git ls-files -u two | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+
+	test 3 = $(find . | grep -v .git | wc -l) &&
+
+	test -f one &&
+	test -f two &&
+	test "other" = $(cat one) &&
+	test "stuff" = $(cat two)
+'
+
 test_done
-- 
1.7.3.271.g16009

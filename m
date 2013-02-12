From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 3/4] contrib/subtree/t: Added tests for .gitsubtree support
Date: Tue, 12 Feb 2013 23:23:55 +0000
Message-ID: <CALeLG_=v-XwTygQKOD2JDWmbD0oVV=R+HnXi3dBXtXykV0wXKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David A. Greene" <greened@obbligato.org>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 00:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5PD1-0005jp-OY
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835Ab3BLXX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:23:57 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:56096 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab3BLXX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:23:56 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so706375oag.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 15:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=lxa61x4iRFAZzgE4PAuLe81oy6s0t5lQ2MQQd4YJWwY=;
        b=PtypqhrYi+Tz+1PgKa+BmUPcZQuf6CnmdvSJ6IfEMUkf92QlzNIeXzLe+2Fr22gfeu
         yobLG9xTmBS3IJIFMz0HQlOPqIAvkrijiZMi/42KkcWTDDCE2VRxo0A9Dk8QIrvPfQGz
         dUY/3lAJW4YhcrtD8FISiwVi8+CRIAwtQ9E15e2rWsDMjQ/qToUsQkAoOegYl39CACHx
         HRjw7+IO3XuA9ILlZZKYRCPlIgBa964iHxmIBHK5t9jloJofGU+zNDDn2slWpAK1Q4Y3
         eajTujnsi3k0vIulzfebWdwwcYz/Gh2STnBG3EOM7N4/33j1Rv/CuyCnL6NT37pv9mv4
         rlLA==
X-Received: by 10.60.31.195 with SMTP id c3mr14857423oei.57.1360711435874;
 Tue, 12 Feb 2013 15:23:55 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Tue, 12 Feb 2013 15:23:55 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQlBHaAlaQ9A5ZXw2KTEJchB/Rtqxdkps/O2pKUfy+/D8r6jqdUZ9yplJpzuPIs2KXDJKwig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216225>

 55 add: ensure details are added to .gitsubtree
 56 push: check for a SHA1 update line
 57 pull: add a file on one subtree, push it to a branch, then pull into
    another subtree containing the same branch and confirm the files match
 58 add: ensure stale .gitsubtree entry is replaced

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/t/t7900-subtree.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh
b/contrib/subtree/t/t7900-subtree.sh
index bc2eeb0..5ae4584 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -505,4 +505,38 @@ test_expect_success 'verify one file change per commit' '
         ))
 '

+# return to mainline
+cd ../..
+
+# .gitsubtree
+# 55
+test_expect_success 'added repository appears in .gitsubtree' '
+        git subtree add --prefix=copy0 sub1 &&
+        grep "^copy0 \. sub1$" .gitsubtree
+'
+
+# 56
+test_expect_success 'change in subtree is pushed okay' '
+        cd copy0 && create new_file && git commit -m"Added new_file" &&
+        cd .. && git subtree push --prefix=copy0 2>&1 | \
+                grep -E "^   [0-9a-f]{7}\.\.[0-9a-f]{7}  [0-9a-f]{40} -> sub1$"
+'
+
+# 57
+test_expect_success 'pull into subtree okay' '
+        git subtree add --prefix=copy1 sub1 &&
+        git subtree add --prefix=copy2 sub1 &&
+        cd copy1 && create new_file_in_copy1 && git commit -m"Added
new_file_in_copy1" &&
+        cd .. && git subtree push --prefix=copy1 &&
+        git subtree pull --prefix=copy2 | grep "^ create mode 100644
copy2/new_file_in_copy1$"
+'
+
+# 58
+test_expect_success 'replace outdated entry in .gitsubtree' '
+        echo "copy3 . sub2" >> .gitsubtree &&
+        git subtree add --prefix=copy3 sub1 &&
+        (grep "^copy3 . sub2$" .gitsubtree && die || true) &&
+        grep "^copy3 . sub1$" .gitsubtree
+'
+
 test_done
-- 
1.8.1.3.566.gaa39828

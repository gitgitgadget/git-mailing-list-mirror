From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 2/3] contrib/subtree/t: Added tests for .gitsubtree support
Date: Fri, 15 Feb 2013 22:50:58 +0000
Message-ID: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 23:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6U7n-0003Of-34
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 23:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3BOWu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 17:50:59 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51940 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab3BOWu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 17:50:59 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so4138398obc.12
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 14:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=hG4tA2nQs0Q0yZeuGpvY+Qf+mzpf7rH7j4YjXEVTmTc=;
        b=bH34Bmgu0PeyNO2m2uyv+qQxvgD9MhFHXZPZIaHjP/x/0dXLDORVC/nSn7pOcChFdc
         eGYj8Hah0wH3fdfRJUhnGRc+8oV0WHNHbCuz/Oy0dYJdD1lO4Y/+sTYxF73otBCeCZyj
         cgLNs9351yMZcaIYgvCquYR4BW+dA6c7AlT0YP2r6V2HwIzjRu7FwH//ofe8yRAZRFdp
         KZ3LaWNUwwdFPzAqW+LJ1nagIZ7uZs8y4/MsfrlRV2kaaQ0FtZkaA1miluudw5bZ1z9y
         RZF0SBMmoyhxI9e+ZwrhxufZyiKJuup866QtVDBEgyXrfx5V6LG21ZmIMWB+6f5wDuQ7
         qsfQ==
X-Received: by 10.182.51.98 with SMTP id j2mr2892963obo.77.1360968658333; Fri,
 15 Feb 2013 14:50:58 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Fri, 15 Feb 2013 14:50:58 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQm4ALV6nLkM9HbxvdE+wUJir00/lidHqoLJYlo9mOKNKgBanMgjhalXrrET1XWIVHJ8/1La
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216360>

add: ensure details are added to .gitsubtree
push: check for a SHA1 update line
pull: add a file on one subtree, push it to a branch, then pull into
    another subtree containing the same branch and confirm the files match
add: ensure stale .gitsubtree entry is replaced

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/t/t7900-subtree.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh
b/contrib/subtree/t/t7900-subtree.sh
index 80d3399..4437dc6 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -465,4 +465,34 @@ test_expect_success 'verify one file change per commit' '
         ))
 '

+# return to mainline
+cd ../..
+
+# .gitsubtree
+test_expect_success 'added repository appears in .gitsubtree' '
+        git subtree add --prefix=copy0 sub1 &&
+        grep "^copy0 \. sub1$" .gitsubtree
+'
+
+test_expect_success 'change in subtree is pushed okay' '
+        cd copy0 && create new_file && git commit -m"Added new_file" &&
+        cd .. && git subtree push --prefix=copy0 2>&1 | \
+                grep
"^\s\{3\}[0-9a-f]\{7\}\.\.[0-9a-f]\{7\}\s\s[0-9a-f]\{40\}\s->\ssub1$"
+'
+
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
+test_expect_success 'replace outdated entry in .gitsubtree' '
+        echo "copy3 . sub2" >> .gitsubtree &&
+        git subtree add --prefix=copy3 sub1 &&
+        (grep "^copy3 . sub2$" .gitsubtree && die || true) &&
+        grep "^copy3 . sub1$" .gitsubtree
+'
+
 test_done
-- 
1.8.1.3.605.g02339dd

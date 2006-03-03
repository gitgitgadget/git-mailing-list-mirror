From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: workaround fat/ntfs deficiencies for t3600-rm.sh (git-rm)
Date: Fri, 3 Mar 2006 11:20:18 +0100
Message-ID: <81b0412b0603030220v527779a3p4818309443e330cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23044_976751.1141381218477"
Cc: "Junio C Hamano" <junkio@cox.net>, "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Mar 03 11:20:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF7Od-0000Ix-JW
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 11:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbWCCKUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 05:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbWCCKUY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 05:20:24 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:43568 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752249AbWCCKUY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 05:20:24 -0500
Received: by nproxy.gmail.com with SMTP id y38so433009nfb
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 02:20:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=ryaprjHsI+Eoukm9lxglDyb5gmUNUCcf+OZXvQav8zeQiW6xZut8zccrmlP3KR3fp87qUKbKsIZqkjMyhcdqhsuabena09jK4fyDrJsk4a3WLMtQWw79mT0sW4E28XXG5Y9DsDM6EHz7dXPo/rkhugb9F/+6wE7Bh9RZ03yyQgI=
Received: by 10.48.238.3 with SMTP id l3mr1089962nfh;
        Fri, 03 Mar 2006 02:20:18 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Fri, 3 Mar 2006 02:20:18 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17151>

------=_Part_23044_976751.1141381218477
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>
---
chmod u-w and even chmod a-w dont work on fat and ntfs.
The actually do something, but rm a file from that directory
will succeed anyway. That's windows permission model to you...

------=_Part_23044_976751.1141381218477
Content-Type: text/plain; 
	name=0001-workaround-fat-ntfs-deficiencies-for-t3600-rm.sh-git-rm.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ekccro00
Content-Disposition: attachment; filename="0001-workaround-fat-ntfs-deficiencies-for-t3600-rm.sh-git-rm.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Fri Mar 3 11:15:05 2006 +0100
Subject: workaround fat/ntfs deficiencies for t3600-rm.sh (git-rm)

---

 t/t3600-rm.sh |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

583a9faeab3a200fc970577458b7827d86aa7df1
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index cabfadd..d1947e1 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,11 +8,20 @@ test_description='Test of the various op
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
-touch -- foo bar baz 'space embedded' 'tab	embedded' 'newline
-embedded' -q
-git-add -- foo bar baz 'space embedded' 'tab	embedded' 'newline
-embedded' -q
-git-commit -m "add files"
+touch -- foo bar baz 'space embedded' -q
+git-add -- foo bar baz 'space embedded' -q
+git-commit -m "add normal files"
+test_tabs=y
+if touch -- 'tab	embedded' 'newline
+embedded'
+then
+git-add -- 'tab	embedded' 'newline
+embedded'
+git-commit -m "add files with tabs and newlines"
+else
+    say 'Your filesystem does not allow tabs in filenames.'
+    test_tabs=n
+fi
 
 test_expect_success \
     'Pre-check that foo exists and is in index before git-rm foo' \
@@ -42,16 +51,18 @@ test_expect_success \
     'Test that "git-rm -- -q" succeeds (remove a file that looks like an option)' \
     'git-rm -- -q'
 
-test_expect_success \
+test "$test_tabs" = y && test_expect_success \
     "Test that \"git-rm -f\" succeeds with embedded space, tab, or newline characters." \
     "git-rm -f 'space embedded' 'tab	embedded' 'newline
 embedded'"
 
+if test "$test_tabs" = y; then
 chmod u-w .
 test_expect_failure \
     'Test that "git-rm -f" fails if its rm fails' \
     'git-rm -f baz'
 chmod u+w .
+fi
 
 test_expect_success \
     'When the rm in "git-rm -f" fails, it should not remove the file from the index' \
-- 
1.2.4.ga091




------=_Part_23044_976751.1141381218477--

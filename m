From: Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 02:59:06 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 08 09:04:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adCcw-0000SV-ML
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 09:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbcCHIET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 03:04:19 -0500
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:53925 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753495AbcCHIER (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 03:04:17 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2016 03:04:17 EST
X-AuditID: 12074423-847ff70000007333-1a-56de864c3bc9
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by  (Symantec Messaging Gateway) with SMTP id 40.31.29491.C468ED65; Tue,  8 Mar 2016 02:59:08 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id u287x843028465;
	Tue, 8 Mar 2016 02:59:08 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u287x6WD014830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Mar 2016 02:59:07 -0500
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixCmqrevTdi/MYP0fa4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugStjf9ds9oJT/BWrJm5haWDcxNPFyMkhIWAi8e7d
	K8YuRi4OIYE2Jom7v/tZIJwNjBKNDZPYIJxdTBI9j64ygrSwCGhJ3Jk8jwnEZhNQk/hw9Csr
	iC0iICpxZP4iNhCbWUBcYtPyN2A1wgIuEouPTWIBsXkF3CVub/wDFhcV0JU49O8PG0RcUOLk
	zCcsEL1aEsunb2OZwMg7C0lqFpLUAkamVYyyKblVurmJmTnFqcm6xcmJeXmpRbpmermZJXqp
	KaWbGEFhxO6ivIPxZZ/3IUYBDkYlHt4HP++GCbEmlhVX5h5ilORgUhLlfVtxL0yILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCC9/C1CONyWxsiq1KB8mJc3BoiTOy8jAwCAkkJ5YkpqdmlqQWgST
	leHgUJLg5W4FahQsSk1PrUjLzClBSDNxcIIM5wEargZSw1tckJhbnJkOkT/FqMsx5/e5nUxC
	LOlFiZVS4rzzQC4QACnKKM2DmwOJfweJV4ziQG8J864CGcUDTB1wk14BLWECWqLTdwtkSUki
	QkqqgbFxpyt/W/HdCzNS5QNNDs1YX//BO6Nhzj3h0wc+rXS53C5yVE747KPHSeE8Fb07jh7h
	/VLJ1mm9IOT1P5EVLzvOC7m8+PjfTNF4tQO70fPXZ/bu4S62m/SEVbB5AafGu+SWo0fs4ky2
	hcc92SX+e4dqYHr3Hpa+ph9BvR/cmFqnsvGkee2Yf0WJpTgj0VCLuag4EQD0zO7+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288423>

The included test case, which uses rebase -p with non-ASCII commit
messages, was failing as follows:

  Warning: the command isn't recognized in the following line:
   - Binary file (standard input) matches

  You can fix this with 'git rebase --edit-todo'.
  Or you can abort the rebase with 'git rebase --abort'.

Possibly related to recent GNU grep changes, as with commit
316336379cf7937c2ecf122c7197cfe5da6b2061.  Avoid the issue by using sed
instead.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 git-rebase--interactive.sh        |  2 +-
 t/t3409-rebase-preserve-merges.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c0cfe88..0efc65c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1241,7 +1241,7 @@ then
 			# be rebasing on top of it
 			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
 			sha1=$(git rev-list -1 $rev)
-			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+			sed "/^[a-z][a-z]* $sha1/d" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
 			rm "$rewritten"/$rev
 		fi
 	done
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8c251c5..1f01b29 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -119,4 +119,25 @@ test_expect_success 'rebase -p ignores merge.log config' '
 	)
 '
 
+test_expect_success 'rebase -p works with non-ASCII commit message' '
+	(
+	mkdir non-ascii &&
+	cd non-ascii &&
+	git init &&
+	echo a > a &&
+	git add a &&
+	git commit -m a &&
+	echo b > b &&
+	git add b &&
+	git commit -m b &&
+	git branch foo &&
+	git reset --hard HEAD^ &&
+	git cherry-pick -x foo &&
+	echo c > c &&
+	git add c &&
+	git commit -m "$(printf "I \\342\\231\\245 Unicode")" &&
+	git rebase -p foo
+	)
+'
+
 test_done
-- 
2.8.0.rc0

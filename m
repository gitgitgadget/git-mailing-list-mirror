From: Madhu <enometh@meer.net>
Subject: git-rebase --abort eats files
Date: Sat, 26 Jun 2010 18:23:11 +0530 (IST)
Message-ID: <20100626125924.160F11F212@leonis4.robolove.meer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:11:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVAh-0001uG-Do
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0FZNLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:11:38 -0400
Received: from mail.meer.net ([64.13.141.3]:56862 "EHLO mail.meer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902Ab0FZNLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:11:37 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jun 2010 09:11:37 EDT
Received: from mail2.meer.net (mail2.meer.net [64.13.141.16])
	by mail.meer.net (8.13.3/8.13.3/meer) with ESMTP id o5QCxXPt044679
	for <git@vger.kernel.org>; Sat, 26 Jun 2010 05:59:33 -0700 (PDT)
	(envelope-from enometh@meer.net)
Received: from leonis4.robolove.meer.net ([59.92.46.156])
	(authenticated bits=0)
	by mail2.meer.net (8.14.1/8.14.3) with ESMTP id o5QCxS3D045907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 26 Jun 2010 05:59:32 -0700 (PDT)
	(envelope-from enometh@meer.net)
Received: by leonis4.robolove.meer.net (Postfix, from userid 500)
	id 160F11F212; Sat, 26 Jun 2010 18:23:11 +0530 (IST)
X-Attribution: Madhu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149742>

Don't know if this has been resolved-by-debate here before, But adding
a file via git-add in the middle of an interactive rebase and aborting
the rebase deletes the hitherto untracked file.  It should not. 

rm -rfv /tmp/t1 ; mkdir -pv /tmp/t1
cd /tmp/t1 && git-init-db
cd /tmp/t1 && touch file1 file2 file3
cd /tmp/t1 && git-add file1
cd /tmp/t1 && git-commit -m "Explet1" file1
cd /tmp/t1 && git-add file2
cd /tmp/t1 && git-commit -m "Explet2" file2
cd /tmp/t1 && git-rebase --abort
cd /tmp/t1 && EDITOR="sed -i -e 's/^pick/edit/'" git rebase -i 'HEAD^'
cd /tmp/t1 && git-add file3
cd /tmp/t1 && git-status
cd /tmp/t1 && git-rebase --abort
test -e /tmp/t1/file3 || echo bwaaah

Maybe something like this to fix it?

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 436b7f5..2702536 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -749,6 +749,7 @@ first and then run 'git rebase --continue' again."
                        git symbolic-ref HEAD $HEADNAME
                        ;;
                esac &&
+               git-reset &&
                output git reset --hard $HEAD &&
                rm -rf "$DOTEST"
                exit

--
Madhu

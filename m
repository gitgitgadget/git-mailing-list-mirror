From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t1301-shared-repo: Fix forced modes test
Date: Sat, 11 Apr 2009 23:32:05 +0200
Message-ID: <49E10C55.1050005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 23:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lskqo-00087g-37
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 23:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbZDKVcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 17:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbZDKVcP
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 17:32:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:65006 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZDKVcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 17:32:14 -0400
Received: from [77.117.144.164] (77.117.144.164.wireless.dyn.drei.com [77.117.144.164])
	by bsmtp.bon.at (Postfix) with ESMTP id 81301A7EBD;
	Sat, 11 Apr 2009 23:32:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116351>

This test was added recently (5a688fe, "core.sharedrepository = 0mode"
should set, not loosen; 2009-03-28). It checked the result of a sed
invocation for emptyness, but in some cases it forgot to print anything
at all, so that those checks would never be false.

Due to this mistake, it went unnoticed that the files in objects/info are
not necessarily 0440, but can also be 0640. This directory is now exempt
from the check.

Finally, this test cannot be run on Windows (requires POSIXPERM).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---

  I don't have a Linux/Unix readily available right now, so this is only
  tested on Windows.

  -- Hannes

  t/t1301-shared-repo.sh |    8 +++++---
  1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 750fbb3..fb7c51d 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -126,7 +126,7 @@ test_expect_success POSIXPERM 'git reflog expire
  	esac
  '

-test_expect_success 'forced modes' '
+test_expect_success POSIXPERM 'forced modes' '
  	mkdir -p templates/hooks &&
  	echo update-server-info >templates/hooks/post-update &&
  	chmod +x templates/hooks/post-update &&
@@ -145,7 +145,7 @@ test_expect_success 'forced modes' '
  	xargs ls -ld >actual &&

  	# Everything must be unaccessible to others
-	test -z "$(sed -n -e "/^.......---/d" actual)" &&
+	test -z "$(sed -e "/^.......---/d" actual)" &&

  	# All directories must have either 2770 or 770
  	test -z "$(sed -n -e "/^drwxrw[sx]---/d" -e "/^d/p" actual)" &&
@@ -156,10 +156,12 @@ test_expect_success 'forced modes' '
  		p
  	}" actual)" &&

-	# All files inside objects must be 0440
+	# All files inside objects (except objects/info) must be 0440
  	test -z "$(sed -n -e "/objects\//{
  		/^d/d
+		/info/d
  		/^-r--r-----/d
+		p
  	}" actual)"
  '

-- 
1.6.2.2.1458.gf2216d6

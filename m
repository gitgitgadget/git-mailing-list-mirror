From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/10] t3404 (rebase -i): introduce helper to check position
 of HEAD
Date: Sun, 31 Oct 2010 02:40:30 -0500
Message-ID: <20101031074030.GJ11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSX0-00078z-7l
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab0JaHkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:40:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48606 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0JaHkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:40:41 -0400
Received: by gyg4 with SMTP id 4so2658044gyg.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kCFe+Pwl3L6f7xjqOEEtAh8LKOFGpiqQv3b2VTuFmVc=;
        b=Tg87c/riDSeH1v03S18x6k5bTyE65a4OR3vxBqEKCkk7GJlPHh7+9tyjCn81qa8T+L
         OHaL/LOByO/JOOiFBiUl+dnVEAL32pQ0tx+Fr5ZrlqrEseGWyrWX0lE3sKKq4Gwfm7X4
         Rg71G2kezXUSUMKS4aeAH7D+cJGJkuFTQJ24Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rSHIL003GPbziy7dmW48BpborLWKWFUEVHuVkikk1d0Kjlj+08wV39RJPxYqoGoNlp
         7E638hQi+Wurs5GxlaGuKRnoO2vJnMZ28RVeJpJWeB6fhq4CYsGhqB2YCbVZh1SYDNeo
         NDLyxVrf/vUlHEVfiMIk1cKvJp0wQmwOZ+bAY=
Received: by 10.150.137.19 with SMTP id k19mr25778926ybd.109.1288510840455;
        Sun, 31 Oct 2010 00:40:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q14sm5071018ybk.19.2010.10.31.00.40.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160428>

The same code to check the position of HEAD is used by several
tests in this script.  Factor it out as a function and simplify it.

Noticed using an &&-chaining tester, because the current code
does not propagate the precise exit status from errors.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3404-rebase-interactive.sh |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4097a2d..4fcedda 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -29,6 +29,12 @@ Initial setup:
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+test_cmp_rev () {
+	git describe --always --tags "$1" >expect.rev &&
+	git describe --always --tags "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
 set_fake_editor
 
 # WARNING: Modifications to the initial repository can change the SHA ID used
@@ -80,20 +86,12 @@ test_expect_success 'rebase -i with the exec command' '
 	test_path_is_file touch-one &&
 	test_path_is_file touch-two &&
 	test_path_is_missing touch-three " (should have stopped before)" &&
-	test $(git rev-parse C) = $(git rev-parse HEAD) || {
-		echo "Stopped at wrong revision:"
-		echo "($(git describe --tags HEAD) instead of C)"
-		false
-	} &&
+	test_cmp_rev C HEAD &&
 	git rebase --continue &&
 	test_path_is_file touch-three &&
 	test_path_is_file "touch-file  name with spaces" &&
 	test_path_is_file touch-after-semicolon &&
-	test $(git rev-parse master) = $(git rev-parse HEAD) || {
-		echo "Stopped at wrong revision:"
-		echo "($(git describe --tags HEAD) instead of master)"
-		false
-	} &&
+	test_cmp_rev master HEAD &&
 	rm -f touch-*
 '
 
@@ -114,11 +112,7 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	export FAKE_LINES &&
 	test_must_fail git rebase -i HEAD^
 	) &&
-	test $(git rev-parse master^) = $(git rev-parse HEAD) || {
-		echo "Stopped at wrong revision:"
-		echo "($(git describe --tags HEAD) instead of master^)"
-		false
-	} &&
+	test_cmp_rev master^ HEAD &&
 	git reset --hard &&
 	git rebase --continue
 '
-- 
1.7.2.3.557.gab647.dirty

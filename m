From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/10] t3404 (rebase -i): unroll test_commit loops
Date: Sun, 31 Oct 2010 02:38:25 -0500
Message-ID: <20101031073825.GH11483@burratino>
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
X-From: git-owner@vger.kernel.org Sun Oct 31 08:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSUy-0006Ii-HD
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab0JaHih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:38:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34500 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0JaHif (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:38:35 -0400
Received: by iwn10 with SMTP id 10so5665176iwn.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tlflnnqck3lWGgnh62xFLSxQGVtfAyIzEDpvK7ty6vU=;
        b=N43tNkDkLccZXM0u6uHw8n2kFYxRjophz90W33KW2Ug+imgDBWuiXuDGJ9NKvGXw4T
         E/7/XR00s4kVe+n9K2hDsphTrTPnIz0cCntVWwQ3MIPTgaV4DCdpUkMwAztP4EhiMh58
         mpuT2sUrdsbWBtIEuFAE5lVsNZRSjCNmo4E08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hs2aL4ygsaOTw8huTaTMH5hNJsMmtBreRYSR3dxA4iZyHzam7cn+X0imAQ1kUXSmZ9
         j+10hICZ39ssMubLtGVma3EHVSODrqHtRiF8mQp0NiYNC/axD9ntKSURp2FFAnS1y74f
         z3bz/CcZY6dVsQnQu8Tf2MQJbRAZZ+NC/rFDE=
Received: by 10.42.12.129 with SMTP id y1mr6978231icy.185.1288510715122;
        Sun, 31 Oct 2010 00:38:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w9sm6432794ibc.7.2010.10.31.00.38.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:38:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160426>

Allow test_commit failures in loop iterations before the last one to
cause the test assertion to fail.

More importantly, avoiding these loops makes the test a little
simpler to read and decreases the vertical screen footprint of
the setup test assertion by one line.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3404-rebase-interactive.sh |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c0e69f6..b372314 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -48,20 +48,19 @@ test_expect_success 'setup' '
 	git checkout -b branch2 F &&
 	test_commit I file6 &&
 	git checkout -b conflict-branch A &&
-	for n in one two three four
-	do
-		test_commit $n conflict
-	done &&
+	test_commit one conflict &&
+	test_commit two conflict &&
+	test_commit three conflict &&
+	test_commit four conflict &&
 	git checkout -b no-conflict-branch A &&
-	for n in J K L M
-	do
-		test_commit $n file$n
-	done &&
+	test_commit J fileJ &&
+	test_commit K fileK &&
+	test_commit L fileL &&
+	test_commit M fileM &&
 	git checkout -b no-ff-branch A &&
-	for n in N O P
-	do
-		test_commit $n file$n
-	done
+	test_commit N fileN &&
+	test_commit O fileO &&
+	test_commit P fileP
 '
 
 # "exec" commands are ran with the user shell by default, but this may
-- 
1.7.2.3.557.gab647.dirty

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 02/20] t5800: factor out some ref tests
Date: Sun, 19 Jun 2011 17:18:27 +0200
Message-ID: <1308496725-22329-3-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn1-0003jn-0H
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab1FSPTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:35 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1FSPTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:33 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=2oZ0DKmEmlKgwZS8L/Fip+GPB+Ykb2/RnBQnjcI2MvI=;
        b=MyvuPtuHR9Q3e0w6P8hoZ4wStsXiMJcrLS+Q2HcbjemrfgB3LSAtMtxWDG2U+XrNMb
         91KYcFYO01MrBxtogSDdFHs+fFBy3XL+dcR0hBzavbS+nuEUaQUnFcLdrVc8Sdy1IumI
         PBY+QFFL1J6ml2+PtZfe7Hf+fxr/5/SwJWluw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QbA/JBvyN4wEa4kW5fErqXJbbyLox6VMlQ841pd4FAzJ6+eqqHtV6uso5EaSrZ1ixZ
         o+FD+WhX5ou+1BuqAjAerFaY1+r7Hy7XGEbw9dt5S10k8BCqKY+GuKAfp3GHzJraEGnc
         d3Ofu65pIIpYsM6+F3JDQxDLPb3CNXf97OQC8=
Received: by 10.14.101.68 with SMTP id a44mr1603834eeg.47.1308496772230;
        Sun, 19 Jun 2011 08:19:32 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176005>

From: Jeff King <peff@peff.net>

These are a little hard to read, and I'm about to add more
just like them. Plus the failure output is nicer if we use
test_cmp than a comparison with "test".

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 t/t5800-remote-helpers.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1fb6380..3a37ad0 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -17,6 +17,12 @@ then
 	test_set_prereq PYTHON_24
 fi
 
+compare_refs() {
+	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
+	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success PYTHON_24 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
@@ -59,8 +65,7 @@ test_expect_success PYTHON_24 'pushing to local repo' '
 	echo content >>file &&
 	git commit -a -m three &&
 	git push) &&
-	HEAD=$(git --git-dir=localclone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs localclone HEAD server HEAD
 '
 
 test_expect_success PYTHON_24 'synch with changes from localclone' '
@@ -73,8 +78,7 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	echo content >>file &&
 	git commit -a -m four &&
 	git push) &&
-	HEAD=$(git --git-dir=clone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs clone HEAD server HEAD
 '
 
 test_done
-- 
1.7.5.1.292.g728120

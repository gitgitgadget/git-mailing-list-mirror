From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 15/20] remote-hg: add basic author tests
Date: Mon,  8 Apr 2013 12:13:29 -0500
Message-ID: <1365441214-21096-16-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFgZ-0006Qa-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934813Ab3DHRQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:16:17 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63466 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3DHRPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:30 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so6506994oag.31
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2CHfCMXYQolOsLxMaBndGh25pfPHwf9KuBgj3jJe3zk=;
        b=ytlOaHKAmSdLg0D5XkYh5pvX6zzCkEmDSlgsJG0R9TvB5seQyRHE2WIbc5JgKFxmuP
         gYzMqEt4xUfYe4PY8/r+lcyz8i17ELJNypup0YWwITCUN2lKLlFPmNRjbwEtXaRxaWm4
         GREYkLOiKQNoCMYyYJ5TY4LttEXe7DLaEsj87l2EhH6P15SqROoDguDtEbEs3R0SIAwg
         rNWDdSAIZDAFBiHEo2pB4UCCLicsFUJ/XAz0mIqzAVt3xgTazJXFIpGGLrBMEexbwDjs
         pmGS8/c6fssen4io20OdQnazoSC9bYrc8Cs/bliilhe7WRZ05O6j7v2vPCssl8qxoGYU
         5qTg==
X-Received: by 10.60.134.234 with SMTP id pn10mr13349601oeb.0.1365441330262;
        Mon, 08 Apr 2013 10:15:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c4sm24852418obo.9.2013.04.08.10.15.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220462>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 5f81dfa..62e3a47 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -118,4 +118,39 @@ test_expect_success 'update bookmark' '
   hg -R hgrepo bookmarks | grep "devel\s\+3:"
 '
 
+author_test () {
+  echo $1 >> content &&
+  hg commit -u "$2" -m "add $1" &&
+  echo "$3" >> ../expected
+}
+
+test_expect_success 'authors' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp" &&
+
+  (
+  hg init hgrepo &&
+  cd hgrepo &&
+
+  touch content &&
+  hg add content &&
+
+  author_test alpha "" "H G Wells <wells@example.com>" &&
+  author_test beta "test" "test <unknown>" &&
+  author_test beta "test <test@example.com> (comment)" "test <unknown>" &&
+  author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
+  author_test delta "name<test@example.com>" "name <test@example.com>" &&
+  author_test epsilon "name <test@example.com" "name <unknown>" &&
+  author_test zeta " test " "test <unknown>" &&
+  author_test eta "test < test@example.com >" "test <test@example.com>" &&
+  author_test theta "test >test@example.com>" "test <unknown>" &&
+  author_test iota "test < test <at> example <dot> com>" "test <unknown>"
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  git --git-dir=gitrepo/.git log --reverse --format="%an <%ae>" > actual &&
+
+  test_cmp expected actual
+'
+
 test_done
-- 
1.8.2

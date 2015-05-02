From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/7] t5520: test pulling multiple branches into an empty repository
Date: Sat,  2 May 2015 23:37:09 +0800
Message-ID: <1430581035-29464-2-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZTy-0002wB-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbbEBPh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34265 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbEBPh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:27 -0400
Received: by pacyx8 with SMTP id yx8so119395331pac.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NVQ4UUBJEkuJIUQGFXySNtSRVQscSqV5Ttt0x2rB00=;
        b=onL7/81UCsMqB9JsmTf1ygsAfQvWolhwIrxNmqHESOaUaWpQzO1pQ3JLi3kHBIG8S9
         UWAZ21sEMG/W0MBjRanC8heOasD95U2qe8N2OPggJ01om64wE/EJEz0iTnFSqLtF7/tP
         uz5muulyb1xDufwctwwM6GPbOhN/X6+KsoBb/veeep2xMv4jMMBNWNYR9uu3VnIbE3qj
         RhIRIeGWNazSoACCt7NpKki6RRYH/3oufLkzUose4rRRgUIZ9iYtYf1BWR6Ab1L7MJgx
         oyqhEMDzJwgzSFIzCqfch7DqHYt7sSy8EA0mD1KzDWL0yNc5+AlZUMBCIInao4rVxbt/
         AhCg==
X-Received: by 10.66.62.227 with SMTP id b3mr27480809pas.65.1430581046572;
        Sat, 02 May 2015 08:37:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268230>

Commit d09e79cb ("allow pulling into an empty repository") introduced
the ability to pull into an empty head. As pulling in multiple branches
does not make sense in this context, git-pull explicitly fails when
there is an empty head and multiple branches are specified.

Add a test to ensure that this safeguard works.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5520-pull.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 227d293..01ae1bf 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -86,6 +86,18 @@ test_expect_success 'pulling into void does not remove new staged files' '
 	)
 '
 
+test_expect_success 'refuse to pull multiple branches into void' '
+	git branch test master &&
+	test_when_finished "git branch -D test" &&
+	git init cloned-multiple-branches &&
+	test_when_finished "rm -rf cloned-multiple-branches" &&
+	(
+		cd cloned-multiple-branches &&
+		test_must_fail git pull .. master test 2>out &&
+		test_i18ngrep "Cannot merge multiple branches into empty head" out
+	)
+'
+
 test_expect_success 'test . as a remote' '
 
 	git branch copy master &&
-- 
2.1.4

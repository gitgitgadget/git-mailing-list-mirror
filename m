From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 02/10] t7900: Demonstrate failure to expand "$peer/$branch" according to refspecs
Date: Sat, 11 May 2013 18:21:12 +0200
Message-ID: <1368289280-30337-3-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYF-0007SE-3c
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab3EKQVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:31 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35571 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3EKQV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:29 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so1570158wiv.8
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E0t3WljMOfSDHb0OGD9spri0u61sHZ9kOJU+fD845Vc=;
        b=Nmokd15V/bCqOGDpoyslQVeGALs8HY8qUTCyoZ4Ld7X+CYZIiP2QNHcsTHlmqoLHWx
         2gLx+TamnSbnXczklp4PQfaZQtIPsm79qrKxX43VvSyxJFuDtrXjZkGk0z4zyhj+jScm
         6ov/iQ9T8iQaWrXSwAWCM+H4AcmS32NzJxiH1r1EY/HyxoWBjQuGFAlHge0FcYooXw/2
         O0YefpatESpTmtabtuYdbDchHreY0saYA4gTS/KvfNeLfZWW7bDoJBFVy7shI3Olac7z
         omLoq7Ej8nBKsmYDar081v8BIkHkLHDHdY1Jtq2ZbCe2hdPo+0FA1hGlZokMD6018f+k
         FfzQ==
X-Received: by 10.194.71.241 with SMTP id y17mr30768878wju.31.1368289288138;
        Sat, 11 May 2013 09:21:28 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223983>

This test verifies that the following expressions all evaluate to the
full refname "refs/peers/origin/heads/master":

 - refs/peers/origin/heads/master
 - peers/origin/heads/master
 - origin/heads/master
 - origin/master

(We assume that there are no other conflicting refs for which the above
expressions would cause ambiguity.)

Currently none of these work, because the refs machinery don't know how
to expand shorthand names within the refs/peers/* hierarchy.

Mirroring the expansion of the above 4 expressions into the full refname,
the same 4 expressions should also be shortened into "origin/master" when
abbreviating them into their shortest unambiguous representation, e.g.
when running "git rev-parse --abbrev-ref" on them. A (currently failing)
test verifying this behavior is also added by this patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7900-working-with-namespaced-remote-refs.sh | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
index dfd916b..109e9b8 100755
--- a/t/t7900-working-with-namespaced-remote-refs.sh
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -79,4 +79,32 @@ test_expect_success 'work-around "clone" with namespaced remote refs' '
 	test_clone client
 '
 
+test_expect_success 'enter client repo' '
+	cd client
+'
+
+test_expect_failure 'short-hand notation expands correctly for remote-tracking branches' '
+	echo refs/peers/origin/heads/master >expect &&
+	git rev-parse --symbolic-full-name refs/peers/origin/heads/master >actual &&
+	test_cmp expect actual &&
+	git rev-parse --symbolic-full-name peers/origin/heads/master >actual &&
+	test_cmp expect actual &&
+	git rev-parse --symbolic-full-name origin/heads/master >actual &&
+	test_cmp expect actual &&
+	git rev-parse --symbolic-full-name origin/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'remote-tracking branches are shortened correctly' '
+	echo origin/master >expect &&
+	git rev-parse --abbrev-ref refs/peers/origin/heads/master >actual &&
+	test_cmp expect actual &&
+	git rev-parse --abbrev-ref peers/origin/heads/master >actual &&
+	test_cmp expect actual &&
+	git rev-parse --abbrev-ref origin/heads/master >actual &&
+	test_cmp expect actual &&
+	git rev-parse --abbrev-ref origin/master >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f

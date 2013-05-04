From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/7] t7900: Demonstrate failure to expand "$remote/$branch" according to refspecs
Date: Sun,  5 May 2013 01:55:45 +0200
Message-ID: <1367711749-8812-4-git-send-email-johan@herland.net>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJL-0005n7-G8
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab3EDX4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:56:02 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:36446 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3EDX4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:56:00 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1146025bkc.2
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YhT52RZsQxiB0BNj6VObLY8AJ1CvplbKm7y5zwpLf7U=;
        b=YcAjZXMp0hiEEmvCKLcmBO0ain9qINesTrZsxYTMmAyYqyz+ccRLesL8T7Vly8XoNy
         csweG7wODMWPkjHThSIaUbvbHeEtDmKnjBlb3WRIN2l/OkEekKqgOm4TqlnRb3IuZUSb
         5OY1WREaAjiYI4FyJV5s3HA6d1GJ7aJB9P9H86LW+WrzlbCXjGs53aeMcW/8JFk1qX5F
         h+7CFz89E51Vuc+RnEiX4yhAjeqLCI6E17t0DNby36SgGGIRDtonkBha7c3XIRWWWriR
         lnstMNsKi3mko/y0fwU+WZ9f7NeJYdZDe3ZEpp+4DSGc9w7pR6Kxq1+1mhqHn73y/ze7
         F1yA==
X-Received: by 10.204.166.11 with SMTP id k11mr4921074bky.6.1367711758988;
        Sat, 04 May 2013 16:55:58 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.55.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:55:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223386>

This test verifies that the following expressions all evaluate to the
full refname "refs/remotes/origin/heads/master":

 - refs/remotes/origin/heads/master
 - remotes/origin/heads/master
 - origin/heads/master
 - origin/master

Currently the last of these fail, because the "$remote/$branch" syntax only
works for remotes with conventional (refs/heads/*:refs/remotes/origin/*)
refspecs.

In order for users of namespaced remote refs (or any other unconventional
refspec configuration) to be able to use the "$remote/$branch" syntax, we
need to extend the parsing of "$remote/$branch" expressions to take the
configured refspecs into account (i.e. look up the fetch refspecs for
$remote, and map "refs/heads/$branch" through the refspecs to find the
corresponding remote-tracking branch name).

Mirroring the expansion of the above 4 expressions into the full refname,
the same 4 expression should also be shortened into "origin/master" when
abbreviating them into their shortest unambiguous representation, e.g.
when running "git rev-parse --abbrev-ref" on them. A (currently failing)
test verifying this behavior is also added by this patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7900-working-with-namespaced-remote-refs.sh | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
index af03ac9..cc25e76 100755
--- a/t/t7900-working-with-namespaced-remote-refs.sh
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -85,4 +85,32 @@ test_expect_success 'work-around "clone" with namespaced remote refs' '
 	test_clone client
 '
 
+test_expect_success 'enter client repo' '
+	cd client
+'
+
+test_expect_failure 'short-hand notation expands correctly for remote-tracking branches' '
+	echo refs/remotes/origin/heads/master > expect &&
+	git rev-parse --symbolic-full-name refs/remotes/origin/heads/master > actual &&
+	test_cmp expect actual &&
+	git rev-parse --symbolic-full-name remotes/origin/heads/master > actual &&
+	test_cmp expect actual &&
+	git rev-parse --symbolic-full-name origin/heads/master > actual &&
+	test_cmp expect actual &&
+	git rev-parse --symbolic-full-name origin/master > actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'remote-tracking branches are shortened correctly' '
+	echo origin/master > expect &&
+	git rev-parse --abbrev-ref refs/remotes/origin/heads/master > actual &&
+	test_cmp expect actual &&
+	git rev-parse --abbrev-ref remotes/origin/heads/master > actual &&
+	test_cmp expect actual &&
+	git rev-parse --abbrev-ref origin/heads/master > actual &&
+	test_cmp expect actual &&
+	git rev-parse --abbrev-ref origin/master > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f

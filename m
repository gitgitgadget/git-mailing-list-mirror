From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20cherry-pick=3A=20add=20failing=20test=20for=20out-of-order=20pick?=
Date: Thu, 12 Jan 2012 23:20:47 +0530
Message-ID: <1326390647-21446-1-git-send-email-artagnon@gmail.com>
References: <CALkWK0nJM2wUE9qzp38qjFFqCdwX9w0Jckxi1G=1=7adMxg2rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOpR-0002WC-Bu
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab2ALRwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:52:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65200 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab2ALRwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 12:52:38 -0500
Received: by ggdk6 with SMTP id k6so1131682ggd.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qtEX1tyYMJ3xXyRWOvUP/beskBaTP3egt0m7HmbViQQ=;
        b=G9wvK5fGjrx/jNAaZX5zdqV03uHWbpZYkFmGNBDXUzqNy3+y+GhpMWInOhreLk4gbG
         NeyIXKS1IEWHJeMA9oKE8V27xKhexWFbpaeQlzDou1IPGebPIzRIIzqDPB+wad9y+BnG
         cw/4hq1tDjs1zXuvxdg8ptjHyLBC8x+rq0xO0=
Received: by 10.50.160.201 with SMTP id xm9mr5160702igb.16.1326390757752;
        Thu, 12 Jan 2012 09:52:37 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id gf6sm1845982igb.1.2012.01.12.09.52.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 09:52:06 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <CALkWK0nJM2wUE9qzp38qjFFqCdwX9w0Jckxi1G=1=7adMxg2rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188463>

Due to the way traditional revision arguments work, the following
invocations of 'git cherry-pick' are equivalent:

  $ git cherry-pick master..topic
  $ git cherry-pick topic ^master
  $ git cherry-pick ^master topic

So the order of the arguments specified on the command-line is
irrelevant in these cases.  However, there are cases where it is worth
paying attention to the order.  For instance:

  $ git cherry-pick commit3 commit1 commit2

picks commits after sorting by date order, which is counter-intuitive.
Add a failing test to t3508 (cherry-pick-many-commits) documenting
this behavior.

Reported-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Irrespective of how far we get with the '--literal-order' idea, I
 think this quirk is worth documenting.

 t/t3508-cherry-pick-many-commits.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-=
many-commits.sh
index 8e09fd0..dd65835 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -59,6 +59,31 @@ test_expect_success 'cherry-pick first..fourth works=
' '
 	check_head_differs_from fourth
 '
=20
+test_expect_failure 'cherry-pick picks commits in the right order' '
+	cat <<-\EOF >expected &&
+	[master OBJID] fourth
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	[master OBJID] second
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	[master OBJID] third
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	EOF
+
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick fourth second third >actual &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+
+	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
+	test_cmp expected actual.fuzzy &&
+	check_head_differs_from second
+'
+
 test_expect_success 'cherry-pick --strategy resolve first..fourth work=
s' '
 	cat <<-\EOF >expected &&
 	Trying simple merge.
--=20
1.7.8.2

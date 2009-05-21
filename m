From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v0 2/3] t/t3400-rebase.sh: add more tests to help migrating git-rebase.sh to C
Date: Thu, 21 May 2009 19:47:08 +1000
Message-ID: <1242899229-27603-2-git-send-email-pclouds@gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 11:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74sR-0007AZ-TR
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZEUJrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 05:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbZEUJrf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:47:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:42358 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbZEUJre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 05:47:34 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1602689rvb.5
        for <git@vger.kernel.org>; Thu, 21 May 2009 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=I6h2nbZr4jQu2sGxJbd1Dkib7DKlI7DytU7DPh1JOeg=;
        b=FPbYN4+h9Eli+vVnSP5i8XcmBS0j/JNP9A77kjjH7GlHHHKWrylVhO4GtGlMuHAcDj
         my1djRRi/ggvC1QaU+DbWsps3Tdoq4kYIUJTBbUEmLYura6IOcGyedNY/9r0E/lluWu8
         p9qrtctw/woJ/uu/+CqlnuuEXSB9iEaus4C+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iullXLSZKT7FR4R8P3tdi4Sf77aWqVjM6eHfO5PQB8dOksX09jMR+5M6nd2H5il4ow
         3WvXmGfIf0jnmtRYJEYSwo/MRz1sZOiq6gBXgYgquAICjc6Al8gKuHgaMCqqH8sjMXdz
         FeXvfXSqJPFg4xCUhr/wrkW+Nm6VEQ0AjeypE=
Received: by 10.140.247.13 with SMTP id u13mr1039603rvh.288.1242899256318;
        Thu, 21 May 2009 02:47:36 -0700 (PDT)
Received: from dektop ([121.91.24.237])
        by mx.google.com with ESMTPS id g22sm6446518rvb.16.2009.05.21.02.47.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 02:47:35 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 21 May 2009 19:47:24 +1000
X-Mailer: git-send-email test
In-Reply-To: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119667>

These new tests make sure I don't miss any check being performed before
rebase is proceeded (which is well tested by other tests)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3400-rebase.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6e391a3..37f86ab 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -41,9 +41,37 @@ test_expect_success \
      git tag topic
 '
=20
+test_expect_success 'rebase on dirty worktree' '
+     echo dirty >> A &&
+     ! git rebase master'
+
+test_expect_success 'rebase on dirty cache' '
+     git add  A &&
+     ! git rebase master'
+
 test_expect_success 'rebase against master' '
+     git reset HEAD &&
+     git checkout -f &&
      git rebase master'
=20
+test_expect_success 'rebase against master twice' '
+	git rebase master 2>&1|grep "Current branch my-topic-branch is up to =
date\\."
+'
+
+test_expect_success 'rebase against master twice with --force' '
+	git rebase --force-rebase master 2>&1|grep "Current branch my-topic-b=
ranch is up to date, rebase forced"
+'
+
+test_expect_success 'rebase against master twice from another branch' =
'
+	git checkout my-topic-branch^ &&
+	git rebase master my-topic-branch 2>&1|grep "Current branch my-topic-=
branch is up to date\\."
+'
+
+test_expect_success 'rebase fast-forward to master' '
+	git checkout my-topic-branch^ &&
+	git rebase my-topic-branch 2>&1|grep "Fast-forwarded HEAD to my-topic=
-branch"
+'
+
 test_expect_success \
     'the rebase operation should not have destroyed author information=
' \
     '! (git log | grep "Author:" | grep "<>")'
--=20
test

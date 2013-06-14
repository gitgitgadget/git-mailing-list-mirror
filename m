From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 13:17:37 +0530
Message-ID: <1371196058-23948-2-git-send-email-artagnon@gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 09:46:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnOht-0004O6-A4
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 09:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab3FNHpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 03:45:51 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62423 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3FNHpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 03:45:49 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so317299pbc.29
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bI7oAVbNkTEbNeL2UNwVlIUT+U7D4icj0xBVe6gSWHc=;
        b=fvvgqmsJbpV96aMqwEhqEUbgguqPTKvQlboWfRupk+jBBt4wicKAdw8cEpiHwD07e8
         idtmp/vb08AiwxjFOXaZw8Nb237vZGjPqDWLJH85f4JxRbintDy7NalvZ7e/Xyv5Pc4c
         E1rVGXjZYQlCxHFVhgiXi+f7OrYDiyieVOeF2G1n4o3kr2sq/0ELJ7Jc/Ozr7Phe30SD
         9mhjWgJ4mjUdmUAi4bLyQGxVEGCEyuuGLinWRosQf0olZhnZd63swV9/6E55FdTxz+oY
         F4Vl08WFWXuDVqEssLFvMd22Ot5PRtDqL8qG1lU6R+NAJFJPtcJWvCXblkEVFF2IoYPx
         qPgA==
X-Received: by 10.66.4.106 with SMTP id j10mr1324270paj.218.1371195948712;
        Fri, 14 Jun 2013 00:45:48 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id fn9sm1413129pab.2.2013.06.14.00.45.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 00:45:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.380.g67e7d64.dirty
In-Reply-To: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227792>

The following bug has been observed:

  $ git am  # no input file
  ^C
  $ git am --abort
  Resolve operation not in progress, we are not resuming.

This happens because the following test fails:

  test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"

and the codepath for an "am in-progress" is not executed.  It falls back
to the codepath that treats this as a "fresh execution".  Before
rr/rebase-autostash, this condition was

  test -d "$dotest"

It would incorrectly execute the "normal" am --abort codepath:

  git read-tree --reset -u HEAD ORIG_HEAD
  git reset ORIG_HEAD

by incorrectly assuming that an am is "in progress" (i.e. ORIG_HEAD
etc. was written during the previous execution).

Notice that

  $ git am
  ^C

executes nothing of significance, is equivalent to

  $ mkdir .git/rebase-apply

Therefore, the correct solution is to treat .git/rebase-apply as a
"stray directory" and remove it on --abort in the fresh-execution
codepath.

While at it, tell the user to run "git am --abort" to get rid of the
stray $dotest directory, if she attempts anything else.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh     | 14 ++++++++++++++
 t/t4150-am.sh |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index 1cf3d1d..37ee18b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -506,6 +506,20 @@ then
 	esac
 	rm -f "$dotest/dirtyindex"
 else
+	# Possible stray $dotest directory
+	if test -d "$dotest"; then
+	case "$skip,$resolved,$abort" in
+		,,t)
+			rm -fr "$dotest"
+			exit 0
+			;;
+		*)
+			die "$(eval_gettext "Stray $dotest directory found.
+Use \"git am --abort\" to remove it.")"
+			;;
+	esac
+	fi
+
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" = "" ||
 		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 12f6b02..6c2cc3e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -363,6 +363,12 @@ test_expect_success 'am --skip works' '
 	test_cmp expected another
 '
 
+test_expect_success 'am --abort removes a stray directory' '
+	mkdir .git/rebase-apply &&
+	git am --abort &&
+	test_path_is_missing .git/rebase-apply
+'
+
 test_expect_success 'am --resolved works' '
 	echo goodbye >expected &&
 	rm -fr .git/rebase-apply &&
-- 
1.8.3.1.380.g67e7d64.dirty

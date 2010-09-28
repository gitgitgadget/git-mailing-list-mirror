From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: do not switch branch during a rebase unless -f is given
Date: Tue, 28 Sep 2010 14:55:02 +1000
Message-ID: <1285649702-24773-1-git-send-email-pclouds@gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 06:55:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0SDm-0005iR-P8
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 06:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab0I1EzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 00:55:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52500 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0I1EzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 00:55:11 -0400
Received: by pzk34 with SMTP id 34so1427107pzk.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 21:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HbB/0O1QpRbqmoSMNrU3+1OzusKMcfXsjt68QtLyDRU=;
        b=a0CS9smgobaqIKFCc1HIhPG8RoHoUMZ59ItX/q2F5lOVAdtFubUSm9lXTkIrYOy3ib
         xkqdSAM48XBWp2KmbZT/2vOuAiEk5yy18TvQBUGf7MKS7tq09UTLx59rpHCUpfKy2MxO
         1AQuupbEzdhS20C2VMsTWXDkHFUCoLuKVyhWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X06580MMQxP2XsVH0CY39OYOZQbzs7JmqPjzDcVn/TnGGKeMf3w2z19PUZMu4JXlOC
         gdGaRpcBsxm/kikedGg3Kz25gQtVzOrXknzgGpaNrIlqOVFWFmyMnudSUzXKlz+JR79E
         NjN6MCEwbnXt14uvvBNmb6XNsR/+dkMEmMHGQ=
Received: by 10.114.131.2 with SMTP id e2mr9716641wad.158.1285649710650;
        Mon, 27 Sep 2010 21:55:10 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s5sm11786845wak.0.2010.09.27.21.55.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 21:55:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 28 Sep 2010 14:55:03 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157386>

It does not make much sense to switch branch when you are in a middle
of a rebase. Sometimes you might want to switch away for a moment then
back with "git checkout - ". But I find myself so many times switching
away then forget that I was rebasing something.

Avoid doing that by default. Users can use -f if they really want to.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Sorry, the previous patch had wrong subject line

 I know there are other commands like rebase ("git am" comes to mind)
 but I don't use those. Feel free to put some more on top if somebody
 finds it a good thing to do.

 builtin/checkout.c         |    7 +++++++
 t/t2018-checkout-branch.sh |   22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cc622c0..7d8ba04 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -571,6 +571,13 @@ static int switch_branches(struct checkout_opts *o=
pts, struct branch_info *new)
 	struct branch_info old;
 	unsigned char rev[20];
 	int flag;
+	struct stat st;
+
+	if (!opts->force &&
+	    ((!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode)) ||
+	     (!stat(git_path("rebase-apply"), &st) && S_ISDIR(st.st_mode))))
+		die("You should not switch branch during a rebase. Use '-f' if you r=
eally want to.");
+
 	memset(&old, 0, sizeof(old));
 	old.path =3D resolve_ref("HEAD", rev, 0, &flag);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index fa69016..95a1da8 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -169,4 +169,26 @@ test_expect_success 'checkout -f -B to an existing=
 branch with mergeable changes
 	test_must_fail test_dirty_mergeable
 '
=20
+test_expect_success 'checkout fails during rebase' '
+	git reset --hard &&
+	git checkout branch1 &&
+	mkdir .git/rebase-merge &&
+	test_must_fail git checkout branch2 &&
+	git checkout -f branch2
+'
+
+test_expect_success 'checkout fails during rebase (2)' '
+	rmdir .git/rebase-merge &&
+	git reset --hard &&
+	git checkout branch1 &&
+	mkdir .git/rebase-apply &&
+	test_must_fail git checkout branch2 &&
+	git checkout -f branch2
+'
+
+# this is to be incorporated to the next test
+test_expect_success 'cleanup' '
+	rmdir .git/rebase-apply
+'
+
 test_done
--=20
1.7.1.rc1.70.g788ca

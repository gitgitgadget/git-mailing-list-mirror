From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] apply: make sure check_preimage() does not leave empty file on error
Date: Sat, 22 Aug 2015 08:08:07 +0700
Message-ID: <1440205700-19749-5-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:09:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxIq-0004ul-JJ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbbHVBI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:08:56 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34340 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbHVBIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:08:55 -0400
Received: by padfo6 with SMTP id fo6so17790017pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YTEvQbUhlrw+UTfnsniOxDaQgvPi42zQQObTKMvwLqE=;
        b=eP7l0cnYyYTZsfzc1wiFc2ccqcpNGNoSeY1j7awmc+9kR3I4ZYgLVVR001poDhSuWK
         5J1PvjV3Eyqg0MaTsatzHDV+LoZn/uSlgO5IPQoNldmI6miwDbOzctxvbhkTHY1xBhsv
         YkOY5npKt0kUbuDlp4arzSCs1g/l44GAjrB4gLkm6WHwpBRJ1eo7vuXl/ybeuFQGjKiC
         eyFrleUmclpvS0wUCQwkdbQ26Zu45938ANymrH9p4lYJYSx/3U80gVSYepodML1X6TBW
         LXoDVyCXQcmTff5JYMS3WaQxaZhktQDpZ3NwM/iEN1ASvsItlBubwsdEi1JAykuEXNR3
         UHYA==
X-Received: by 10.66.185.72 with SMTP id fa8mr22745354pac.44.1440205734926;
        Fri, 21 Aug 2015 18:08:54 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id fm5sm9117685pbb.60.2015.08.21.18.08.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:08:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:08:51 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276356>

The test case probably describes the test scenario the best. We have a
patch to modify some file but the base file is gone. Because
check_preimage() finds an index entry with the same old_name, it tries
to restore the on-disk base file with cached content with
checkout_target() and move on.

If this old_name is i-t-a, before this patch "apply -3" will call
checkout_target() which will write an empty file (i-t-a entries always
have "empty blob" SHA-1), then it'll fail at verify_index_match()
(i-t-a entries are always "modified") and the operation is aborted.

This empty file should not be created. Compare to the case where
old_name does not exist in index, "apply -3" fails with a different
error message "...: does not exist" but it does not touch
worktree. This patch makes sure the same happens to i-t-a entries.

load_current() shares the same code pattern (look up an index entry,
if on-disk version is not found, restore using the cached
version). Fix it too (even though it's not exercised in any test case)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c       |  4 ++--
 t/t2203-add-intent.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 76b58a1..b185c97 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3348,7 +3348,7 @@ static int load_current(struct image *image, stru=
ct patch *patch)
 		die("BUG: patch to %s is not a creation", patch->old_name);
=20
 	pos =3D cache_name_pos(name, strlen(name));
-	if (pos < 0)
+	if (pos < 0 || ce_intent_to_add(active_cache[pos]))
 		return error(_("%s: does not exist in index"), name);
 	ce =3D active_cache[pos];
 	if (lstat(name, &st)) {
@@ -3501,7 +3501,7 @@ static int check_preimage(struct patch *patch, st=
ruct cache_entry **ce, struct s
=20
 	if (check_index && !previous) {
 		int pos =3D cache_name_pos(old_name, strlen(old_name));
-		if (pos < 0) {
+		if (pos < 0 || ce_intent_to_add(active_cache[pos])) {
 			if (patch->is_new < 0)
 				goto is_new;
 			return error(_("%s: does not exist in index"), old_name);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index bb5ef2b..96c8755 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -95,5 +95,21 @@ test_expect_success 'apply adds new file on i-t-a en=
try' '
 	)
 '
=20
+test_expect_success 'apply:check_preimage() not creating empty file' '
+	git init check-preimage &&
+	(
+		cd check-preimage &&
+		echo oldcontent >newfile &&
+		git add newfile &&
+		echo newcontent >newfile &&
+		git diff >patch &&
+		rm .git/index &&
+		git add -N newfile &&
+		rm newfile &&
+		test_must_fail git apply -3 patch &&
+		! test -f newfile
+	)
+'
+
 test_done
=20
--=20
2.3.0.rc1.137.g477eb31

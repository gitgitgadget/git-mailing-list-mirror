From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Tue, 17 Apr 2012 20:25:18 +0200
Message-ID: <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKD6T-0001Mt-56
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab2DQS0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 14:26:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53400 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab2DQS0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:26:05 -0400
Received: by wejx9 with SMTP id x9so4218443wej.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rCVeFaO0pwXHVICQI5fyeO/gdpH9NbSp7Gecb+bIheo=;
        b=ii1WpazjjpAiTFUe6RW6aGAJSUbwJ4x3bfNKwntJeRp1GawaHEr7cMCv1Wg+8M3kIq
         aXioQjjXL82/OyK090SoQJZtbhAzeMimBkQBihQmpw1peIL2il8h4nWCmd5yXG/5CjN6
         20eYibKldp5MnjJLfIWUn5E8OptrUZ/is9JyRnswjHVSmbMqAO4/o1T7GPwWqJ6SOxDu
         anX1AMykHeLngqoi/omflPX03mvnvQzwl0LXk8/ucZs7V7tOJlaA2Ca+jyVUisoAA/d9
         5CQWfu0R1vRZiaEBl+u/9zz5rl7QF/73uszDQ5p1qV6HgqY7feUWhXH3L/xaZW/aqwBU
         r6JA==
Received: by 10.216.135.206 with SMTP id u56mr10119952wei.29.1334687164044;
        Tue, 17 Apr 2012 11:26:04 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id fl2sm45891620wib.2.2012.04.17.11.26.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 11:26:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195787>

This makes us do proper fast-forward merges even for octopus merges,
which could otherwise result in "merge commit" that only had one actual
parent, and should have been a fast-forward.

Odd-case-triggered-by: James Morris <jmorris@namei.org>
Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

This is the proposed fix sent as a proper patch with commit message
stolen from Linus and testcases.

I'm not sure if I don't introduce a memleak with the call to
reduce_heads() but other callers seem to not care, just like whole
cmd_merge().

 builtin/merge.c               |    3 +++
 t/t7603-merge-reduce-heads.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 08e01e8..2d5930f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1346,6 +1346,9 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			allow_trivial =3D 0;
 	}
=20
+	if (remoteheads->next)
+		remoteheads =3D reduce_heads(remoteheads);
+
 	if (!remoteheads->next)
 		common =3D get_merge_bases(head_commit, remoteheads->item, 1);
 	else {
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads=
=2Esh
index 7e17eb4..a3b08a6 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -113,4 +113,23 @@ test_expect_success 'verify merge result' '
 	test $(git rev-parse HEAD^1) =3D $(git rev-parse E2) &&
 	test $(git rev-parse HEAD^2) =3D $(git rev-parse I2)
 '
+
+test_expect_success 'fast-forward to redundant refs' '
+	git reset --hard c0 &&
+	git merge c4 c5
+'
+
+test_expect_success 'verify merge result' '
+	test $(git rev-parse HEAD) =3D $(git rev-parse c5)
+'
+
+test_expect_success 'merge up-to-date redundant refs' '
+	git reset --hard c5 &&
+	git merge c0 c4
+'
+
+test_expect_success 'verify merge result' '
+	test $(git rev-parse HEAD) =3D $(git rev-parse c5)
+'
+
 test_done
--=20
1.7.8.4

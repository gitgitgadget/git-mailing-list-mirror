From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/2] t7810: correct --no-index test
Date: Mon, 11 Jan 2016 22:26:19 +0100
Message-ID: <1452547580-30687-2-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 22:26:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjyv-0004GP-9j
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349AbcAKV0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:26:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34869 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933101AbcAKV0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:26:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id f206so28129668wmf.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1rMm22CxnVCI+CG976JPCSdAVmDpXNrZuhFLAg4Ylk=;
        b=BxHJSUdCQT8iMYApPFMeXbFCZ/EKBwVHr7egx4z79VlXt9qQRZiUbS4F1uageuUNye
         VI3U9YKlMZVMMJIFAXJTDv4CNV5gzKwbZuC8fSzOQQlT2vf2RtY0nAlaJ5fOMN96kMNa
         AgRcRr2hIBbIM031nT8z2cm4s3Ni6dQjOBCMLzFKfl2XGOv4iW2u2Km0z/ROYZkkYxu7
         gGIFHvcSRyJpkQC5XKdQ/7yaVjRHU9LH6zrA1zbzPF8PIzWrRKPTeH/ODp4NhIZat9+b
         EcyedLvLCvqSMULxWNOqRuNT5WO/5UlxFOptSmNNb0K47NOKX5qEBP3IIBDonMe4Bhho
         Zpig==
X-Received: by 10.194.176.170 with SMTP id cj10mr124650548wjc.165.1452547581238;
        Mon, 11 Jan 2016 13:26:21 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id u12sm14469826wmu.10.2016.01.11.13.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 13:26:20 -0800 (PST)
X-Mailer: git-send-email 2.7.0.2.gafd9bce.dirty
In-Reply-To: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283723>

GIT_CEILING_DIRECTORIES doesn't prevent chdir up into another directory
while looking for a repository directory if it is equal to the current
directory.  Because of this, the test which claims to test the git grep
--no-index command outside of a repository actually tests it inside of a
repository.  The test_must_fail assertions still pass because the git
grep only looks at untracked files and therefore no file matches, but
not because it's run outside of a repository as it was originally
intended.

Set the GIT_CEILING_DIRECTORIES environment variable to the parent
directory of the directory in which the git grep command is executed, to
make sure it is actually run outside of a git repository.

In addition, the && chain was broken in a couple of places in the same
test, fix that.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t7810-grep.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 028ffe4..cc4b97d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -791,12 +791,12 @@ test_expect_success 'outside of git repository' '
 	} >non/expect.full &&
 	echo file2:world >non/expect.sub &&
 	(
-		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git grep o &&
 		git grep --no-index o >../actual.full &&
-		test_cmp ../expect.full ../actual.full
+		test_cmp ../expect.full ../actual.full &&
 		cd sub &&
 		test_must_fail git grep o &&
 		git grep --no-index o >../../actual.sub &&
@@ -805,7 +805,7 @@ test_expect_success 'outside of git repository' '
 
 	echo ".*o*" >non/git/.gitignore &&
 	(
-		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git grep o &&
@@ -813,7 +813,7 @@ test_expect_success 'outside of git repository' '
 		test_cmp ../expect.full ../actual.full &&
 
 		{
-			echo ".gitignore:.*o*"
+			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
 		git grep --no-index --no-exclude o >../actual.full &&
-- 
2.7.0.2.gafd9bce.dirty

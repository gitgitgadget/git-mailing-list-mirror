From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 1/2] t7810: correct --no-index test
Date: Tue, 12 Jan 2016 11:40:25 +0100
Message-ID: <1452595226-14616-2-git-send-email-t.gummerer@gmail.com>
References: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
 <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 11:40:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIwNS-0004zj-6X
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 11:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762075AbcALKkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 05:40:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36781 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934737AbcALKkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 05:40:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so30567600wmf.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 02:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kllx2cLWFLEnryInpuF1sL8uJJ2yyr0qqTV7WGUTD7Y=;
        b=XfXLDd3Vk8jIRGztKhjgrKFE8YHab+lGLF2bCogWxxeIP4Rr5+oqvVljUxX5z5rFQl
         UyU0Ame42SrwHpX+ruT0uYFCzVKCSPGRD7huDh8BkROTllIsNiu9VtYKRX6e2q+IjaDM
         8zPROWRnwZqMGzkeyvX64Oyv5crxq0EzSQ0vwLVIv+b5902Xc5fl2I3slU2WJ278Ijn5
         iQ0RoQMGYd4z3f4kYXRgnXZWqVN19f9DpIZVhIlhhbNSviWx8N/dAGV48ZNvZQWZHXke
         teruuE0Db6JkDeTx8RsKbc1nk7JPtaSHfAyXS3rmsSFrYzTlBN+tSvaiV6wGxSBKCCg9
         KaEA==
X-Received: by 10.28.224.134 with SMTP id x128mr20208196wmg.62.1452595204083;
        Tue, 12 Jan 2016 02:40:04 -0800 (PST)
Received: from localhost (host214-63-dynamic.48-82-r.retail.telecomitalia.it. [82.48.63.214])
        by smtp.gmail.com with ESMTPSA id 79sm16995258wmo.7.2016.01.12.02.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 02:40:03 -0800 (PST)
X-Mailer: git-send-email 2.7.0.2.gcdcca30.dirty
In-Reply-To: <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283788>

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
2.7.0.2.gcdcca30.dirty

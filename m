From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Tue, 27 Oct 2015 14:24:48 -0700
Message-ID: <1445981088-6285-1-git-send-email-davvid@gmail.com>
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:26:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBkt-0004ZJ-26
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbbJ0VZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 17:25:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35006 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbbJ0VZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:25:06 -0400
Received: by pasz6 with SMTP id z6so233329652pas.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YaoDKefNSovfdScBtXsrZqA8k14VpWOsvkBLVQlruK0=;
        b=hvUe8RkyIo8L44GsgznxY0Uf96YXty9HJGL9Gncy/uaRxL2PS9xKhnsQ+pzRxIs4i7
         gYpA0jHLQldirjXAlj0oVs1NIzTdZqCzLCeQapVz/oVT51d8cJMEUzFbK/kJWfLTowL5
         hsWuyejOboim4ZJnTtSl0L4KA44sVSlT/sq3H3pX9KK0JUSAAjvq7rfcNLFqwW9uxaWl
         w2AIJJQeRYvbOTHEnN0LdmKpNGeiCbYDf4BZ/XZxDfZ3ib0vmRug4bz3viDUsm1ikApd
         GevIULDb1Ow8eaDlsN41zX1sbhvHSfr6jL3UYuQs4zORG0LV8aHCDmvoe/LNLiGWYDEE
         s5Qg==
X-Received: by 10.66.218.230 with SMTP id pj6mr30406891pac.104.1445981106025;
        Tue, 27 Oct 2015 14:25:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-45-48-246-9.socal.res.rr.com. [45.48.246.9])
        by smtp.gmail.com with ESMTPSA id ss6sm41330272pbc.74.2015.10.27.14.24.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 14:25:05 -0700 (PDT)
X-Mailer: git-send-email 2.6.2.282.gfefd36e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280300>

difftool's dir-diff should never reuse a symlink, regardless of
what it points to.  Tighten use_wt_file() so that it rejects all
symlinks.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 1abe647..873db57 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -70,13 +70,13 @@ sub use_wt_file
 	my ($repo, $workdir, $file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if (! -f "$workdir/$file") {
-		return (0, $null_sha1);
+	my $workfile = "$workdir/$file";
+	if (-f $workfile && ! -l $workfile) {
+		my $wt_sha1 = $repo->command_oneline('hash-object', $workfile);
+		my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
+		return ($use, $wt_sha1);
 	}
-
-	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
-	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
-	return ($use, $wt_sha1);
+	return (0, $null_sha1);
 }
 
 sub changed_files
-- 
2.6.2.282.gfefd36e

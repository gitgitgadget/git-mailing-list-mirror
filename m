From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: [PATCH] Test case for a problem with git add -u from subdirectory
Date: Wed, 20 Feb 2008 16:32:15 +0200
Message-ID: <20080220143215.GA23053@localdomain>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 20 15:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRq0Z-0005Iz-WD
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 15:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYBTOcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 09:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbYBTOcj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 09:32:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:64627 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYBTOci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 09:32:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so749803ugc.16
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 06:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        bh=OPVAeUIlgCaWf+QCNTaujPCi8AdL+t1elM5dSOP6ggo=;
        b=xtyrzrvX3OaFhtplk6gKqLuYv5qfQ+7kAstzhBgKxvMdxUqkeSUxDPPD2x3VQ3ySUViiH4n23RYFi7T8As1Sxm8fmmRlBWmDQa5bHlXl6zfRyaqQF4kQfMq0sYEwXFqHly0+pDGFJqPYTQmeavmtnv2AW1b2BtZCv5/yP9WyTV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=TkrPMutmtsngnKJnEju3vFP/U7n+mxrHiw3pvgHC8o7xCxuxnVFFQrp8QERV0FTb2k+iV0Gb6GP/D/V+KMjlNnolBqUVaQSUTvNO222/7BhJynTWFBxpO7pIMZq6NH6X0W+kYLsLPUoY+3IHyg42Ho7jYxcFZr3MXKumKsuyCh4=
Received: by 10.66.237.9 with SMTP id k9mr3802296ugh.13.1203517956575;
        Wed, 20 Feb 2008 06:32:36 -0800 (PST)
Received: from shadow ( [128.214.182.234])
        by mx.google.com with ESMTPS id j1sm9180355ugf.74.2008.02.20.06.32.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 06:32:35 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74515>

Manual page for "git-add -u" says:
Update only files that git already knows about. This is similar to
what "git commit -a" does in preparation for making a commit, except
that the update is limited to paths specified on the command line. If
no paths are specified, all tracked files are updated.

The key sentence being: "If no paths are specified, all tracked files
are updated." If one modifies a file in subdir1, then goes to subdir2
and performs "git add -u" the modified file in subdir1 is not added to
the index. This test case demonstrates the problem.

Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
---

I found a possible problem in "git add -u" command without any
paths. Modified files located in a different subdirectory are not
added to the index even though the documentation says that in this
case all tracked files should be. Maybe this is caused by a bug in
"git add"? Or is the problem in the documentation?

In any case, this patch contains a test case that demonstrates the
problem.

 t/t2200-add-update.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 24f892f..5815ec5 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,6 +80,22 @@ test_expect_success 'change gets noticed' '
 
 '
 
+test_expect_success 'update from a different subdirectory' '
+	(
+		cd dir1 &&
+		echo addmore >sub2 &&
+                cd ../dir2 &&
+                git add -u
+	)
+
+'
+
+test_expect_success 'change gets noticed' '
+
+	test "$(git diff-files --name-status dir1)" = ""
+
+'
+
 test_expect_success 'replace a file with a symlink' '
 
 	rm foo &&
-- 
1.5.4.2

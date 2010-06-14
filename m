From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] revert: accept arbitrary rev-list options
Date: Mon, 14 Jun 2010 00:29:38 -0500
Message-ID: <20100614052938.GB1737@burratino>
References: <20100614032251.20121.83253.chriscool@tuxfamily.org>
 <20100614052027.GA1509@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:29:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2F9-0006WQ-CC
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab0FNF3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:29:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56134 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0FNF3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:29:50 -0400
Received: by iwn9 with SMTP id 9so2913142iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fu2sGPF84Uk4+iBPl8pHfC59D5vw+4kCXKbVn8efTfk=;
        b=KniIKvCBTUeZ0y0sDFe6l3TrwEnyUuq6Dhtj+smHRL4K7beyGUresUB4xr8FRIlZA9
         FH+Tavg54hW5FB1XGnEypVYaCUeCbQN5r/2szdmQkSfggHA7btGh9fxJW7dqFmHVqrFn
         RcWQT7DJcdxWI1K0Eq/ZbVEKNc/gaYR/ewkfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qds6W/AGA8UMLqnLdzig1mjqJnowGDBEWfuRAkFmwa/PqqR2zRr2AeC6Cr6BxrTBuJ
         Y7BtagR6DV1S4drzCesTZI9QNqEO8BHvN2JavpsGJEHTasEidXJnWxuemEtzxmAGfKkI
         PIK0XoHc53BgJAKNFbqS3m+369qvooG/D3ftQ=
Received: by 10.231.207.225 with SMTP id fz33mr4946781ibb.173.1276493389578;
        Sun, 13 Jun 2010 22:29:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm18965175ibf.19.2010.06.13.22.29.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 22:29:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100614052027.GA1509@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149071>

From: Christian Couder <chriscool@tuxfamily.org>

This can be useful to do something like:

git rev-list --reverse master -- README | git cherry-pick -n --stdin

without using xargs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt   |    7 +++++++
 builtin/revert.c                    |    3 ++-
 t/t3508-cherry-pick-many-commits.sh |   10 ++++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bcb4c75..f047739 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -113,6 +113,13 @@ git cherry-pick --ff ..next::
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
+git rev-list --reverse master -- README | git cherry-pick -n --stdin::
+
+	Apply the changes introduced by all commits on the master
+	branch that touched README to the working tree and index,
+	so the result can be inspected and made into a single new
+	commit if suitable.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e4..67e191b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -78,7 +78,8 @@ static void parse_args(int argc, const char **argv)
 			die("program error");
 	}
 
-	commit_argc = parse_options(argc, argv, NULL, options, usage_str, 0);
+	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
+	                            PARSE_OPT_KEEP_UNKNOWN);
 	if (commit_argc < 1)
 		usage_with_options(usage_str, options);
 
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 26a8730..93d7189 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -92,4 +92,14 @@ test_expect_failure 'cherry-pick -3 fourth works' '
 	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
 '
 
+test_expect_success 'cherry-pick --stdin works' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify fourth)"
+'
+
 test_done
-- 
1.7.1.246.g398e5.dirty

From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [BUG] t9151: Unreliable test/test setup
Date: Thu, 6 Feb 2014 00:46:21 +0100
Message-ID: <20140205234621.GA4777@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: amyrick@apple.com, tuomas.suutari@gmail.com, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 00:46:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBCAq-0004Zy-ED
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 00:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaBEXq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 18:46:28 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:56116 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaBEXq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 18:46:27 -0500
Received: by mail-la0-f48.google.com with SMTP id mc6so900319lab.35
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=W3ipNVgpuWHdQ63pHONl4BUtGaSLzK454JaDNb5W5A0=;
        b=roRA/McxK7C0rXgbdt9njzcmMgVXy1tX6gNWmLVddlrx4wBTevalJ+sNZh4oGIgQ3f
         ZeAaGzOVHtkuGPRWT162EAYzpXYqIF+2tW+6pCmF9Ko84hla2vUNU0skbH1UPLpXzZnS
         EyMucXfR2prXdBuBQo6+ZKkrLzgiAYdUvOL1faHqppBxOXTJZmKjSKi8MZfvsJXLt3kk
         XdzrI0WyQ90VO5RLoh958USH3zb6XAFko+9uSZtnzxHqhyKOj+XQAfJUvRX61aKJ2BEn
         Nzyro+9Iq3y/yOaLUQY/ylETQghpkPsg+Wg173hV5trOlnji7WDmOIMBgEoTp1yUnz9f
         aJ1Q==
X-Received: by 10.112.189.68 with SMTP id gg4mr2810309lbc.18.1391643986470;
        Wed, 05 Feb 2014 15:46:26 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id t5sm43014970lat.6.2014.02.05.15.46.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Feb 2014 15:46:25 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241677>

Hi,

It appears that the last test in t9151-svn-mergeinfo.sh:

	test_expect_failure 'everything got merged in the end' '
		unmerged=$(git rev-list --all --not master) &&
		[ -z "$unmerged" ]
		'

reports "known breakage" or "breakage vanished" seemingly at random:

	$ while true; do (cd t && sh t9151-svn-mergeinfo.sh | \
		grep -q vanished && printf "f" || printf "b"); done
	bbbffffbbffbffbbbffbfffbbbffffffffbffbbbfbbffffffbbfbfff

I would guess that it might not be the test itself that is unreliable,
but rather the svn setup done prior, looking at test logs:

	(cd t && mkdir -p logs; i=0; \
	while true; do sh t9151-svn-mergeinfo.sh --verbose 2>&1 | tee logs/cur \
	| grep -q vanished && \
		(printf "f" && mv logs/cur logs/fixed-"$i") || \
		(printf "b" && mv logs/cur logs/broken-"$i"); \
	i=$((i+1)); done)
	bbffbff

the only consistent difference between broken and fixed seems to be in
the svn setup stage and more specifically the bit below, with r44
becoming different SHA1s in "broken" and "fixed" imports:

--- broken-0    2014-02-05 23:40:21.412967698 +0100
+++ fixed-2     2014-02-05 23:40:44.441536583 +0100
(...)
@@ -176,12 +176,12 @@
        M       subdir/palindromes
 r43 = a671eec900764a4ab85a6166def3e0d30f1a2664 (refs/remotes/bugfix)
        M       subdir/palindromes
-Couldn't find revmap for file:///home/arand/utv/git/git/t/trash%20directory.t9151-svn-mergeinfo/svnrepo/branches/bugfix/subdir
-Couldn't find revmap for file:///home/arand/utv/git/git/t/trash%20directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0/subdir
-W: Cannot find common ancestor between 90411e1b2118e11664e368a24a1eaa5e8749d150 and fdb537791ee8ba532e49c3d5a34a30feeb87bd59. Ignoring merge info.
 Couldn't find revmap for file:///home/arand/utv/git/git/t/trash%20directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0
 Found merge parent (svn:mergeinfo prop): a671eec900764a4ab85a6166def3e0d30f1a2664
-r44 = a110dec28a4b152b394906b1303fbf19174f7d26 (refs/remotes/trunk)
+Couldn't find revmap for file:///home/arand/utv/git/git/t/trash%20directory.t9151-svn-mergeinfo/svnrepo/branches/bugfix/subdir
+Couldn't find revmap for file:///home/arand/utv/git/git/t/trash%20directory.t9151-svn-mergeinfo/svnrepo/tags/v1.0/subdir
+Found merge parent (svn:mergeinfo prop): fdb537791ee8ba532e49c3d5a34a30feeb87bd59
+r44 = 8b619659a5126105c0a9765b655b6a1add9db4c1 (refs/remotes/trunk)
 Checked out HEAD:
   file:///home/arand/utv/git/git/t/trash%20directory.t9151-svn-mergeinfo/svnrepo/trunk r44
 ok 1 - load svn dump

Does anyone who is more familiar with the test know what's going on
here? Is there any way to fix it, or should the test maybe be disabled
completely for the time being?

--
Martin Erik Werner <martinerikwerner@gmail.com>

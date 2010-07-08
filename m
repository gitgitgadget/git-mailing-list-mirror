From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t9118 (git-svn): prevent early failure from taking down
 later tests
Date: Thu, 8 Jul 2010 08:36:02 -0500
Message-ID: <20100708133602.GA1882@burratino>
References: <4C352EB5.5020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Torsten Schmutzler <git-ts@theblacksun.eu>,
	Eric Wong <normalperson@yhbt.net>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 15:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWrHg-0004vv-VW
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 15:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757Ab0GHNgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 09:36:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46391 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab0GHNgq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 09:36:46 -0400
Received: by iwn7 with SMTP id 7so889880iwn.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V7gcBraHN+RdNyIMDji0oC2DO6YGF6VkbggFUH09ibQ=;
        b=XtYnuxAOnQPazU4pJHGYEY6aZreT4QOB8LTVW1fpO6JNoRAH9HpMkhqm8kiV0wTw63
         zGSz53M0LDfEfrympkjqoFM1mGX+V5eu+1gwgdHZ4doidg4nLaJqlgtPTl7B4Dt9KHv0
         vS7RoHE7xR1Ldel1/KvjLT+/xQ95UAF+eQtuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qsXox88dBUFFP6NklR95ukVKBBQXdRgyoyiT9uxERNXLEO9RFyiFTaKHEZfs13OyLT
         jTQLmtQmUUzoh+fVdIFM5RZyFqZ25yQh7d08iJoOU11TUnOsdydN9fFNneeHXvbP5c4A
         YgAZRNTk/uclKfaBykeYaevbDbBIqSJagB/j4=
Received: by 10.42.6.195 with SMTP id b3mr2644157icb.14.1278596206354;
        Thu, 08 Jul 2010 06:36:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm34144915ibk.15.2010.07.08.06.36.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 06:36:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C352EB5.5020005@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150574>

When test #2 fails, the cwd is project/, causing all the
remaining tests in the same script to get confused and fail.

So in the spirit of v1.7.1.1~53^2~10 (t5550-http-fetch: Use subshell
for repository operations, 2010-04-17), use a subshell for svn
working copy operations.  This way, the cwd will reliably return
to the top of the trash directory and later tests can still be run
when a command has failed.

Reported-by: A Large Angry SCM <gitzilla@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
A Large Angry SCM wrote:

> *** t9118-git-svn-funky-branch-names.sh ***
> ok 1 - setup svnrepo
> not ok - 2 test clone with funky branch names

Relates to an svn change from some point between 1.5.1 and 1.6.12.
Not solved yet.  See
<http://thread.gmane.org/gmane.comp.version-control.git/146498/focus=150549>.

> not ok - 3 test dcommit to funky branch
> not ok - 4 test dcommit to scary branch
> not ok - 5 test dcommit to trailing_dotlock branch

Collateral damage.  How about this patch?

 t/t9118-git-svn-funky-branch-names.sh |   46 ++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 7d7acc3..5dbea59 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -34,42 +34,46 @@ test_expect_success 'setup svnrepo' '
 
 test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
-	cd project &&
+	(
+		cd project &&
 		git rev-parse "refs/remotes/fun%20plugin" &&
 		git rev-parse "refs/remotes/more%20fun%20plugin!" &&
 		git rev-parse "refs/remotes/$scary_ref" &&
 		git rev-parse "refs/remotes/%2Eleading_dot" &&
 		git rev-parse "refs/remotes/trailing_dot%2E" &&
 		git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
-		git rev-parse "refs/remotes/not-a%40{0}reflog" &&
-	cd ..
+		git rev-parse "refs/remotes/not-a%40{0}reflog"
+	)
 	'
 
 test_expect_success 'test dcommit to funky branch' "
-	cd project &&
-	git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
-	echo hello >> foo &&
-	git commit -m 'hello' -- foo &&
-	git svn dcommit &&
-	cd ..
+	(
+		cd project &&
+		git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
+		echo hello >> foo &&
+		git commit -m 'hello' -- foo &&
+		git svn dcommit
+	)
 	"
 
 test_expect_success 'test dcommit to scary branch' '
-	cd project &&
-	git reset --hard "refs/remotes/$scary_ref" &&
-	echo urls are scary >> foo &&
-	git commit -m "eep" -- foo &&
-	git svn dcommit &&
-	cd ..
+	(
+		cd project &&
+		git reset --hard "refs/remotes/$scary_ref" &&
+		echo urls are scary >> foo &&
+		git commit -m "eep" -- foo &&
+		git svn dcommit
+	)
 	'
 
 test_expect_success 'test dcommit to trailing_dotlock branch' '
-	cd project &&
-	git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
-	echo who names branches like this anyway? >> foo &&
-	git commit -m "bar" -- foo &&
-	git svn dcommit &&
-	cd ..
+	(
+		cd project &&
+		git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
+		echo who names branches like this anyway? >> foo &&
+		git commit -m "bar" -- foo &&
+		git svn dcommit
+	)
 	'
 
 stop_httpd
-- 
1.7.2.rc1.527.gff41c3.dirty

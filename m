From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH v3] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 12:51:40 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807241233190.16518@harper.uchicago.edu>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
 <200807240757.26290.chriscool@tuxfamily.org> <20080724060647.GA24587@glandium.org>
 <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
 <20080724165434.GA26660@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM50W-0005oC-Ku
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbYGXRwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbYGXRwO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:52:14 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:60749 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbYGXRwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:52:13 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6OHphNg020021;
	Thu, 24 Jul 2008 12:51:43 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6OHpex0017295;
	Thu, 24 Jul 2008 12:51:40 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <20080724165434.GA26660@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89923>

t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
status when asked to list nonexistent files.  Unfortunately,
/bin/ls on Mac OS X 10.3 exits with exit code 0.  So use "echo"
instead.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Mike Hommey wrote:

 >>>> +	test -z "$(ls .git/BISECT_*)" &&
 >>> That is still a useless use of ls ;)
 >> It is much better than what I wrote, at least.
 > But could also be written with echo instead of ls.

 How about this?  (The echo is necessary because the argument
 to a case statement does not undergo filename expansion.)

 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0626544..b6841fe 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	test_must_fail git bisect start foo $HASH1 -- &&
 	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
-	test_must_fail ls .git/BISECT_* &&
+	case $(echo .git/BISECT_*) in *\*) ;; *) false ;; esac &&
 	git bisect start &&
 	test_must_fail git bisect good foo $HASH1 &&
 	test_must_fail git bisect good $HASH1 bar &&
-- 
1.5.6.3.549.g8ca11

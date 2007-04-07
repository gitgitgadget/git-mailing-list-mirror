From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t5300-pack-object.sh: portability issue using /usr/bin/stat
Date: Fri, 06 Apr 2007 19:08:02 -0700
Message-ID: <7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net>
References: <20070406234903.GJ3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: arjen@yaph.org (Arjen Laarhoven)
X-From: git-owner@vger.kernel.org Sat Apr 07 04:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha0La-000228-I1
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 04:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbXDGCIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 22:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbXDGCIG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 22:08:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44328 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965028AbXDGCIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 22:08:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407020802.HSKY792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 22:08:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k2821W00A1kojtg0000000; Fri, 06 Apr 2007 22:08:02 -0400
In-Reply-To: <20070406234903.GJ3854@regex.yaph.org> (Arjen Laarhoven's message
	of "Sat, 7 Apr 2007 01:49:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43954>

arjen@yaph.org (Arjen Laarhoven) writes:

> In the test 'compare delta flavors', /usr/bin/stat is used to get file size.
> This isn't portable.  There already is a dependency on Perl, use its '-s'
> operator to get the file size.

If you do use Perl, then you do not want to do it as two
separate invocations with their result compared with test.

How about this on top of your patch?

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a400e7a..5710a23 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -123,11 +123,13 @@ test_expect_success \
      done'
 cd "$TRASH"
 
-test_expect_success \
-    'compare delta flavors' \
-    'size_2=`perl -e "print -s q[test-2-${packname_2}.pack]"` &&
-     size_3=`perl -e "print -s q[test-3-${packname_3}.pack]"` &&
-     test $size_2 -gt $size_3'
+test_expect_success 'compare delta flavors' '
+	perl -e "
+		exit ( ((-s q[test-2-${packname_2}.pack]) >
+			(-s q[test-3-${packname_3}.pack]))
+			? 0 : 1);
+	"
+'
 
 rm -fr .git2
 mkdir .git2

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use testlib to skip t3300-funny-names
Date: Fri, 06 Jan 2006 14:38:03 -0800
Message-ID: <7vvewxq8xg.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050353o6b96ed4fp2a6d24dd514cc9c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0EX-0007m3-05
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWAFWiR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWAFWiQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:38:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36271 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964864AbWAFWiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:38:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223659.TDJR6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:36:59 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14221>

Alex Riesen <raa.lkml@gmail.com> writes:

> The test cannot be run on cygwin anyway.
> Corrected the error message to reflect the problem source.

I'd rather see the test actually try to create a funny-named
testfile and see if it managed to create it, so that it can be
skipped on non DOS systems that mounted DOS filesystem.

So instead I would do something like this:

---
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 6a85d67..b1a86db 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -9,9 +9,6 @@ This test tries pathnames with funny cha
 tree, index, and tree objects.
 '
 
-# since FAT/NTFS does not allow tabs in filenames, skip this test
-test "$(uname -o 2>/dev/null)" = Cygwin && exit 0
-
 . ./test-lib.sh
 
 p0='no-funny'
@@ -27,6 +24,12 @@ EOF
 cat >"$p1" "$p0"
 echo 'Foo Bar Baz' >"$p2"
 
+test -f "$p1" && cmp "$p0" "$p1" || {
+	# since FAT/NTFS does not allow tabs in filenames, skip this test
+	say 'Your filesystem does not allow tabs in filenames, test skipped.'
+	test_done
+}
+
 echo 'just space
 no-funny' >expected
 test_expect_success 'git-ls-files no-funny' \

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -B broken
Date: Sat, 08 Apr 2006 19:51:12 -0700
Message-ID: <7vwtdzcvhb.fsf@assigned-by-dhcp.cox.net>
References: <20060409004605.GU27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 04:51:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSQ1U-0004U1-H9
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 04:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWDICvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 22:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWDICvO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 22:51:14 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58844 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965059AbWDICvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 22:51:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409025113.RTRO15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 22:51:13 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18538>

Petr Baudis <pasky@ucw.cz> writes:

> 	$ git-diff-tree -r -p -B -M 916d8240bfc8ef5b80780b1a32ebb83ed055a178 \
> 		3c9324ea16c345fc0bc0f11041905ba714797e4a cg-mkpatch
> 	diff --git a/cg-mkpatch b/cg-mkpatch
> 	dissimilarity index 57%
> 	index 74fe917..c932bc9 100755
> 	--- cg-mkpatch
> 	+++ cg-mkpatch
> 	@@ -0,0 +0,0 @@
>
> and nothing else. I'm too tired to debug or bisect this (xdiff
> introduction is the obvious suspect, I guess), just didn't want this
> to slip into the looming 1.3.0 so reporting early.

Thanks.

There are two issues.  One of them is addressed with the
attached patch, which is just an artifact of the xdiff
introduction.

Another issue is a bit bigger.

The changes to the sample cg-mkpatch is estimated to be big
enough to get broken, just in case if there is another file
whose postimage that is more similar than the postimage of
cg-mkpatch itself, so that it can be matched up with the other
file, but it is _not_ dissimilar enough that diffcore_break()
code marks it to be merged back together if pieces of the broken
pair do not get matched up with other files.  And in this
particular case, since you are limiting the search space to a
single file, there is no other files to match, so the broken
pair should survive the rename detection match-up, and they
should be shown as a normal diff without dissimilarity index at
all.

The funny thing is, the broken pair are matched up with
themselves, with similarity index of 57% (they originally are
from the same filepair, so that is natural).  So in this case,
rename code _should_ take notice.  I'll work on a fix.

-- >8 --
diff --git a/diff.c b/diff.c
index ce98a90..e887410 100644
--- a/diff.c
+++ b/diff.c
@@ -145,8 +145,9 @@ static void emit_rewrite_diff(const char
 			      struct diff_filespec *one, 
 			      struct diff_filespec *two)
 {
-	/* Use temp[i].name as input, name_a and name_b as labels */
 	int lc_a, lc_b;
+	diff_populate_filespec(one, 0);
+	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
 	printf("--- %s\n+++ %s\n@@ -", name_a, name_b);

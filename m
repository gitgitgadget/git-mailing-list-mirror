From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Fix the processing of multiple patch files with --check in git-apply.
Date: Tue, 06 Sep 2005 17:54:22 -0700
Message-ID: <7vslwhbsu9.fsf@assigned-by-dhcp.cox.net>
References: <1125360111916-git-send-email-robfitz@273k.net>
	<11253601111257-git-send-email-robfitz@273k.net>
	<7vll2ccs4k.fsf@assigned-by-dhcp.cox.net>
	<20050905123445.GA27107@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 02:54:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECoCw-0005wo-UW
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 02:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVIGAyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 20:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVIGAyY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 20:54:24 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:210 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751178AbVIGAyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 20:54:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050907005422.GQRE17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 20:54:22 -0400
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20050905123445.GA27107@localhost> (Robert Fitzsimons's message
	of "Mon, 5 Sep 2005 12:34:45 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8159>

Robert Fitzsimons <robfitz@273k.net> writes:

> No problem I know it's a controversial change.

Not really controversial anymore, as long as --ignore-applied is
used only when appropriate.

>>> Yes my change has a bug with a copy patch which modifies the same file.
> I'll send on a fix now.

Here is another one that the patch seems to regress.

Unfortunately this turns out to be a death sentence to the
'multiple patch touching the same file' patch.

Note that patches from a single 'git-diff-*' run are supposed to
be independent, so the second one that copy-edits from frotz to
rezrov copies frotz _before_ it is modified and then makes its
modification.

On the other hand, we can have one 'git-diff-*' run that
modifies frotz in place, and then a separate 'git-diff-*' run
that copies frotz to rezrov and then modifies rezrov, and feed
the concatenation of the two to git-apply.  That would look very
similar to a single run that edits frotz and copy-edits rezrov,
but the pre-image to create rezrov would use the post-edit image
of frotz from the first patch.  Without an explicit "here an
output from the next git-diff-*' run begins" marker, we cannot
tell these two apart.

This means that applying multiple-patches concatenated in a
single file does not make much sense.  There is no guarantee
that we can detect where the first 'git-diff-*' output ends, at
which point we need to reset the status of 'frotz' to
post-modification image of the first patch.  And if we can
detect reliably where one 'git-diff-*' output ends and the next
one begins, we could just split the input there and run
git-apply independently.  So my conclusion is to just drop this
patch, and instead tell people not to feed overlapping outputs
from multiple git-diff-* runs to a single invocation of
git-apply.

I personally do not mind considering --ignore-applied
independently from the multiple-patch-files changes, though.

------------
echo frotz >frotz
git-apply --check <<\EOF
diff --git a/frotz b/frotz
--- a/frotz
+++ b/frotz
@@ -1 +1 @@
-frotz
+frottz
diff --git a/frotz b/rezrov
similarity index 64%
copy from frotz
copy to rezrov
--- a/frotz
+++ b/rezrov
@@ -1 +1 @@
-frotz
+frotttz
EOF

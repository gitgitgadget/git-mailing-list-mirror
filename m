From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more verbose when checkout takes a long time
Date: Sat, 23 Feb 2008 14:20:25 -0800
Message-ID: <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2kA-0002bA-Dl
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbYBWWUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbYBWWUm
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:20:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbYBWWUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:20:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0561A1648;
	Sat, 23 Feb 2008 17:20:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 243901646; Sat, 23 Feb 2008 17:20:34 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sat, 23 Feb 2008 13:36:08 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74863>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I find it irritating when git thinks for a long time without telling me 
> what's taking so long. And by "long time" I definitely mean less than two 
> seconds, which is already way too long for me.

Do you mean more than two or less than two?

> Now, git read-tree already had support for the "-v" flag that does nice 
> updates about what's going on, but it was delayed by two seconds, and if 
> the thing had already done more than half by then it would be quiet even 
> after that, so in practice it meant that we migth be quiet for up to four 
> seconds. Much too long.

Geez you are impatient ;-).

The other user of start_progress_delay uses 95% as cutoff.  and
probably 50% was too low, but that may just be bikeshedding.

> ... Quite frankly, I'm not really sure why it disabled 
> error messages in the first place: ...
> ...
> Now, I'm sure this had a good reason (for the "git checkout -m" case), but 
> it did make the common case of git-checkout really annoying.

I agree.  Perhaps we can add some message when "-m" codepath
falls back to the three-way merge to make "merge-error" less
scary.  Perhaps like:

 git-checkout.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index bd74d70..5e36136 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -210,11 +210,14 @@ then
     git read-tree $v --reset -u $new
 else
     git update-index --refresh >/dev/null
-    merge_error=$(git read-tree -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
-	case "$merge" in
-	'')
-		echo >&2 "$merge_error"
+    git read-tree -$v m -u --exclude-per-directory=.gitignore $old $new || (
+	case "$merge,$v" in
+	,*)
 		exit 1 ;;
+	1,)
+		;; # quiet
+	*)
+		echo >&2 "Falling back to 3-way merge..." ;;
 	esac
 
 	# Match the index to the working tree, and do a three-way.

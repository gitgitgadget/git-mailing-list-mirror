From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout: automerge local changes while switching branches.
Date: Wed, 11 Jan 2006 23:33:20 -0800
Message-ID: <7v4q49uchr.fsf_-_@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
	<7vu0cdjhd1.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601100731p46ec276btfe04382a9e53bd5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 08:33:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewwxa-000389-8O
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 08:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWALHdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 02:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWALHdX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 02:33:23 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29938 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750826AbWALHdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 02:33:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112073054.MFX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 02:30:54 -0500
To: Alex Riesen <public-raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@ciao.gmane.org>
In-Reply-To: <81b0412b0601100731p46ec276btfe04382a9e53bd5c@mail.gmail.com>
	(Alex Riesen's message of "Tue, 10 Jan 2006 16:31:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14551>

When switching branches from A to B, if the working tree has a
local modification at paths that are different between A and B,
we refused the operation saying "cannot merge."  This attempts
to do an automerge for such paths.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

 > On 1/9/06, Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org> wrote:
 >> 2. Fix "git checkout <branch>" so that it does a reasonable thing
 >>    even when a dirty path is different in current HEAD and
 >>    destination branch.  Then I could:
 >>
 >>         $ git checkout symref ;# this would not work in the current git
 >>             # it would die like this:
 >>             # $ git checkout symref
 >>             # fatal: Entry 'gitweb.cgi' not uptodate. Cannot merge.
 >
 > That is actually very interesting. I already wished sometimes to be
 > able to switch branches with a dirty working directory (and usually
 > ended up with git diff+checkout+apply).
 > Even if it results in a merge and conflict markers in files it looks
 > like a very practical idea!

 This is still experimental and probably has rough edges, but I
 actually tested it once and it worked fine ;-).

 git-checkout.sh |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

7929db987a9aac1d0370b64a8a00ffa13e6bab82
diff --git a/git-checkout.sh b/git-checkout.sh
index 3bbd111..1b2db91 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -121,7 +121,29 @@ then
 	git-checkout-index -q -f -u -a
 else
     git-update-index --refresh >/dev/null
-    git-read-tree -m -u $old $new
+    git-read-tree -m -u $old $new || (
+	echo >&2 -n "Try automerge [y/N]? "
+	read yesno
+	case "$yesno" in [yY]*) ;; *) exit 1 ;; esac
+
+	# NEEDSWORK: We may want to reset the index from the $new for
+	# these paths after the automerge happens, but it is not done
+	# yet.  Probably we need to leave unmerged ones alone, and
+	# yank the object name & mode from $new for cleanly merged
+	# paths and stuff them in the index.
+
+	names=`git diff-files --name-only`
+	echo "$names" | git update-index --remove --stdin
+
+	work=`git write-tree` &&
+	git read-tree -m -u $old $work $new || exit
+	if result=`git write-tree 2>/dev/null`
+	then
+	    echo >&2 "Trivially automerged." ;# can this even happen?
+	    exit 0
+	fi
+	git merge-index -o git-merge-one-file -a
+    )
 fi
 
 # 
-- 
1.1.1-g8ecb

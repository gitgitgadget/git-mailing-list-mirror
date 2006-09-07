From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why is there a --binary option needed for git-apply?
Date: Wed, 06 Sep 2006 23:45:43 -0700
Message-ID: <7virk041k8.fsf@assigned-by-dhcp.cox.net>
References: <874pvmxikq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 07 08:45:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDdp-0006oo-8M
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWIGGpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIGGpd
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:45:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7838 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750838AbWIGGpc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 02:45:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907064532.UBFB26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 02:45:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KJlQ1V00M1kojtg0000000
	Thu, 07 Sep 2006 02:45:25 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <874pvmxikq.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	05 Sep 2006 11:40:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26603>

Carl Worth <cworth@cworth.org> writes:

> Shawn Pearce was kind enough to direct me to the --binary option for
> git-apply which solved my problem. But that left me wondering why
> git-apply requires this extra command-line option to do its
> job. Shouldn't git-apply simply apply the patch it is given?

There is no reason it shouldn't.

Initially it was done that way only because doing something
unusual should be done under explicit user permission.  Binary
patch is not "unusual" anymore, I guess ;-).

-- >8 --
[PATCH] Make apply --binary a no-op.

Historically we did not allow binary patch applied without an
explicit permission from the user, and this flag was the way to
do so.  This makes the flag a no-op by always allowing binary
patch application.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-apply.txt |   13 ++++---------
 builtin-apply.c             |   19 +++++--------------
 t/t4103-apply-binary.sh     |    4 ++--
 3 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c76cfff..0a6f7b3 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -110,15 +110,10 @@ OPTIONS
 	deletion part but not addition part.
 
 --allow-binary-replacement, --binary::
-	When applying a patch, which is a git-enhanced patch
-	that was prepared to record the pre- and post-image object
-	name in full, and the path being patched exactly matches
-	the object the patch applies to (i.e. "index" line's
-	pre-image object name is what is in the working tree),
-	and the post-image object is available in the object
-	database, use the post-image object as the patch
-	result.  This allows binary files to be patched in a
-	very limited way.
+	Historically we did not allow binary patch applied
+	without an explicit permission from the user, and this
+	flag was the way to do so.  Currently we always allow binary
+	patch application, so this is a no-op.
 
 --exclude=<path-pattern>::
 	Don't apply changes to files matching the given path pattern. This can
diff --git a/builtin-apply.c b/builtin-apply.c
index 872c800..6e0864c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -28,7 +28,6 @@ static int prefix_length = -1;
 static int newfd = -1;
 
 static int p_value = 1;
-static int allow_binary_replacement;
 static int check_index;
 static int write_index;
 static int cached;
@@ -1228,14 +1227,12 @@ static int parse_chunk(char *buffer, uns
 			}
 		}
 
-		/* Empty patch cannot be applied if:
-		 * - it is a binary patch and we do not do binary_replace, or
-		 * - text patch without metadata change
+		/* Empty patch cannot be applied if it is a text patch
+		 * without metadata change.  A binary patch appears
+		 * empty to us here.
 		 */
 		if ((apply || check) &&
-		    (patch->is_binary
-		     ? !allow_binary_replacement
-		     : !metadata_changes(patch)))
+		    (!patch->is_binary && !metadata_changes(patch)))
 			die("patch with only garbage at line %d", linenr);
 	}
 
@@ -1676,11 +1673,6 @@ static int apply_binary(struct buffer_de
 	unsigned char hdr[50];
 	int hdrlen;
 
-	if (!allow_binary_replacement)
-		return error("cannot apply binary patch to '%s' "
-			     "without --allow-binary-replacement",
-			     name);
-
 	/* For safety, we require patch index line to contain
 	 * full 40-byte textual SHA1 for old and new, at least for now.
 	 */
@@ -2497,8 +2489,7 @@ int cmd_apply(int argc, const char **arg
 		}
 		if (!strcmp(arg, "--allow-binary-replacement") ||
 		    !strcmp(arg, "--binary")) {
-			allow_binary_replacement = 1;
-			continue;
+			continue; /* now no-op */
 		}
 		if (!strcmp(arg, "--numstat")) {
 			apply = 0;
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index ff05269..e2b1124 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -94,11 +94,11 @@ test_expect_failure 'apply binary diff (
 	'do_reset
 	 git-apply --index C.diff'
 
-test_expect_failure 'apply binary diff without replacement -- should fail.' \
+test_expect_success 'apply binary diff without replacement.' \
 	'do_reset
 	 git-apply BF.diff'
 
-test_expect_failure 'apply binary diff without replacement (copy) -- should fail.' \
+test_expect_success 'apply binary diff without replacement (copy).' \
 	'do_reset
 	 git-apply CF.diff'
 
-- 
1.4.2.gfce41

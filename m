From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't permit ref/branch names to end with ".lock"
Date: Tue, 24 Mar 2009 16:31:01 -0700
Message-ID: <20090324233101.GU23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:32:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmG6j-0003pG-Gj
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZCXXbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 19:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbZCXXbF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:31:05 -0400
Received: from george.spearce.org ([209.20.77.23]:41128 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbZCXXbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 19:31:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 16FD238211; Tue, 24 Mar 2009 23:31:01 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114514>

We already skip over loose refs under $GIT_DIR/refs if the name
ends with ".lock", so creating a branch named "foo.lock" will not
appear in the output of "git branch", "git for-each-ref", nor will
its commit be considered reachable by "git rev-list --all".

In the latter case this is especially evil, as it may cause
repository corruption when objects reachable only through such a
ref are deleted by "git prune".

It should be reasonably safe to deny use of ".lock" as a ref suffix.
In prior versions of Git such branches would be "phantom branches";
you can create it, but you can't see it in "git branch" output.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This goes on top of your jc/name-branch-iffy currently in pu.

 Documentation/git-check-ref-format.txt |    2 ++
 refs.c                                 |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index d23fd21..9b707a7 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -34,6 +34,8 @@ imposes the following rules on how refs are named:
 
 . They cannot end with a slash `/` nor a dot `.`.
 
+. They cannot end with the sequence `.lock`.
+
 . They cannot contain a sequence `@{`.
 
 These rules makes it easy for shell script based tools to parse
diff --git a/refs.c b/refs.c
index e355489..f3fdcbd 100644
--- a/refs.c
+++ b/refs.c
@@ -676,6 +676,7 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
  * - it ends with a "/".
+ * - it ends with ".lock"
  */
 
 static inline int bad_ref_char(int ch)
@@ -737,6 +738,8 @@ int check_ref_format(const char *ref)
 				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
+			if (has_extension(ref, ".lock"))
+				return CHECK_REF_FORMAT_ERROR;
 			return ret;
 		}
 	}
-- 
1.6.2.1.471.g682837

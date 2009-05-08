From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] Extend sample update hook, disable modifying of
	existing tags
Date: Fri, 8 May 2009 17:22:30 +0200
Message-ID: <20090508152230.GA7802@macbook.lan>
References: <20090507164023.GB5807@macbook.lan> <7vzldobgrm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 17:22:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2RuJ-0004rO-Ov
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 17:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbZEHPWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 11:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbZEHPWa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 11:22:30 -0400
Received: from darksea.de ([83.133.111.250]:51682 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753124AbZEHPW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 11:22:29 -0400
Received: (qmail 6830 invoked from network); 8 May 2009 17:22:19 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 8 May 2009 17:22:19 +0200
Content-Disposition: inline
In-Reply-To: <7vzldobgrm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118611>

Because no special rule for this existed it was allowed by default

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
On Thu, May 07, 2009 at 05:05:49PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Because no special rule for this existed it was allowed by default
> 
> I do not disagree that it is a good thing to be able to reject
> overwriting, but I do not think it is a _fix_.  allowdeletetag is about
> _deletion_ and it already is covered by the code, isn't it?
> I think it would make more sense to introduce $allowmodifytag and reject
> such pushes in the codepath you touched.

You are (as usual) right. I was actually thinking about adding another
variable but then thought it might become to complex, but if you are
asking for it.  Here it is ;)

cheers Heiko

 templates/hooks--update.sample |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index f8bf490..fd63b2d 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -13,6 +13,9 @@
 # hooks.allowdeletetag
 #   This boolean sets whether deleting tags will be allowed in the
 #   repository.  By default they won't be.
+# hooks.allowmodifytag
+#   This boolean sets whether a tag may be modified after creation. By default
+#   it won't be.
 # hooks.allowdeletebranch
 #   This boolean sets whether deleting branches will be allowed in the
 #   repository.  By default they won't be.
@@ -44,6 +47,7 @@ allowunannotated=$(git config --bool hooks.allowunannotated)
 allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
 denycreatebranch=$(git config --bool hooks.denycreatebranch)
 allowdeletetag=$(git config --bool hooks.allowdeletetag)
+allowmodifytag=$(git config --bool hooks.allowmodifytag)
 
 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")
@@ -82,6 +86,12 @@ case "$refname","$newrev_type" in
 		;;
 	refs/tags/*,tag)
 		# annotated tag
+		if [ "$allowmodifytag" != "true" ] && git rev-parse $refname > /dev/null 2>&1
+		then
+			echo "*** Tag '$refname' already exists." >&2
+			echo "*** Modifying a tag is not allowed in this repository." >&2
+			exit 1
+		fi
 		;;
 	refs/heads/*,commit)
 		# branch
-- 
1.6.2.1.423.g442d

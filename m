From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC] contrib: git-c2t converts tag creating commits to tags
Date: Fri, 27 May 2011 15:55:33 +0200
Message-ID: <59fe17310157f99d5f20173ed65408d9e1f33462.1306504473.git.git@drmicha.warpmail.net>
References: <59fe17310157f99d5f20173ed65408d9e1f33462.1306504356.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:55:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxVs-0000SR-W6
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab1E0Nzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:55:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38687 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794Ab1E0Nzf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 09:55:35 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 58BE0209FE
	for <git@vger.kernel.org>; Fri, 27 May 2011 09:55:35 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 27 May 2011 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=4MWwbyLd5P0HMR2SOwLVY9YM+q4=; b=sERX58455ePjIyoFRRj5uKwJ03j16qtO0R16in6lEryzhK2sR5T/vC7fKXCk4J7jPjjJaf87yl8fSqQ3U3FwXXHWQ7n6jl+yeV1UCQw1Iu9TVtYrSqiytPibJZCVVpdMAjsl8WQ2DCW6WM/grTHwVQ8uhA04Lib3GyYgrBHCWwY=
X-Sasl-enc: y3PT3GsfvA7bcKn86bewvbdM4koODevxAu30597kLAK2 1306504534
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BBBE2403EBC;
	Fri, 27 May 2011 09:55:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.3.688.g647459
In-Reply-To: <59fe17310157f99d5f20173ed65408d9e1f33462.1306504356.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174621>

Introduce git-c2t <commit> <tag> which converts a commit object <commit>
into a tag object (and tags it with <tagname>), under the provision that
<commit> has exactly one parent and has the same tree. That tag points
at the parent commit.

This is useful for converting "tag creating commits" such as those
produced by git-svn into proper git tags. Tag creating commits typically
create a "1-commit side branch" whereas the tag created by c2t points at
the pseudo fork point (the commit being tagged).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
[And here with the notes, sorry.]
This is super useful for me but I dunno whether it should live in contrib/
(or a subdir thereof).

Also, it is not that polished. I'd be happy to put it somewhere else if that's
more appropriate. (Noting again that we miss make install contrib/feature.)
---
 contrib/git-c2t.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-c2t.sh

diff --git a/contrib/git-c2t.sh b/contrib/git-c2t.sh
new file mode 100755
index 0000000..14c9bf0
--- /dev/null
+++ b/contrib/git-c2t.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+die () {
+	echo "$@"
+	rm -f "$tagfile"
+ 	exit 1
+}
+
+warn () {
+	echo "$@"
+}
+
+test $# -eq 2 || die "Usage: $0 <commit> <tagname>"
+
+tagname="$2"
+commit="$1"
+
+git rev-parse --verify -q "$commit" >/dev/null || die "Cannot parse $commit."
+
+test x$(git cat-file -t $commit) == "xcommit" || die "$commit is no commit."
+
+tagfile=$(mktemp)
+
+git cat-file commit "$commit" | {
+	read drop tree
+	test $drop == "tree" || die "No tree."
+	read drop parent
+	test $drop = "parent" || die "No parent."
+	read drop author
+	test $drop == "author" || die "No author."
+	read drop committer
+	test $drop == "committer" || die "No committer."
+	test "$author" == "$committer" || warn "author $author != committer $committer, taking author."
+	ptree=$(git cat-file -p $parent|fgrep tree|head -1|cut -d' ' -f2)
+	test $ptree == $tree || die "commit $commit introduces a diff."
+	cat <<EOF >$tagfile
+object $parent
+type commit
+tag $tagname
+tagger $author
+EOF
+	cat >>$tagfile
+	hash=$(git hash-object -t tag -w "$tagfile")
+	git tag "$tagname" $hash
+}
+rm -f $tagfile
-- 
1.7.5.3.688.g647459

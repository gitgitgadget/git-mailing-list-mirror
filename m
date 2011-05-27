From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC] contrib: git-c2t converts tag creating commits to tags
Date: Fri, 27 May 2011 15:52:59 +0200
Message-ID: <59fe17310157f99d5f20173ed65408d9e1f33462.1306504356.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxTR-0007EN-Ss
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab1E0NxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:53:05 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44626 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928Ab1E0NxC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 09:53:02 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3F53E205CA
	for <git@vger.kernel.org>; Fri, 27 May 2011 09:53:01 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 27 May 2011 09:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=Fsd+FJXuTS7c97MtayAfGQXZmkk=; b=gLonq3mKNE7/9yANnYoe8zg54cmdasQYQfDAsxq7d0fRulPjzPJMztnPeqH2OCVGSLWgtsWXleL26eAKODuKL1bGOQVZ+LMdf6r30y9KA+PHicaIZNNhCj9Qr734xHue0pLiFrMDldreAWKEt298SN2k0QIfSfc9yZDL5E2WAHY=
X-Sasl-enc: lYxFNkH3fGjnooarW655Utyl8hiGagcngcwH3Gd46Gto 1306504380
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C6F43441154;
	Fri, 27 May 2011 09:53:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.3.688.g647459
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174620>

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

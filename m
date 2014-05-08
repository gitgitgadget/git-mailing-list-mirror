From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH] contrib/subtree bugfix: Can't `add` annotated tag
Date: Thu,  8 May 2014 11:04:39 +1000
Message-ID: <1399511079-1994-1-git-send-email-nod.helm@gmail.com>
Cc: Kevin Cagle <kcagle@micron.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 03:05:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiCln-0000OZ-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 03:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaEHBFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 21:05:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56701 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbaEHBFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 21:05:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so1876718pab.19
        for <git@vger.kernel.org>; Wed, 07 May 2014 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0eOdzN4YtPfYRYdzL6ePKmrEIlFHbap/VcaWe/MLDEY=;
        b=wiKNTOgAa1IkQ3j94XbNblHV2JU5Qn/bLhMy2wSsb2eG8Gg/IPq0za+72TahhdJ2ug
         s078CqP3gpI37GkviPACv0R+XdEMmlyT6p+ULiHrpga3AnnCGKFEo4zKelu5b1fBNz/w
         s7FANEpplx1MC/W0pB/E75nPcn2NWKia2Zx19OWFtYPC8KzR0RMox94Mc96VxBPmGIKP
         kfzf36HP17ZIU+yR2tdD0b+1g0A+pkvFB8E8OPrfIcxJY6XgbqCla/Wg21oTts9KLDgY
         iWHIt8Ug0ahsJ5SFIMmafGVCuAThskRrRlB1Il1AbzR4hCt1EFVqM/YU6B0NiGTF7qq9
         ol9g==
X-Received: by 10.66.248.228 with SMTP id yp4mr1123767pac.94.1399511101518;
        Wed, 07 May 2014 18:05:01 -0700 (PDT)
Received: from pvtjoker.unimelb.edu.au (e-nat-unistudent-0-95.uniaccess.unimelb.edu.au. [128.250.0.95])
        by mx.google.com with ESMTPSA id ha3sm5435695pbc.5.2014.05.07.18.04.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 May 2014 18:05:01 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248395>

cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which is
then rev-parsed into an object ID. However, if the user is fetching a
tag rather than a branch HEAD, such as by executing:

$ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0

The object ID is a tag and is never peeled, and the git commit-tree call
(line 561) slaps us in the face because it doesn't handle tag IDs.

Because peeling a committish ID doesn't do anything if it's already a
commit, fix by peeling[1] the object ID before assigning it to $rev, as
per the patch.

[*1*]: Via peel_committish(), from git:git-sh-setup.sh

Reported-by: Kevin Cagle <kcagle@micron.com>
Diagnosed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: James Denholm <nod.helm@gmail.com>
---
NB: This bug doesn't surface when using --squash, as $rev is reassigned
to the squash commit via new_squash_commit before git commit-tree sees
it (though for simplicity, new_squash_commit now also sees the peeled
ID).

Also doesn't surface when using "git subtree merge", as git merge can
handle tag objects.

On a side note, if merging a tag without --squash, git merge recognises
that it's a tag and adds a note to the merge commit body. It may be
worth mimicking this when using "subtree merge --squash" or
"subtree add".

 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dc59a91..9453dae 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -538,7 +538,7 @@ cmd_add_commit()
 {
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	set -- $revs
-	rev="$1"
+	rev=$(peel_committish "$1")
 	
 	debug "Adding $dir as '$rev'..."
 	git read-tree --prefix="$dir" $rev || exit $?
-- 
1.9.2

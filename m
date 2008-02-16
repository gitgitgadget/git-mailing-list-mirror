From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an
 accentuated letter in the filename
Date: Fri, 15 Feb 2008 23:54:47 -0800
Message-ID: <7v63wpcp4o.fsf@gitster.siamese.dyndns.org>
References: <87bq6iw42w.dlv@maison.homelinux.org>
 <7vd4qygld8.fsf@gitster.siamese.dyndns.org>
 <87tzk9tnnu.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 08:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQHu6-0008FO-GC
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 08:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbYBPHzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 02:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYBPHzS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 02:55:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYBPHzR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Feb 2008 02:55:17 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 162FA3939;
	Sat, 16 Feb 2008 02:55:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 CA5F53938; Sat, 16 Feb 2008 02:55:05 -0500 (EST)
In-Reply-To: <87tzk9tnnu.dlv@maison.homelinux.org> (Remi Vanicat's message of
 "Sat, 16 Feb 2008 07:34:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74026>

Not just those two lines but the next two lines were also very
old fashioned.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Could you try this one?

 git-filter-branch.sh     |    9 +++++----
 t/t7003-filter-branch.sh |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ff716ca..49e13f0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -276,10 +276,11 @@ while read commit parents; do
 		eval "$filter_tree" < /dev/null ||
 			die "tree filter failed: $filter_tree"
=20
-		git diff-index -r $commit | cut -f 2- | tr '\012' '\000' | \
-			xargs -0 git update-index --add --replace --remove
-		git ls-files -z --others | \
-			xargs -0 git update-index --add --replace --remove
+		(
+			git diff-index -r --name-only $commit
+			git ls-files --others
+		) |
+		git update-index --add --replace --remove --stdin
 	fi
=20
 	eval "$filter_index" < /dev/null ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 5f60b22..868babc 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -165,4 +165,18 @@ test_expect_success '"map" works in commit filter'=
 '
 	git rev-parse --verify master
 '
=20
+test_expect_success 'Name needing quotes' '
+
+	git checkout -b rerere A &&
+	mkdir foo &&
+	name=3D"=E3=82=8C=E3=82=8C=E3=82=8C" &&
+	>foo/$name &&
+	git add foo &&
+	git commit -m "Adding a file" &&
+	git filter-branch --tree-filter "rm -fr foo" &&
+	! git ls-files --error-unmatch "foo/$name" &&
+	test $(git rev-parse --verify rerere) !=3D $(git rev-parse --verify A=
)
+
+'
+
 test_done

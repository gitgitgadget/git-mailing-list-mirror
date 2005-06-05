From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH] Make cg-add use xargs -0
Date: Sun, 05 Jun 2005 21:15:38 +0200
Message-ID: <42A34F5A.2090909@gmail.com>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz> <20050605182912.GC6890@tumblerings.org> <20050605184341.GA21345@immutable.crsr.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050408030003090304060807"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 05 21:15:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df0aB-0005sv-EB
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 21:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFETSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFETSO
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 15:18:14 -0400
Received: from main.gmane.org ([80.91.229.2]:13459 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261283AbVFETSF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 15:18:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Df0Ys-0005jj-5S
	for git@vger.kernel.org; Sun, 05 Jun 2005 21:13:30 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Jun 2005 21:13:30 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Jun 2005 21:13:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050605184341.GA21345@immutable.crsr.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------050408030003090304060807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make cg-add use xargs -0, to avoid failure on files with
quotes of all kinds, spaces, etc.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>

--------------050408030003090304060807
Content-Type: text/plain;
 name="cg-add.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-add.patch.txt"

 cg-add |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -19,10 +19,13 @@ USAGE="cg-add FILE..."
 
 [ "$1" ] || usage
 
-TMPFILE=$(mktemp -t gitadd.XXXXXX)
-find "$@" -type f > $TMPFILE || die "not all files exist, nothing added"
+TMPFILE=$(mktemp -t gitadd.XXXXXX) || exit 1
+find "$@" -type f -print0 > $TMPFILE || {
+	die "not all files exist, nothing added"
+	rm $TMPFILE
+}
 
-cat $TMPFILE | awk '{print "Adding file "  $0}'
-cat $TMPFILE | xargs git-update-cache --add --
+cat $TMPFILE | tr \\0 \\n | awk '{print "Adding file "  $0}'
+cat $TMPFILE | xargs -0r git-update-cache --add --
 
 rm $TMPFILE

--------------050408030003090304060807--


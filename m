From: Miguel Bazdresch <git-01@thewizardstower.org>
Subject: [PATCH] cg-clone fails to clone tags
Date: Tue, 31 May 2005 20:58:35 -0500
Message-ID: <20050601015835.GA11507@localhost.domain.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Wed Jun 01 03:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdIOK-0006Cx-Tr
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 03:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFAByK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFAByK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 21:54:10 -0400
Received: from relay01.pair.com ([209.68.5.15]:53508 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261192AbVFAByC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 21:54:02 -0400
Received: (qmail 2170 invoked from network); 1 Jun 2005 01:54:01 -0000
Received: from unknown (HELO localhost.localdomain) (unknown)
  by unknown with SMTP; 1 Jun 2005 01:54:01 -0000
X-pair-Authenticated: 201.129.159.217
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 69D1D67BDD; Tue, 31 May 2005 20:58:35 -0500 (CDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Mailer: Mutt 1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed that cg-clone fails to clone tags when the source and
destination directories are on different filesystems (this is on a local
clone). The command produces warnings of the type:

cp: cannot create link `.git/refs/tags/git-pasky-0.6.2': Invalid cross-device link
`/home/miguel/bin/cogito/.git/refs/tags/git-pasky-0.6.3' -> `.git/refs/tags/git-pasky-0.6.3'

I think the culprit is the "l" flag passed to cp in fetch-local() in
script cg-pull. After thinking a bit on how to solve this, I decided on
a "blunt force" approach, where the cp is done twice, once with "l" and
once without it. Only when both fail is a warning issued about the
failure to get the tag list.

This has the unfortunate side effect of also removing the "u" flag to
cp, but I don't think it's a big deal (cg-pull adds the "l" and "u"
flags at the same time).

Following is the output of cg-mkpatch:

---

Currently, cg-clone fails to clone the tag list if the destination
and source directory are in different filesystem. This caused by the
"l" flag used by fetch_local.

This patch tries the copy without the "l" flag if it fails with it.

Signed-off-by: Miguel Bazdresch <miguelb@ieee.org>

---
commit 5823514635ca67be41914d9294081353b70272a4
tree 19092122a45366f46b7f140d411f875000ff2ba7
parent 20e473c9afd8b5d2d549b0e7881473600beb9c37
author Miguel Bazdresch <miguelb@ieee.org> Tue, 31 May 2005 20:23:44
-0500
committer Miguel Bazdresch <miguelb@ieee.org> Tue, 31 May 2005 20:23:44
-0500

 cg-pull |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -259,8 +259,16 @@ rsyncerr=
 $fetch -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" || rsyncerr=1
 if [ "$rsyncerr" ]; then
 rsyncerr=
-	$fetch -i -s -u -d "$uri/tags" "$_git/refs/tags" || rsyncerr=1
+	$fetch -i -s -d "$uri/refs/tags" "$_git/refs/tags" || rsyncerr=1
 fi
+if [ "$rsyncerr" ]; then
+rsyncerr=
+	$fetch -i -s -u -d "$uri/tags" "$_git/refs/tags" || rsyncerr=1
+fi
+if [ "$rsyncerr" ]; then
+rsyncerr=
+	$fetch -i -s -d "$uri/tags" "$_git/refs/tags" || rsyncerr=1
+fi
 [ "$rsyncerr" ] && echo "unable to get tags list (non-fatal)" >&2

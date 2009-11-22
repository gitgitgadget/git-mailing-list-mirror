From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git-svn: Fails to drop leading path from empty dir name
Date: Sun, 22 Nov 2009 14:46:38 +0100
Message-ID: <20091122134638.GA12233@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 22 14:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCCmF-0003OZ-DC
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 14:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbZKVNqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 08:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbZKVNqi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 08:46:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:56630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752382AbZKVNqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 08:46:38 -0500
Received: (qmail invoked by alias); 22 Nov 2009 13:46:42 -0000
Received: from i59F5B6DD.versanet.de (EHLO atjola.homenet) [89.245.182.221]
  by mail.gmx.net (mp009) with SMTP; 22 Nov 2009 14:46:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/XgnlLCWnXHmTL5kpGKilaRf98tS2Dj5LMIOhfQf
	pcbZ/bKxN0vwBP
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

the stuff to create empty directories fails to strip leading path
components, e.g. when using
"git svn clone -s svn://whatever/project/trunk".

Instead of creating the empty directory "foo" in the repo root, it
creates "project/trunk/foo".

Ad hoc patch for the test case below.

Bj=F6rn

diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs=
=2Esh
index 5948544..9e22089 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -82,4 +82,27 @@ test_expect_success 'git svn mkdirs -r works' '
 	)
 '
=20
+test_expect_success 'initialize trunk' '
+	for i in trunk trunk/a trunk/"weird file name"
+	do
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+	done
+'
+
+test_expect_success 'clone trunk' 'git svn clone -s "$svnrepo" trunk'
+
+test_expect_success 'empty directories in trunk exist' '
+	(
+		cd cloned &&
+		for i in trunk/a trunk/"weird file name"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+	)
+'
+
 test_done

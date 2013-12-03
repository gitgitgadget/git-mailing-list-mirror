From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Mon, 02 Dec 2013 16:16:03 -0800
Message-ID: <8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 01:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vndf1-0007xq-0t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab3LCAQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 19:16:15 -0500
Received: from nk11p03mm-asmtp002.mac.com ([17.158.232.237]:50923 "EHLO
	nk11p03mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752262Ab3LCAQN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 19:16:13 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MX70030QFD8A230@nk11p03mm-asmtp002.mac.com> for
 git@vger.kernel.org; Tue, 03 Dec 2013 00:16:04 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-02_04:2013-12-02,2013-12-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=15 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312020196
In-reply-to: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238668>

=46rom: Nick Townsend <nick.townsend@mac.com>
Date: Sat, 30 Nov 2013 16:54:20 -0800
Subject: [PATCH 2/2] Additional git-archive tests

Interplay between paths specified in three ways now tested:
* After a : in the tree-ish,
* As a pathspec in the command,
* By virtue of the current working directory

Note that these tests are based on the behaviours
as found in 1.8.5. They may not be intentional.
They were developed to regression test enhancements
made to parse_treeish_arg() in archive.c

Signed-off-by: Nick Townsend <nick.townsend@mac.com>
---
 t/t5004-archive-corner-cases.sh | 67 +++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 67 insertions(+)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-c=
ases.sh
index 67f3b54..8b70e4a 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -113,4 +113,71 @@ test_expect_success 'archive empty subtree by dire=
ct pathspec' '
 	check_dir extract sub
 '
=20
+test_expect_success 'setup - repository with subdirs' '
+	mkdir -p a/b/{c,d} &&
+	echo af >a/af &&
+	echo bf >a/b/bf &&
+	echo cf >a/b/c/cf &&
+	git add a &&
+	git commit -m "commit 1" &&
+	git tag -a -m "rev-1" rev-1
+'
+
+test_expect_success 'archive subtree from root by treeish' '
+	git archive --format=3Dtar HEAD:a >atreeroot.tar &&
+	make_dir extract &&
+	"$TAR" xf atreeroot.tar -C extract &&
+	check_dir extract af b b/bf b/c b/c/cf
+'
+
+test_expect_success 'archive subtree from root with pathspec' '
+	git archive --format=3Dtar HEAD a >atreepath.tar &&
+	make_dir extract &&
+	"$TAR" xf atreepath.tar -C extract &&
+	check_dir extract a a/af a/b a/b/bf a/b/c a/b/c/cf
+'
+
+test_expect_success 'archive subtree from root by 2-level treeish' '
+	git archive --format=3Dtar HEAD:a/b >abtreeroot.tar &&
+	make_dir extract &&
+	"$TAR" xf abtreeroot.tar -C extract &&
+	check_dir extract bf c c/cf
+'
+
+test_expect_success 'archive subtree from subdir' '
+	cd a &&
+	git archive --format=3Dtar HEAD >../asubtree.tar &&
+	cd .. &&
+	make_dir extract &&
+	"$TAR" xf asubtree.tar -C extract &&
+	check_dir extract af b b/bf b/c b/c/cf
+'
+
+test_expect_success 'archive subtree from subdir with treeish' '
+	cd a &&
+	git archive --format=3Dtar HEAD:./b >../absubtree.tar &&
+	cd .. &&
+	make_dir extract &&
+	"$TAR" xf absubtree.tar -C extract &&
+	check_dir extract bf c c/cf
+'
+
+test_expect_success 'archive subtree from subdir with treeish and path=
spec' '
+	cd a &&
+	git archive --format=3Dtar HEAD:./b c >../absubtree.tar &&
+	cd .. &&
+	make_dir extract &&
+	"$TAR" xf absubtree.tar -C extract &&
+	check_dir extract c c/cf
+'
+
+test_expect_success 'archive subtree from subdir with alt treeish' '
+	cd a &&
+	git archive --format=3Dtar HEAD:b >../abxsubtree.tar &&
+	cd .. &&
+	make_dir extract &&
+	"$TAR" xf abxsubtree.tar -C extract &&
+	check_dir extract bf c c/cf
+'
+
 test_done
--=20
1.8.5.4.g9d8cd78.dirty

On 2 Dec 2013, at 16:10, Nick Townsend <nick.townsend@mac.com> wrote:

> As per the previous patch request, I=92ve delayed the work on git-arc=
hive.
> However the following two patches (attached as replies) should still
> be considered.
> Kind Regards
> Nick

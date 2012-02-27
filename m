From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] branch: don't assume the merge filter ref exists
Date: Mon, 27 Feb 2012 16:11:53 +0100
Message-ID: <1330355513-22351-1-git-send-email-cmn@elego.de>
References: <20120227122609.GA26981@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 16:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S22Ec-000489-4K
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 16:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab2B0PLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 10:11:24 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:38767 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab2B0PLY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 10:11:24 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9ac75.pool.mediaWays.net [77.185.172.117])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 98EB846057;
	Mon, 27 Feb 2012 16:11:17 +0100 (CET)
Received: (nullmailer pid 22385 invoked by uid 1000);
	Mon, 27 Feb 2012 15:11:53 -0000
X-Mailer: git-send-email 1.7.9.rc0
In-Reply-To: <20120227122609.GA26981@mx.loc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191624>

print_ref_list looks up the merge_filter_ref and assumes that a valid
pointer is returned. When the object doesn't exist, it tries to
dereference a NULL pointer. This can be the case when git branch
--merged is given an argument that isn't a valid commit name.

Check whether the lookup returns a NULL pointer and die with an error
if it does. Add a test, while we're at it.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

It certainly looks like --merged was only ever supposed to be used
with branch names, as it assumed that get_sha1() would catch the
errors.

I'm not sure if "bad object" or "invalid object" fits better. "bad
object" might have a stronger implication that it exists but is
corrupt.

 builtin/branch.c  |    3 +++
 t/t3200-branch.sh |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cb17bc3..b63d5fe 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -530,6 +530,9 @@ static int print_ref_list(int kinds, int detached, =
int verbose, int abbrev, stru
 	if (merge_filter !=3D NO_FILTER) {
 		struct commit *filter;
 		filter =3D lookup_commit_reference_gently(merge_filter_ref, 0);
+		if (!filter)
+			die("bad object %s", sha1_to_hex(merge_filter_ref));
+
 		filter->object.flags |=3D UNINTERESTING;
 		add_pending_object(&ref_list.revs,
 				   (struct object *) filter, "");
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd1aceb..9fe1d8f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -653,4 +653,8 @@ test_expect_success 'refuse --edit-description on u=
nborn branch for now' '
 	)
 '
=20
+test_expect_success '--merged catches invalid object names' '
+	test_must_fail git branch --merged 0000000000000000000000000000000000=
000000
+'
+
 test_done
--=20
1.7.9.rc0

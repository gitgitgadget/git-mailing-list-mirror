From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] refs: add "for_each_ref_in" function to refactor
 "for_each_*_ref" functions
Date: Mon, 30 Mar 2009 05:07:15 +0200
Message-ID: <20090330050715.7fa6f3ab.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 05:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo7sk-000239-HO
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 05:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbZC3DIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 23:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZC3DIU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 23:08:20 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39471 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbZC3DIT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 23:08:19 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5B6BB940041;
	Mon, 30 Mar 2009 05:08:10 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 1295D940019;
	Mon, 30 Mar 2009 05:08:07 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115056>

The "for_each_{tag,branch,remote,replace,}_ref" functions are
redefined in terms of "for_each_ref_in" so that we can lose the
hardcoded length of prefix strings from the code.

And the "for_each_bisect_ref" as it is only used in "bisect.c" and
a call like 'for_each_ref_in("refs/bisect/", register_ref, NULL)'
is clear enough.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |    2 +-
 refs.c   |   18 +++++++++---------
 refs.h   |    2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

	Junio wrote:

	> > +static int read_bisect_refs(void)
	> > +{
	> > +=A0=A0=A0=A0=A0return for_each_bisect_ref(register_ref, NULL);
	> > +}
	>
	> This is only a minor point, but I do not foresee anybody other than
	> bisect--helper (and later bisect) running for_each_bisect_ref(). =A0=
It might
	> make sense to redo [01/10] to introduce
	>
	>=A0=A0=A0=A0=A0=A0=A0=A0for_each_ref_in(const char *prefix, each_ref_=
fn fn, void *cb)
	>
	> and change this call site to:
	>
	>=A0=A0=A0=A0=A0=A0=A0=A0return for_each_ref_in("refs/bisect/", regist=
er_ref, NULL);
	>
	> Needless to say, for_each_{ref,tag_ref,branch_ref,remote_ref}() can =
be
	> redefined in terms of for_each_ref_in() so that we can lose these
	> hardcoded length of prefix strings from the code.

	Here is a patch to do that, though "for_each_ref" is not redefined in =
terms
	of "for_each_ref_in", as it passes 0 as the length of the prefix strin=
g.

diff --git a/bisect.c b/bisect.c
index b4089ca..2e3d063 100644
--- a/bisect.c
+++ b/bisect.c
@@ -422,7 +422,7 @@ static int register_ref(const char *refname, const =
unsigned char *sha1,
=20
 static int read_bisect_refs(void)
 {
-	return for_each_bisect_ref(register_ref, NULL);
+	return for_each_ref_in("refs/bisect/", register_ref, NULL);
 }
=20
 void read_bisect_paths(void)
diff --git a/refs.c b/refs.c
index e512d4c..c52a758 100644
--- a/refs.c
+++ b/refs.c
@@ -647,29 +647,29 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/", fn, 0, 0, cb_data);
 }
=20
-int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/tags/", fn, 10, 0, cb_data);
+	return do_for_each_ref(prefix, fn, strlen(prefix), 0, cb_data);
 }
=20
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/heads/", fn, 11, 0, cb_data);
+	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
=20
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13, 0, cb_data);
+	return for_each_ref_in("refs/heads/", fn, cb_data);
 }
=20
-int for_each_bisect_ref(each_ref_fn fn, void *cb_data)
+int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/bisect/", fn, 12, 0, cb_data);
+	return for_each_ref_in("refs/remotes/", fn, cb_data);
 }
=20
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
+	return for_each_ref_in("refs/replace/", fn, cb_data);
 }
=20
 int for_each_rawref(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index c76d96b..18649a7 100644
--- a/refs.h
+++ b/refs.h
@@ -20,10 +20,10 @@ struct ref_lock {
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1=
, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
+extern int for_each_ref_in(const char *, each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
-extern int for_each_bisect_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
=20
 /* can be used to learn about broken ref and symref */
--=20
1.6.2.1.531.gbd5067.dirty

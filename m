From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 13:04:10 -0700
Message-ID: <7vve076d6t.fsf@gitster.siamese.dyndns.org>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
 <20080616092554.GB29404@genesis.frugalware.org>
 <48563D6C.8060704@viscovery.net>
 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
 <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	sverre@rabbelier.nl, "Johannes Sixt" <j.sixt@viscovery.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 17 22:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8hRA-00038m-6H
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 22:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbYFQUE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 16:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYFQUE2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 16:04:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbYFQUE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 16:04:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9773F10E5B;
	Tue, 17 Jun 2008 16:04:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 039E610E5A; Tue, 17 Jun 2008 16:04:13 -0400 (EDT)
In-Reply-To: <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 (Geoff Russell's message of "Tue, 17 Jun 2008 08:15:50 +0930")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93FE5130-3CA8-11DD-9C71-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85319>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> Thanks everybody,
>
> On 6/17/08, Sverre Rabbelier <alturin@gmail.com> wrote:
>> On Mon, Jun 16, 2008 at 12:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>  > The solution depends on whether *all* files in B should be taken, or only
>>  > those files in B where there's a merge conflict. I don't know an easy way
>>  > to do the former, but the latter I'd do like this:
>>  >
>>  >        $ git diff --name-only | xargs git checkout B --
>
> This looks like a manageable approach and better than the scripting I was
> thinking about -- ie. scan the conflict files with perl and fix them!

Careful.

The above pipeline gives quite different result from "scan the conflict
files with perl and fix them".

If the result you want from the "scan and fix the conflicts" approach is
to take as much automerge as possible, and punt only on conflicting parts
by discarding your work (side note: I hear this wish often and still I
have not heard satisfactory explanation why people think that could be a
sane result, though), the above pipeline is not what you want.  It not
only discards your work in conflicting parts but also all your work from
even cleanly automerged parts of a path that has conflicts.

For example, suppose the original, our version and their version are like
these respectively:

        (orig)    (ours)     (theirs)
        1         one        uno
        2         2          2
        3         3          3
        4         4          4
        5         5          5
        6         6          6
        7         7          7
        8         eight      8

If you merge these with natural 3-way merge, you would get this:

        $ git-merge-file -p ours orig theirs
        <<<<<<< ours
        one
        =======
        uno
        >>>>>>> theirs
        2
        3
        4
        5
        6
        7
        eight

Note: git-merge-file mimicks the "merge" program from RCS suite.  The
      three file parameters are mine, old and yours (in alphabetical order
      as easy-to-remember mnemonic) and means "update mine taking the
      change that you made to old to reach yours".

That's a conflict.  The above suggested pipeline would give "their"
version.  That means the result does not have your change s/8/eight/.

It all depends on what you really mean by take "theirs", but you might
have wanted to have this instead, with the "scan and fix the conflicts"
approach you hinted in your message:

        $ git-merge-file -p --theirs ours orig theirs
        uno
        2
        3
        4
        5
        6
        7
        eight

That retains your change in non-conflicting part while favoring their
change where conflicts are.

No, neither --theirs nor --ours option exists in your version of git.
But here is a patch to add it to git-merge-file.

---

 builtin-merge-file.c |   10 ++++++++--
 xdiff/xdiff.h        |    8 +++++++-
 xdiff/xmerge.c       |   24 ++++++++++++++++--------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 3605960..7d4ca8c 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -4,7 +4,7 @@
 #include "xdiff-interface.h"
 
 static const char merge_file_usage[] =
-"git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
+"git merge-file [-p | --stdout] [-q | --quiet] [--ours|--theirs] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
@@ -13,6 +13,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
 	int ret = 0, i = 0, to_stdout = 0;
+	int flags, favor = 0;
 
 	while (argc > 4) {
 		if (!strcmp(argv[1], "-L") && i < 3) {
@@ -25,6 +26,10 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q") ||
 				!strcmp(argv[1], "--quiet"))
 			freopen("/dev/null", "w", stderr);
+		else if (!strcmp(argv[1], "--ours"))
+			favor = XDL_MERGE_FAVOR_OURS;
+		else if (!strcmp(argv[1], "--theirs"))
+			favor = XDL_MERGE_FAVOR_THEIRS;
 		else
 			usage(merge_file_usage);
 		argc--;
@@ -45,8 +50,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 					argv[i + 1]);
 	}
 
+	flags = XDL_MERGE_FLAGS(XDL_MERGE_ZEALOUS_ALNUM, favor);
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, XDL_MERGE_ZEALOUS_ALNUM, &result);
+			&xpp, flags, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 413082e..d40cf21 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -99,9 +99,15 @@ long xdl_mmfile_size(mmfile_t *mmf);
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 
+#define XDL_MERGE_FAVOR_OURS		1
+#define XDL_MERGE_FAVOR_THEIRS		2
+#define XDL_MERGE_FAVOR(flag)		(((flag)>>4) & 03)
+#define XDL_MERGE_LEVEL(flag)		((flag) & 07)
+#define XDL_MERGE_FLAGS(level,flag)	((level) | ((flag)<<4))
+
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result);
+		xpparam_t const *xpp, int flag, mmbuffer_t *result);
 
 #ifdef __cplusplus
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 82b3573..88c29ae 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -114,7 +114,9 @@ static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 }
 
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
-		xdfenv_t *xe2, const char *name2, xdmerge_t *m, char *dest)
+				 xdfenv_t *xe2, const char *name2,
+				 int favor,
+				 xdmerge_t *m, char *dest)
 {
 	const int marker_size = 7;
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
@@ -124,6 +126,9 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 	int size, i1, j;
 
 	for (size = i1 = 0; m; m = m->next) {
+		if (favor && !m->mode)
+			m->mode = favor;
+
 		if (m->mode == 0) {
 			size += xdl_recs_copy(xe1, i1, m->i1 - i1, 0,
 					dest ? dest + size : NULL);
@@ -322,8 +327,9 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
-		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		int level, xpparam_t const *xpp, mmbuffer_t *result) {
+			xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
+			int level, int favor,
+			xpparam_t const *xpp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
 	int i1, i2, chg1, chg2;
 
@@ -430,25 +436,27 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	/* output */
 	if (result) {
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-			changes, NULL);
+						 favor, changes, NULL);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
 			return -1;
 		}
 		result->size = size;
-		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
-				result->ptr);
+		xdl_fill_merge_buffer(xe1, name1, xe2, name2,
+				      favor, changes, result->ptr);
 	}
 	return xdl_cleanup_merge(changes);
 }
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result) {
+		xpparam_t const *xpp, int flag, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
+	int level = XDL_MERGE_LEVEL(flag);
+	int favor = XDL_MERGE_FAVOR(flag);
 
 	result->ptr = NULL;
 	result->size = 0;
@@ -482,7 +490,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		} else {
 			status = xdl_do_merge(&xe1, xscr1, name1,
 					      &xe2, xscr2, name2,
-					      level, xpp, result);
+					      level, favor, xpp, result);
 		}
 		xdl_free_script(xscr1);
 		xdl_free_script(xscr2);

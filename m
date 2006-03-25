From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 12:17:22 -0800
Message-ID: <7vslp6uvn1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
	<118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
	<Pine.LNX.4.64.0603250734130.15714@g5.osdl.org>
	<Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 21:17:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNFCT-0005Jb-Mc
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 21:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWCYURZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 15:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCYURY
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 15:17:24 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54406 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751380AbWCYURY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 15:17:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325201723.MXWW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 15:17:23 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 25 Mar 2006 07:56:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17995>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 25 Mar 2006, Linus Torvalds wrote:
>> 
>> I'll be taking a look at trying to fix it. 
>
> Actually, it ended up being easier than I expected it to be.
>
> This (on top of the previous patch) should fix it.

This is a replacement for my previous one, which reduces the
changes to the testsuite.

I'll find time to omit prepare_temp_file() calls from diffcore
emit routines over the weekend.  Another useful project would be
to redo the combine-diff.c using the real built-in diff.

-- >8 --
[PATCH] built-in diff: minimum tweaks

This fixes up a couple of minor issues with the real built-in
diff to be more usable:

 - Omit ---/+++ header unless we emit diff output;

 - Detect and punt binary diff like GNU does;

 - Honor GIT_DIFF_OPTS minimally (only -u<number> and
   --unified=<number> are currently supported);

 - Omit line count of 1 from "@@ -l,k +m,n @@" hunk header
   (i.e. when k == 1 or n == 1)

 - Adjust testsuite for the lack of -p support.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diff.c                 |   41 ++++++++++++++++++++++++++++++++++++-----
 t/t4001-diff-rename.sh |    2 +-
 xdiff/xutils.c         |   16 ++++++++++------
 3 files changed, 47 insertions(+), 12 deletions(-)

6ff2f393f16e56a5d3d611b4d3e8f039994ce0a8
diff --git a/diff.c b/diff.c
index f6a1f5d..cd2ce0f 100644
--- a/diff.c
+++ b/diff.c
@@ -212,16 +212,37 @@ static int fill_mmfile(mmfile_t *mf, con
 	return 0;
 }
 
+struct emit_callback {
+	const char **label_path;
+};
+
 static int fn_out(void *priv, mmbuffer_t *mb, int nbuf)
 {
 	int i;
+	struct emit_callback *ecbdata = priv;
 
+	if (ecbdata->label_path[0]) {
+		printf("--- %s\n", ecbdata->label_path[0]);
+		printf("+++ %s\n", ecbdata->label_path[1]);
+		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
+	}
 	for (i = 0; i < nbuf; i++)
 		if (!fwrite(mb[i].ptr, mb[i].size, 1, stdout))
 			return -1;
 	return 0;
 }
 
+#define FIRST_FEW_BYTES 8000
+static int mmfile_is_binary(mmfile_t *mf)
+{
+	long sz = mf->size;
+	if (FIRST_FEW_BYTES < sz)
+		sz = FIRST_FEW_BYTES;
+	if (memchr(mf->ptr, 0, sz))
+		return 1;
+	return 0;
+}
+
 static const char *builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_tempfile *temp,
@@ -306,22 +327,32 @@ static const char *builtin_diff(const ch
 	if (label_path[1][0] != '/')
 		label_path[1] = quote_two("b/", name_b);
 
-	printf("--- %s\n", label_path[0]);
-	printf("+++ %s\n", label_path[1]);
-
 	if (fill_mmfile(&mf1, temp[0].name) < 0 ||
 	    fill_mmfile(&mf2, temp[1].name) < 0)
 		die("unable to read files to diff");
 
-	/* Crazy xdl interfaces.. */
-	{
+	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))
+		printf("Binary files %s and %s differ\n",
+		       label_path[0], label_path[1]);
+	else {
+		/* Crazy xdl interfaces.. */
+		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
+		struct emit_callback ecbdata;
 
+		ecbdata.label_path = label_path;
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
+		if (!diffopts)
+			;
+		else if (!strncmp(diffopts, "--unified=", 10))
+			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
+		else if (!strncmp(diffopts, "-u", 2))
+			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
 		ecb.outf = fn_out;
+		ecb.priv = &ecbdata;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2e3c20d..08c1131 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -49,7 +49,7 @@ rename from path0
 rename to path1
 --- a/path0
 +++ b/path1
-@@ -8,7 +8,7 @@ Line 7
+@@ -8,7 +8,7 @@
  Line 8
  Line 9
  Line 10
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index b68afa2..8221806 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -245,20 +245,24 @@ int xdl_emit_hunk_hdr(long s1, long c1, 
 
 	nb += xdl_num_out(buf + nb, c1 ? s1: 0);
 
-	memcpy(buf + nb, ",", 1);
-	nb += 1;
+	if (c1 != 1) {
+		memcpy(buf + nb, ",", 1);
+		nb += 1;
 
-	nb += xdl_num_out(buf + nb, c1);
+		nb += xdl_num_out(buf + nb, c1);
+	}
 
 	memcpy(buf + nb, " +", 2);
 	nb += 2;
 
 	nb += xdl_num_out(buf + nb, c2 ? s2: 0);
 
-	memcpy(buf + nb, ",", 1);
-	nb += 1;
+	if (c2 != 1) {
+		memcpy(buf + nb, ",", 1);
+		nb += 1;
 
-	nb += xdl_num_out(buf + nb, c2);
+		nb += xdl_num_out(buf + nb, c2);
+	}
 
 	memcpy(buf + nb, " @@\n", 4);
 	nb += 4;
-- 
1.2.4.g88d9

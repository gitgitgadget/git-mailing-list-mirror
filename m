From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 11:52:07 -0800
Message-ID: <7v7j6iwbdk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
	<118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
	<Pine.LNX.4.64.0603250734130.15714@g5.osdl.org>
	<Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 20:52:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNEo3-0001DB-Hy
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 20:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWCYTwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 14:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCYTwL
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 14:52:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:57839 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751136AbWCYTwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 14:52:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325195208.YWUM17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 14:52:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17993>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 25 Mar 2006, Linus Torvalds wrote:
>> 
>> I'll be taking a look at trying to fix it. 
>
> Actually, it ended up being easier than I expected it to be.
>
> This (on top of the previous patch) should fix it.
>...
> +	if (!size || rec[size-1] != '\n') {
> +		mb[2].ptr = "\n\\ No newline at end of file\n";
>... 

Thanks.  Here is what I cooked last night, which I rebased
on top of your two patches, to:

 - Punt "binary" diff like GNU does;

 - Minimally support GIT_DIFF_OPTS to allow passing -u0;

 - Omit ---/+++ lines when we do not have any diff output;

 - Adjust the tests to "@@ -k,l +m,n @@" form.

 - Adjust the tests to lack of "diff -p".

The first two are hacks but I think they are good enough hacks
for real life.  The third one is a real fix.  I agree with you
that libxdiff form is more rational, and that is the
justification for the fourth point.

-- >8 --
diff --git a/diff.c b/diff.c
index f6a1f5d..cd2ce0f 100644
--- a/diff.c
+++ b/diff.c
@@ -212,13 +212,34 @@
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
+	return 0;
+}
+
+#define FIRST_FEW_BYTES 8000
+static int mmfile_is_binary(mmfile_t *mf)
+{
+	long sz = mf->size;
+	if (FIRST_FEW_BYTES < sz)
+		sz = FIRST_FEW_BYTES;
+	if (memchr(mf->ptr, 0, sz))
+		return 1;
 	return 0;
 }
 
@@ -306,22 +327,32 @@
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
 
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 1002413..5ac373f 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -22,7 +22,7 @@
 index 557db03..263414f 100644
 --- a/hello
 +++ b/hello
-@@ -1 +1,2 @@
+@@ -1,1 +1,2 @@
  Hello World
 +It's a new day for git
 EOF
@@ -60,14 +60,14 @@
 index 0000000..f24c74a
 --- /dev/null
 +++ b/example
-@@ -0,0 +1 @@
+@@ -0,0 +1,1 @@
 +Silly example
 diff --git a/hello b/hello
 new file mode 100644
 index 0000000..557db03
 --- /dev/null
 +++ b/hello
-@@ -0,0 +1 @@
+@@ -0,0 +1,1 @@
 +Hello World
 EOF
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2e3c20d..08c1131 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -49,7 +49,7 @@
 rename to path1
 --- a/path0
 +++ b/path1
-@@ -8,7 +8,7 @@ Line 7
+@@ -8,7 +8,7 @@
  Line 8
  Line 9
  Line 10
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index 2751970..af744fd 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -36,7 +36,7 @@
 copy to COPYING.1
 --- a/COPYING
 +++ b/COPYING.1
-@@ -6 +6 @@
+@@ -6,1 +6,1 @@
 - HOWEVER, in order to allow a migration to GPLv3 if that seems like
 + However, in order to allow a migration to GPLv3 if that seems like
 diff --git a/COPYING b/COPYING.2
@@ -44,13 +44,13 @@
 rename to COPYING.2
 --- a/COPYING
 +++ b/COPYING.2
-@@ -2 +2 @@
+@@ -2,1 +2,1 @@
 - Note that the only valid version of the GPL as far as this project
 + Note that the only valid version of the G.P.L as far as this project
-@@ -6 +6 @@
+@@ -6,1 +6,1 @@
 - HOWEVER, in order to allow a migration to GPLv3 if that seems like
 + HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
-@@ -12 +12 @@
+@@ -12,1 +12,1 @@
 -	This file is licensed under the GPL v2, or a later version
 +	This file is licensed under the G.P.L v2, or a later version
 EOF
@@ -74,13 +74,13 @@
 diff --git a/COPYING b/COPYING
 --- a/COPYING
 +++ b/COPYING
-@@ -2 +2 @@
+@@ -2,1 +2,1 @@
 - Note that the only valid version of the GPL as far as this project
 + Note that the only valid version of the G.P.L as far as this project
-@@ -6 +6 @@
+@@ -6,1 +6,1 @@
 - HOWEVER, in order to allow a migration to GPLv3 if that seems like
 + HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
-@@ -12 +12 @@
+@@ -12,1 +12,1 @@
 -	This file is licensed under the GPL v2, or a later version
 +	This file is licensed under the G.P.L v2, or a later version
 diff --git a/COPYING b/COPYING.1
@@ -88,7 +88,7 @@
 copy to COPYING.1
 --- a/COPYING
 +++ b/COPYING.1
-@@ -6 +6 @@
+@@ -6,1 +6,1 @@
 - HOWEVER, in order to allow a migration to GPLv3 if that seems like
 + However, in order to allow a migration to GPLv3 if that seems like
 EOF
@@ -116,7 +116,7 @@
 copy to COPYING.1
 --- a/COPYING
 +++ b/COPYING.1
-@@ -6 +6 @@
+@@ -6,1 +6,1 @@
 - HOWEVER, in order to allow a migration to GPLv3 if that seems like
 + However, in order to allow a migration to GPLv3 if that seems like
 EOF
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index a23aaa0..04f0147 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -40,7 +40,7 @@
 new file mode 120000
 --- /dev/null
 +++ b/bozbar
-@@ -0,0 +1 @@
+@@ -0,0 +1,1 @@
 +xzzzy
 \ No newline at end of file
 diff --git a/frotz b/nitfol
@@ -55,7 +55,7 @@
 deleted file mode 100644
 --- a/yomin
 +++ /dev/null
-@@ -1 +0,0 @@
+@@ -1,1 +0,0 @@
 -xyzzy
 \ No newline at end of file
 EOF
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 379a831..36ac16d 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -15,7 +15,7 @@
 index 0000000..7c465af
 --- /dev/null
 +++ b/frotz
-@@ -0,0 +1 @@
+@@ -0,0 +1,1 @@
 +xyzzy
 \ No newline at end of file
 EOF
@@ -41,7 +41,7 @@
 index 7c465af..0000000
 --- a/frotz
 +++ /dev/null
-@@ -1 +0,0 @@
+@@ -1,1 +0,0 @@
 -xyzzy
 \ No newline at end of file
 EOF
@@ -68,7 +68,7 @@
 index 7c465af..df1db54 120000
 --- a/frotz
 +++ b/frotz
-@@ -1 +1 @@
+@@ -1,1 +1,1 @@
 -xyzzy
 \ No newline at end of file
 +yxyyz

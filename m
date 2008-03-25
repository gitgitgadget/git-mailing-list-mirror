From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init: show "Reinit" message even in an (existing) empty
 repository
Date: Tue, 25 Mar 2008 00:35:18 -0700
Message-ID: <7viqzbmf2h.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site>
 <alpine.OSX.1.00.0803230943500.7541@cougar>
 <alpine.LSU.1.00.0803231200010.4353@racer.site>
 <alpine.OSX.1.00.0803231326290.11994@cougar>
 <alpine.LSU.1.00.0803231404390.4353@racer.site>
 <alpine.OSX.1.00.0803231428220.13789@cougar>
 <20080323235610.GB25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803240101220.4353@racer.site>
 <20080324002302.GD25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241155300.4353@racer.site>
 <20080324122153.GF25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241611200.4353@racer.site>
 <alpine.LSU.1.00.0803241613480.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je3hd-0001Cb-Sh
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 08:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbYCYHfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 03:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYCYHfc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 03:35:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYCYHfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 03:35:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA6B91A05;
	Tue, 25 Mar 2008 03:35:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 90E551A04; Tue, 25 Mar 2008 03:35:25 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803241613480.4353@racer.site> (Johannes
 Schindelin's message of "Mon, 24 Mar 2008 16:14:52 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78159>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 1975910..ceb4727 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -168,10 +168,9 @@ static int create_default_files(const char *git_dir, const char *template_path)
>  {
>  	unsigned len = strlen(git_dir);
>  	static char path[PATH_MAX];
> -	unsigned char sha1[20];
>  	struct stat st1;
>  	char repo_version_string[10];
> 	int reinit;

Here I saw a hand-edit, but that is less of a problem...

>  	int filemode;
>  
>  	if (len > sizeof(path)-50)
> @@ -220,7 +219,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
>  	 * branch, if it does not exist yet.
>  	 */
>  	strcpy(path + len, "HEAD");
> -	reinit = !read_ref("HEAD", sha1);
> +	reinit = !access(path, R_OK);

If this is a HEAD (or .git/HEAD) that is a dangling symlink (we do still
support them, don't we?) wouldn't this access fail?

-- >8 --
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Mon, 24 Mar 2008 16:14:52 +0100
Subject: [PATCH] init: show "Reinit" message even in an (existing) empty repository

Earlier, git-init tested for a valid HEAD ref, but if the repository
was empty, there was none.  Instead, test for the existence of
the file $GIT_DIR/HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-init-db.c |    5 +++--
 t/t0001-init.sh   |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..2854868 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -167,9 +167,9 @@ static int create_default_files(const char *git_dir, const char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
-	unsigned char sha1[20];
 	struct stat st1;
 	char repo_version_string[10];
+	char junk[2];
 	int reinit;
 	int filemode;
 
@@ -219,7 +219,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	 * branch, if it does not exist yet.
 	 */
 	strcpy(path + len, "HEAD");
-	reinit = !read_ref("HEAD", sha1);
+	reinit = (!access(path, R_OK)
+		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c015405..b0289e3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -113,4 +113,21 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
 
+test_expect_success 'reinit' '
+
+	(
+		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
+
+		mkdir again &&
+		cd again &&
+		git init >out1 2>err1 &&
+		git init >out2 2>err2
+	) &&
+	grep "Initialized empty" again/out1 &&
+	grep "Reinitialized existing" again/out2 &&
+	>again/empty &&
+	test_cmp again/empty again/err1 &&
+	test_cmp again/empty again/err2
+'
+
 test_done
-- 
1.5.5.rc1.121.g1594

From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git archive
Date: Thu, 23 Oct 2008 22:33:31 +0700
Message-ID: <fcaeb9bf0810230833i3953a5abt2d2ba6ca1b751754@mail.gmail.com>
References: <gdmp0p$92r$1@ger.gmane.org>
	 <20081022130829.GC2015@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "kenneth johansson" <ken@kenjo.org>, git@vger.kernel.org
To: "Deskin Miller" <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Oct 23 17:35:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt2Db-0006uw-T2
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 17:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbYJWPdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbYJWPdr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 11:33:47 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53516 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbYJWPdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 11:33:45 -0400
Received: by mail-gx0-f16.google.com with SMTP id 9so4270gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=o0j9Q/WhJdDhHai/LJmOUpdmvSqp80vyekzYXd2Khjc=;
        b=Bjp703OnSKZTSac7MwoHRpoG8iJhB8K08d/WMZzO6vDP7EysxfpPuDcXIcIZe3PSks
         cBWBFrbUUbWy2g+mtGhXE1qke1gAlGkWmZ2uy7gnLoTGiWX+DvjUJm+Ps0Azu/e+EuRe
         ls0wXq9XrbAk1fBupty0HmlKRFGya4Nkwv6vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I3bJb8C+oFbe2UgMb/CEUeaIVkUS7I+AoHAMYpI/D737fEB+Oycycchtju1Xz0n0/T
         CcQVan08kvT9gl4NaynEUgs5i3uAUsReaDdhePG4VnLCr27Y57whVcxxA2pQlrFWhd5i
         ECDttTiwAx6C1aY0udBUCGT5Y0BkoZF+NOltw=
Received: by 10.86.59.2 with SMTP id h2mr2382347fga.40.1224776011120;
        Thu, 23 Oct 2008 08:33:31 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 23 Oct 2008 08:33:31 -0700 (PDT)
In-Reply-To: <20081022130829.GC2015@riemann.deskinm.fdns.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98974>

On 10/22/08, Deskin Miller <deskinm@umich.edu> wrote:
> On Wed, Oct 22, 2008 at 08:42:01AM +0000, kenneth johansson wrote:
>  > I was going to make a tar of the latest stable linux kernel.
>  > Done it before but now I got a strange problem.
>  >
>  > >git archive --format=tar v2.6.27.2
>  > fatal: Not a valid object name
>
>
> I had the same thing happen to me, while trying to make an archive of Git.
>  Were you perchance working in a bare repository, as I was?  I spent some time
>  looking at it and I think git archive sets up the environment in the wrong
>  order, though of course I never finished a patch so I'm going from memory:
>
>  After looking at the code again, I think the issue is that git_config is called
>  in builtin-archive.c:cmd_archive before setup_git_directory is called in
>  archive.c:write_archive.  The former ends up setting GIT_DIR to be '.git' even
>  if you're in a bare repository.  My coding skills weren't up to fixing it
>  easily; moving setup_git_directory before git_config in builtin-archive caused
>  last test of t5000 to fail: GIT_DIR=some/nonexistent/path git archive --list
>  should still display the archive formats.

The problem affects some other commands as well. I tried the following
patch, ran "make test" and discovered "git mailinfo", "git
verify-pack", "git hash-object" and "git unpack-file". A bandage patch
is at the end of this mail. Solution is as Jeff suggested: call
setup_git_directory_gently() early.

---<---
diff --git a/environment.c b/environment.c
index 0693cd9..00ed640 100644
--- a/environment.c
+++ b/environment.c
@@ -49,14 +49,18 @@ static char *work_tree;

 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
+int git_dir_discovered;

 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
+	if (!git_dir) {
+		if (!git_dir_discovered)
+			die("Internal error: .git must be relocated at cwd by setup_git_*");
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	}
 	git_object_dir = getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
diff --git a/setup.c b/setup.c
index 78a8041..d404c21 100644
--- a/setup.c
+++ b/setup.c
@@ -368,6 +368,7 @@ const char *read_gitfile_gently(const char *path)
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
+extern int git_dir_discovered;
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
@@ -472,6 +473,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		chdir("..");
 	}
+	/* It is safe to call setup_git_env() now */
+	git_dir_discovered = 1;

 	inside_git_dir = 0;
 	if (!work_tree_env)
---<---


Bandage patch:

---<---
diff --git a/builtin-archive.c b/builtin-archive.c
index 432ce2a..5ea0a12 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -110,7 +110,9 @@ static const char *extract_remote_arg(int *ac,
const char **av)
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	const char *remote = NULL;
+	int nongit;

+	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_default_config, NULL);

 	remote = extract_remote_arg(&argc, argv);
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index e890f7a..5d401fb 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -916,10 +916,9 @@ static const char mailinfo_usage[] =
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
+	int nongit;

-	/* NEEDSWORK: might want to do the optional .git/ directory
-	 * discovery
-	 */
+	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_default_config, NULL);

 	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 25a29f1..35a4eb2 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -115,7 +115,9 @@ int cmd_verify_pack(int argc, const char **argv,
const char *prefix)
 	int verbose = 0;
 	int no_more_options = 0;
 	int nothing_done = 1;
+	int nongit;

+	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_default_config, NULL);
 	while (1 < argc) {
 		if (!no_more_options && argv[1][0] == '-') {
diff --git a/hash-object.c b/hash-object.c
index 20937ff..a52b6be 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -78,19 +78,20 @@ int main(int argc, const char **argv)
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	const char *errstr = NULL;
+	int nongit;

 	type = blob_type;

-	git_config(git_default_config, NULL);
-
 	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);

-	if (write_object) {
-		prefix = setup_git_directory();
-		prefix_length = prefix ? strlen(prefix) : 0;
-		if (vpath && prefix)
-			vpath = prefix_filename(prefix, prefix_length, vpath);
-	}
+	prefix = setup_git_directory_gently(&nongit);
+	git_config(git_default_config, NULL);
+	prefix_length = prefix ? strlen(prefix) : 0;
+	if (vpath && prefix)
+		vpath = prefix_filename(prefix, prefix_length, vpath);
+
+	if (write_object && nongit)
+		die("Git repository required");

 	if (stdin_paths) {
 		if (hashstdin)
diff --git a/unpack-file.c b/unpack-file.c
index bcdc8bb..1a58d72 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -27,10 +27,10 @@ int main(int argc, char **argv)

 	if (argc != 2)
 		usage("git-unpack-file <sha1>");
+	setup_git_directory();
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);

-	setup_git_directory();
 	git_config(git_default_config, NULL);

 	puts(create_temp_file(sha1));
---<---
-- 
Duy

From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH] archive: fix setup to work in bare repositories
Date: Wed, 22 Oct 2008 16:37:22 -0400
Message-ID: <20081022203722.GD2015@riemann.deskinm.fdns.net>
References: <gdmp0p$92r$1@ger.gmane.org> <20081022130829.GC2015@riemann.deskinm.fdns.net> <gdnsca$92r$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: kenneth johansson <ken@kenjo.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:42:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskXO-0004G6-7v
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYJVUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbYJVUkv
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:40:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:31402 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYJVUku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:40:50 -0400
Received: by wx-out-0506.google.com with SMTP id h27so1279502wxd.4
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=pDX3IthwHDafJv/6+7eIjwOSTWVdBtl+x5nTMPBZ9r8=;
        b=W0gti5aLpWilKR+UJyuEasXGA0t0722Gi/YRUPcHM5XAs9cK/qgb6qUWWseoBXsKwG
         ozg1ovqOjfSOCK63f16nLTn/x9k0E6deuqi9T0+oRh0jaxnLDWOcOimaXiAPXquTnKG+
         YlrKVKs2WA2nPM7RHWqljjX62/rdvDNbnUJXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=uS9kMNzEFn7TvGtZGTjptA8qKAeZ6pF9L8BqpPoLjmQNgqnT5/do07G0Znr8bSGBRy
         W3mJG1DWN+sh34uh6PmaN4O6ophiTJsT2XGyopJ4oYiZkErEE1YwIuq0nVxriJoBZCTl
         GlyJr2QVkpL0Apt+RVILgq7dAusoRJopzE19c=
Received: by 10.65.212.18 with SMTP id o18mr9010027qbq.0.1224708048110;
        Wed, 22 Oct 2008 13:40:48 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id q16sm5890732qbq.1.2008.10.22.13.40.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 13:40:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <gdnsca$92r$2@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98908>

cmd_archive was calling git_config -> setup_git_env prior to
write_archive calling setup_git_directory.  In a bare repository, the
former will set git_dir to be '.git' since the latter has not
determined that it's operating in a bare repository yet.

Things are complicated, however, by the fact that git archive --list
should work from anywhere, not just in git repositories, so that
argument needs to be checked for before setup_git_directory is called.
---
On Wed, Oct 22, 2008 at 06:45:30PM +0000, kenneth johansson wrote:
> On Wed, 22 Oct 2008 09:08:29 -0400, Deskin Miller wrote:
> 
> > On Wed, Oct 22, 2008 at 08:42:01AM +0000, kenneth johansson wrote:
> >> I was going to make a tar of the latest stable linux kernel. Done it
> >> before but now I got a strange problem.
> >> 
> >> >git archive --format=tar v2.6.27.2
> >> fatal: Not a valid object name
> > 
> > I had the same thing happen to me, while trying to make an archive of
> > Git. Were you perchance working in a bare repository, as I was?  I spent
> > some time looking at it and I think git archive sets up the environment
> > in the wrong order, though of course I never finished a patch so I'm
> > going from memory:
> 
> Yes it was a bare repository.
> 
> > 
> > After looking at the code again, I think the issue is that git_config is
> > called in builtin-archive.c:cmd_archive before setup_git_directory is
> > called in archive.c:write_archive.  The former ends up setting GIT_DIR
> > to be '.git' even if you're in a bare repository.  My coding skills
> > weren't up to fixing it easily; moving setup_git_directory before
> > git_config in builtin-archive caused last test of t5000 to fail:
> > GIT_DIR=some/nonexistent/path git archive --list should still display
> > the archive formats.
> 
> if I do
> GIT_DIR=. git  archive --format=tar v2.6.27.2
> 
> it does work so it looks like you are on the right track.

Looks like this works, but I think it's really ugly; let me know if you have
any suggestions for improvement.

 archive.c           |   13 +++++++++++++
 archive.h           |    1 +
 builtin-archive.c   |    4 +++-
 t/t5000-tar-tree.sh |    9 +++++++++
 4 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index e2280df..d8e4373 100644
--- a/archive.c
+++ b/archive.c
@@ -325,6 +325,19 @@ static int parse_archive_args(int argc, const char **argv,
 	return argc;
 }
 
+int archive_parse_options_early(int argc, const char **argv)
+{
+	int i;
+	for (i = 1; i < argc; ++i) {
+		if (!strcmp(argv[i], "--list")) {
+			for (i = 0; i < ARRAY_SIZE(archivers); i++)
+				printf("%s\n", archivers[i].name);
+			exit(0);
+		}
+	}
+	return 0;
+}
+
 int write_archive(int argc, const char **argv, const char *prefix,
 		int setup_prefix)
 {
diff --git a/archive.h b/archive.h
index 0b15b35..ff5b6cf 100644
--- a/archive.h
+++ b/archive.h
@@ -24,6 +24,7 @@ extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
+extern int archive_parse_options_early(int argc, const char **argv);
 extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index 432ce2a..e518113 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -111,6 +111,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	const char *remote = NULL;
 
+	archive_parse_options_early(argc, argv);
+	prefix = setup_git_directory();
 	git_config(git_default_config, NULL);
 
 	remote = extract_remote_arg(&argc, argv);
@@ -119,5 +121,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, 1);
+	return write_archive(argc, argv, prefix, 0);
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e395ff4..53fe25c 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -192,4 +192,13 @@ test_expect_success \
     'git archive --list outside of a git repo' \
     'GIT_DIR=some/non-existing/directory git archive --list'
 
+test_expect_success \
+    'git archive inside bare repository' \
+    'git clone --bare "$(pwd)"/.git trash-bare &&
+    cd trash-bare &&
+    git archive --format=tar HEAD >/dev/null &&
+    cd .. &&
+    rm -rf trash-bare
+    '
+
 test_done
-- 
1.6.0.2.554.g3041b

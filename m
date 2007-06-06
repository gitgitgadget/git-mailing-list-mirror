From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git does the wrong thing with ambiguous names
Date: Thu, 7 Jun 2007 01:33:27 +0200
Message-ID: <20070606233327.GD3969@steel.home>
References: <4667319C.9070302@nrlssc.navy.mil> <20070606225826.GC3969@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 07 01:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw50U-00014i-Eu
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 01:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935346AbXFFXdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935353AbXFFXdc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 19:33:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:60875 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935346AbXFFXdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 19:33:31 -0400
Received: from tigra.home (Fa87f.f.strato-dslnet.de [195.4.168.127])
	by post.webmailer.de (mrclete mo8) (RZmta 7.2)
	with ESMTP id S05378j56IfX5L ; Thu, 7 Jun 2007 01:33:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6CAEC277BD;
	Thu,  7 Jun 2007 01:33:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DB913BEA7; Thu,  7 Jun 2007 01:33:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070606225826.GC3969@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49334>

Alex Riesen, Thu, Jun 07, 2007 00:58:26 +0200:
> Brandon Casey, Thu, Jun 07, 2007 00:13:48 +0200:
> > 
> > When a branch and tag have the same name, a git-checkout using that name 
> > succeeds (exits zero without complaining), switches to the _branch_, but 
> > updates the working directory contents to that specified by the _tag_. 
> > git-status show modified files.
> 
> Bad. To reproduce:
> 
> mkdir a && cd a && git init && :> a && git add . && git commit -m1 &&
> :>b && git add . && git commit -m2 && git tag master HEAD^ &&
> find .git/refs/ && gco -b new && gco master && git status
> 

git-rev-parse actually warns about ambguities:

    $ git-rev-parse --verify master
    warning: refname 'master' is ambiguous.
    dd5cdc387f2160bf04d02ac08dfdaf952f769357

It's just that the warning is thrown away in git-checkout.sh

A quick and _very_ messy fix could like like that:

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..3c3bc4e 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -368,6 +368,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				show_datestring("--min-age=", arg+8);
 				continue;
 			}
+			if (!strcmp(arg, "--fail-ambiguous")) {
+				fail_ambiguous_refs = 1;
+				continue;
+			}
 			if (show_flag(arg) && verify)
 				die("Needed a single revision");
 			continue;
diff --git a/cache.h b/cache.h
index 8a9d1f3..4c532c6 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
+extern int fail_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
diff --git a/environment.c b/environment.c
index 9d3e5eb..872ab36 100644
--- a/environment.c
+++ b/environment.c
@@ -18,6 +18,7 @@ int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
+int fail_ambiguous_refs = 0;
 int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/git-checkout.sh b/git-checkout.sh
index 6b6facf..4c07fe5 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -57,6 +57,13 @@ while [ "$#" != "0" ]; do
 		usage
 		;;
 	*)
+		if ! git-rev-parse --verify --fail-ambiguous "$arg^0" \
+		    2>/dev/null
+		then
+		    echo >&2 "$arg is ambiguous"
+		    find "$GIT_DIR/refs/" |grep -F "$arg"|sed -e 's|.git/|  |'
+		    exit 1
+		fi
 		if rev=$(git-rev-parse --verify "$arg^0" 2>/dev/null)
 		then
 			if [ -z "$rev" ]; then
diff --git a/sha1_name.c b/sha1_name.c
index 7df01af..d094d41 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -345,6 +345,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 
 	if (warn_ambiguous_refs && refs_found > 1)
 		fprintf(stderr, warning, len, str);
+	if (fail_ambiguous_refs && refs_found > 1) {
+		fprintf(stderr, "found %d refs\n", refs_found);
+		return -1;
+	}
 
 	if (reflog_len) {
 		int nth, i;

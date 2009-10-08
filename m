From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git archive and trailing "/" in prefix
Date: Thu, 08 Oct 2009 18:46:54 +0200
Message-ID: <4ACE177E.209@lsrfire.ath.cx>
References: <loom.20091008T172303-658@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 18:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwHh-0005sz-Kt
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 18:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718AbZJHQrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 12:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbZJHQrw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 12:47:52 -0400
Received: from india601.server4you.de ([85.25.151.105]:38672 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbZJHQrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 12:47:51 -0400
Received: from [10.0.1.101] (p57B7CC44.dip.t-dialin.net [87.183.204.68])
	by india601.server4you.de (Postfix) with ESMTPSA id 445992F806A;
	Thu,  8 Oct 2009 18:47:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <loom.20091008T172303-658@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129700>

Sergio Callegari schrieb:
> Hi!
> 
> The git-archive man page indicates that if the --prefix option is passed to
> git-archive, it is compulsory to end the prefix with a "/"
> 
>  git archive [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>] ...
> 
> As a matter of fact, the archiver behaves quite strangely if that slash is
> missing. Files in the root of the working dir are added to the archive with
> their own name modified by the prefix and the same happens for working dir
> sub-directories. However, no file present in the sub-directories, nor
> sub-sub-directories are added.

The latter is a bug.

> I would like to know if there some reason why a trailing "/" is not added
> automatically to the prefix when it is missing and the prefix is not empty.
> Would that break anything?

The --prefix option is intended to add a string to the beginning (i.e. "to
prefix") of the name of the archive entries.  I'm not sure if there's a use
case for anything else than adding a fake directory for all entries to live
in (thus requiring a trailing slash), but I also don't see why we should
disallow it.

The following patch fixes handling of prefixes without trailing slashes by
taking it out of the hands of get_pathspec() and read_tree_recursive() --
which can only handle prefixes that are path components -- and adding the
prefix later, in write_archive_entry().  

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/archive.c b/archive.c
index 73b8e8a..0cc79d2 100644
--- a/archive.c
+++ b/archive.c
@@ -115,6 +115,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 
 	strbuf_reset(&path);
 	strbuf_grow(&path, PATH_MAX);
+	strbuf_add(&path, args->base, args->baselen);
 	strbuf_add(&path, base, baselen);
 	strbuf_addstr(&path, filename);
 	path_without_prefix = path.buf + args->baselen;
@@ -187,8 +188,8 @@ int write_archive_entries(struct archiver_args *args,
 		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
 	}
 
-	err =  read_tree_recursive(args->tree, args->base, args->baselen, 0,
-			args->pathspec, write_archive_entry, &context);
+	err = read_tree_recursive(args->tree, "", 0, 0, args->pathspec,
+				  write_archive_entry, &context);
 	if (err == READ_TREE_RECURSIVE)
 		err = 0;
 	return err;
@@ -211,7 +212,7 @@ static const struct archiver *lookup_archiver(const char *name)
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec = get_pathspec(ar_args->base, pathspec);
+	ar_args->pathspec = get_pathspec("", pathspec);
 }
 
 static void parse_treeish_arg(const char **argv,

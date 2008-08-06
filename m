From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: Documentation: user-manual: "git commit -a" doesn't motivate
 .gitignore
Date: Wed, 6 Aug 2008 17:29:58 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu>
 <20080806214747.GY32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 00:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQrXm-0005M0-MH
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 00:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbYHFWak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbYHFWak
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 18:30:40 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:36957 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbYHFWaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 18:30:39 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m76MU0px029117;
	Wed, 6 Aug 2008 17:30:00 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m76MTwYf021848;
	Wed, 6 Aug 2008 17:30:00 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <20080806214747.GY32057@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91547>

Miklos Vajna wrote:

> On Wed, Aug 06, 2008 at 04:22:00PM -0500, Jonathan Nieder <jrnieder@uchicago.edu> wrote:
> > 	happy to know.  Maybe the sort of person that wants to track the
> > 	exact contents of the working tree would prefer
> > 	"git commit -a -i ." over "git commit -a"?
> 
> If you want so, then probably git add -A && git commit is easier.

Hmm.  I don't want it myself, but it seemed like the spirit behind
the lines I mentioned in the user manual.  Maybe something like this
(untested) would serve such people even better.

If anyone actually wants this, I'd be glad to make tests and document
it.  Thanks for the pointer.

-- snipsnip --
Subject: git commit --addremove: add and update all files

This makes git commit -A a shortcut for git add -A && git commit.  It
saves keystrokes, but more importantly it seems to be conceptually the
right thing thing for users who have perfect .gitignore files and want
to ignore the index.
---
 builtin-commit.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index b783e6e..e3f645e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -50,7 +50,8 @@ static char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, addremove, edit_flag, also, interactive, only;
+static int amend, signoff;
 static int quiet, verbose, no_verify, allow_empty;
 static char *untracked_files_arg;
 /*
@@ -99,6 +100,7 @@ static struct option builtin_commit_options[] = {
 
 	OPT_GROUP("Commit contents options"),
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
+	OPT_BOOLEAN('A', "addremove", &addremove, "commit all changed files, including untracked"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
@@ -788,8 +790,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			free(enc);
 	}
 
-	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.");
+	if (!!also + !!only + !!all + !!addremove + !!interactive > 1)
+		die("Only one of --include/--only/--all/--addremove/--interactive can be used.");
 	if (argc == 0 && (also || (only && !amend)))
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
@@ -823,6 +825,16 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else if (interactive && argc > 0)
 		die("Paths with --interactive does not make sense.");
 
+	if (addremove) {
+		all = 1;
+		also = 1;
+	}
+	if (addremove && !argc) {
+		static const char *here[2] = {".", NULL };
+		argc = 1;
+		*argv = here;
+	}
+
 	return argc;
 }
 
-- 
1.6.0.rc1.228.ge730

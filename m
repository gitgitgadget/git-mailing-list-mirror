From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 9/8] Teach git var to run the editor
Date: Fri, 30 Oct 2009 05:49:58 -0500
Message-ID: <20091030104958.GJ1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3otf-0005Hh-Dt
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993AbZJ3Kjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbZJ3Kjn
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:39:43 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54741 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbZJ3Kjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:39:42 -0400
Received: by ywh40 with SMTP id 40so2541414ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DZa1AdQTFb12QvvCete6YygZzJLbPbMEmeM3o8QisBQ=;
        b=gljGW9vI6GNsV2rJKCVQSdvSZxVIccEvGuMfGHVStgG80Z7PUJmZPPxs5ZYOeXvGQy
         5DK/4RP6x25sa1uqWKnG2GY5YyHZgpDoNt7+aKQRUxGpqIBPqZobJ4y44dxYP4oMvP/U
         ruZhGXjFjunK0ehOK8k7ZmgFNMvRAd/yCS9Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i8Nlc78fCWyf46tMioqMY4xzLpD7R8ibA95v4yLpzpYH9cDrPbbXD7xgaDqQqfIMQl
         H1XI5Lmwuy72X/urBcqpxheQpObdXv0LyPeo6yD+m2j+ds3U7EiP/edu479vUTb+Ful6
         5emUu6qaQRTe0kCnRzm0RTJ5JteItRw5xZtqQ=
Received: by 10.90.45.11 with SMTP id s11mr3872857ags.72.1256899187155;
        Fri, 30 Oct 2009 03:39:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm1312800yxg.66.2009.10.30.03.39.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:39:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131693>

Expose the functionality of launch_editor() for scripts to use.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As I mentioned in the cover letter, the analogous change for the pager
is a little more tricky.  I was wrong to blame Windows for this.  The
excellent commit ea27a18 (spawn pager via run_command interface,
2008-07-22) explains all.

The difficulties: the pager receives input from the current process
and the run_pager() function does not take an argument to take input
from somewhere else.  Also the pager is not exec()'d directly, so the
current process sticks around uselessly until it quits and it is a
little tricky to find the 'less' exit status for "git var --run" to
use as well.

 Documentation/git-var.txt |   10 ++++++++-
 var.c                     |   48 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index ef6aa81..1bfdb6c 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -8,7 +8,10 @@ git-var - Show a git logical variable
 
 SYNOPSIS
 --------
-'git var' [ -l | <variable> ]
+[verse]
+'git var' <variable>
+'git var' -l
+'git var' --run <variable> [ args ]
 
 DESCRIPTION
 -----------
@@ -22,6 +25,11 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of 'git config -l'.)
 
+--run variable [args]::
+	If the specified logical variable represents a command, run that
+	command.  For example, `git var --run GIT_EDITOR foo.txt` edits
+	foo.txt with the text editor git is configured to use.
+
 EXAMPLE
 --------
 	$ git var GIT_AUTHOR_IDENT
diff --git a/var.c b/var.c
index 18dad57..c97b2e6 100644
--- a/var.c
+++ b/var.c
@@ -6,7 +6,8 @@
 #include "cache.h"
 #include "exec_cmd.h"
 
-static const char var_usage[] = "git var [-l | <variable>]";
+static const char var_usage[] =
+	"git var { -l | <variable> | --run <variable> [args] }";
 
 static const char *editor(int flag)
 {
@@ -26,16 +27,25 @@ static const char *pager(int flag)
 	return pgm;
 }
 
+static int run_editor(int argc, const char *const *argv)
+{
+	if (argc > 1)
+		return error("cannot launch editor with more than one file");
+
+	return launch_editor(argv[0], NULL, NULL);
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
+	int (*run)(int argc, const char *const *argv);
 };
 static struct git_var git_vars[] = {
-	{ "GIT_COMMITTER_IDENT", git_committer_info },
-	{ "GIT_AUTHOR_IDENT",   git_author_info },
-	{ "GIT_EDITOR", editor },
-	{ "GIT_PAGER", pager },
-	{ "", NULL },
+	{ "GIT_COMMITTER_IDENT", git_committer_info, NULL },
+	{ "GIT_AUTHOR_IDENT", git_author_info, NULL },
+	{ "GIT_EDITOR", editor, run_editor },
+	{ "GIT_PAGER", pager, NULL },
+	{ "", NULL, NULL },
 };
 
 static void list_vars(void)
@@ -59,6 +69,17 @@ static const char *read_var(const char *var)
 	return val;
 }
 
+static int run_var_cmd(const char *var, int argc, char **argv)
+{
+	struct git_var *ptr;
+
+	for (ptr = git_vars; ptr->read; ptr++)
+		if (ptr->run && strcmp(var, ptr->name) == 0)
+			return ptr->run(argc, (const char *const *)argv);
+
+	return error("%s is not a variable command", var);
+}
+
 static int show_config(const char *var, const char *value, void *cb)
 {
 	if (value)
@@ -72,12 +93,23 @@ int main(int argc, char **argv)
 {
 	const char *val;
 	int nongit;
+
+	git_extract_argv0_path(argv[0]);
+
+	if (argv[1] && strcmp(argv[1], "--run") == 0) {
+		if (argc <= 2)
+			usage(var_usage);
+
+		setup_git_directory_gently(&nongit);
+		git_config(git_default_config, NULL);
+
+		return run_var_cmd(argv[2], argc - 3, argv + 3);
+	}
+
 	if (argc != 2) {
 		usage(var_usage);
 	}
 
-	git_extract_argv0_path(argv[0]);
-
 	setup_git_directory_gently(&nongit);
 	val = NULL;
 
-- 
1.6.5.2

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] ls-files: fix broken --no-empty-directory
Date: Tue, 10 Mar 2009 15:11:11 -0400
Message-ID: <20090310191111.GA27662@sigill.intra.peff.net>
References: <20090308012049.GA18616@coredump.intra.peff.net> <20090308012722.GB18714@coredump.intra.peff.net> <20090308211312.GE4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 20:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh7Nh-0001wE-R0
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 20:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZCJTLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZCJTLP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 15:11:15 -0400
Received: from peff.net ([208.65.91.99]:58556 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbZCJTLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 15:11:14 -0400
Received: (qmail 13164 invoked by uid 107); 10 Mar 2009 19:11:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 10 Mar 2009 15:11:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 15:11:11 -0400
Content-Disposition: inline
In-Reply-To: <20090308211312.GE4371@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112840>

On Sun, Mar 08, 2009 at 10:13:12PM +0100, Miklos Vajna wrote:

> > +		OPT_BIT(0, "no-empty-directory", &dir.flags,
> > +			"don't show empty directories",
> >  			DIR_HIDE_EMPTY_DIRECTORIES),
> >  		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
> >  			"show unmerged files in the output"),
> 
> Thanks for catching this. But then why not using PARSE_OPT_NONEG?
> 
> That would avoid --no-no-empty-directory.

I think either we don't care about negation, in which case it is not
hurting anybody to support --no-no-empty-directory, or we do, in which
case you actually want to do the negation properly. Which would be
something like:

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 437c366..2c5f7a5 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -427,6 +427,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
 	int require_work_tree = 0, show_tag = 0;
+	int show_empty_directories = 1;
 	struct dir_struct dir;
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
@@ -454,9 +455,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			"show 'other' directories' name only",
 			DIR_SHOW_OTHER_DIRECTORIES),
-		OPT_BIT(0, "no-empty-directory", &dir.flags,
-			"don't show empty directories",
-			DIR_HIDE_EMPTY_DIRECTORIES),
+		OPT_BOOLEAN(0, "empty-directory", &show_empty_directories,
+			"show empty directories (on by default)"),
 		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
 			"show unmerged files in the output"),
 		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], "pattern",
@@ -506,6 +506,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		show_stage = 1;
 	if (dir.exclude_per_dir)
 		exc_given = 1;
+	if (!show_empty_directories)
+		dir.flags |= DIR_HIDE_EMPTY_DIRECTORIES;
 
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();


which is even still a little confusing, as you get "--empty-directory"
in the usage message. But you would almost never want to use that, as it
is already the default.

-Peff

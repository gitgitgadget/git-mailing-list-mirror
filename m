From: Jeff King <peff@peff.net>
Subject: Re: Tiny bug report, interaction between alias and help
Date: Sat, 19 Jan 2008 12:41:47 -0500
Message-ID: <20080119174146.GA3913@coredump.intra.peff.net>
References: <20080119142750.GA9182@phenix.progiciels-bpi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Pinard <pinard@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Sat Jan 19 18:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGHiH-0000nF-CU
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 18:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYASRlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 12:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbYASRlv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 12:41:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3923 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbYASRlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 12:41:49 -0500
Received: (qmail 25016 invoked by uid 111); 19 Jan 2008 17:41:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 19 Jan 2008 12:41:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Jan 2008 12:41:47 -0500
Content-Disposition: inline
In-Reply-To: <20080119142750.GA9182@phenix.progiciels-bpi.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71123>

On Sat, Jan 19, 2008 at 09:27:50AM -0500, Fran=E7ois Pinard wrote:

> Page http://git.or.cz/#community says to report git bugs on this list=
=2E
> This is a tiny bug for "git version 1.5.4.rc3.14.g44397-dirty".  If t=
he
> "bug" is inappropriate, please then consider this as a suggestion!  :=
-)

I think it is more of a feature request than a bug, and as such should
probably be dealt with post-1.5.4.

> If, after "git config --global alias.st status", say, I try:
>
>   git st --help
>
> git then replies:
>
>   No manual entry for git-st
>
> It would be nice if --help was interacting better with aliases.

Maybe something like the following would be nicer. It would be a lot
cleaner if the parsing were done by parseopt (which is hopefully going
to happen post-1.5.4).

-- >8 --
help: print alias definitions

When asking for "git help alias", we unhelpfully just
tried to look for the manpage for "git-alias" which almost
certainly doesn't exist. Instead, let's print out the alias
definition.
---
 help.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/help.c b/help.c
index 1302a61..35176eb 100644
--- a/help.c
+++ b/help.c
@@ -334,6 +334,27 @@ static void show_html_page(const char *git_cmd)
 	execl_git_cmd("help--browse", page, NULL);
 }
=20
+static const char *alias_help_cb_key;
+static char *alias_help_cb_value;
+static int alias_help_cb(const char *k, const char *v)
+{
+	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_help_cb_key))
+		alias_help_cb_value =3D xstrdup(v);
+	return 0;
+}
+
+static int show_alias_help(const char *git_cmd)
+{
+	alias_help_cb_key =3D git_cmd;
+	alias_help_cb_value =3D NULL;
+	git_config(alias_help_cb);
+	if (!alias_help_cb_value)
+		return 0;
+	printf("`git %s' is aliased to `%s'\n", git_cmd, alias_help_cb_value)=
;
+	free(alias_help_cb_value);
+	return 1;
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n"=
, cmd);
@@ -349,6 +370,9 @@ int cmd_version(int argc, const char **argv, const =
char *prefix)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	const char *help_cmd =3D argv[1];
+	int nongit;
+
+	setup_git_directory_gently(&nongit);
=20
 	if (argc < 2) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -362,21 +386,30 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	else if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
-		show_html_page(argc > 2 ? argv[2] : NULL);
+		const char *cmd =3D argc > 2 ? argv[2] : NULL;
+		if (cmd && show_alias_help(cmd))
+			return 0;
+		show_html_page(cmd);
 	}
=20
 	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
-		show_info_page(argc > 2 ? argv[2] : NULL);
+		const char *cmd =3D argc > 2 ? argv[2] : NULL;
+		if (cmd && show_alias_help(cmd))
+			return 0;
+		show_info_page(cmd);
 	}
=20
 	else if (!strcmp(help_cmd, "--man") || !strcmp(help_cmd, "-m")) {
-		show_man_page(argc > 2 ? argv[2] : NULL);
+		const char *cmd =3D argc > 2 ? argv[2] : NULL;
+		if (cmd && show_alias_help(cmd))
+			return 0;
+		show_man_page(cmd);
 	}
=20
 	else {
-		int nongit;
+		if (show_alias_help(help_cmd))
+			return 0;
=20
-		setup_git_directory_gently(&nongit);
 		git_config(git_help_config);
 		if (help_default_format)
 			parse_help_format(help_default_format);
--=20
1.5.4.rc3.1129.g3e1ca-dirty

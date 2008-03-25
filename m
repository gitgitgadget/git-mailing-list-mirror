From: SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] shortlog: initialize nongit variable
Date: Tue, 25 Mar 2008 17:03:56 +0100
Message-ID: <20080325160356.GC6506@neumann>
References: <1206456377-2735-1-git-send-email-szeder@ira.uka.de> <fcaeb9bf0803250839p721e1870l8fbc8715b3c6e7cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 17:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeBdo-0002JT-AE
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 17:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbYCYQEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 12:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbYCYQD7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 12:03:59 -0400
Received: from francis.fzi.de ([141.21.7.5]:54099 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755823AbYCYQD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 12:03:58 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 17:03:56 +0100
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0803250839p721e1870l8fbc8715b3c6e7cb@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-OriginalArrivalTime: 25 Mar 2008 16:03:56.0085 (UTC) FILETIME=[D427F650:01C88E91]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78195>

On Tue, Mar 25, 2008 at 10:39:38PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Tue, Mar 25, 2008 at 9:46 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > setup_git_directory_gently() only modifies the value of the nongit
> >  variable if we are not in a git repository, therefore nongit is le=
ft
> >  uninitialized if we are in a git repository.  This sometimes broke
> >  shortlog when it was not fed with a log on its standard input.
>=20
> cmd_help() has the same problem. Can you make a similar patch for
> cmd_help as well?
Yes, I saw that, too, but:

While it's true that cmd_help()'s nongit variable will not be
initialized if we are in a git repository, cmd_help() never touches
nongit after calling setup_git_directory_gently(), so there is no
problem after all.

However, it might be better to let setup_git_directory_gently() set
*nongit_ok to 0 if we are in a git repository.  Patch appended.


Regards,
G=E1bor



Always set *nongit_ok in setup_git_directory_gently()

setup_git_directory_gently() only modified the value of its *nongit_ok
argument if we were not in a git repository.  Now it will always set it
to 0 when we are inside a repository.

Also remove now unnecessary initializations in the callers of this
function.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 builtin-bundle.c     |    2 +-
 builtin-config.c     |    2 +-
 builtin-diff-files.c |    2 +-
 builtin-ls-remote.c  |    2 +-
 git.c                |    2 +-
 setup.c              |    8 ++++++++
 6 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9f38e21..ac476e7 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -14,7 +14,7 @@ static const char *bundle_usage=3D"git-bundle (create=
 <bundle> <git-rev-list args>
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
-	int nongit =3D 0;
+	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd =3D -1;
 	char buffer[PATH_MAX];
diff --git a/builtin-config.c b/builtin-config.c
index 2b9a426..c34bc8b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -264,7 +264,7 @@ static int get_colorbool(int argc, const char **arg=
v)
=20
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit =3D 0;
+	int nongit;
 	char* value;
 	const char *file =3D setup_git_directory_gently(&nongit);
=20
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 4abe3c2..e2306c1 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -16,7 +16,7 @@ COMMON_DIFF_OPTIONS_HELP;
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	int nongit =3D 0;
+	int nongit;
 	int result;
=20
 	prefix =3D setup_git_directory_gently(&nongit);
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 8907a89..06ab8da 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -31,7 +31,7 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 {
 	int i;
 	const char *dest =3D NULL;
-	int nongit =3D 0;
+	int nongit;
 	unsigned flags =3D 0;
 	const char *uploadpack =3D NULL;
 	const char **pattern =3D NULL;
diff --git a/git.c b/git.c
index 13de801..70458af 100644
--- a/git.c
+++ b/git.c
@@ -142,7 +142,7 @@ static int split_cmdline(char *cmdline, const char =
***argv)
=20
 static int handle_alias(int *argcp, const char ***argv)
 {
-	int nongit =3D 0, envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
+	int nongit, envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
 	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
diff --git a/setup.c b/setup.c
index 41e298b..3d2d958 100644
--- a/setup.c
+++ b/setup.c
@@ -326,6 +326,14 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	int len, offset;
=20
 	/*
+	 * Let's assume that we are in a git repository.
+	 * If it turns out later that we are somewhere else, the value will b=
e
+	 * updated accordingly.
+	 */
+	if (nongit_ok)
+		*nongit_ok =3D 0;
+
+	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery, but we still do repository
 	 * validation.
--=20
1.5.5.rc1

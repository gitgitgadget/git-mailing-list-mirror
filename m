From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] clone: accept config options on the command line
Date: Thu, 9 Jun 2011 16:56:19 -0400
Message-ID: <20110609205619.GC4671@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
 <20110609155740.GJ25507@sigill.intra.peff.net>
 <BANLkTinBqSVpREg6667Ydf2JjL3r14BgRA@mail.gmail.com>
 <20110609171214.GA30888@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 22:56:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUmHE-0004df-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 22:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab1FIU4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 16:56:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32926
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022Ab1FIU4X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 16:56:23 -0400
Received: (qmail 19457 invoked by uid 107); 9 Jun 2011 20:56:30 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 16:56:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 16:56:19 -0400
Content-Disposition: inline
In-Reply-To: <20110609171214.GA30888@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175576>

On Thu, Jun 09, 2011 at 01:12:14PM -0400, Jeff King wrote:

> > > +-c <key>=3D<value>::
> > > + =C2=A0 =C2=A0 =C2=A0 Set a configuration variable in the newly-=
cloned repository. The
> >=20
> > Shouldn't this be 'newly-created repository', because the
> > configuration variables are set before the actual cloning, but afte=
r
> > initializing the new repository.
>=20
> Yeah, I think your wording is better. It might also make sense to
> explicitly say that the config takes effect during the fetch and
> checkout phases of the clone (there's otherwise no point, of course, =
but
> it never hurts to make the documentation clear).

There was also an unrelated typo in the newly-added documentation. So
here's a replacement 10/10 with the fixed documentation.

-- >8 --
Subject: [PATCH] clone: accept config options on the command line

Clone does all of init, "remote add", fetch, and checkout
without giving the user a chance to intervene and set any
configuration. This patch allows you to set config options
in the newly created repository after the clone, but before
we do any other operations.

In many cases, this is a minor convenience over something
like:

  git clone git://...
  git config core.whatever true

But in some cases, it can bring extra efficiency by changing
how the fetch or checkout work. For example, setting
line-ending config before the checkout avoids having to
re-checkout all of the contents with the correct line
endings.

It also provides a mechanism for passing information to remote
helpers during a clone; the helpers may read the git config
to influence how they operate.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt |   11 +++++++++++
 builtin/clone.c             |   21 ++++++++++++++++++++-
 t/t5707-clone-config.sh     |   40 +++++++++++++++++++++++++++++++++++=
+++++
 3 files changed, 71 insertions(+), 1 deletions(-)
 create mode 100755 t/t5707-clone-config.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b093e45..4b8b26b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -159,6 +159,17 @@ objects from the source repository into a pack in =
the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
=20
+--config <key>=3D<value>::
+-c <key>=3D<value>::
+	Set a configuration variable in the newly-created repository;
+	this takes effect immediately after the repository is
+	initialized, but before the remote history is fetched or any
+	files checked out.  The key is in the same format as expected by
+	linkgit:git-config[1] (e.g., `core.eol=3Dtrue`). If multiple
+	values are given for the same key, each value will be written to
+	the config file. This makes it safe, for example, to add
+	additional fetch refspecs to the origin remote.
+
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.  A shallow repository has a
diff --git a/builtin/clone.c b/builtin/clone.c
index f579794..a15784a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -46,6 +46,7 @@ static const char *real_git_dir;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress;
+static struct string_list option_config;
=20
 static struct option builtin_clone_options[] =3D {
 	OPT__VERBOSITY(&option_verbosity),
@@ -83,7 +84,8 @@ static struct option builtin_clone_options[] =3D {
 		    "create a shallow clone of that depth"),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
 		   "separate git dir from working tree"),
-
+	OPT_STRING_LIST('c', "config", &option_config, "key=3Dvalue",
+			"set config inside the new repository"),
 	OPT_END()
 };
=20
@@ -364,6 +366,22 @@ static void write_remote_refs(const struct ref *lo=
cal_refs)
 	clear_extra_refs();
 }
=20
+static int write_one_config(const char *key, const char *value, void *=
data)
+{
+	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
+}
+
+static void write_config(struct string_list *config)
+{
+	int i;
+
+	for (i =3D 0; i < config->nr; i++) {
+		if (git_config_parse_parameter(config->items[i].string,
+					       write_one_config, NULL) < 0)
+			die("unable to write parameters to config file");
+	}
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle =3D 0, is_local;
@@ -482,6 +500,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			printf(_("Cloning into %s...\n"), dir);
 	}
 	init_db(option_template, INIT_DB_QUIET);
+	write_config(&option_config);
=20
 	/*
 	 * At this point, the config exists, so we do not need the
diff --git a/t/t5707-clone-config.sh b/t/t5707-clone-config.sh
new file mode 100755
index 0000000..27d730c
--- /dev/null
+++ b/t/t5707-clone-config.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description=3D'tests for git clone -c key=3Dvalue'
+. ./test-lib.sh
+
+test_expect_success 'clone -c sets config in cloned repo' '
+	rm -rf child &&
+	git clone -c core.foo=3Dbar . child &&
+	echo bar >expect &&
+	git --git-dir=3Dchild/.git config core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c can set multi-keys' '
+	rm -rf child &&
+	git clone -c core.foo=3Dbar -c core.foo=3Dbaz . child &&
+	{ echo bar; echo baz; } >expect &&
+	git --git-dir=3Dchild/.git config --get-all core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c without a value is boolean true' '
+	rm -rf child &&
+	git clone -c core.foo . child &&
+	echo true >expect &&
+	git --git-dir=3Dchild/.git config --bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c config is available during clone' '
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	rm -rf child &&
+	git clone -c core.autocrlf . child &&
+	printf "content\\r\\n" >expect &&
+	test_cmp expect child/file
+'
+
+test_done
--=20
1.7.6.rc1.36.g91167

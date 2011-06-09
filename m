From: Jeff King <peff@peff.net>
Subject: [PATCH 10/10] clone: accept config options on the command line
Date: Thu, 9 Jun 2011 11:57:40 -0400
Message-ID: <20110609155740.GJ25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhcL-0002Mk-Jq
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab1FIP5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:57:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38450
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174Ab1FIP5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:57:49 -0400
Received: (qmail 14213 invoked by uid 107); 9 Jun 2011 15:57:56 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:57:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:57:40 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175544>

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
Yay, the actual patch. Even if we don't end up using this for transport
helpers, I think it's a sane thing to allow (e.g., see the final test
below).

 Documentation/git-clone.txt |    9 +++++++++
 builtin/clone.c             |   21 ++++++++++++++++++++-
 t/t5707-clone-config.sh     |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletions(-)
 create mode 100755 t/t5707-clone-config.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b093e45..3e24064 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -159,6 +159,15 @@ objects from the source repository into a pack in the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
+--config <key>=<value>::
+-c <key>=<value>::
+	Set a configuration variable in the newly-cloned repository. The
+	key is in the same as expected by linkgit:git-config[1] (e.g.,
+	`core.eol=true`). If multiple values are given for the same key,
+	each value will be written to the config file. This makes it
+	safe, for example, to add additional fetch refspecs to the
+	origin remote.
+
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.  A shallow repository has a
diff --git a/builtin/clone.c b/builtin/clone.c
index f579794..a15784a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -46,6 +46,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress;
+static struct string_list option_config;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -83,7 +84,8 @@ static struct option builtin_clone_options[] = {
 		    "create a shallow clone of that depth"),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
 		   "separate git dir from working tree"),
-
+	OPT_STRING_LIST('c', "config", &option_config, "key=value",
+			"set config inside the new repository"),
 	OPT_END()
 };
 
@@ -364,6 +366,22 @@ static void write_remote_refs(const struct ref *local_refs)
 	clear_extra_refs();
 }
 
+static int write_one_config(const char *key, const char *value, void *data)
+{
+	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
+}
+
+static void write_config(struct string_list *config)
+{
+	int i;
+
+	for (i = 0; i < config->nr; i++) {
+		if (git_config_parse_parameter(config->items[i].string,
+					       write_one_config, NULL) < 0)
+			die("unable to write parameters to config file");
+	}
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -482,6 +500,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			printf(_("Cloning into %s...\n"), dir);
 	}
 	init_db(option_template, INIT_DB_QUIET);
+	write_config(&option_config);
 
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
+test_description='tests for git clone -c key=value'
+. ./test-lib.sh
+
+test_expect_success 'clone -c sets config in cloned repo' '
+	rm -rf child &&
+	git clone -c core.foo=bar . child &&
+	echo bar >expect &&
+	git --git-dir=child/.git config core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c can set multi-keys' '
+	rm -rf child &&
+	git clone -c core.foo=bar -c core.foo=baz . child &&
+	{ echo bar; echo baz; } >expect &&
+	git --git-dir=child/.git config --get-all core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c without a value is boolean true' '
+	rm -rf child &&
+	git clone -c core.foo . child &&
+	echo true >expect &&
+	git --git-dir=child/.git config --bool core.foo >actual &&
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
-- 
1.7.6.rc1.36.g91167

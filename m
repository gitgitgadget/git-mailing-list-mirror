From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Sat, 8 Nov 2008 20:49:27 -0500
Message-ID: <20081109014926.GA31276@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net> <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org> <20081108142756.GC17100@coredump.intra.peff.net> <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 02:56:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyzXI-0005Ts-BZ
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 02:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbYKIBta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 20:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbYKIBta
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 20:49:30 -0500
Received: from peff.net ([208.65.91.99]:3151 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527AbYKIBt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 20:49:29 -0500
Received: (qmail 8718 invoked by uid 111); 9 Nov 2008 01:49:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Nov 2008 20:49:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2008 20:49:27 -0500
Content-Disposition: inline
In-Reply-To: <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100433>

On Sat, Nov 08, 2008 at 12:49:21PM -0800, Junio C Hamano wrote:

> I meant to suggest that change contained in 3/4 can instead be "set the
> configuration to allow such a dangerous push upfront, and make sure the
> pushes the current tests perform actually are still allowed", _if_ you are
> changing the default to forbid.

Ah, I see. I did think about using the config variable for those tests,
but it felt too much like testing two things at once. That is, it is
nicer to debug if each test breaks only when the thing it is testing for
is broken, not some other random unrelated feature. Obviously that isn't
always possible, but it seemed kind of clumsy to me.

Anyway, with a default of "warn" the tests don't need any update at all
(and do serve as a test that we still haven't broken people), and I can
pass the decision off to whoever changes it to "refuse" after the
deprecation period. :)

> I think the default should be to warn for two release cycles during which
> we will give deprecation notice, and then switch the default to forbid

OK, the patch is below, replacing 4/4. 3/4 can simply be dropped at this
point (and I think 1/4 is a no-brainer to apply, and 2/4 is probably
worth it as cleanup).

I worded the warning to explain what happened so that the Frequently
Asking users might have a clue that something bad has happened. But
maybe it should also:

  - suggest "git reset --hard"; of course, then we need to explain that
    you would be losing your work, so we have to warn about that, too.

  - more explicitly warn that the behavior is deprecated.

Also, we could potentially note the deprecation in the documentation for
the config option.

> (and we do not touch "git init/git clone" at all --- changing the default
> to forbid in newly created repositories earlier than existing repositories
> would be changing the behaviour of the command between old and new
> repositories, which is madness).  If we are going this route, I think we

I agree. I suggested that for another config option recently, and I now
think I was wrong. It really doesn't dodge the "things are changing"
bullet. It just makes them change at a slightly different time, which
can be even more confusing (i.e., "this breaks in my repo, but when I
make a test repo it works" or vice versa).

I do feel like we made a config change like that at some point long ago,
but I can't recall for what, or the reasoning. Maybe
core.logallrefupdates, which does have clone-specific behavior.

> can modify the tests 3/4 touches to set the configuration to allow such a
> push and make sure that such a push is still allowed.

Again, I am not sure that is best, as above. But I tried to cover all
cases explicitly with my tests, so I think we should get good coverage
either way (and my tests don't depend on any particular default config
setting).

-- >8 --
receive-pack: detect push to current branch of non-bare repo

Pushing into the currently checked out branch of a non-bare
repository can be dangerous; the HEAD then loses sync with
the index and working tree, and it looks in the receiving
repo as if the pushed changes have been reverted in the
index (since they were never there in the first place).

This patch adds a safety valve that checks for this
condition and either generates a warning or denies the
update. We trigger the check only on a non-bare repository,
since a bare repo does not have a working tree (and in fact,
pushing to the HEAD branch is a common workflow for
publishing repositories).

The behavior is configurable via receive.denyCurrentBranch,
defaulting to "warn" so as not to break existing setups
(though it may, after a deprecation period, switch to
"refuse" by default). For users who know what they are doing
and want to silence the warning (e.g., because they have a
post-receive hook that reconciles the HEAD and working
tree), they can turn off the warning by setting it to false
or "ignore".

Signed-off-by: Jeff King <peff@peff.net>

---
 Documentation/config.txt |    9 +++++++
 builtin-receive-pack.c   |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh    |   37 ++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 965ed74..32dcd64 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1198,6 +1198,15 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+receive.denyCurrentBranch::
+	If set to true or "refuse", receive-pack will deny a ref update
+	to the currently checked out branch of a non-bare repository.
+	Such a push is potentially dangerous because it brings the HEAD
+	out of sync with the index and working tree. If set to "warn",
+	print a warning of such a push to stderr, but allow the push to
+	proceed. If set to false or "ignore", allow such pushes with no
+	message. Defaults to "warn".
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 7f9f134..db67c31 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -11,8 +11,15 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
+enum deny_action {
+	DENY_IGNORE,
+	DENY_WARN,
+	DENY_REFUSE,
+};
+
 static int deny_deletes = 0;
 static int deny_non_fast_forwards = 0;
+static enum deny_action deny_current_branch = DENY_WARN;
 static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
@@ -22,6 +29,21 @@ static int report_status;
 static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
 
+static enum deny_action parse_deny_action(const char *var, const char *value)
+{
+	if (value) {
+		if (!strcasecmp(value, "ignore"))
+			return DENY_IGNORE;
+		if (!strcasecmp(value, "warn"))
+			return DENY_WARN;
+		if (!strcasecmp(value, "refuse"))
+			return DENY_REFUSE;
+	}
+	if (git_config_bool(var, value))
+		return DENY_REFUSE;
+	return DENY_IGNORE;
+}
+
 static int receive_pack_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "receive.denydeletes") == 0) {
@@ -49,6 +71,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "receive.denycurrentbranch")) {
+		deny_current_branch = parse_deny_action(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -173,6 +200,20 @@ static int run_update_hook(struct command *cmd)
 	return hook_status(run_command(&proc), update_hook);
 }
 
+static int is_ref_checked_out(const char *ref)
+{
+	unsigned char sha1[20];
+	const char *head;
+
+	if (is_bare_repository())
+		return 0;
+
+	head = resolve_ref("HEAD", sha1, 0, NULL);
+	if (!head)
+		return 0;
+	return !strcmp(head, ref);
+}
+
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -186,6 +227,24 @@ static const char *update(struct command *cmd)
 		return "funny refname";
 	}
 
+	switch (deny_current_branch) {
+	case DENY_IGNORE:
+		break;
+	case DENY_WARN:
+		if (!is_ref_checked_out(name))
+			break;
+		warning("updating the currently checked out branch; this may"
+			" cause confusion,\n"
+			"as the index and working tree do not reflect changes"
+			" that are now in HEAD.");
+		break;
+	case DENY_REFUSE:
+		if (!is_ref_checked_out(name))
+			break;
+		error("refusing to update checked out branch: %s", name);
+		return "branch is currently checked out";
+	}
+
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", sha1_to_hex(new_sha1));
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3411107..a6532cb 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -486,4 +486,41 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 '
 
+test_expect_success 'warn on push to HEAD of non-bare repository' '
+	mk_test heads/master
+	(cd testrepo &&
+		git checkout master &&
+		git config receive.denyCurrentBranch warn) &&
+	git push testrepo master 2>stderr &&
+	grep "warning.*this may cause confusion" stderr
+'
+
+test_expect_success 'deny push to HEAD of non-bare repository' '
+	mk_test heads/master
+	(cd testrepo &&
+		git checkout master &&
+		git config receive.denyCurrentBranch true) &&
+	test_must_fail git push testrepo master
+'
+
+test_expect_success 'allow push to HEAD of bare repository (bare)' '
+	mk_test heads/master
+	(cd testrepo &&
+		git checkout master &&
+		git config receive.denyCurrentBranch true &&
+		git config core.bare true) &&
+	git push testrepo master 2>stderr &&
+	! grep "warning.*this may cause confusion" stderr
+'
+
+test_expect_success 'allow push to HEAD of non-bare repository (config)' '
+	mk_test heads/master
+	(cd testrepo &&
+		git checkout master &&
+		git config receive.denyCurrentBranch false
+	) &&
+	git push testrepo master 2>stderr &&
+	! grep "warning.*this may cause confusion" stderr
+'
+
 test_done

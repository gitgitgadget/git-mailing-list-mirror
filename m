From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sat, 31 Jan 2009 17:27:45 -0800
Message-ID: <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTR9G-0002o8-To
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbZBAB16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZBAB14
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:27:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZBAB14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:27:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7884895816;
	Sat, 31 Jan 2009 20:27:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6DD4F95814; Sat,
 31 Jan 2009 20:27:49 -0500 (EST)
In-Reply-To: <20090131095622.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat, 31 Jan 2009 09:56:22 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D26C576-EFFF-11DD-9E96-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107960>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> How about doing these before the 1.7.0 release?
> ...
> What do people think?

I haven't manged to convince myself about the "git init" change (I have
the code and also I've looked at the extent of damage the change causes to
the existing test suite), but at least I think it is a sensible suggestion
to differentiate between unconfigured-wwwand-defaults-to-warn case and
configured-to-warn-so-we-warn case.  Something like this.

-- >8 --
Subject: [PATCH] receive-pack: explain what to do when push updates the current branch

This makes "git push" issue a more detailed instruction when a user pushes
into the current branch of a non-bare repository without having an
explicit configuration set to receive.denycurrentbranch.  In such a case,
it will also tell the user that the default will change to refusal in a
future version of git.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-receive-pack.c |   58 +++++++++++++++++++++++++++++++++++------------
 t/t5516-fetch-push.sh  |    6 ++--
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6564a97..f2c94fc 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -12,6 +12,7 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 enum deny_action {
+	DENY_UNCONFIGURED,
 	DENY_IGNORE,
 	DENY_WARN,
 	DENY_REFUSE,
@@ -19,7 +20,7 @@ enum deny_action {
 
 static int deny_deletes = 0;
 static int deny_non_fast_forwards = 0;
-static enum deny_action deny_current_branch = DENY_WARN;
+static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
@@ -214,6 +215,35 @@ static int is_ref_checked_out(const char *ref)
 	return !strcmp(head, ref);
 }
 
+static char *warn_unconfigured_deny_msg[] = {
+	"Updating the currently checked out branch may cause confusion,",
+	"as the index and work tree do not reflect changes that are in HEAD."
+	"As a result, you may see the changes you just pushed into it",
+	"reverted when you run 'git diff' over there, and you may want",
+	"to run 'git reset --hard' before starting to work to recover.",
+	"",
+	"You can set 'receive.denyCurrentBranch' configuration variable to",
+	"'refuse' in the repository to forbid pushing into the current branch",
+	"of it."
+	"",
+	"To allow pushing into the current branch, you can set it to 'ignore';",
+	"but this is not recommended unless you really know what you are doing.",
+	"",
+	"To squelch this message, you can set it to 'warn'.",
+	"",
+	"Note that the default will change in a future version of git",
+	"to refuse updating the currentbranch unless you have the",
+	"configuration variable set to either 'ignore' or 'warn'."
+};
+
+static void warn_unconfigured_deny(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_deny_msg); i++)
+		warning(warn_unconfigured_deny_msg[i]);
+}
+
+
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -227,22 +257,20 @@ static const char *update(struct command *cmd)
 		return "funny refname";
 	}
 
-	switch (deny_current_branch) {
-	case DENY_IGNORE:
-		break;
-	case DENY_WARN:
-		if (!is_ref_checked_out(name))
+	if (is_ref_checked_out(name)) {
+		switch (deny_current_branch) {
+		case DENY_IGNORE:
 			break;
-		warning("updating the currently checked out branch; this may"
-			" cause confusion,\n"
-			"as the index and working tree do not reflect changes"
-			" that are now in HEAD.");
-		break;
-	case DENY_REFUSE:
-		if (!is_ref_checked_out(name))
+		case DENY_UNCONFIGURED:
+		case DENY_WARN:
+			warning("updating the current branch");
+			if (deny_current_branch == DENY_UNCONFIGURED)
+				warn_unconfigured_deny();
 			break;
-		error("refusing to update checked out branch: %s", name);
-		return "branch is currently checked out";
+		case DENY_REFUSE:
+			error("refusing to update checked out branch: %s", name);
+			return "branch is currently checked out";
+		}
 	}
 
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4426df9..89649e7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -492,7 +492,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 		git checkout master &&
 		git config receive.denyCurrentBranch warn) &&
 	git push testrepo master 2>stderr &&
-	grep "warning.*this may cause confusion" stderr
+	grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
@@ -510,7 +510,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 		git config receive.denyCurrentBranch true &&
 		git config core.bare true) &&
 	git push testrepo master 2>stderr &&
-	! grep "warning.*this may cause confusion" stderr
+	! grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
@@ -520,7 +520,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 		git config receive.denyCurrentBranch false
 	) &&
 	git push testrepo master 2>stderr &&
-	! grep "warning.*this may cause confusion" stderr
+	! grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'fetch with branches' '
-- 
1.6.1.2.312.g5be3c

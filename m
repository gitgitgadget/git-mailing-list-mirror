From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH v2] cherry-pick: make sure all input objects are commits
Date: Thu, 11 Apr 2013 11:26:38 +0200
Message-ID: <20130411092638.GA12770@suse.cz>
References: <20130403092704.GC21520@suse.cz>
 <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 11:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQDmP-0007JS-A4
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 11:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935515Ab3DKJ0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 05:26:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38941 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935483Ab3DKJ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 05:26:42 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 12915A3A49;
	Thu, 11 Apr 2013 11:26:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220836>

When a single argument was a non-commit, the error message used to be:

	fatal: BUG: expected exactly one commit from walk

For multiple arguments, when none of the arguments was a commit, the error was:

	fatal: empty commit set passed

Finally, when some of the arguments were non-commits, we ignored those
arguments.  Instead, now make sure all arguments are commits, and for
the first non-commit, error out with:

	fatal: <name>: Can't cherry-pick a <type>

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---

On Mon, Apr 08, 2013 at 09:56:55AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> In other words, perhaps we would want to inspect pending objects
> before running prepare_revision_walk and make sure everybody is
> commit-ish or something?

Sure, that makes sense to me.

 sequencer.c                         | 13 +++++++++++++
 t/t3508-cherry-pick-many-commits.sh |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index baa0310..eb25101 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1047,6 +1047,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 	unsigned char sha1[20];
+	int i;
 
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
@@ -1067,6 +1068,18 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_CONTINUE)
 		return sequencer_continue(opts);
 
+	for (i = 0; i < opts->revs->pending.nr; i++) {
+		unsigned char sha1[20];
+		const char *name = opts->revs->pending.objects[i].name;
+
+		if (!get_sha1(name, sha1)) {
+			enum object_type type = sha1_object_info(sha1, NULL);
+
+			if (type > 0 && type != OBJ_COMMIT)
+				die(_("%s: can't cherry-pick a %s"), name, typename(type));
+		}
+	}
+
 	/*
 	 * If we were called as "git cherry-pick <commit>", just
 	 * cherry-pick/revert it, set CHERRY_PICK_HEAD /
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 4e7136b..19c99d7 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -55,6 +55,12 @@ one
 two"
 '
 
+test_expect_success 'cherry-pick three one two: fails' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_must_fail git cherry-pick three one two:
+'
+
 test_expect_success 'output to keep user entertained during multi-pick' '
 	cat <<-\EOF >expected &&
 	[master OBJID] second
-- 
1.8.1.4

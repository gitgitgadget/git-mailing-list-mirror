From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Thu, 11 Apr 2013 15:06:52 +0200
Message-ID: <20130411130652.GG12770@suse.cz>
References: <20130403092704.GC21520@suse.cz>
 <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
 <20130411092638.GA12770@suse.cz>
 <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
 <20130411110324.GD12770@suse.cz>
 <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 15:07:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQHDU-0004Zu-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 15:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934320Ab3DKNG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 09:06:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48090 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab3DKNG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 09:06:58 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A8826A4FFA;
	Thu, 11 Apr 2013 15:06:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220875>

When a single argument was a non-commit, the error message used to be:

	fatal: BUG: expected exactly one commit from walk

For multiple arguments, when none of the arguments was a commit, the error was:

	fatal: empty commit set passed

Finally, when some of the arguments were non-commits, we ignored those
arguments.  Fix this bug and make sure all arguments are commits, and
for the first non-commit, error out with:

	fatal: <name>: Can't cherry-pick a <type>

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---

On Thu, Apr 11, 2013 at 05:12:06PM +0530, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Then why do you have an if() guarding the code?  In my opinion, you
> should have an else-clause that die()s with an appropriate message.

And you were right -- I actually forgot about --stdin, where the 
else-clause is hit. Added that for now, excluding --stdin.

> Nope, I'd never suggest that: this is fine.  What I meant is: you
> should clarify that you're fixing a bug and adding a test to guard it,
> in the commit message.

Done.

 sequencer.c                         | 18 ++++++++++++++++++
 t/t3508-cherry-pick-many-commits.sh |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index baa0310..61fdb68 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1047,6 +1047,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 	unsigned char sha1[20];
+	int i;
 
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
@@ -1067,6 +1068,23 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_CONTINUE)
 		return sequencer_continue(opts);
 
+	for (i = 0; i < opts->revs->pending.nr; i++) {
+		unsigned char sha1[20];
+		const char *name = opts->revs->pending.objects[i].name;
+
+		/* This happens when using --stdin. */
+		if (!strlen(name))
+			continue;
+
+		if (!get_sha1(name, sha1)) {
+			enum object_type type = sha1_object_info(sha1, NULL);
+
+			if (type > 0 && type != OBJ_COMMIT)
+				die(_("%s: can't cherry-pick a %s"), name, typename(type));
+		} else
+			die(_("%s: bad revision"), name);
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

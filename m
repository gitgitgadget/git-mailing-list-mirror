From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git diff/diff-index/diff-files: call setup_work_tree()
Date: Tue, 26 Aug 2008 16:58:09 -0700
Message-ID: <7vprnvuy5q.fsf@gitster.siamese.dyndns.org>
References: <20080825145044.GE23800@genesis.frugalware.org>
 <1219677095-21732-1-git-send-email-vmiklos@frugalware.org>
 <fcaeb9bf0808250826l2f1a0f3l94fff1b702e69c5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Karl Chen" <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:59:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY8Ra-00072O-UN
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYHZX6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbYHZX6V
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:58:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYHZX6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:58:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D1C35D5EF;
	Tue, 26 Aug 2008 19:58:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 71C035D5EA; Tue, 26 Aug 2008 19:58:11 -0400 (EDT)
In-Reply-To: <fcaeb9bf0808250826l2f1a0f3l94fff1b702e69c5d@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Mon, 25 Aug 2008 22:26:07 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB469A8A-73CA-11DD-8789-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93837>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 8/25/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
>>  diff --git a/builtin-diff.c b/builtin-diff.c
>>
>> index 7ffea97..57da6ed 100644
>>
>> --- a/builtin-diff.c
>>  +++ b/builtin-diff.c
>>
>> @@ -279,6 +279,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>         diff_no_index(&rev, argc, argv, nongit, prefix);
>>
>>         /* Otherwise, we are doing the usual "git" diff */
>>  +       setup_work_tree();
>>         rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
>>
>>         if (nongit)
>
> At least builtin_diff_blobs() and builtin_diff_tree() won't need
> worktree, so NACK again. Anyway I'm not familiar with diff*. Junio
> should know these better.

How about doing it this way then?

 * diff-files is about comparing with work tree, so it obviously needs a
   work tree;

 * diff-index also does;

 * no-index is about random files outside git context, so it obviously
   doesn't need any work tree;

 * comparing two (or more) trees doesn't;

 * comparing two blobs doesn't;

 * comparing a blob with a random file doesn't;

What could be problematic is "git diff --cached".  Strictly speaking, it
compares the index and a tree so it shouldn't need any work tree.  The
same obviously applies to "git diff-index --cached".

While it is theoretically possible to have an index in a bare repository
and build your history using it without using any worktree, I do not think
it is a use case worth worrying about.  As long as setup_work_tree() does
not complain and die in such a setup, "diff --cached" itself won't look at
the work tree (whereever random place setup_work_tree() sets it) at all,
so probably it is a non issue.  I dunno.

I do not have a test environment that uses a separate worktree settings,
so this is obviously untested.

Perhaps people who are interested in keeping core.worktree alive can add
test scripts in t/ somewhere to help salvaging the feature?

---

 builtin-diff.c |    3 +++
 git.c          |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git i/builtin-diff.c w/builtin-diff.c
index 7ffea97..06c85da 100644
--- i/builtin-diff.c
+++ w/builtin-diff.c
@@ -114,6 +114,8 @@ static int builtin_diff_index(struct rev_info *revs,
 			      int argc, const char **argv)
 {
 	int cached = 0;
+
+	setup_work_tree();
 	while (1 < argc) {
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--cached"))
@@ -207,6 +209,7 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	int result;
 	unsigned int options = 0;
 
+	setup_work_tree();
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "--base"))
 			revs->max_count = 1;
diff --git i/git.c w/git.c
index 37b1d76..a8e730d 100644
--- i/git.c
+++ w/git.c
@@ -286,8 +286,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files, RUN_SETUP },
-		{ "diff-index", cmd_diff_index, RUN_SETUP },
+		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
+		{ "diff-index", cmd_diff_index, RUN_SETUP | NEED_WORK_TREE },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
 		{ "fetch", cmd_fetch, RUN_SETUP },

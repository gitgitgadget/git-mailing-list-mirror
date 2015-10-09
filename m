From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Fri, 09 Oct 2015 13:46:27 -0700
Message-ID: <xmqqsi5jojmk.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
	<CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
	<xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
	<xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 22:46:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkeZ2-0002Or-9N
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 22:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746AbbJIUqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 16:46:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35183 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbbJIUqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 16:46:30 -0400
Received: by pabve7 with SMTP id ve7so37532187pab.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=N+h+ZZR+1y8lDJ/v49d1QyfqEmDuOhhkPJwXDOJeEVo=;
        b=cHj1Q7cBy025aYzQFKEow3m63fElxu3dzwJxPbrDqVg7fp5LToYway6GwLWDHMDZ8A
         t1Lx++iqmS7cnLA9zsDD8d84d25zML+5Cgu33db1tzDp9YW6H7Es96JQACUKM2XanOPo
         EXW9Z2BsgrBvPKe62W2iMFdEEnf+fQ1WfRRfMRiXCn5Nnb5iT7oZnx9P3VlZleUuaSKZ
         XR79mKz/dMFYA0q0blPUT5q6m56mre+l/+fSM2T0jUR16hvgGN3MCziq5Uw7HkjyDYsl
         uU0/8wjke1Yo3KQ3U1doEdlcDvG3wuckFqA4e15c7mHZ7mK+9EEX/D9oOJyGOzVo/OAg
         9zbg==
X-Received: by 10.66.236.129 with SMTP id uu1mr17540914pac.34.1444423589544;
        Fri, 09 Oct 2015 13:46:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id be3sm4098807pbc.88.2015.10.09.13.46.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 13:46:28 -0700 (PDT)
In-Reply-To: <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 09 Oct 2015 11:40:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279316>

Junio C Hamano <gitster@pobox.com> writes:

> I think the most sensible regression fix as the first step at this
> point is to call it as a separate process, just like the code calls
> "apply" as a separate process for each patch.  Optimization can come
> later when it is shown that it matters---we need to regain
> correctness first.

And the fix would look like this, I think.

It passes the test Dscho's 3/2 adds to t5520 ;-) but that is not
surprising.

---
Subject: [PATCH] am -3: do not let failed merge abort the error codepath

When "am" was rewritten in C, the codepath for falling back to
three-way merge was mistakenly made to make an internal call to
merge-recursive, disabling the error reporting code for certain
types of errors merge-recursive detects and reports by calling
die().

This is a quick-fix for correctness.  The ideal endgame would be to
replace run_command() in run_fallback_merge_recursive() with a
direct call after making sure that internal call to merge-recursive
does not die().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4f77e07..c869796 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1590,16 +1590,44 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
+ * Do the three-way merge using fake ancestor, his tree constructed
+ * from the fake ancestor and the postimage of the patch, and our
+ * state.
+ */
+static int run_fallback_merge_recursive(const struct am_state *state,
+					unsigned char *orig_tree,
+					unsigned char *our_tree,
+					unsigned char *his_tree)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int status;
+
+	cp.git_cmd = 1;
+
+	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
+			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
+	if (state->quiet)
+		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
+
+	argv_array_push(&cp.args, "merge-recursive");
+	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
+	argv_array_push(&cp.args, "--");
+	argv_array_push(&cp.args, sha1_to_hex(our_tree));
+	argv_array_push(&cp.args, sha1_to_hex(his_tree));
+
+	status = run_command(&cp) ? (-1) : 0;
+	discard_cache();
+	read_cache();
+	return status;
+}
+
+/**
  * Attempt a threeway merge, using index_path as the temporary index.
  */
 static int fall_back_threeway(const struct am_state *state, const char *index_path)
 {
 	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
 		      our_tree[GIT_SHA1_RAWSZ];
-	const unsigned char *bases[1] = {orig_tree};
-	struct merge_options o;
-	struct commit *result;
-	char *his_tree_name;
 
 	if (get_sha1("HEAD", our_tree) < 0)
 		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
@@ -1651,22 +1679,11 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	init_merge_options(&o);
-
-	o.branch1 = "HEAD";
-	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
-	o.branch2 = his_tree_name;
-
-	if (state->quiet)
-		o.verbosity = 0;
-
-	if (merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result)) {
+	if (run_fallback_merge_recursive(state, orig_tree, our_tree, his_tree)) {
 		rerere(state->allow_rerere_autoupdate);
-		free(his_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
 
-	free(his_tree_name);
 	return 0;
 }
 
-- 
2.6.1-296-ge15092e

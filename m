From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 19:05:27 -0400
Message-ID: <20130726230527.GA12968@sigill.intra.peff.net>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
 <20130726213705.GJ14690@google.com>
 <20130726214036.GB1388@sigill.intra.peff.net>
 <20130726224359.GA3928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 01:05:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2r4o-0006oo-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 01:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759924Ab3GZXFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 19:05:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:33223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758327Ab3GZXF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 19:05:29 -0400
Received: (qmail 14034 invoked by uid 102); 26 Jul 2013 23:05:30 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 18:05:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 19:05:27 -0400
Content-Disposition: inline
In-Reply-To: <20130726224359.GA3928@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231214>

On Fri, Jul 26, 2013 at 06:43:59PM -0400, Jeff King wrote:

> I think instead we would want to leave the single-commit case alone, and
> for the multi-commit case add "...and then cherry-pick --continue". That
> message is generated from within git-commit, though; I guess it would
> need to learn about the difference between single/multi cherry-picks.

Like this?

-- >8 --
Subject: [PATCH] commit: tweak empty cherry pick advice for sequencer

When we refuse to make an empty commit, we check whether we
are in a cherry-pick in order to give better advice on how
to proceed. We instruct the user to repeat the commit with
"--allow-empty" to force the commit, or to use "git reset"
to skip it and abort the cherry-pick.

This works fine when we are cherry-picking a single commit.
When we are using the sequencer to cherry-pick multiple
items, though, using "git reset" is not good advice. It does
not skip the commit (you must run "cherry-pick --continue"
to keep going), but nor does it abort the cherry-pick (the
.sequencer directory still exists).

Let's teach commit to tell when the sequencer is in use, and
to mention "cherry-pick --continue" in that case.

Signed-off-by: Jeff King <peff@peff.net>
---
The advice in the multi case could eventually change to "cherry-pick
--skip" if and when it exists.

 builtin/commit.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e47f100..45a98d7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -63,8 +63,14 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "If you wish to commit it anyway, use:\n"
 "\n"
 "    git commit --allow-empty\n"
+"\n");
+static const char empty_cherry_pick_advice_skip_single[] =
+N_("Otherwise, please use 'git reset'\n");
+static const char empty_cherry_pick_advice_skip_multi[] =
+N_("If you wish to skip this commit, use:\n"
 "\n"
-"Otherwise, please use 'git reset'\n");
+"    git reset && git cherry-pick --continue\n"
+"\n");
 
 static const char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -107,6 +113,7 @@ static enum commit_whence whence;
 static const char *cleanup_arg;
 
 static enum commit_whence whence;
+static int sequencer_in_use;
 static int use_editor = 1, include_status = 1;
 static int show_ignored_in_status, have_option_m;
 static const char *only_include_assumed;
@@ -141,8 +148,11 @@ static void determine_whence(struct wt_status *s)
 {
 	if (file_exists(git_path("MERGE_HEAD")))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path("CHERRY_PICK_HEAD")))
+	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		whence = FROM_CHERRY_PICK;
+		if (file_exists(git_path("sequencer")))
+			sequencer_in_use = 1;
+	}
 	else
 		whence = FROM_COMMIT;
 	if (s)
@@ -808,8 +818,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
-		else if (whence == FROM_CHERRY_PICK)
+		else if (whence == FROM_CHERRY_PICK) {
 			fputs(_(empty_cherry_pick_advice), stderr);
+			if (!sequencer_in_use)
+				fputs(_(empty_cherry_pick_advice_skip_single),
+				      stderr);
+			else
+				fputs(_(empty_cherry_pick_advice_skip_multi),
+				      stderr);
+		}
 		return 0;
 	}
 
-- 
1.8.3.rc1.30.gff0fb75

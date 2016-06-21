Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA9B1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbcFUKlH (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:41:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:51904 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbcFUKgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1bXwQo2NMb-00sOWT; Tue, 21 Jun 2016 12:34:51
 +0200
Date:	Tue, 21 Jun 2016 12:34:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 1/9] am: stop ignoring errors reported by
 log_tree_diff()
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <e1d68fa14e7938f7e3a07bb85db28aa84017710d.1466505222.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YdA4d4+8hOfZQUmQtQmCkD6xW5R0C3ZbS9q2JiNMu9WOtHQS8nI
 4EE5dE1zzKMKjZFOmM051eKNALP5zdf9NNgf1gbXS3H4WpwlXQvkY8DU6ubL38mXRaB3DwU
 sJEOnRq38X3HDgGi4Z2T5vzByCWJ4tsuJzdR4cKGY91VecFitrR2jojQbLdhVpB84ONg+rm
 5gMuEbh/ufEMreL3oVisA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/NvWwUpWC4w=:5sFlEazl2pTvbaQvqhOeHu
 njQVj80QumBPBhh9C4W2VYFElSes7YPZbQ2vqhwbkNF+3h9uKlowDCv8+HiHs2Dm1+gMQUp+I
 wplvQ2pBRUVb4UsLQxw/p1Ihqfpj83d2hhcU/8IM8ofPb6dDqG8Oy/pYqtrWLfHNWbdGyjVrb
 2GaYFKTqTZYOK2jPOVfPJ1c1fKI9eMsH1R0oLYZjlohuLxsUpNTFUz5IpCRh7u8nkTnP/yziw
 4vj8S90eyZaegGINWeH/RDBmL+NNUAlSud9XSQMwHqMR3plzOHTLf28O/RflD+yfauca+859z
 dobvFzpPFxiwEFlm8ESEe/QD57mG2gdhp1dG2QjEps2enHsC2+sCfGsNble1m3+nluJT/m+4n
 ej4aRAqkxORxJCHFKSy5nQgBpoJidl9rwHZ/E1HhA+R7I8rCudrupWOcD+jAcUdAT8DfuY2zq
 nhPfUjwD+f6cFy5PkxmdcnJSTVAN2E1GTXHay+DMyk+oZMWMEthOlb7SqA3fJpGRIqWvcvKkf
 AsKlGMurBtKJ/QTHmIlTjrsCmzKcNgiu09oTMVYQdDoy6rkxoQYWXQX0JfoicKEsI4sZSDtNB
 oJTuJny1Oy2KUYSkLhaZCoLnuWTVYS9tIQY2YcczAWvKo3fIJyoRyxbpO2SVonm/W3BiZyz3L
 kdu9Rk+xEmbz6rUvxfouKuFnLu4/chXUaDtvZ8Kf6mG8+4mKTRL4tIEPB1HOPpLRx8MTNWMpk
 40GJSGOzCZMh0Kr2UGY4fxrwEf1SBCA18zS/HO4RD1DIleeDOw08mDpZrFgo0JjhkTpk+EfD7
 2xE7lW0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is never a good idea to ignore errors, so let's handle them.

While at it, handle fopen() errors more gently (i.e. give the caller a
chance to do something about it rather than die()ing).

Note: there are more places in the builtin am code that ignore
errors returned from library functions. Fixing those is outside the
purview of the current patch series, though.

Cc: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..0e28a62 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1433,12 +1433,15 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 /**
  * Writes `commit` as a patch to the state directory's "patch" file.
  */
-static void write_commit_patch(const struct am_state *state, struct commit *commit)
+static int write_commit_patch(const struct am_state *state, struct commit *commit)
 {
 	struct rev_info rev_info;
 	FILE *fp;
 
-	fp = xfopen(am_path(state, "patch"), "w");
+	fp = fopen(am_path(state, "patch"), "w");
+	if (!fp)
+		return error(_("Could not open %s for writing"),
+			am_path(state, "patch"));
 	init_revisions(&rev_info, NULL);
 	rev_info.diff = 1;
 	rev_info.abbrev = 0;
@@ -1453,7 +1456,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &commit->object, "");
 	diff_setup_done(&rev_info.diffopt);
-	log_tree_commit(&rev_info, commit);
+	return log_tree_commit(&rev_info, commit);
 }
 
 /**
@@ -1501,13 +1504,14 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
 
 	if (get_mail_commit_sha1(commit_sha1, mail) < 0)
-		die(_("could not parse %s"), mail);
+		return error(_("could not parse %s"), mail);
 
 	commit = lookup_commit_or_die(commit_sha1, mail);
 
 	get_commit_info(state, commit);
 
-	write_commit_patch(state, commit);
+	if (write_commit_patch(state, commit) < 0)
+		return -1;
 
 	hashcpy(state->orig_commit, commit_sha1);
 	write_state_text(state, "original-commit", sha1_to_hex(commit_sha1));
-- 
2.9.0.118.g0e1a633



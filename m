From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Sat, 23 Jan 2010 17:37:26 +0100
Message-ID: <4B5B25C6.70604@web.de>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 17:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYizR-0006yC-0F
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 17:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab0AWQhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 11:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794Ab0AWQhc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 11:37:32 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:34309 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab0AWQhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 11:37:31 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 08AD013C80571;
	Sat, 23 Jan 2010 17:37:30 +0100 (CET)
Received: from [80.128.106.22] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NYizJ-0004vV-00; Sat, 23 Jan 2010 17:37:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <7vtyudfqju.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18nQ1HxH6nDMO8vy9T8h47kqAa5EFPmBiI9V+MJ
	hDcmC9gAmpTviD2K9wivpIm/WMSlh2crZtMGFzcyDtecQBVoUs
	e4CPwdAdVZNHmvo3OpqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137849>

Am 23.01.2010 04:28, schrieb Junio C Hamano:
> * jl/submodule-diff (2010-01-18) 4 commits
>   (merged to 'next' on 2010-01-20 at 95cb513)
>  + Performance optimization for detection of modified submodules
>   (merged to 'next' on 2010-01-17 at 525075b)
>  + git status: Show uncommitted submodule changes too when enabled
>   (merged to 'next' on 2010-01-16 at 0a99e3c)
>  + Teach diff that modified submodule directory is dirty
>  + Show submodules as modified when they contain a dirty work tree

What about adding the following patch to this series?
Without it i see a performance regression for people who use
"git diff* --ignore-submodules".

A patch that teaches "git diff --submodule" to display if the submodule
contains new untracked and/or modified files is also almost ready. Would
you consider it for inclusion into 1.7.0 too or shall i wait until after
the release?

------8<-----
Subject: [PATCH] git diff: Don't test submodule dirtiness with --ignore-submodules

The diff family suppresses the output of submodule changes when
requested but checks them nonetheless. But since recently submodules
get examined for their dirtiness, which is rather expensive. There is
no need to do that when the --ignore-submodules option is used, as
the gathered information is never used anyway.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 diff-lib.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ec2e2ac..e896b9c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -161,7 +161,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}

-		if ((ce_uptodate(ce) && !S_ISGITLINK(ce->ce_mode)) || ce_skip_worktree(ce))
+		if ((ce_uptodate(ce)
+		     && (!S_ISGITLINK(ce->ce_mode)
+			 || DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)))
+		    || ce_skip_worktree(ce))
 			continue;

 		/* If CE_VALID is set, don't look at workdir for file removal */
@@ -179,6 +182,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
 		if (S_ISGITLINK(ce->ce_mode)
+		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
 		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		    && is_submodule_modified(ce->name)) {
 			changed = 1;
@@ -220,7 +224,7 @@ static int get_stat_data(struct cache_entry *ce,
 			 const unsigned char **sha1p,
 			 unsigned int *modep,
 			 int cached, int match_missing,
-			 unsigned *dirty_submodule, int output_format)
+			 unsigned *dirty_submodule, struct diff_options *diffopt)
 {
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
@@ -241,7 +245,8 @@ static int get_stat_data(struct cache_entry *ce,
 		}
 		changed = ce_match_stat(ce, &st, 0);
 		if (S_ISGITLINK(ce->ce_mode)
-		    && (!changed || (output_format & DIFF_FORMAT_PATCH))
+		    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
+		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH))
 		    && is_submodule_modified(ce->name)) {
 			changed = 1;
 			*dirty_submodule = 1;
@@ -270,7 +275,7 @@ static void show_new_file(struct rev_info *revs,
 	 * the working copy.
 	 */
 	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
-	    &dirty_submodule, revs->diffopt.output_format) < 0)
+	    &dirty_submodule, &revs->diffopt) < 0)
 		return;

 	diff_index_show_file(revs, "+", new, sha1, mode, dirty_submodule);
@@ -287,7 +292,7 @@ static int show_modified(struct rev_info *revs,
 	unsigned dirty_submodule = 0;

 	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
-			  &dirty_submodule, revs->diffopt.output_format) < 0) {
+			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
 					     old->sha1, old->ce_mode, 0);
-- 
1.6.6.1.558.g5c480.dirty

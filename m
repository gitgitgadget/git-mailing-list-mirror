From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] compat/regex/regexec.c: Fix some sparse warnings
Date: Tue, 17 May 2011 18:40:20 +0100
Message-ID: <4DD2B304.90305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:45:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMOKk-0006Gj-ST
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 19:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab1EQRpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 13:45:19 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65322 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755995Ab1EQRpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 13:45:16 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1QMOKY-0006c3-nr; Tue, 17 May 2011 17:45:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173816>


In particular, sparse issues the following warnings:

        SP compat/regex/regex.c
    .../regexec.c:2329:40: warning: Using plain integer as NULL pointer
    .../regexec.c:2316:15: warning: symbol 'merge_state_with_log' was \
        not declared. Should it be static?
    .../regexec.c:2395:15: warning: symbol 'find_recover_state' was not \
        declared. Should it be static?

In order to fix the "symbol not declared" warnings (they are in fact
declared static earlier in the file), we simply add the static modifier
to the function definitions.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Now that I'm building git with NO_REGEX=1 in my config.mak, I'm also
seeing these sparse warnings.

Note that the "symbol not declared" warnings actually highlight
a sparse bug; the earlier static function declarations should have
(effectively) 'transferred' the static modifier to the corresponding
function definition ...
[I have a testcase for this in my sparse repo, but I don't seem to have
found time to actually create a patch to fix this. :(]

ATB,
Ramsay Jones
 
 compat/regex/regexec.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0194965..0cd6e0e 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2313,7 +2313,7 @@ transit_state (reg_errcode_t *err, re_match_context_t *mctx,
 }
 
 /* Update the state_log if we need */
-re_dfastate_t *
+static re_dfastate_t *
 internal_function
 merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
 		      re_dfastate_t *next_state)
@@ -2326,7 +2326,7 @@ merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
       mctx->state_log[cur_idx] = next_state;
       mctx->state_log_top = cur_idx;
     }
-  else if (mctx->state_log[cur_idx] == 0)
+  else if (mctx->state_log[cur_idx] == NULL)
     {
       mctx->state_log[cur_idx] = next_state;
     }
@@ -2392,7 +2392,7 @@ merge_state_with_log (reg_errcode_t *err, re_match_context_t *mctx,
 /* Skip bytes in the input that correspond to part of a
    multi-byte match, then look in the log for a state
    from which to restart matching.  */
-re_dfastate_t *
+static re_dfastate_t *
 internal_function
 find_recover_state (reg_errcode_t *err, re_match_context_t *mctx)
 {
-- 
1.7.5

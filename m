X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix git-runstatus for repositories containing a file named HEAD
Date: Sun, 5 Nov 2006 17:22:15 -0500
Message-ID: <20061105222215.GA29042@coredump.intra.peff.net>
References: <11627635702846-git-send-email-pdmef@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 22:22:31 +0000 (UTC)
Cc: git@vger.kernel.org, Rocco Rutte <pdmef@gmx.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <11627635702846-git-send-email-pdmef@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30988>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgqNg-0000Uc-F9 for gcvg-git@gmane.org; Sun, 05 Nov
 2006 23:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422747AbWKEWWT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWKEWWS
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 17:22:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:6337 "HELO
 peff.net") by vger.kernel.org with SMTP id S1422747AbWKEWWR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 17:22:17 -0500
Received: (qmail 19743 invoked from network); 5 Nov 2006 17:21:20 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 5 Nov 2006 17:21:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Nov
 2006 17:22:15 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, Nov 05, 2006 at 09:52:50PM +0000, Rocco Rutte wrote:

> The wt_status_print_updated() and wt_status_print_untracked() routines
> call setup_revisions() with 'HEAD' being the reference to the tip of the
> current branch. However, setup_revisions() gets confused if the branch
> also contains a file named 'HEAD' resulting in a fatal error.

Ack. This is definitely a bug, and the patch fixes it. I wonder if it
would be slightly more readable to simply get rid of the argv nonsense.
Junio, please apply whichever you find more readable.

-- >8 --
The wt_status_print_updated() and wt_status_print_untracked() routines
call setup_revisions() with 'HEAD' being the reference to the tip of the
current branch. However, setup_revisions() gets confused if the branch
also contains a file named 'HEAD' resulting in a fatal error.

Instead, don't pass an argv to setup_revisions() at all; simply give it no
arguments, and make 'HEAD' the default revision.

Bug noticed by Rocco Rutte <pdmef@gmx.net>.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 7dd6857..9692dfa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -154,10 +154,8 @@ void wt_status_print_initial(struct wt_s
 static void wt_status_print_updated(struct wt_status *s)
 {
 	struct rev_info rev;
-	const char *argv[] = { NULL, NULL, NULL };
-	argv[1] = s->reference;
 	init_revisions(&rev, NULL);
-	setup_revisions(2, argv, &rev, NULL);
+	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
@@ -168,9 +166,8 @@ static void wt_status_print_updated(stru
 static void wt_status_print_changed(struct wt_status *s)
 {
 	struct rev_info rev;
-	const char *argv[] = { NULL, NULL };
 	init_revisions(&rev, "");
-	setup_revisions(1, argv, &rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
@@ -225,10 +222,8 @@ static void wt_status_print_untracked(co
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
-	const char *argv[] = { NULL, NULL, NULL };
-	argv[1] = s->reference;
 	init_revisions(&rev, NULL);
-	setup_revisions(2, argv, &rev, NULL);
+	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
 	run_diff_index(&rev, 1);
-- 
1.4.3.3.ga02d-dirty

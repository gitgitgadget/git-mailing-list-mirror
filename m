From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/18] revert: Rename no_replay to record_origin
Date: Wed, 27 Jul 2011 08:49:02 +0530
Message-ID: <1311736755-24205-6-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qluhz-0005xW-7B
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab1G0DWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:22:41 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1G0DWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:22:39 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8d7N5tbDifodAwTxRafShOR5nftG9L+NeRW4K/TpFQ4=;
        b=VYn7QqGUShwGloPUd3RpwiiktV9BNt307K2Iq9VWqJfGLPw6s7lPOe5veh3dvhKlp9
         K6JOasGSxqKY/NNQbQB610Ixx7EYf0yHYT+/zikvQyKq5ubk4ak2wWSIj2MaJC+eSMaN
         At+3P42XfTXkNEoStqbqoXy4/PlnVeJq2d2i0=
Received: by 10.68.12.161 with SMTP id z1mr3942745pbb.521.1311736959592;
        Tue, 26 Jul 2011 20:22:39 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.22.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:22:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177910>

The "-x" command-line option is used to record the name of the
original commits being picked in the commit message.  The variable
corresponding to this option is named "no_replay" for historical
reasons; the name is especially confusing because the term "replay" is
used to describe what cherry-pick does (for example, in the
documentation of the "--mainline" option).  So, give the variable
corresponding to the "-x" command-line option a better name:
"record_origin".

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 30b39c0..794c050 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -35,7 +35,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
+static int edit, record_origin, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static int commit_argc;
@@ -91,7 +91,7 @@ static void parse_args(int argc, const char **argv)
 
 	if (action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
+			OPT_BOOLEAN('x', NULL, &record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
@@ -464,7 +464,7 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, p);
 		}
 
-		if (no_replay) {
+		if (record_origin) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -559,7 +559,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
 		if (no_commit)
 			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (no_replay)
+		if (record_origin)
 			die(_("cherry-pick --ff cannot be used with -x"));
 		if (edit)
 			die(_("cherry-pick --ff cannot be used with --edit"));
-- 
1.7.4.rc1.7.g2cf08.dirty

From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] diff: make -M -C mean the same as -C -M
Date: Fri, 23 Jan 2015 11:07:15 +0900
Message-ID: <1421978835-9921-1-git-send-email-mh@glandium.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 23 03:07:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YETek-0008A7-Im
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 03:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbbAWCH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 21:07:26 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:49875 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115AbbAWCHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 21:07:25 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YETeV-0002ae-MM; Fri, 23 Jan 2015 11:07:15 +0900
X-Mailer: git-send-email 2.2.2.2.g806f5e2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262899>

While -C implies -M, it is quite common to see both on example command lines
here and there. The unintuitive thing is that if -M appears after -C, then
copy detection is turned off because of how the command line arguments are
handled.

Change this so that when both -C and -M appear, whatever their order, copy
detection is on.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

Interestingly, I even found mentions of -C -M in this order for benchmarks,
on this very list (see 6555655.XSJ9EnW4BY@mako).

 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index d1bd534..9081fd8 100644
--- a/diff.c
+++ b/diff.c
@@ -3670,7 +3670,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		 !strcmp(arg, "--find-renames")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -M: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_RENAME;
+		if (options->detect_rename != DIFF_DETECT_COPY)
+			options->detect_rename = DIFF_DETECT_RENAME;
 	}
 	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
-- 
2.2.2.2.g806f5e2.dirty

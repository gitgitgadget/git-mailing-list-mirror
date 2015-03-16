From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Mon, 16 Mar 2015 11:11:43 -0400
Message-ID: <1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
Cc: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXWhU-0001Dd-Ky
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 16:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934220AbbCPPMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 11:12:48 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35215 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934206AbbCPPMh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 11:12:37 -0400
Received: by qgez64 with SMTP id z64so42647178qge.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlTyiQdSsb5VEWIQ5j/GscfO689MsTEoJ3sjFVzImVY=;
        b=JERT9HlWJVZ53MWvu1b0nYeAw0Te19KUjBRffZYPt6NMG/XVCJB/U2PfBXYC/7P2Nl
         N7fXixmhuFz5Lbde6RzRhhU3Vi7CuZW2Ko0Rd+sA6N98DmYTAb2klnmNQYBVfTYlyKls
         NZzblKAPWHq3QO6hzxwdFh/OSpntCzSfuDqs32s41P7+iVRaPxebyPhGx/G4l/dsH73a
         9Pelk6FhJZqkq4525Yb0RNZlgfR6S9GYBgzW2AXnpXs2vIwkuk29SpQe5M/P9lSzi2Q2
         Ny+YsB7MTQLMyOX1y78vbvT1YzaXcCBioCTviLkHTdHkDenCjUDD0tMpnUrZbBSCeG+n
         N+mQ==
X-Received: by 10.229.4.4 with SMTP id 4mr74730547qcp.8.1426518757128;
        Mon, 16 Mar 2015 08:12:37 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.24])
        by mx.google.com with ESMTPSA id t102sm7636693qgt.45.2015.03.16.08.12.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2015 08:12:36 -0700 (PDT)
X-Mailer: git-send-email 2.3.2.224.gae1335b
In-Reply-To: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265564>

Currently it is not be possible to do something like "git checkout
master && git checkout next && git log -.." to see what master has on
top of master.

Allows use of the revision range such as <rev>..- or -..<rev> to see
what HEAD has on top of <rev> or vice versa, respectively.

Also allows use of symmetric differences such as <rev>...- and -...<rev>

This is written on top of Junio's "Just For Fun" patch ($Gmane/265260).

Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
---
 revision.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 7778bbd..a79b443 100644
--- a/revision.c
+++ b/revision.c
@@ -1490,6 +1490,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		int symmetric = *next == '.';
 		unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
 		static const char head_by_default[] = "HEAD";
+		static const char prev_rev[] = "@{-1}";
 		unsigned int a_flags;
 
 		*dotdot = 0;
@@ -1499,6 +1500,13 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 			next = head_by_default;
 		if (dotdot == arg)
 			this = head_by_default;
+		/*  Allows -..<rev> and <rev>..- */
+		if (!strcmp(this, "-")) {
+			this = prev_rev;
+		}
+		if (!strcmp(next, "-")) {
+			next = prev_rev;
+		}
 		if (this == head_by_default && next == head_by_default &&
 		    !symmetric) {
 			/*
@@ -2198,7 +2206,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (arg[0] == '-' && arg[1]) {
+		if (arg[0] == '-' && !strstr(arg, "..")) {
 			int opts;
 
 			opts = handle_revision_pseudo_opt(submodule,
@@ -2220,6 +2228,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				continue;
 			}
 
+
 			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
 			if (opts > 0) {
 				i += opts - 1;
@@ -2229,7 +2238,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				exit(128);
 			continue;
 		}
-
+		if (strstr(arg, "..")) {
+			handle_revision_arg(arg, revs, flags, revarg_opt);
+			continue;
+		}
 
 		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			int j;
-- 
2.3.2.225.gebdc58a

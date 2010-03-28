From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Allow git gui to display the diff with the HEAD in the 
	case of conflicts. [ amended ]
Date: Sun, 28 Mar 2010 13:19:34 +1100
Message-ID: <2cfc40321003271919kd939540n7354546a95515a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spearce@spearce.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 04:19:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvi6Q-0007pg-PD
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 04:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab0C1CTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 22:19:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62755 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0C1CTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 22:19:35 -0400
Received: by pwi5 with SMTP id 5so5885830pwi.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 19:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=MoUS1nF5CkViQLzOjyg/CCSav0ftA8NK11t2SZ0J35M=;
        b=Zsrf2lw951MP8ko6K7sHxenjqJ7knfO6V5e//GA3f3RwGSp9E2CQ299yBFiO5uYCBJ
         p8a5gn2fpoh+WQ6PeAGBYnywq7GF+WZvLccNBJ9ngMwmzkdaOm6nFjXgXkmgehd6lu8b
         9SOZ5tny6J/GWkfUiAiAq3KS7rat0AaqcSYms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=dZoeE3u2XVdA0mKCjjxEdE0Qp76Wgm7w1RNYjzG7kv7o9GAOPNmGK8G6Q8bfAo9N78
         DkDmYaXeef3ikgSaIk22hV/GNFAJN4Qgb1wwAhE1/5FCBV1ZvQ3FTZ0bEdFBoy3i7ZeI
         7iyd+thYiZ9GJ/hR2o7vL0ARFvae2HJ1Zr3Po=
Received: by 10.115.89.7 with HTTP; Sat, 27 Mar 2010 19:19:34 -0700 (PDT)
Received: by 10.115.81.6 with SMTP id i6mr2067917wal.48.1269742774871; Sat, 27 
	Mar 2010 19:19:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143373>

If the configuration variable gui.conflictsdiffwithhead is true,
then the diff displayed for conflicted paths will be the difference
between the working tree and the HEAD.

The rationale for this change is that the previous behaviour did not allow
the user to make an informed decision about whether "Use Local Version"
was safe since non-conflicting changes in the remote branch were already
in the index and thus not visible from git gui.

With this change, the gui displays what the index would contain if
the current working tree copy (including diff markers) was staged
to the index as is. If there are successfully merged hunks from the remote
branch in the index, then these will be visible in diff.

| Amended Use Remote Version -> Use Local Version

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/config.txt |    9 +++++++++
 git-gui/lib/diff.tcl     |    6 +++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06b2f82..a03c050 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1032,6 +1032,15 @@ gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.

+gui.conflictsdiffwithhead::
+	If set to "true", then the diff displayed by the gui for unstaged conflicted
+	changes is the diff between the working tree and the HEAD. This mode
+	of operation allows the user to assess whether use of "Use Local
Version" is safe
+	or will discard successfully merged hunks from the remote branch.
+	If set to "false", the diff shown for all unstaged changes is the difference
+	between the working tree and the index.	Default: "false".
+
+
 gui.diffcontext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index e7b1986..7aeb98d 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -300,7 +300,11 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 	if {$w eq $ui_index} {
 		lappend cmd [PARENT]
-	}
+	} else {
+            if {$is_unmerged && [is_config_true gui.conflictsdiffwithhead]} {
+                 lappend cmd "HEAD"
+            }
+        }
 	if {$add_opts ne {}} {
 		eval lappend cmd $add_opts
 	} else {
-- 
1.6.6.1

From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Change git gui to display the diff with the HEAD in the 
	case of conflicts.
Date: Sun, 28 Mar 2010 14:38:02 +1100
Message-ID: <2cfc40321003272038r767cc042u555aa7685c8836f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spearce@spearce.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 05:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvjKS-0000cd-BB
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 05:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab0C1DiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 23:38:05 -0400
Received: from mail-pz0-f173.google.com ([209.85.222.173]:54242 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0C1DiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 23:38:04 -0400
Received: by pzk3 with SMTP id 3so33089pzk.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 20:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=KxOemQODmYMe4CTOwPCyF5TukMAlLugQRoxnqC9M41U=;
        b=RKQCIsmNQoEtccBa8EVNnJqqbxI96OJJ1AAJARv92V+Z8obuBCxeh2GRt53t+2yo8q
         vcMFUXNCqeEN3JckZcATTM+w1S2ytpk44st87zkuJGiRjekH0bHn81HPHVtU/WzWDxQa
         I9MNwhZekDaFFG93arxA+MPG9QwIfw375axmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=ea+M/1dmgL08VpPkqSajAjBo0UOl6Ng3fe4Aws4krJiw9ehegHhoUryJx1/nObz89D
         ZkwNWypMfkdwhnsfXbWwVIbxYWMMVJWfwAcXVzOXf+8LD5XckCJO3EzEyJSSlP7HTAi/
         N06SuQZaBMUpwqEHyE3wlQIuFx5NLveYYZZnA=
Received: by 10.115.89.7 with HTTP; Sat, 27 Mar 2010 20:38:02 -0700 (PDT)
Received: by 10.115.81.6 with SMTP id i6mr2114620wal.48.1269747482150; Sat, 27 
	Mar 2010 20:38:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143375>

The rationale for this change is that the previous behaviour did not allow
the user to make an informed decision about the likely consequences
of "Use Local Version" or "Stage to commit".

For example, use of "Use Local Version" would silently discard from the index,
and the working tree any successfully merged remote hunks. Since these hunks
had never been displayed to the user, this loss would be unnoticed and
unexpected.

In the case of "Stage to commit" the successfully merged remote hunks are
preserved in the index and the working tree, but unless the user checks
the diff after the action has been taken, the user may not be aware that these
hunks were staged in the first place since these hunks are not visible until
after the "Stage to commit" action has been taken.

With this change, the gui displays what the index would contain if
the current working tree copy (including diff markers, if any) was staged
to the index as is. If there are successfully merged hunks from the remote
branch in the index, then these will be visible in diff. With this change
the potential consequences of both "Use Local Version" and "Stage to commit" are
directly visible.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Ok, here's the change that makes the proposed safe behaviour, the
default behaviour.

I can supply a patch to make it optional upon request, but I think
that is a dumb idea since it makes the default behaviour unsafe and
requires
configuration to get safe behavour.

       [PATCH 1/2] Introduce is_unmerged global variable to
encapsulate its derivation.
---
 git-gui/lib/diff.tcl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index e7b1986..a017fba 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -300,7 +300,11 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 	if {$w eq $ui_index} {
 		lappend cmd [PARENT]
-	}
+	} else {
+		if {$is_unmerged} {
+			lappend cmd "HEAD"
+		}
+        }
 	if {$add_opts ne {}} {
 		eval lappend cmd $add_opts
 	} else {
-- 
1.6.6.1

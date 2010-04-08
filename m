From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5] gitk: Use git-difftool for external diffs when git >= 1.7.0
Date: Thu,  8 Apr 2010 02:08:10 -0700
Message-ID: <1270717690-32133-1-git-send-email-davvid@gmail.com>
References: <20100408090211.GA31594@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 11:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nznip-00063A-RB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 11:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205Ab0DHJIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 05:08:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50613 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab0DHJIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 05:08:17 -0400
Received: by gyg13 with SMTP id 13so1068789gyg.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+3C+BIaeYgrloyFT0leHBggSWlgPokySl4BASvqAIyA=;
        b=MXHuQi94nom5lZWUhBS49dwK2y0gJuQsIHZtU3ohuwqOPzYeurHTH88EpZteRLhjS4
         M9Nn/v1VXoRLveTgJcHJPsyqBtlOaI0gu3JbvBp++W9xdEo9/Im0xincpU09S2iDb7q6
         qgRyaobAHggtcBJEhI/pvEn4oCIcvrUH0EFOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cYvwbZ5qu3L9mfM3p0kKt3RQw5GkmW2/gZkVPVdDMSr7EMSO3pzVTaYVg2JF4Scou+
         AcxlBquu88uUm0AzSx2SJPBVSq703xgJtUE6gnI1npVWYjBM9q1apMM4F1NDyC6BIjuP
         7knUjjnXCuCAGYwYO6xQFehMHePQEO1fg1oG0=
Received: by 10.150.66.12 with SMTP id o12mr10235559yba.147.1270717695497;
        Thu, 08 Apr 2010 02:08:15 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm4244808ywg.9.2010.04.08.02.08.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 02:08:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.313.g87b3c
In-Reply-To: <20100408090211.GA31594@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144348>

git-difftool is used instead of the built-in external diff
code when git is >= 1.7.0.  git-difftool's '--extcmd=frotz'
feature was first introduced in 1.7.0 and is the mechanism
through which we launch the configured difftool.

A benefit of this change is that gitk's external diff feature
no longer needs write-access to the current directory.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Unlike previous versions, this one checks the git version at runtime
and gracefully falls back to the old code when git is older.

 gitk |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..a49eecc 100755
--- a/gitk
+++ b/gitk
@@ -3355,6 +3355,7 @@ proc external_diff {} {
     global flist_menu_file
     global diffids
     global extdifftool
+    global git_version
 
     if {[llength $diffids] == 1} {
         # no reference commit given
@@ -3375,6 +3376,19 @@ proc external_diff {} {
         set diffidto [lindex $diffids 1]
     }
 
+    if {[package vcompare $git_version "1.7.0"] >= 0} {
+        set cmd [list "git" "difftool" "--no-prompt" "--extcmd=$extdifftool"]
+        if {$diffidfrom ne $nullid && $diffidfrom ne $nullid2} {
+            lappend cmd $diffidfrom
+        }
+        if {$diffidto ne $nullid && $diffidto ne $nullid2} {
+            lappend cmd $diffidto
+        }
+        lappend cmd "--" $flist_menu_file
+        eval exec $cmd &
+        return
+    }
+
     # make sure that several diffs wont collide
     set diffdir [gitknewtmpdir]
     if {$diffdir eq {}} return
-- 
1.7.0.3.313.g87b3c

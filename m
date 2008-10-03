From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] git-gui: Fix the blame viewer destroy handler.
Date: Fri,  3 Oct 2008 11:36:54 +0400
Message-ID: <1223019414-24643-3-git-send-email-angavrilov@gmail.com>
References: <1223019414-24643-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 09:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlfGR-0008FF-1W
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 09:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbYJCHig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 03:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbYJCHig
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 03:38:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:42246 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbYJCHib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 03:38:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1015993fgg.17
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KizanvzRN82rs8x8EgqD5FaitNhdFnERvyGiKVIiIto=;
        b=kH2qtwE1DHvbaX7Kkhqn6jlTCqd4IMk1uy/cZfJEjA/nYSgBKM2oJ6R4tILdnPgQsh
         qK7oWZZt2ASZjeoNEcyPRVqFD8ig9RHbmPkQh2AA0VF+b9VutwjrMiqIU7z0tTniH9dt
         HlPLfDOwYHI472PzOyGA4ucLdYbZq2naRRnPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=klgt/N050Zr633cazwlIgubXgOOnkBXcwJI0fAf96PoEyHqaq4QdhqZeTA45doX7rv
         C6DglUSpbzdAqnldQmn6bcKdtbHshyKSZuVJB/htzKv+Tg3sDH5PpjMZTW/p286sGpL5
         d5QgJO4HOHSehoE9OEhe0oeDe+GSwgzEo9zEA=
Received: by 10.180.253.12 with SMTP id a12mr292437bki.40.1223019509842;
        Fri, 03 Oct 2008 00:38:29 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm3873133fkt.3.2008.10.03.00.38.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 00:38:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223019414-24643-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97401>

It did not delete the object, which is not very good.
Also, destroy may be fired up for subwindows, so we
should check %W.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	My own bug. I hope that now I understand
	Tcl better than 2 months ago.
	
	-- Alexander

 lib/blame.tcl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index a45784c..765d08c 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -377,11 +377,18 @@ constructor new {i_commit i_path i_jump} {
 	"if {{$w.file_pane} eq {%W}} {[cb _resize %h]}"
 
 	wm protocol $top WM_DELETE_WINDOW "destroy $top"
-	bind $top <Destroy> [cb _kill]
+	bind $top <Destroy> [cb _handle_destroy %W]
 
 	_load $this $i_jump
 }
 
+method _handle_destroy {win} {
+	if {$win eq $w} {
+		_kill $this
+		delete_this
+	}
+}
+
 method _kill {} {
 	if {$current_fd ne {}} {
 		kill_file_process $current_fd
-- 
1.6.0.20.g6148bc

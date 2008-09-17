From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 5/8] git-gui: Support the encoding menu in gui blame.
Date: Thu, 18 Sep 2008 01:07:36 +0400
Message-ID: <1221685659-476-6-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
 <1221685659-476-4-git-send-email-angavrilov@gmail.com>
 <1221685659-476-5-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4IT-0003an-Jr
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbYIQVJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbYIQVJL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:58531 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbYIQVJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:09:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2125232fgg.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Gbpf4DiDtT/6e4uHsvstdi+5ZFJaif7Ul3oqetELUF8=;
        b=d0Koc3WODLTJIlyyvipyezodcYsgVRwIKOmZuWCNJgTz3JHA4aRuubmrNIHG0okEL6
         hSon9HfT8IpnnMAVDDuQQ8+/7DJnblTdqGTKlIkqfkIIrUVhUuRFFf+6tS2mgSa+P0jr
         yC67Y7M90BjxA3KaCowFg3OHS+r+BoVBKKEt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sXwlurWfGYQmYhkhrYtTT1Rf1TyZiLbLr555UrzIeTzDmmnacT9/o7sZ3+DrZOWWfX
         pL0f42tu4gzNQRaq+zJMH19AHyInTj573oFOYJCI5iMj2ySPJ0+dpL5+WTfH5dzVH1u/
         83PKviPNQ+25DNtEbBLfGZof419x6I98mwt8I=
Received: by 10.180.252.8 with SMTP id z8mr2320376bkh.82.1221685740739;
        Wed, 17 Sep 2008 14:09:00 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.08.59
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:09:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-5-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96142>

Allow dynamically changing the encoding from the blame
viewer as well.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 84d55b5..eb61374 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -256,9 +256,16 @@ constructor new {i_commit i_path i_jump} {
 	$w.ctxm add command \
 		-label [mc "Copy Commit"] \
 		-command [cb _copycommit]
+	$w.ctxm add separator
+	menu $w.ctxm.enc
+	build_encoding_menu $w.ctxm.enc [cb _setencoding]
+	$w.ctxm add cascade \
+		-label [mc "Encoding"] \
+		-menu $w.ctxm.enc
 	$w.ctxm add command \
 		-label [mc "Do Full Copy Detection"] \
 		-command [cb _fullcopyblame]
+	$w.ctxm add separator
 	$w.ctxm add command \
 		-label [mc "Show History Context"] \
 		-command [cb _gitkcommit]
@@ -791,6 +798,16 @@ method _click {cur_w pos} {
 	_showcommit $this $cur_w $lno
 }
 
+method _setencoding {enc} {
+	force_path_encoding $path $enc
+	_load $this [list \
+		$highlight_column \
+		$highlight_line \
+		[lindex [$w_file xview] 0] \
+		[lindex [$w_file yview] 0] \
+		]
+}
+
 method _load_commit {cur_w cur_d pos} {
 	upvar #0 $cur_d line_data
 	set lno [lindex [split [$cur_w index $pos] .] 0]
-- 
1.6.0.20.g6148bc

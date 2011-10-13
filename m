From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH 4/4] git-gui: incremental goto line in blame view
Date: Thu, 13 Oct 2011 15:48:15 +0200
Message-ID: <7a9760b8cf85274b17c7233f61f59bb59cd18578.1318513492.git.bert.wesarg@googlemail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
 <a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
 <fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
Cc: David Fries <David@Fries.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELeD-0002Hq-4V
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab1JMNsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:48:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33264 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab1JMNs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:48:29 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1464856bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=VfJTf3AmJmp1nYPGu895v5rGL9RH1+1wbgIsXzoeLvY=;
        b=IItMdcYSJp3704c3vWDFg3xmOqK7ICjvuXWsFQniJGzvelV5hNLsWPxVWKnNeVqzwH
         XoBCClEwpzBvk3n2kiMPIysY5EAkECuqAzz5T7EIhgluXVIkW69IfHpgOLmKr5+yVu9y
         6LzGSzbBpZ1bPsnZINctNCR07SwsgNDLiMoo8=
Received: by 10.204.140.153 with SMTP id i25mr2750888bku.102.1318513708580;
        Thu, 13 Oct 2011 06:48:28 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id z9sm3732087bkn.7.2011.10.13.06.48.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 06:48:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
In-Reply-To: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183482>

The view jumps now to the given line number after each key press.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

I didn't know this before, but gedits goto-line-dialog works this way.

 lib/line.tcl |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/line.tcl b/lib/line.tcl
index 70785e1..0113e06 100644
--- a/lib/line.tcl
+++ b/lib/line.tcl
@@ -20,7 +20,7 @@ constructor new {i_w i_text args} {
 		-background lightgreen \
 		-validate key \
 		-validatecommand [cb _validate %P]
-	${NS}::button $w.bn      -text [mc Go] -command [cb _incrgoto]
+	${NS}::button $w.bn      -text [mc Go] -command [cb _goto]
 
 	pack   $w.l   -side left
 	pack   $w.bn  -side right
@@ -29,7 +29,8 @@ constructor new {i_w i_text args} {
 	eval grid conf $w -sticky we $args
 	grid remove $w
 
-	bind $w.ent <Return> [cb _incrgoto]
+	trace add variable linenum write [cb _goto_cb]
+	bind $w.ent <Return> [cb _goto]
 	bind $w.ent <Escape> [cb hide]
 
 	bind $w <Destroy> [list delete_this $this]
@@ -67,10 +68,16 @@ method _validate {P} {
 	return 0
 }
 
-method _incrgoto {} {
+method _goto_cb {name ix op} {
+	after idle [cb _goto 1]
+}
+
+method _goto {{nohide {0}}} {
 	if {$linenum ne {}} {
 		$ctext see $linenum.0
-		hide $this
+		if {!$nohide} {
+			hide $this
+		}
 	}
 }
 
-- 
1.7.6.789.gb4599

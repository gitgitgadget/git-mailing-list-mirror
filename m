From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 3/4] git-gui: add regexp search mode to the searchbar
Date: Fri, 14 Oct 2011 10:14:51 +0200
Message-ID: <a93e3d17587afbaef299b2d497ec3c3a037f4101.1318579823.git.bert.wesarg@googlemail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
 <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 10:15:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcvJ-0007o2-14
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 10:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab1JNIPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 04:15:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53845 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1JNIPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 04:15:10 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2512825bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=tW6d+4BOSWarsi2HUNZz0dThkFhYlbUX9ul9hCPnru4=;
        b=NOhMUr5/Htc0fYMVVzSvm82d/Bsdsdks/5v1qGRFaduOAAlXRMgSj3KIV6P9vFLikE
         sLdhNGWDLzvDkMq6i+BcMMimnfbCLz4gGS7FhZW1xIxJ9Q78KCC8JrN/qt1F9IQBPHdH
         0oIkveNE8v0S654QBYpTPIAxIDZw91puhJ3B4=
Received: by 10.204.142.202 with SMTP id r10mr5816405bku.56.1318580110105;
        Fri, 14 Oct 2011 01:15:10 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id u10sm7505715bkv.3.2011.10.14.01.15.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 01:15:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
In-Reply-To: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183555>

It's off by default, but can be enabled via the config gui.search.regexp.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/search.tcl |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/lib/search.tcl b/lib/search.tcl
index 461c66d..9268ec3 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -7,6 +7,8 @@ field w
 field ctext
 
 field searchstring   {}
+field regexpsearch
+field default_regexpsearch
 field casesensitive
 field default_casesensitive
 field searchdirn     -forwards
@@ -19,6 +21,7 @@ constructor new {i_w i_text args} {
 	set w      $i_w
 	set ctext  $i_text
 
+	set default_regexpsearch [is_config_true gui.search.regexp]
 	if {[is_config_true gui.search.smartcase]} {
 		set default_casesensitive 0
 	} else {
@@ -30,10 +33,13 @@ constructor new {i_w i_text args} {
 	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
 	${NS}::button $w.bn      -text [mc Next] -command [cb find_next]
 	${NS}::button $w.bp      -text [mc Prev] -command [cb find_prev]
-	${NS}::checkbutton $w.cs -text [mc Case-Sensitive] \
+	${NS}::checkbutton $w.re -text [mc RegExp] \
+		-variable ${__this}::regexpsearch -command [cb _incrsearch]
+	${NS}::checkbutton $w.cs -text [mc Case] \
 		-variable ${__this}::casesensitive -command [cb _incrsearch]
 	pack   $w.l   -side left
 	pack   $w.cs  -side right
+	pack   $w.re  -side right
 	pack   $w.bp  -side right
 	pack   $w.bn  -side right
 	pack   $w.ent -side left -expand 1 -fill x
@@ -52,6 +58,7 @@ constructor new {i_w i_text args} {
 method show {} {
 	if {![visible $this]} {
 		grid $w
+		set regexpsearch  $default_regexpsearch
 		set casesensitive $default_casesensitive
 	}
 	focus -force $w.ent
@@ -106,6 +113,9 @@ method _do_search {start {mlenvar {}} {dir {}} {endbound {}}} {
 		upvar $mlenvar mlen
 		lappend cmd -count mlen
 	}
+	if {$regexpsearch} {
+		lappend cmd -regexp
+	}
 	if {!$casesensitive} {
 		lappend cmd -nocase
 	}
-- 
1.7.6.789.gb4599

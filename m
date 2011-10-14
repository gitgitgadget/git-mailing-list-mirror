From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/4] git-gui: add smart case search mode in searchbar
Date: Fri, 14 Oct 2011 10:14:50 +0200
Message-ID: <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 10:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcv9-0007jE-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 10:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab1JNIPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 04:15:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53845 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab1JNIO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 04:14:58 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2512825bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=FzHwf1pfez/7nrH6ki66qKPrAZ/bTsfRng4mx0sj60A=;
        b=Ce+4zQenoqlpRfvSaHjZGJSC+l26GTwcCi2KocRZSe8C2rGUDWrH1fip9aeL3rOwzJ
         y8GBKqZAx48pvcm2+Twz9EaMe66TlIRu4oGd6jCBFrKOHf5+pUkVGQXdsz7esntisxb0
         2oRup+4jwXeIHsEpXOU6V6Po5E0Wfo/udFb+I=
Received: by 10.204.129.146 with SMTP id o18mr5816561bks.95.1318580097385;
        Fri, 14 Oct 2011 01:14:57 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id z9sm7484152bkn.7.2011.10.14.01.14.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 01:14:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
In-Reply-To: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183554>

Setting config gui.search.smartcase to true, the search mode in the
searchbar (from the blame view) is by default case-insensitive. But
entering an upper case letter into the search field activates the case-
sensitive search mode.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/search.tcl |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/lib/search.tcl b/lib/search.tcl
index ef3486f..461c66d 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -7,7 +7,8 @@ field w
 field ctext
 
 field searchstring   {}
-field casesensitive  1
+field casesensitive
+field default_casesensitive
 field searchdirn     -forwards
 
 field smarktop
@@ -18,6 +19,12 @@ constructor new {i_w i_text args} {
 	set w      $i_w
 	set ctext  $i_text
 
+	if {[is_config_true gui.search.smartcase]} {
+		set default_casesensitive 0
+	} else {
+		set default_casesensitive 1
+	}
+
 	${NS}::frame  $w
 	${NS}::label  $w.l       -text [mc Find:]
 	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
@@ -45,6 +52,7 @@ constructor new {i_w i_text args} {
 method show {} {
 	if {![visible $this]} {
 		grid $w
+		set casesensitive $default_casesensitive
 	}
 	focus -force $w.ent
 }
@@ -125,6 +133,9 @@ method _incrsearch {} {
 	if {[catch {$ctext index anchor}]} {
 		$ctext mark set anchor [_get_new_anchor $this]
 	}
+	if {[regexp {[[:upper:]]} $searchstring]} {
+		set casesensitive 1
+	}
 	if {$searchstring ne {}} {
 		set here [_do_search $this anchor mlen]
 		if {$here ne {}} {
-- 
1.7.6.789.gb4599

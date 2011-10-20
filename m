From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: use a tristate to control the case mode in the searchbar
Date: Thu, 20 Oct 2011 21:27:27 +0200
Message-ID: <9193677f1fef348d5b081653840e8a829ddd3e50.1319138692.git.bert.wesarg@googlemail.com>
References: <CAKPyHN0KCwDu2-JXAEk4wAvfOqE3jHY63aG6R9YSOoLoKwWGgQ@mail.gmail.com>
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 21:27:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGyHD-0004Av-BT
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 21:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab1JTT1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 15:27:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63450 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1JTT1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 15:27:34 -0400
Received: by bkbzt19 with SMTP id zt19so3916722bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QRC0Yx8SYQfn5mv/wawHKRTt5MklNhhmNt/wRjJB4dY=;
        b=Sxld/8I1VnhzOYGc76FGVLKntd1p81+cboTN6ISp4JudWSxu3L671uiladRc5uO+AI
         u+JPkf1szm9nMu7W2tTb1djd5kXFOOsAE1jkCxQ3Vg6RZ+uIL2IAW8xDp3KA49NDcKZJ
         QRnLJEEHpyNNyFYCj1MEi5DTHqXfwKVkfy+tk=
Received: by 10.204.148.68 with SMTP id o4mr9001264bkv.21.1319138852405;
        Thu, 20 Oct 2011 12:27:32 -0700 (PDT)
Received: from localhost (p5B2AD78D.dip.t-dialin.net. [91.42.215.141])
        by mx.google.com with ESMTPS id a27sm10883813bku.9.2011.10.20.12.27.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 12:27:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.759.gfc8c6
In-Reply-To: <CAKPyHN0KCwDu2-JXAEk4wAvfOqE3jHY63aG6R9YSOoLoKwWGgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184037>

The config is now called gui.search.case and can have the three values:
no/yes/smart. yes is the default.

It also resets the case detection in smart mode, when the entry field was
cleared by the use.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/search.tcl |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/lib/search.tcl b/lib/search.tcl
index 04a316b..ef1e555 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -26,11 +26,20 @@ constructor new {i_w i_text args} {
 	set ctext  $i_text
 
 	set default_regexpsearch [is_config_true gui.search.regexp]
-	set smartcase [is_config_true gui.search.smartcase]
-	if {$smartcase} {
+	switch -- [get_config gui.search.case] {
+	no {
 		set default_casesensitive 0
-	} else {
+		set smartcase 0
+	}
+	smart {
+		set default_casesensitive 0
+		set smartcase 1
+	}
+	yes -
+	default {
 		set default_casesensitive 1
+		set smartcase 0
+	}
 	}
 
 	set history [list]
@@ -157,12 +166,10 @@ method _incrsearch {} {
 	if {[catch {$ctext index anchor}]} {
 		$ctext mark set anchor [_get_new_anchor $this]
 	}
-	if {$smartcase} {
-		if {[regexp {[[:upper:]]} $searchstring]} {
+	if {$searchstring ne {}} {
+		if {$smartcase && [regexp {[[:upper:]]} $searchstring]} {
 			set casesensitive 1
 		}
-	}
-	if {$searchstring ne {}} {
 		set here [_do_search $this anchor mlen]
 		if {$here ne {}} {
 			$ctext see $here
@@ -175,6 +182,9 @@ method _incrsearch {} {
 			#$w.ent configure -background lightpink
 			$w.ent state pressed
 		}
+	} elseif {$smartcase} {
+		# clearing the field resets the smart case detection
+		set casesensitive 0
 	}
 }
 
-- 
1.7.7.759.gfc8c6

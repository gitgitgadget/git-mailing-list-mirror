From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] git-gui: support for diff3 conflict style
Date: Wed, 30 Mar 2011 08:44:46 +0200
Message-ID: <56c38bdfd71d8af5633bea00cb130256d6981af5.1301467146.git.bert.wesarg@googlemail.com>
References: <2cd6fc8a8da65dc6c2e420d150429b59fdbb3386.1301467146.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4p9F-0003tt-2k
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 08:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab1C3Gow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 02:44:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39090 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab1C3Gow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 02:44:52 -0400
Received: by fxm17 with SMTP id 17so801009fxm.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=bap0zJEo0ODunKc3dF11X82oJeTbREMqgjJb/+quOzo=;
        b=lkHAKGhcqOPLqFA9l/zG8n/0ehM9SClOj5UyIKiDq7+1fvA80w1D2TiAKXNXbnplFD
         cr4Dn8/s0dgaxvDO3CrUQXRW20DUiRkvB5fKwm3n7dZ8U+E9LNfrgEQkUfZGOYy2GrgR
         fOrC6h8IQCDMot8BBOgNuZzPn3jdMOiSKUnQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nvkiM0BRAl6ipWw2Pfdy1KU3PJjm2VKNmlPl+4ytbOESYXLFf499A4H+/mZezQ9U0A
         Sj7Tfrrw7Mbtfx4F/TV8NgRebqVPj5+xY0NTyg8YmHGB853iDp+oPL/Axa1U87BgM9vN
         5yzuPZvxyfrhKj1PLn9m9o3JOIp7vXIC2CxVA=
Received: by 10.223.158.9 with SMTP id d9mr766254fax.124.1301467490941;
        Tue, 29 Mar 2011 23:44:50 -0700 (PDT)
Received: from localhost ([141.76.90.212])
        by mx.google.com with ESMTPS id n7sm2233399fam.35.2011.03.29.23.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 23:44:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.1319.ga04f7.dirty
In-Reply-To: <AANLkTin4-1_bNuH2kQ0m6wpevnO5uCJUmLvy=gP4mLfH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170358>

This adds highlight support for the diff3 conflict style.

The common pre-image will be reversed to --, because it has been removed
and either replaced with our or their side.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Maybe it's not too late for the next release.

 git-gui.sh   |    3 +++
 lib/diff.tcl |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d5c1535..6adcda6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3388,6 +3388,9 @@ $ui_diff tag conf d_s- \
 $ui_diff tag conf d< \
 	-foreground orange \
 	-font font_diffbold
+$ui_diff tag conf d| \
+	-foreground orange \
+	-font font_diffbold
 $ui_diff tag conf d= \
 	-foreground orange \
 	-font font_diffbold
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 39e4d90..11f9e16 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -339,6 +339,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	set ::current_diff_inheader 1
+	set ::in_conflict_pre_image 0
 	fconfigure $fd \
 		-blocking 0 \
 		-encoding [get_path_encoding $path] \
@@ -439,10 +440,21 @@ proc read_diff {fd conflict_size cont_info} {
 			{++} {
 				set regexp [string map [list %conflict_size $conflict_size]\
 								{^\+\+([<>=]){%conflict_size}(?: |$)}]
+				set regexp_pre_image [string map [list %conflict_size $conflict_size]\
+								{^\+\+\|{%conflict_size}(?: |$)]
 				if {[regexp $regexp $line _g op]} {
 					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
 					set tags d$op
+					set ::in_conflict_pre_image 0
+				} elseif {[regexp $regexp_pre_image $line]} {
+					set is_conflict_diff 1
+					set line [string replace $line 0 1 {  }]
+					set tags d|
+					set ::in_conflict_pre_image 1
+				} elseif ($::in_conflict_pre_image) {
+					set line [string replace $line 0 1 {--}]
+					set tags d_--
 				} else {
 					set tags d_++
 				}
-- 
1.7.4.1.1319.ga04f7.dirty

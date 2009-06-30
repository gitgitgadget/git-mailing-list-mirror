From: Dan Zwell <dzwell@gmail.com>
Subject: [PATCH] Limited git-gui to displaying 5000 new files
Date: Tue, 30 Jun 2009 15:37:58 -0500
Message-ID: <4A4A77A6.1020905@lawrence.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, raa.lkml@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 30 22:38:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLk62-00028V-BZ
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbZF3UiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbZF3UiH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:38:07 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:43534 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbZF3UiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:38:06 -0400
Received: by pxi28 with SMTP id 28so366194pxi.33
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=b39r63yCahZFLMQOQ4SeeZYwCdNHL8+Cfo//wDh6Mqc=;
        b=lqgfxc3Iml0A3YJqPt7JgxSW8kD/SMX4TqWUoHj3X1C/jeAZuHRpOHzCNSa+qGIN/I
         yIe7KdgLwFRkMbS0Bsh1+k+HYReEyp7jPQlQfg2Qbf1Fqazg6P2GQpw+fVSZtL6mtt0p
         mq4YTUbrXCumTcXwRQMbY+z34TQhTCh1YiE8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=caSPjVThc21SSICQIIoVrGBJ2jPu9roVTuu5+16GmxYngSWGb3USXvKDT6nWobQEbC
         +n7sLN1jMpIjwc6Lb1Jx+vVALqE7647MwzO3/NrXJqgLxdrR1U4pykVlNmhmdpQ6VaQe
         Mz05XpABZsN5lmfBilMWv4SF2JmT5Eq10tmjs=
Received: by 10.115.76.5 with SMTP id d5mr14121958wal.170.1246394288983;
        Tue, 30 Jun 2009 13:38:08 -0700 (PDT)
Received: from ?192.168.1.103? (c-76-21-120-57.hsd1.ca.comcast.net [76.21.120.57])
        by mx.google.com with ESMTPS id c26sm792281waa.50.2009.06.30.13.38.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:38:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090319)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122540>

When there is a large number of new or modified files,
"display_all_files" takes a long time, and git-gui appears to
hang. Limit the display to 5000 files, by default. This number
is configurable as gui.maxfilesdisplayed.

Show a warning if the list of files is truncated.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 git-gui.sh |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 14b92ba..5a20923 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -745,6 +745,8 @@ set default_config(gui.newbranchtemplate) {}
 set default_config(gui.spellingdictionary) {}
 set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
+# TODO: this option should be added to the git-config documentation
+set default_config(gui.maxfilesdisplayed) 5000
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
@@ -1702,6 +1704,8 @@ proc display_all_files {} {
 	global ui_index ui_workdir
 	global file_states file_lists
 	global last_clicked
+	global files_warning
+	global default_config
 
 	$ui_index conf -state normal
 	$ui_workdir conf -state normal
@@ -1713,7 +1717,18 @@ proc display_all_files {} {
 	set file_lists($ui_index) [list]
 	set file_lists($ui_workdir) [list]
 
-	foreach path [lsort [array names file_states]] {
+	set to_display [lsort [array names file_states]]
+	set display_limit $default_config(gui.maxfilesdisplayed)
+	if {[llength $to_display] > $display_limit} {
+		if {![info exists files_warning] || !$files_warning} {
+			set warning "Displaying only $display_limit of "
+			append warning "[llength $to_display] files."
+			info_popup [mc $warning]
+			set files_warning 1
+		}
+		set to_display [lrange $to_display 0 [expr {$display_limit-1}]]
+	}
+	foreach path $to_display {
 		set s $file_states($path)
 		set m [lindex $s 0]
 		set icon_name [lindex $s 1]
-- 
1.6.3.3

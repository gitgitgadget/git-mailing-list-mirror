From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 2/3] Kill the blame back-end on window close.
Date: Thu, 17 Jul 2008 00:48:08 +0400
Organization: TEPKOM
Message-ID: <200807170048.08909.angavrilov@gmail.com>
References: <200807170042.29462.angavrilov@gmail.com> <200807170043.49016.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDw5-0005Pz-HF
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052AbYGPUsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756451AbYGPUsS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:48:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:44832 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbYGPUsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:48:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2506863fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5rkho0EZEjSJF0zJ5n266uH7ER8T+lDgXXMu1DXtr7w=;
        b=pDp803wa+SGGvyrtkmH05/OB7VOLYmtqE+tBg1dV6JgbDZzkgvxsswzt4P1RulR0Ne
         pBZY4P1T/JSzE5VuxhnK3fHARHDNEhKULF8msEsZQoOYmTSzI9ytUNONKNEcXKAD+DO3
         0pUoOWnLJ8F1ovq6uVT2GEk5Ufhc7YQ4SntXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fJyjbFyWrWHmOipbTvhqfiLwxaAZs6aQ0IsPH48pXHUZ8oz7Aa/Hm9E4cSmBIDQntO
         WV8RCm01iyXVN0Kcl7BSG89Kk0hITVCORAP4OJlCz+/m5iLvjXQ1cWSge5I1e68C6UHU
         ieNUFVknTgGV4lLX6EbAyRkz/in0W7OjJC5YQ=
Received: by 10.86.26.1 with SMTP id 1mr2681440fgz.49.1216241296299;
        Wed, 16 Jul 2008 13:48:16 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id d6sm1076286fga.2.2008.07.16.13.48.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 13:48:16 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807170043.49016.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88756>

Currently 'git-gui blame' does not kill its back-end
process, hoping that it will die anyway when the pipe
is closed. However, in some cases the process works
for a long time without producing any output. This
behavior results in a runaway CPU hog.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	The -f flag is necessary for msysgit.

	For this fix I submitted to msysgit a patch that includes
	a Cygwin-compatible kill.exe in the installer.

	-- Alexander

 git-gui.sh    |   14 ++++++++++++++
 lib/blame.tcl |   16 ++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b1ed0ec..83e2645 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -497,6 +497,20 @@ proc githook_read {hook_name args} {
 	return {}
 }
 
+proc kill_file_process {fd} {
+	set process [pid $fd]
+
+	catch {
+		if {[is_Windows]} {
+			# Use a Cygwin-specific flag to allow killing
+			# native Windows processes
+			exec kill -f $process
+		} else {
+			exec kill $process
+		}
+	}
+}
+
 proc sq {value} {
 	regsub -all ' $value "'\\''" value
 	return "'$value'"
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 192505d..2c19048 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -326,19 +326,27 @@ constructor new {i_commit i_path} {
 	bind $w.file_pane <Configure> \
 	"if {{$w.file_pane} eq {%W}} {[cb _resize %h]}"
 
+	wm protocol $top WM_DELETE_WINDOW "destroy $top"
+	bind $top <Destroy> [cb _kill]
+
 	_load $this {}
 }
 
+method _kill {} {
+	if {$current_fd ne {}} {
+		kill_file_process $current_fd
+		catch {close $current_fd}
+		set current_fd {}
+	}
+}
+
 method _load {jump} {
 	variable group_colors
 
 	_hide_tooltip $this
 
 	if {$total_lines != 0 || $current_fd ne {}} {
-		if {$current_fd ne {}} {
-			catch {close $current_fd}
-			set current_fd {}
-		}
+		_kill $this
 
 		foreach i $w_columns {
 			$i conf -state normal
-- 
1.5.6.3.17.g3f148

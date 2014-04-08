From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git-gui: show staged submodules regardless of ignore config
Date: Tue, 08 Apr 2014 21:30:51 +0200
Message-ID: <53444E6B.7000107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXbjY-0000yC-3J
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbaDHTay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 15:30:54 -0400
Received: from mout.web.de ([212.227.17.12]:54148 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159AbaDHTax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:30:53 -0400
Received: from [192.168.178.41] ([79.193.64.34]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M9GYQ-1Wi4mL3x5a-00Cf6K; Tue, 08 Apr 2014 21:30:52
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:dKlMaKbLYGEPX95YUJwDI/aCVTyQlI5bpp2hKoNzl/0kQPU8bzr
 NiVe/LqJFB32t5BqqiEWLAs7JknFJRYZn2S0Z4zUbBkwtDUQT/q5VbAyLakGN139THeTo5l
 w/vWxfWhTFnc5n6xMgjDb6xiWCvgOPjO07/KmJqz6GdVOFq7FxCVFjO2LaUD7tr3sU5HwU4
 dIdbKyXI9vTyQI/ZfLhCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245953>

Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
"all" suppresses all output of submodule changes for git-gui. This is
really confusing, as even when the user chooses to record a new commit for
an ignored submodule by adding it manually this change won't show up under
"Staged Changes (Will Commit)".

Fix that by using the '--ignore-submodules=dirty' option for both callers
of "git diff-index --cached" when the underlying git version supports that
option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-gui.sh   | 6 +++++-
 lib/diff.tcl | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index cf2209b..c69bfb3 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1558,7 +1558,11 @@ proc rescan_stage2 {fd after} {

 	set rescan_active 2
 	ui_status [mc "Scanning for modified files ..."]
-	set fd_di [git_read diff-index --cached -z [PARENT]]
+	if {[git-version >= "1.7.2"]} {
+		set fd_di [git_read diff-index --cached --ignore-submodules=dirty -z [PARENT]]
+	} else {
+		set fd_di [git_read diff-index --cached -z [PARENT]]
+	}
 	set fd_df [git_read diff-files -z]

 	fconfigure $fd_di -blocking 0 -translation binary -encoding binary
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 30d9a79..b0a5180 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -287,6 +287,9 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	if {$w eq $ui_index} {
 		lappend cmd diff-index
 		lappend cmd --cached
+		if {[git-version >= "1.7.2"]} {
+			lappend cmd --ignore-submodules=dirty
+		}
 	} elseif {$w eq $ui_workdir} {
 		if {[string first {U} $m] >= 0} {
 			lappend cmd diff
-- 
1.9.1.492.g8149f6f

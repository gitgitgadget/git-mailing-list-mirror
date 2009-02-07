From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI BUG) v2] git-gui: Avoid an infinite rescan loop in handle_empty_diff.
Date: Sat, 7 Feb 2009 19:24:01 +0300
Organization: HOME
Message-ID: <200902071924.02419.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 17:24:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVpyR-0003MW-F2
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 17:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbZBGQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 11:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbZBGQWk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 11:22:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:19920 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZBGQWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 11:22:39 -0500
Received: by fg-out-1718.google.com with SMTP id 16so761319fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 08:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nYKUsTApTmnelFXVaB7zq6rrjceJ9QNnOVm68rAZ3Ek=;
        b=efO4vCY4s4wdWiVZ1pIcJsHPoxXmzsmOfcB/ynYuoAnNuY07gjyUSUBXuTppDa9leQ
         YqP7HecHPmJnFzvmMNZ6O4FyscgCfgFELq/laMwKaomPRFfRgme7uYG9wD+eUYuKREU/
         Ud3H68gHSrWdBhF5Mq7r/gZwX4WxFOO7NTx6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=w8RMcHV5zOxo2oqVGDKnh5rCc2eHICBLucH6Kh/yb78fKoRO8vqn4326lpQJL43tgC
         cbMX9QCC6rPcSiF7BZesiipeXhHJEv/jpsHcMjXXaRTGhLHZT26mYwkGGCJOl2NTnt3n
         egtcdU8yq7mlqVhW1wJrtwkCHwU+tuZ1jKDv8=
Received: by 10.86.61.13 with SMTP id j13mr1690262fga.6.1234023756781;
        Sat, 07 Feb 2009 08:22:36 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 4sm5286204fge.44.2009.02.07.08.22.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 08:22:36 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27.12-170.2.5.fc10.i686; KDE/4.1.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108865>

If the index update machinery and git diff happen to disagree
on whether a particular file is modified, it may cause git-gui
to enter an infinite index rescan loop, where an empty diff
starts a rescan, which finds the same set of files modified,
and tries to display the diff for the first one, which happens
to be the empty one. A current example of a possible disagreement
point is the autocrlf filter.

This patch breaks the loop by using a global counter to track
the auto-rescans. The variable is reset whenever a non-empty
diff is displayed.

Another suggested approach, which is based on giving the
--exit-code argument to git diff, cannot be used, because
diff-files seems to trust the timestamps in the index, and
returns a non-zero code even if the file is actually
unchanged, which essentially defeats the purpose of the
auto-rescan logic.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	Apparently git-diff also has a small crlf-related bug.
	It can be reproduced using the following commands:


	$ rm -rf .git *
	$ git init
	$ echo > foo
	$ git add foo && git commit -m init
	$ git diff-files -p --exit-code && echo unchanged
	unchanged
	$ git diff --exit-code && echo unchanged
	unchanged
	$ touch foo
	$ git diff-files -p --exit-code && echo unchanged
	diff --git a/foo b/foo
	$ git diff --exit-code && echo unchanged
	unchanged

	    Without autocrlf git-diff recognizes that
	    the file is unchanged.


	$ rm -rf .git *
	$ git init
	$ git config core.autocrlf true
	$ echo > foo
	$ unix2dos -o foo
	$ git add foo && git commit -m init
	$ git diff-files -p --exit-code && echo unchanged
	unchanged
	$ git diff --exit-code && echo unchanged
	unchanged
	$ touch foo
	$ git diff-files -p --exit-code && echo unchanged
	diff --git a/foo b/foo
	$ git diff --exit-code && echo unchanged
	diff --git a/foo b/foo

	    With crlf it prints an empty diff and says
	    that there are some changes.


	I don't think that this behavior should depend
	on the autocrlf setting.

	-- Alexander

 lib/diff.tcl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index bbbf15c..925b3f5 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -51,11 +51,16 @@ proc force_diff_encoding {enc} {
 
 proc handle_empty_diff {} {
 	global current_diff_path file_states file_lists
+	global diff_empty_count
 
 	set path $current_diff_path
 	set s $file_states($path)
 	if {[lindex $s 0] ne {_M}} return
 
+	# Prevent infinite rescan loops
+	incr diff_empty_count
+	if {$diff_empty_count > 1} return
+
 	info_popup [mc "No differences detected.
 
 %s has no changes.
@@ -310,6 +315,7 @@ proc read_diff {fd cont_info} {
 	global ui_diff diff_active
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
+	global diff_empty_count
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -415,7 +421,10 @@ proc read_diff {fd cont_info} {
 
 		if {[$ui_diff index end] eq {2.0}} {
 			handle_empty_diff
+		} else {
+			set diff_empty_count 0
 		}
+
 		set callback [lindex $cont_info 1]
 		if {$callback ne {}} {
 			eval $callback
-- 
1.6.1.63.g950db

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: make gc warning threshold match 'git gc --auto'
Date: Sun, 10 Aug 2014 11:40:03 +0100
Message-ID: <8738d4aarg.fsf@red.patthoyts.tk>
References: <53E27915.9040305@gmail.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 12:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGQdr-00084e-VF
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 12:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbaHJKp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 06:45:56 -0400
Received: from know-smtprelay-omc-1.server.virginmedia.net ([80.0.253.65]:46007
	"EHLO know-smtprelay-omc-1.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbaHJKpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 06:45:55 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Aug 2014 06:45:54 EDT
Received: from red.patthoyts.tk ([82.45.42.101])
	by know-smtprelay-1-imp with bizsmtp
	id cyg41o0262AxhvW01yg4hR; Sun, 10 Aug 2014 11:40:04 +0100
X-Originating-IP: [82.45.42.101]
X-Spam: 0
X-Authority: v=2.1 cv=aLJ+qNNm c=1 sm=1 tr=0 a=FEdcR8KTC/yDun0iFnNZnw==:117
 a=FEdcR8KTC/yDun0iFnNZnw==:17 a=6gpmbu8EOFEA:10 a=xUtUktvLM3QA:10
 a=Iqy1LbjttW8A:10 a=CtgcEeagiGAA:10 a=xqWC_Br6kY4A:10 a=FP58Ms26AAAA:8
 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=ij1I2Bow-7qXn9YrTJoA:9 a=MSl-tDqOz04A:10
 a=VV35OHq6BBAA:10 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id C19091960D31;
	Sun, 10 Aug 2014 11:40:03 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <53E27915.9040305@gmail.com> (Karsten Blees's message of "Wed, 06
	Aug 2014 20:51:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255088>

Karsten Blees <karsten.blees@gmail.com> writes:

>The number of loose objects at which git-gui shows a gc warning has
>historically been hardcoded to ~2000, or ~200 on Windows. The warning can
>only be disabled completely via gui.gcwarning=false.
>
>Especially on Windows, the hardcoded threshold is so ridiculously low that
>git-gui often complains even immediately after gc (due to loose objects
>only referenced by the reflog).
>
>'git gc --auto' uses a much bigger threshold to check if gc is necessary.
>Additionally, the value can be configured via gc.auto (default 6700).
>There's no special case for Windows.
>
>Change git-gui so that it only warns if 'git gc --auto' would also do an
>automatic gc, i.e.:
> - calculate the threshold from the gc.auto setting (default 6700,
>   disabled if <= 0)
> - check directory .git/objects/17
>
>We still check four directories (14-17) if gc.auto is very small, to get a
>better estimate.
>
>Signed-off-by: Karsten Blees <blees@dcon.de>
>---
> git-gui/lib/database.tcl | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
>
>diff --git a/git-gui/lib/database.tcl b/git-gui/lib/database.tcl
>index 1f187ed..212b195 100644
>--- a/git-gui/lib/database.tcl
>+++ b/git-gui/lib/database.tcl
>@@ -89,19 +89,26 @@ proc do_fsck_objects {} {
> }
> 
> proc hint_gc {} {
>+	global repo_config
>+	set auto_gc $repo_config(gc.auto)
>+	if {$auto_gc eq {}} {
>+		set auto_gc 6700
>+	} elseif {$auto_gc <= 0} {
>+		return
>+	}
>+
> 	set ndirs 1
>-	set limit 8
>-	if {[is_Windows]} {
>+	set limit [expr {($auto_gc + 255) / 256}]
>+	if {$limit < 4} {
> 		set ndirs 4
>-		set limit 1
> 	}
> 
> 	set count [llength [glob \
> 		-nocomplain \
> 		-- \
>-		[gitdir objects 4\[0-[expr {$ndirs-1}]\]/*]]]
>+		[gitdir objects 1\[[expr {8-$ndirs}]-7\]/*]]]
> 
>-	if {$count >= $limit * $ndirs} {
>+	if {$count > $limit * $ndirs} {
> 		set objects_current [expr {$count * 256/$ndirs}]
> 		if {[ask_popup \
> 			[mc "This repository currently has approximately %i loose objects.

Applying this to git-gui I get an error raised 
  can't read "repo_config(gc.auto)": no such element in array
which occurs because I've never set this config variable and it is not
present in the default_config array which is used to initialize repo_config.

The following should solve this by moving where we ser the default:

>From bdb136cbcb2a3fc0e3441f852e4bf4525ee4cf99 Mon Sep 17 00:00:00 2001
From: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Sun, 10 Aug 2014 11:36:47 +0100
Subject: [PATCH] git-gui: initialize the default value for gc.auto in case it
 is unset.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 git-gui.sh       | 1 +
 lib/database.tcl | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b186329..ee9c47b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -880,6 +880,7 @@ proc apply_config {} {
 }
 
 set default_config(branch.autosetupmerge) true
+set default_config(gc.auto) 6700
 set default_config(merge.tool) {}
 set default_config(mergetool.keepbackup) true
 set default_config(merge.diffstat) true
diff --git a/lib/database.tcl b/lib/database.tcl
index 212b195..d9ba323 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -91,9 +91,7 @@ proc do_fsck_objects {} {
 proc hint_gc {} {
 	global repo_config
 	set auto_gc $repo_config(gc.auto)
-	if {$auto_gc eq {}} {
-		set auto_gc 6700
-	} elseif {$auto_gc <= 0} {
+	if {$auto_gc <= 0} {
 		return
 	}
 
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

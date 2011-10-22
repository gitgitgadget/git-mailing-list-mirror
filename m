From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCHv2] git-gui: delegate selection from gutter columns to text output
Date: Sat, 22 Oct 2011 21:38:49 +0200
Message-ID: <4494a44b6755080915176a3f726fa8b754deee8d.1319312109.git.bert.wesarg@googlemail.com>
References: <CAKPyHN1zTJsE5-T5LdN=86iKdQ7=SGxuVacw8aE4DvmbX4srHw@mail.gmail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:39:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHhPb-0002XC-IG
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab1JVTi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:38:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35429 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab1JVTiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:38:55 -0400
Received: by bkbzt19 with SMTP id zt19so6299945bkb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5ajZjMpUK4AbQnbNacEsv9kWalB+uYlUM/LVhJCNzUk=;
        b=f4/St3j+6IUBAAgqNgcvS6oLQm8e8Xr/6Yl6cTW8GtoKoNOHRsuaq9I5OHEUVWN8x2
         hD1F/XNtPRZmGzmZjdY/Mpbz9uiUdwNnyzPWGy9wD+cfM7R2GWiFmd3x4KWPgNesRPvq
         WSz2QU3FxOuMDYZwgD3rB1nBpYJ50FJSNfOvs=
Received: by 10.204.140.73 with SMTP id h9mr13325126bku.30.1319312333831;
        Sat, 22 Oct 2011 12:38:53 -0700 (PDT)
Received: from localhost (p5B2AD0E6.dip.t-dialin.net. [91.42.208.230])
        by mx.google.com with ESMTPS id k6sm17792134bkv.8.2011.10.22.12.38.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:38:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.908.g383b5
In-Reply-To: <CAKPyHN1zTJsE5-T5LdN=86iKdQ7=SGxuVacw8aE4DvmbX4srHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184120>

Selecting in the gutter columns of the blame view should make no sense,
so delegate any selection action in these columns to the text output
by selecting whole lines there.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

 git-gui.sh    |   29 +++++++++++++++++++++++++++++
 lib/blame.tcl |   20 +++++++++++++++-----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 21033cb..53d6b43 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2077,6 +2077,35 @@ proc many2scrollbar {list mode sb top bottom} {
 	foreach w $list {$w $mode moveto $top}
 }
 
+# delegates mouse selection actions from gutter columns to the main text
+# widget
+# use delegator_bind, if you need to bind more actions
+proc delegate_sel_to {w from} {
+	set bind_list [list \
+		<Button-1> \
+		<B1-Motion> \
+		<Double-Button-1> \
+		<Triple-Button-1> \
+		<Shift-Button-1> \
+		<Double-Shift-Button-1> \
+		<Triple-Shift-Button-1> \
+	]
+
+	foreach seq $bind_list {
+		set script [bind Text $seq]
+		set new_script [string map [list %W $w %x 0 word line] $script]
+		foreach f $from {
+			bind $f $seq "$new_script; focus $w; break"
+		}
+	}
+}
+
+# use this for binding any of the mouse actions from a delegator
+# see bind_list in delegate_sel_to
+proc delegator_bind {tag seq script} {
+	bind $tag $seq "$script; [bind $tag $seq]"
+}
+
 proc incr_font_size {font {amt 1}} {
 	set sz [font configure $font -size]
 	incr sz $amt
diff --git a/lib/blame.tcl b/lib/blame.tcl
index b031e66..b7eb18a 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -210,6 +210,8 @@ constructor new {i_commit i_path i_jump} {
 
 	set w_columns [list $w_amov $w_asim $w_line $w_file]
 
+	delegate_sel_to $w_file [list $w_amov $w_asim $w_line]
+
 	${NS}::scrollbar $w.file_pane.out.sbx \
 		-orient h \
 		-command [list $w_file xview]
@@ -318,11 +320,19 @@ constructor new {i_commit i_path i_jump} {
 		$i conf -yscrollcommand \
 			"[list ::searchbar::scrolled $finder]
 			 [list many2scrollbar $w_columns yview $w.file_pane.out.sby]"
-		bind $i <Button-1> "
-			[cb _hide_tooltip]
-			[cb _click $i @%x,%y]
-			focus $i
-		"
+		if {$i eq $w_file} {
+			bind $i <Button-1> "
+				[cb _hide_tooltip]
+				[cb _click $i @%x,%y]
+				focus $i
+			"
+		} else {
+			delegator_bind $i <Button-1> "
+				[cb _hide_tooltip]
+				[cb _click $i @%x,%y]
+				focus $i
+			"
+		}
 		bind $i <Any-Motion>  [cb _show_tooltip $i @%x,%y]
 		bind $i <Any-Enter>   [cb _hide_tooltip]
 		bind $i <Any-Leave>   [cb _hide_tooltip]
-- 
1.7.7.908.g383b5

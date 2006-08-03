From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 03 Aug 2006 01:39:57 -0700
Message-ID: <7vvepaqkki.fsf@assigned-by-dhcp.cox.net>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	<20060802192922.GA30539@prophet.net-ronin.org>
	<7virlas9ol.fsf@assigned-by-dhcp.cox.net>
	<20060803053004.GA10413@prophet.net-ronin.org>
	<20060803054831.GB10413@prophet.net-ronin.org>
	<20060803073636.GA12755@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 10:41:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8YkO-0000vE-JA
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 10:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWHCIj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 04:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWHCIj7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 04:39:59 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:13472 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932358AbWHCIj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 04:39:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803083958.PYRB27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 04:39:58 -0400
To: carbonated beverage <ramune@net-ronin.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24713>

carbonated beverage <ramune@net-ronin.org> writes:

> Wheee...
>
> Found it.
>
> diff --git a/gitk b/gitk
> index ba4644f..5ae28ef 100755
> --- a/gitk
> +++ b/gitk
> @@ -770,6 +770,9 @@ proc savestuff {w} {
>  	set wid [expr {([winfo width $ctext] - 8) \
>  			   / [font measure $textfont "0"]}]
>  	puts $f "set geometry(ctextw) $wid"
> +	set geometry(ctexth) [expr {($texth - 8) /
> +			   / [font metrics $textfont -linespace]}]
> +	puts $f "set geometry(ctexth) $wid"

Are you sure about this?

	* $texth is not global, and set geometry(ctexth)
          expression has a syntax error (the slash at the end of
          the line should be backslash for continuation) -- I do
          not see how this could have worked.

	* you are setting geometry(ctexth) but trying to write
          out $wid (which is geometry(ctextw) for the next
          round).

	* but because of the first problem, I suspect the entire
          catch {} clause would have silently failed, perhaps
          leaving the old ~/.gitk around, or more likely not
          creating ~/.gitk at all, which essentially is
          "removing ~/.gitk every time you run it" ;-).

Did your ~/.gitk change after exiting your gitk session?  I
somehow doubt it.

The following _might_ have a better chance of success...

---
diff --git a/gitk b/gitk
index ba4644f..b06e022 100755
--- a/gitk
+++ b/gitk
@@ -761,17 +761,25 @@ proc savestuff {w} {
 	puts $f [list set cmitmode $cmitmode]
 	puts $f [list set wrapcomment $wrapcomment]
 	puts $f [list set showneartags $showneartags]
+
+	set g_height [winfo height .ctop]
+	set g_canvh [expr {[winfo height $canv]-2}]
+
 	puts $f "set geometry(width) [winfo width .ctop]"
-	puts $f "set geometry(height) [winfo height .ctop]"
+	puts $f "set geometry(height) $g_height"
 	puts $f "set geometry(canv1) [expr {[winfo width $canv]-2}]"
 	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-2}]"
 	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-2}]"
-	puts $f "set geometry(canvh) [expr {[winfo height $canv]-2}]"
+	puts $f "set geometry(canvh) $g_canvh"
 	set wid [expr {([winfo width $ctext] - 8) \
 			   / [font measure $textfont "0"]}]
 	puts $f "set geometry(ctextw) $wid"
 	set wid [expr {([winfo width $cflist] - 11) \
 			   / [font measure [$cflist cget -font] "0"]}]
+	set texth [expr {$g_height - $g_canvh - 56}]
+	set g_ctexth [expr {($texth - 8) \
+			   / [font metrics $textfont -linespace]}]
+	puts $f "set geometry(ctexth) $g_ctexth"
 	puts $f "set geometry(cflistw) $wid"
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {

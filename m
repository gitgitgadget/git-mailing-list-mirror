From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-commit: fix signed off handling
Date: Sun, 24 Sep 2006 19:45:19 +0200
Message-ID: <20060924174519.GW20017@pasky.or.cz>
References: <20060825002740.GH2817@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:45:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRY2d-0000pR-L4
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWIXRpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWIXRpV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:45:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35530 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751302AbWIXRpU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 13:45:20 -0400
Received: (qmail 10641 invoked by uid 2001); 24 Sep 2006 19:45:19 +0200
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20060825002740.GH2817@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27683>

Dear diary, on Fri, Aug 25, 2006 at 02:27:40AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> said that...
> Handle the sign off insertion before starting the CG: comment lines. Also,
> fix typo in grepping for existing sign off lines.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
> 
> The late calling of the add_signoff function has multiple problems,
> since at that point comment lines has already been added and the sign
> off line will end up in only one of the log message files.

Well, the commit that moved this was

Commit: 4cf220db10c0b937f9852513effc5565fcbb4f86
Author: Petr Baudis <pasky@pixie.suse.cz> Thu, 20 Jul 2006 11:37:31 -0400

    * cg-commit:

    Add signoff past the message if getting it from stdin

What about this?

diff --git a/cg-commit b/cg-commit
index 43e6c6c..beedb6f 100755
--- a/cg-commit
+++ b/cg-commit
@@ -402,10 +402,6 @@ if [ "$msgfile" ]; then
 	written=1
 fi
 
-# Always have at least one blank line, to ease the editing for
-# the poor people whose text editor has no 'O' command.
-[ "$written" ] || { tty -s && echo >>"$LOGMSG"; }
-
 add_signoff() {
 	if [ "$signoff" ] && ! grep -q -i "signed-off-by: $signoff" $LOGMSG; then
 		grep -q -i sign-off-by $LOGMSG || echo
@@ -413,6 +409,16 @@ add_signoff() {
 	fi >> $LOGMSG
 }
 
+if tty -s; then
+	# Always have at least one blank line, to ease the editing for
+	# the poor people whose text editor has no 'O' command.
+	[ "$written" ] || echo >>"$LOGMSG"
+	# Also, add the signoff line _now_ before spewing out CG: lines.
+	# (In case of non-tty input we do it later after taking the actual
+	# log message from stdin.)
+	add_signoff
+fi
+
 # CG: -----------------------------------------------------------------------
 editor_comment_start commit
 
@@ -472,7 +478,6 @@ editor_msg_end
 
 cp "$LOGMSG" "$LOGMSG2"
 if tty -s; then
-	add_signoff
 	if [ "$editor" ] && ! editor $commitalways commit c; then
 		rm "$LOGMSG" "$LOGMSG2"
 		[ "$review" ] && rm "$PATCH"

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

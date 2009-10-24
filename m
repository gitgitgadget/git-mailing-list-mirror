From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH 1/2] gitk: Initialize msgcat before first use
Date: Sat, 24 Oct 2009 16:20:39 -0400
Message-ID: <1256415640-10328-2-git-send-email-bernt@norang.ca>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
Cc: Paul Mackerras <paulus@samba.org>, Bernt Hansen <bernt@norang.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 22:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1n7a-0005Be-Sw
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 22:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZJXUVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbZJXUVh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 16:21:37 -0400
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49956 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbZJXUVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 16:21:35 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1N1n7M-000MZ1-9S; Sat, 24 Oct 2009 20:21:40 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+awYMrqgpXJAtQE7rEvoQI
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n9OKLbQT012038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Oct 2009 16:21:38 -0400
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n9OKLb0l010417;
	Sat, 24 Oct 2009 16:21:37 -0400
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n9OKLbP7010416;
	Sat, 24 Oct 2009 16:21:37 -0400
X-Mailer: git-send-email 1.6.5.1.69.g36942
In-Reply-To: <1256415640-10328-1-git-send-email-bernt@norang.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131179>

The error text generated when your version of Tcl is too old is
translated with msgcat (mc) before msgcat is initialized.  This
causes Tcl to abort with:

    Error in startup script: invalid command name "mc"

We now initialize msgcat first before we check the Tcl version.  Msgcat
is available since Tcl 8.1.

Signed-off-by: Bernt Hansen <bernt@norang.ca>
---
 gitk |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/gitk b/gitk
index a0214b7..d4cd566 100755
--- a/gitk
+++ b/gitk
@@ -11004,7 +11004,27 @@ proc get_path_encoding {path} {
     return $tcl_enc
 }
 
-# First check that Tcl/Tk is recent enough
+# First setup up mc for translating text
+## For msgcat loading, first locate the installation location.
+if { [info exists ::env(GITK_MSGSDIR)] } {
+    ## Msgsdir was manually set in the environment.
+    set gitk_msgsdir $::env(GITK_MSGSDIR)
+} else {
+    ## Let's guess the prefix from argv0.
+    set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
+    set gitk_libdir [file join $gitk_prefix share gitk lib]
+    set gitk_msgsdir [file join $gitk_libdir msgs]
+    unset gitk_prefix
+}
+
+## Internationalization (i18n) through msgcat and gettext. See
+## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+package require msgcat
+namespace import ::msgcat::mc
+## And eventually load the actual message catalog
+::msgcat::mcload $gitk_msgsdir
+
+# Check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
     show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
 		     Gitk requires at least Tcl/Tk 8.4."]
@@ -11096,25 +11116,6 @@ if {[tk windowingsystem] eq "aqua"} {
     set ctxbut <Button-3>
 }
 
-## For msgcat loading, first locate the installation location.
-if { [info exists ::env(GITK_MSGSDIR)] } {
-    ## Msgsdir was manually set in the environment.
-    set gitk_msgsdir $::env(GITK_MSGSDIR)
-} else {
-    ## Let's guess the prefix from argv0.
-    set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
-    set gitk_libdir [file join $gitk_prefix share gitk lib]
-    set gitk_msgsdir [file join $gitk_libdir msgs]
-    unset gitk_prefix
-}
-
-## Internationalization (i18n) through msgcat and gettext. See
-## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
-package require msgcat
-namespace import ::msgcat::mc
-## And eventually load the actual message catalog
-::msgcat::mcload $gitk_msgsdir
-
 catch {source ~/.gitk}
 
 font create optionfont -family sans-serif -size -12
-- 
1.6.5.1.69.g36942

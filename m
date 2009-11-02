From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH] Skip translation of wrong Tcl version text
Date: Mon, 02 Nov 2009 07:41:00 -0500
Organization: Norang Consulting Inc
Message-ID: <87ljipje03.fsf@gollum.intra.norang.ca>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
	<1256415640-10328-2-git-send-email-bernt@norang.ca>
	<87d443xn5u.fsf@users.sourceforge.net>
	<874opel7de.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 13:41:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4wDi-0004R0-IA
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 13:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbZKBMlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 07:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbZKBMlC
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 07:41:02 -0500
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65066 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbZKBMlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 07:41:01 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1N4wDZ-000KUl-Vb; Mon, 02 Nov 2009 12:41:06 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/3tgesCoVDR6GilOvx7WOp
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id nA2Cf1ir018985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 Nov 2009 07:41:02 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id nA2Cf158025094;
	Mon, 2 Nov 2009 07:41:01 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id nA2Cf0R1025093;
	Mon, 2 Nov 2009 07:41:00 -0500
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131903>

We check the required Tcl version number before we setup msgcat for
language translation.  If the Tcl version is too old just display the
untranslated error text.

The caller of show_error can now pass an alternative function for mc.
The Tcl list function turns the transalation into a no-op.

This fixes the
    Error in startup script: invalid command name "mc"
when attempting to start gitk with Tcl 8.3.

Signed-off-by: Bernt Hansen <bernt@norang.ca>
---
I tested this patch with both Tcl 8.3 and 8.4.

This is an alternative to the previous 2 patches I sent attempting
to initialize msgcat before first use.  This patch is much simpler
but does not attempt to translate the wrong version message text.

This patch fixes the version number error message by displaying it
untranslated since msgcat is not initialized yet.  The current
initialization code for msgcat uses normalize which is only available as
of Tcl 8.4 so moving the code up front didn't work in Tcl 8.3.

 gitk |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index a0214b7..d1f32a9 100755
--- a/gitk
+++ b/gitk
@@ -1787,10 +1787,10 @@ proc make_transient {window origin} {
     }
 }
 
-proc show_error {w top msg} {
+proc show_error {w top msg {mc mc}} {
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text [mc OK] -command "destroy $top"
+    button $w.ok -text [$mc OK] -command "destroy $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
@@ -11006,8 +11006,8 @@ proc get_path_encoding {path} {
 
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
-    show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
-		     Gitk requires at least Tcl/Tk 8.4."]
+    show_error {} . "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
+		     Gitk requires at least Tcl/Tk 8.4." list
     exit 1
 }
 
-- 
1.6.5.2.141.gc8a58

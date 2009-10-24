From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH 2/2] gitk: Provide a default mc function if msgcat is not available
Date: Sat, 24 Oct 2009 16:20:40 -0400
Message-ID: <1256415640-10328-3-git-send-email-bernt@norang.ca>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
Cc: Paul Mackerras <paulus@samba.org>, Bernt Hansen <bernt@norang.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 22:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1n7b-0005Be-Cw
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 22:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbZJXUVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 16:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbZJXUVm
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 16:21:42 -0400
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50120 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbZJXUVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 16:21:41 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1N1n7S-000Mbh-DG; Sat, 24 Oct 2009 20:21:46 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19fCrLZw1Q83qIbMSZXQgp1
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n9OKLiC2012052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Oct 2009 16:21:45 -0400
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n9OKLiha010425;
	Sat, 24 Oct 2009 16:21:44 -0400
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n9OKLiKL010424;
	Sat, 24 Oct 2009 16:21:44 -0400
X-Mailer: git-send-email 1.6.5.1.69.g36942
In-Reply-To: <1256415640-10328-1-git-send-email-bernt@norang.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131180>

Msgcat is available since Tcl 8.1.  For really old versions of Tcl
provide a default mc that just returns the text untranslated.  This
allows the Tcl version check to return the error in a window instead
of making Tcl abort when attempting to load the msgcat package.

Signed-off-by: Bernt Hansen <bernt@norang.ca>
---
I'm not sure if we care about Tcl versions older than 8.1 but this at
least shows the error in the window with the [OK] button.

 gitk |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index d4cd566..bff891d 100755
--- a/gitk
+++ b/gitk
@@ -11019,10 +11019,15 @@ if { [info exists ::env(GITK_MSGSDIR)] } {
 
 ## Internationalization (i18n) through msgcat and gettext. See
 ## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
-package require msgcat
-namespace import ::msgcat::mc
-## And eventually load the actual message catalog
-::msgcat::mcload $gitk_msgsdir
+if {[catch {package require msgcat}]} {
+    proc mc {arg} {
+	return $arg
+    }
+} else {
+    namespace import ::msgcat::mc
+    ## And eventually load the actual message catalog
+    ::msgcat::mcload $gitk_msgsdir
+}
 
 # Check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
-- 
1.6.5.1.69.g36942

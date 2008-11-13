From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH (GIT-GUI)] git-gui: Increase blame viewer usability on MacOS.
Date: Thu, 13 Nov 2008 22:02:09 +0300
Organization: HOME
Message-ID: <200811132202.09139.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0hVs-0001fI-Mv
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 20:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYKMTEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754464AbYKMTEP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:04:15 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:23015 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYKMTEN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 14:04:13 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1015853muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=i9vDJOUvs0S3i46soSaVMh+sdvijsULhz9983PnAhuI=;
        b=knenfV4M9iUb9nhqQcWKXZGyXNLWw8Qdh/jOToI2acrGNUq2oU9QbLQ9BrM6JLIhRN
         vmQ+I0qOfAMr5p/e1Aeb6Ut1yge0YdiBh8fbHW7qhrpWL0E1R37jqTL6WHFxtgrn71O9
         mUcWgz9vKHXaU2wbBMdYZyah3Ux2/zZw9vPLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=QjOzgUoEWLJFRyjsuyxRaB0VMArRlknDbPsHudnwINkzE2ZWIXl7frG3VPL3Nu5Z0j
         V0mJWxoYmLpjJ/MgTsvB1Dx0q/vS9B0TVWBv+J1oqQdP3v+Rdh7baQZAkid0aDoz17u0
         NY+UEDZ88Z6jxcV+R1w6J5JfiefVJeR5RGOH0=
Received: by 10.181.25.10 with SMTP id c10mr14352bkj.181.1226603051755;
        Thu, 13 Nov 2008 11:04:11 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id b17sm5230889fka.7.2008.11.13.11.04.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 11:04:09 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100898>

On MacOS raising a window causes the focus to be transferred
to it -- although it may actually be a bug in the Tcl/Tk port.
When this happens with the blame viewer tooltips, it makes
the interface less usable, because Entry and Leave handlers
on the text view cause the tip to disappear once the mouse
is moved even 1 pixel.

This commit makes the code raise the main window on MacOS
when Tk 8.5 is used. This version seems to properly support
wm transient by making the tip stay on top of the master,
so reraising the master does not cause it to disappear. Thus
the only remaining sign of problems is slight UI flicker
when focus is momentarily transferred to the tip and back.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	An ugly hack, but it makes at least my experience better.
	Unfortunately, even it requires manually installing Tk 8.5.

	I wonder if there is a better fix.
	(maybe, tweaking Enter and Leave instead?)

	Alexander

 lib/blame.tcl |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index c1cd7f3..f086a8a 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -1246,6 +1246,18 @@ method _open_tooltip {cur_w} {
 
 	$tooltip_t conf -state disabled
 	_position_tooltip $this
+
+	# On MacOS raising a window causes it to acquire focus.
+	# Tk 8.5 on MacOS seems to properly support wm transient,
+	# so we can safely counter the effect there.
+	if {$::have_tk85 && [tk windowingsystem] eq {aqua}} {
+		update
+		if {$w eq {}} {
+			raise .
+		} else {
+			raise $w
+		}
+	}
 }
 
 method _position_tooltip {} {
@@ -1269,7 +1281,9 @@ method _position_tooltip {} {
 	append g $pos_y
 
 	wm geometry $tooltip_wm $g
-	raise $tooltip_wm
+	if {[tk windowingsystem] ne {aqua}} {
+		raise $tooltip_wm
+	}
 }
 
 method _hide_tooltip {} {
-- 
1.6.0.3.15.gb8d36

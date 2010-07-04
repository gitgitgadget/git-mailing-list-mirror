From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 git-gui] git-gui--askpass: Do not hang on exit
Date: Sun, 4 Jul 2010 16:24:39 -0500
Message-ID: <20100704212439.GA1765@burratino>
References: <20100704203342.6064.32250.reportbug@balanced-tree>
 <20100704212125.GA1613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 04 23:25:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVWgl-00053B-AY
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 23:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab0GDVZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 17:25:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45997 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757982Ab0GDVZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 17:25:16 -0400
Received: by iwn7 with SMTP id 7so4903832iwn.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PWn1SUZjcNjdfY6IFLgou0LVZuG958LmQGtXBgr/RbQ=;
        b=eO+ETk4vW3XwKxdvkySySPR1fdgS8X2kZCDoBSgoy3S+z/XEKOh7Z+uNZqsOB5wF0t
         EYJaE0lIr94/WVLY1+N2zrBnoBZashsKLHWB3ej4n+CemuiS8crz+lQxG9VvyjzYn1pT
         zp7AJN0gjxiUVndt/IcuMd31ZYhxaQb8jxTcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=biIMgQhSa9S6PFf4058OStuxjv+sqxWivNNEP/znX8fw9keiRJ8kvkCkWmspg9bdWw
         PfdCcOQN/3kY174yoOxFwKO/b1PnHWyMjp5oAhgl3iYmhOinrSfvbZNO9IM29+f3Gxiq
         4XuLGtkDHa45zWsGAjsmymSx2UWMu+d3ZKZaA=
Received: by 10.231.79.135 with SMTP id p7mr1568340ibk.132.1278278715642;
        Sun, 04 Jul 2010 14:25:15 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm15028562ibi.6.2010.07.04.14.25.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 14:25:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100704212125.GA1613@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150231>

Anders Kaseorg wrote:

> When git-gui--askpass is manually copied from the source into
> /usr/lib/git-core, though, it doesn=E2=80=99t particularly work; its =
window
> just freezes after the password is typed.

The problem seems to be the

  bind . <Destroy>    {exit $::rc}

line; apparently each exit causes the window to be destroyed again,
resulting in git gui hanging.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 I wrote:

 > @@ -52,7 +52,9 @@ proc finish {} {
 > =20
 >  	set ::rc 0
 >  	puts $::answer
 > +	bind . <Destroy> {}
 >  	destroy .

 but that does nothing to help the case when the destroy event
 comes from the window manager.  Here=E2=80=99s a saner patch (sorry fo=
r
 the noise).

diff --git a/git-gui--askpass b/git-gui--askpass
index 12e117e..20b8799 100755
--- a/git-gui--askpass
+++ b/git-gui--askpass
@@ -39,7 +39,10 @@ pack .b -side bottom -fill x -padx 10 -pady 10
 bind . <Visibility> {focus -force .e}
 bind . <Key-Return> finish
 bind . <Key-Escape> {destroy .}
-bind . <Destroy>    {exit $rc}
+bind . <Destroy>    {
+	bind . <Destroy> {}
+	exit $::rc
+}
=20
 proc finish {} {
 	if {$::yesno} {
--=20

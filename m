From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH git-gui] git-gui--askpass: Do not hang on exit
Date: Sun, 4 Jul 2010 16:21:25 -0500
Message-ID: <20100704212125.GA1613@burratino>
References: <20100704203342.6064.32250.reportbug@balanced-tree>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 04 23:22:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVWdq-00047m-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 23:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab0GDVWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 17:22:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37822 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757982Ab0GDVWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 17:22:04 -0400
Received: by iwn7 with SMTP id 7so4902569iwn.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bWz2MgJAvYPHSvSoCCEJsHWJC6ilwcQY2//FlzZZxkU=;
        b=qSxYPdVIxA5B4XQ80y9uMFVr+Nric8QXkg1o9QO9V1zeWiof8F3Ay80gvFSxx/z3z3
         WDiC8hgHNEbAvHVNz04X3a/Yqnof4/z12QoOdlOWsGrFmq8HEd/twNSKTGtuAP6ZbDHA
         9q3S42wsRJPDoT7lgQty7CT63s/iCeJTB9npw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vah0JtvhBuFCpTB/3kc4MS6PtOUGTUoYottb4hKsMRyDG6ZKhi4aWQ8wWiHpWlTdMT
         n/EzCmEjas32cwGHmZXaoHVcSDOJl4aubkKxG4aoG/5stUMQCfXxT+iiRZ7yvyfzc61A
         GpplPyw3FZi/vYsKF77D296UvKtwU9mhEw5Ks=
Received: by 10.231.174.65 with SMTP id s1mr99683ibz.3.1278278521963;
        Sun, 04 Jul 2010 14:22:01 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm14995971ibk.15.2010.07.04.14.22.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 14:22:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100704203342.6064.32250.reportbug@balanced-tree>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150230>

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

diff --git a/git-gui--askpass b/git-gui--askpass
index 12e117e..1537f75 100755
--- a/git-gui--askpass
+++ b/git-gui--askpass
@@ -39,7 +39,7 @@ pack .b -side bottom -fill x -padx 10 -pady 10
 bind . <Visibility> {focus -force .e}
 bind . <Key-Return> finish
 bind . <Key-Escape> {destroy .}
-bind . <Destroy>    {exit $rc}
+bind . <Destroy>    {exit $::rc}
=20
 proc finish {} {
 	if {$::yesno} {
@@ -52,7 +52,9 @@ proc finish {} {
=20
 	set ::rc 0
 	puts $::answer
+	bind . <Destroy> {}
 	destroy .
+	exit 0
 }
=20
 wm title . "OpenSSH"
--=20

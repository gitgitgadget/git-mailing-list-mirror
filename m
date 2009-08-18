From: Karthik R <karthikr@fastmail.fm>
Subject: [PATCH][resend 2] git-svn: Use GIT_SSH setting if SVN_SSH is not
 set
Date: Tue, 18 Aug 2009 15:31:36 -0500
Message-ID: <4A8B0FA8.7040500@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 22:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVLH-0006g3-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZHRUba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbZHRUba
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:31:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46732 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739AbZHRUb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 16:31:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E9FE954489
	for <git@vger.kernel.org>; Tue, 18 Aug 2009 16:31:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 18 Aug 2009 16:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=PihDLc8cbo3CqLQBUTs67vUxhFw=; b=hK4th0yLXzIdqFsd57eWSliH36QTYJ+gx+5MWe0OuOmy+AAlw994kT2fdx0eoQ2MPLs3KRXBl7Mim/uFTgEauv4QMlsUKTuVPAVAp1g4SsKhZgjiN74hGmYWpN0KWfIj1EX659hqbvo/j4M9nouVZN/Ps+sbjmO+SHXnptiniwo=
X-Sasl-enc: UQg1sjR574Mvjel9yd81AwI/ux7iVUvoGxxQR8NDSQrg 1250627489
Received: from [192.168.10.12] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 8CE30FB39
	for <git@vger.kernel.org>; Tue, 18 Aug 2009 16:31:29 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126454>

If SVN_SSH is defined, it will be used; else value in
GIT_SSH is copied to SVN_SSH & then, only on Windows,
the \s are escaped.

On Windows, the shell-variables must be set as follows
    GIT_SSH="C:\Program Files\PuTTY\plink.exe"
    SVN_SSH="C:\\Program Files\\PuTTY\\plink.exe"

See http://code.google.com/p/msysgit/issues/detail?id=305
---
Trying again following Dscho's comment (removed MSWin32) & using
logic from Junio (don't muck with user's SVN_SSH; else use GIT_SSH
to seed SVN_SSH & adjust the \s on Windows)

Previous life of patch:
[PATCH] GIT_SSH does not override ssh in git-svn
[PATCH][resend] git-svn: Respect GIT_SSH setting

 git-svn.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b0bfb74..ef86d10 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,6 +21,15 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 
'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
 
+if (! exists $ENV{SVN_SSH}) {
+    if (exists $ENV{GIT_SSH}) {
+        $ENV{SVN_SSH} = $ENV{GIT_SSH};
+        if ($^O eq 'msys') {
+            $ENV{SVN_SSH} =~ s/\\/\\\\/g;
+        }
+    }
+}
+
 $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
-- 
1.5.4.3

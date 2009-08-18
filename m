From: Karthik R <karthikr@fastmail.fm>
Subject: [PATCH][resend 3] git-svn: Use GIT_SSH setting if SVN_SSH is not
 set
Date: Tue, 18 Aug 2009 18:54:40 -0500
Message-ID: <4A8B3F40.10803@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 01:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYVv-0002uY-Bd
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbZHRXyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZHRXym
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:54:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42141 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082AbZHRXym (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 19:54:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4297B515D0;
	Tue, 18 Aug 2009 19:54:43 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 18 Aug 2009 19:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:content-type:content-transfer-encoding; s=smtpout; bh=OX21eUE9htqTlOxBh23gTVtGujY=; b=ts2NQpwuKumXscFmMHnSURuM6uxtc1/6Wd90cS6NXdk1D5Yimc9iW3teMT2+x80MGTTo3fQmKMYdnTQo/MBzkvw13MaBCE4308OI06ujaPpelyggttknr1umZ+PtLCTjvvHk+kBdrfIzMmS4HjR6srTICAYGJL6naDx8Ar0Kbag=
X-Sasl-enc: pYxd2YkSnZT/yffAwSyBJpenm20iv9V7EYpSnJhixZfV 1250639682
Received: from [0.0.0.0] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 91C514F558;
	Tue, 18 Aug 2009 19:54:42 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126486>

If SVN_SSH is defined, it will be used. Else value in
GIT_SSH is copied to SVN_SSH & then, only on Windows,
the \s are escaped.

On Windows, the shell-variables must be set as follows
    GIT_SSH="C:\Program Files\PuTTY\plink.exe"
    SVN_SSH="C:\\Program Files\\PuTTY\\plink.exe"

See http://code.google.com/p/msysgit/issues/detail?id=305

Signed-off-by: Karthik Rajagopalan <karthikr@fastmail.fm>
---
Signed off this time.

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

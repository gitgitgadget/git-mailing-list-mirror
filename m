From: Karthik R <karthikr@fastmail.fm>
Subject: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Mon, 17 Aug 2009 18:02:29 -0500
Message-ID: <4A89E185.2010307@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 01:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBEQ-0006hw-VD
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758362AbZHQXCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbZHQXCa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:02:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54465 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758357AbZHQXC3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 19:02:29 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A789D56F6F
	for <git@vger.kernel.org>; Mon, 17 Aug 2009 19:02:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 17 Aug 2009 19:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=/aepyyIVvULYzbSX20n/am8Fddw=; b=VNXdgw+idMn15BWppZ5L7P6Oej4a7V8M+ReNg/pgnGq2vK3yPwE2zMZgjJeZDIsG3592kkXoiAbgQ7HYuZDGoLuzT2O3KZInI7WLchMiUXW3q2gcv09nFkhUppSByHe2jDa58T+wU9Hab49B/Ze2IUVQt1ZdbqNE3hCMMKbcsZQ=
X-Sasl-enc: uXoEC14ImbHWmrztoQwi7vWdLhnD4CfEMn0MiAs1jqVG 1250550150
Received: from [0.0.0.0] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 17975B5F0
	for <git@vger.kernel.org>; Mon, 17 Aug 2009 19:02:29 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126314>

Setting GIT_SSH when using "git svn clone svn+ssh://..." does not
override the default ssh; SVN_SSH needed to be set instead. Fixed
this.

Also, on Windows, SVN_SSH needs to be set with \ escaped
  e.g., "C:\\PuTTY\\plink.exe"

See http://code.google.com/p/msysgit/issues/detail?id=305

Signed-off-by: Karthik R <karthikr@fastmail.fm>
---

Originally sent as [PATCH] GIT_SSH does not override ssh in git-svn

 git-svn.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b0bfb74..9bc1e71 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,6 +21,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 
'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
 
+# If GIT_SSH is set, also set SVN_SSH...
+$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
+# ... and escape \s in shell-variable on Windows
+if ($^O eq 'MSWin32' || $^O eq 'msys') {
+       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
+}
+
 $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
-- 1.5.4.3

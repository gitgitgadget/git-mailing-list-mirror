From: Karthik R <karthikr@fastmail.fm>
Subject: [PATCH] GIT_SSH does not override ssh in git-svn
Date: Mon, 17 Aug 2009 16:09:12 -0500
Message-ID: <4A89C6F8.3010100@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9SO-0004YH-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbZHQVJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758084AbZHQVJV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:09:21 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54285 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754118AbZHQVJV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 17:09:21 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E7F4D54387
	for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:09:20 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 17 Aug 2009 17:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=4BT2BNGrAgsN5aZBA7jrYx7wB/A=; b=AJcO14Hb1TOXI4p8yu/2Zv/fA9ACH1e/VmUkhWSmYvqt5lGhIDkt6L6B7+Hhirq82EuH2rkRUAG9AIzJvc6KWx6UHOqtt/oHY4TkBo1PM9aYaPo5LNTZDc2R7PzxjukQglROpiK83ZTkfBB+dx2OzG21QQ3J5CLFm9sGtLAiN1E=
X-Sasl-enc: ZAqsqVIyDjQ1dG6OVGxxZMzx4CKe+8GLI+rwBtJMO/gK 1250543360
Received: from [0.0.0.0] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 5859D8E67
	for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:09:20 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126285>



Signed-off-by: Karthik R <karthikr@fastmail.fm>
---

Setting GIT_SSH when using "git svn clone svn+ssh://..." does not 
override the
default ssh; SVN_SSH needs to be set instead. Corrected this.

Also, on Windows, SVN_SSH needs to be set with \ escaped
  e.g., "C:\\PuTTY\\plink.exe"

See http://code.google.com/p/msysgit/issues/detail?id=305

 git-svn.perl |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b0bfb74..c932b6e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,6 +21,16 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 
'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
 
+my $git_ssh_user_set = 1 if defined $ENV{GIT_SSH};
+if ($git_ssh_user_set) {
+       # If GIT_SSH is set, also set SVN_SSH...
+       $ENV{SVN_SSH} = $ENV{GIT_SSH};
+       # ... and escape \s in shell-variable on Windows
+       if ($^O eq 'MSWin32' || $^O eq 'msys') {
+               $ENV{SVN_SSH} =~ s/\\/\\\\/g;
+       }
+}
+
 $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
-- 
1.5.4.3

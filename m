From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Don't force imap.host to be set when imap.tunnel is set
Date: Mon, 21 Apr 2008 14:59:07 +0100
Message-ID: <200804211459.07527.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 16:00:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnwYx-0002g5-WC
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 16:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbYDUN7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 09:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbYDUN7U
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 09:59:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:62157 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769AbYDUN7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 09:59:19 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1338433wxd.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=Mx4mrClqdAd8d5IfKk4dS4+KrclSoS2YXVOGAtuNSbU=;
        b=Sv4ggGUCLaFDCGIrIEbykioeV9BZbcdLsNlPGW6d177hR9WZz0AdVopOMakfUgh5hHOj4f4Li7OZd97oM7FqC4dWv4HD/uVyHD+IObPhM+vyxU9EQqdGSwTQ9Ui2W0og/dqVsyD8ShuUi0mSxGocbb6GoAwgDMob6BTpakXcSuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=uHOTzQmQUDmBrUeVfkgvbW+u6rQr/0VPOnC0rsg06UeFuByPhTvKhphpwAQr2SngZNZIBf+0tK6G782SlWuM0jU4BO0LLhB3ViEB9EmRBfR3tA9SJ1ATGq4fY8uQeEmalNMQQttd5s/D2RDiS8i8D06SLhSTbY9eLnjldk3ImlE=
Received: by 10.70.78.1 with SMTP id a1mr8129353wxb.11.1208786358408;
        Mon, 21 Apr 2008 06:59:18 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id h36sm15337000wxd.29.2008.04.21.06.59.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Apr 2008 06:59:10 -0700 (PDT)
X-TUID: c02d8a085af893a6
X-UID: 8
X-Length: 1293
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80026>

The documentation for git-imap-send suggests a tunnel setting such as

  Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"

which works wonderfully and doesn't require a username, password or port
setting.

However, git-imap-send currently requires that the imap.host variable be
set in the config even when it was unused.  This led me to have to put
the following in my .gitconfig.

 [imap]
   host = dummy

This patch changes imap-send to only require that the imap.host setting
is set if imap.tunnel is _not_ set.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 imap-send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 04afbc4..e15df1e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1302,7 +1302,7 @@ main(int argc, char **argv)
 		fprintf( stderr, "no imap store specified\n" );
 		return 1;
 	}
-	if (!server.host) {
+	if (!server.host && !server.tunnel) {
 		fprintf( stderr, "no imap host specified\n" );
 		return 1;
 	}
-- 
1.5.5.1.57.g5909c

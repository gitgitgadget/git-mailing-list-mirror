From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [RFD PATCH] git-fetch--tool and "insanely" long actions
Date: Thu, 19 Apr 2007 21:05:58 -0400
Message-ID: <462811F6.9060503@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 03:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HehZn-0005Ha-Fn
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 03:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbXDTBGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 21:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbXDTBGG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 21:06:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:2077 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbXDTBGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 21:06:03 -0400
Received: by wx-out-0506.google.com with SMTP id h31so808539wxd
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 18:06:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=hMfbvrw45ylX1tqGXc/n23PDQDlzqYGHHxhkYzzWK0ZLZG96zQbmCQEunL7xbJ0QwrWQpxqC0tQl+Wq5thoZxhPP0QuZHz/664xAUJkqBHSYsNTMamZTSHt78uoY0PrWhORT2wqNusuZoDH/SD+aH/Zp9X96aHMwKNP46J/p5ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nQcpcTjDWMjGqOAyTy5dRrE3VUJwJ1FUNArFK7F7tkstdrhRLbgXhmRbwLuqe3HQ0nAaZBKFsdiEBLV6UxLUIjl+KetDbDLvt7J34ydFd68aizt0yDUvCWkhMqkVEmMYFrcMPaj6jyZTdal13bX/Ggc+whuc9+lq2FOO4TXuZAE=
Received: by 10.70.16.6 with SMTP id 6mr4461997wxp.1177031163147;
        Thu, 19 Apr 2007 18:06:03 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id 71sm2810863wry.2007.04.19.18.06.02;
        Thu, 19 Apr 2007 18:06:02 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45051>

This fixes a problem my repository mirroring script has been having since
the git-fetch--tool was added to master in the middle of March. However,
it is not a proper fix since it causes actual errors from snprintf() to be
ignored. A proper fix is complicated by the lack of a consistent indicator
that the buffer is too small across snprintf() implementations.


 builtin-fetch--tool.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e9d6764..173dd4f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -44,7 +44,7 @@ static int update_ref(const char *action,
 		rla = "(reflog update)";
 	len = snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 	if (sizeof(msg) <= len)
-		die("insanely long action");
+		msg[sizeof(msg)-1] = '\0';
 	lock = lock_any_ref_for_update(refname, oldval);
 	if (!lock)
 		return 1;

From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] gitk - work around stderr redirection on Cygwin
Date: Sat, 14 Jun 2008 12:57:48 -0400
Message-ID: <1213462668-424-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Jun 14 18:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Z61-0003bf-8S
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbYFNQ55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 12:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbYFNQ55
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 12:57:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:52426 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbYFNQ54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 12:57:56 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1599334wxd.4
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gFuEFsCyANgXmrG/QAf+8fETH93499BrnhRcR7fZ/Ro=;
        b=L7D1vzXnsKRChAhGmZkKWINA6XLVjDiXTTPCxX+Bq1sXVqCjz3H4+SmBDBcVq0Y6Ol
         dd0neInpkyfWwtzRmdpaLohjQ5kFFYVWRCz5/P5w7bbmyRMK4Nw0ZZFvzvXF4qI1fnME
         sCqCu2gdXPkMwa8XaC/iieW4zQVIBMXbX7r8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a7pLY2DQc1Ist73LPPjKmEfWTI7ZFeMIcmUAoAsg6wZpfxHb39Nt/VNvekW9lUlkWc
         d+zuDfw5SaGmKcKVr7S31bgAVL6lp527WOPjoHnKGQ1W7cuhgQEguhOkdql4Z+nw+/aE
         2Hu/hWVAWiwyksxknbWQe8kQNMjjizqgwGk/A=
Received: by 10.70.16.8 with SMTP id 8mr4813890wxp.65.1213462674644;
        Sat, 14 Jun 2008 09:57:54 -0700 (PDT)
Received: from localhost.localdomain ( [71.191.242.223])
        by mx.google.com with ESMTPS id i19sm14519607wxd.7.2008.06.14.09.57.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 09:57:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc2.67.g19fe3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85023>

Cygwin is *still* shipping with antiquated Tcl 8.4.1, and will continue
to do so for the indefinite future. This version does not understand
the "2>@1" redirection syntax, so such redirection of stderr must be
done using sh.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index fddcb45..386a385 100755
--- a/gitk
+++ b/gitk
@@ -7625,7 +7625,7 @@ proc resethead {} {
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
-	    [list | git reset --$resettype $rowmenuid 2>@1] r]} err]} {
+	    [list | sh -c "git reset --$resettype $rowmenuid 2>&1"] r]} err]} {
 	error_popup $err
     } else {
 	dohidelocalchanges
@@ -7691,7 +7691,7 @@ proc cobranch {} {
     update
     dohidelocalchanges
     if {[catch {
-	set fd [open [list | git checkout $headmenuhead 2>@1] r]
+	set fd [open [list | sh -c "git checkout $headmenuhead 2>&1"] r]
     } err]} {
 	notbusy checkout
 	error_popup $err
-- 
1.5.6.rc2.67.g19fe3

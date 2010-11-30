From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC] git-gui: disable (un)staging for files with typechange flags
Date: Tue, 30 Nov 2010 23:21:31 +0100
Message-ID: <50fc511f363e8b13b9b1a27db71136d262c95f0d.1291155371.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 30 23:22:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNYaK-0004su-0V
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 23:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab0K3WVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 17:21:41 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39284 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab0K3WVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 17:21:40 -0500
Received: by ewy5 with SMTP id 5so3167049ewy.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jJBdIdWhuMooBP+PsApO8lPaYhZpclZ8V5lTStV84D0=;
        b=vIc2EztpeVF+48Fk2MIYfVNA7JB9A2arYe38hho8kIdQqrSGec76agk1eWrqCawN5I
         bksICMU3YCb3jje7PbEcn53xUzz54VPcLkok3a/aqeJVWGGhVbPEm3b1fB4+Pue15bWy
         PlNfzp5vgiaqk0cvYAlv+U0BEFci4s+vwnQpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=J62BHdR0sS7CGabqPNQbiP0dRw8i69TX13rVOtN6822oIqTpI+s1/qTTQDitOTAS+v
         RnwWnhAlWpNdqvzmU3s24nOizVNfnpL9S/Ojhjr/+xx7RbrryXnAUtSxGEvaEIsYCEDu
         gtEfufHsqKfOxE5CPfc5jstRUSb8eLbr1Y3VQ=
Received: by 10.213.104.138 with SMTP id p10mr3453490ebo.63.1291155699027;
        Tue, 30 Nov 2010 14:21:39 -0800 (PST)
Received: from localhost ([188.46.250.180])
        by mx.google.com with ESMTPS id v51sm6805458eeh.10.2010.11.30.14.21.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 14:21:38 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162491>

This covers also the case for newly added files in the index. Like this:

    echo bar >foo
    git add foo
    rm foo
    ln -s bar foo

This will result in an state of AT. And for cases where the type change is
staged, and the new type was modified after the staging. Like this (cont.):

    git add foo
    git commit -mfoo
    rm foo
    echo bar >foo
    git add foo
    echo baz >foo

Will result in an state of TM for foo.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 38362fa..1bebcf1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1993,7 +1993,9 @@ foreach i {
 		{MD {mc "Staged for commit, missing"}}
 
 		{_T {mc "File type changed, not staged"}}
+		{AT {mc "File type changed, old type staged for commit"}}
 		{T_ {mc "File type changed, staged"}}
+		{TM {mc "Staged file type change, modification not staged"}}
 
 		{_O {mc "Untracked, not staged"}}
 		{A_ {mc "Staged for commit"}}
@@ -3533,8 +3535,8 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 			|| $current_diff_path eq {}
 			|| {__} eq $state
 			|| {_O} eq $state
-			|| {_T} eq $state
-			|| {T_} eq $state
+			|| [string match {?T} $state]
+			|| [string match {T?} $state]
 			|| [has_textconv $current_diff_path]} {
 			set s disabled
 		} else {
-- 
1.7.3.2.1200.ge4bf6

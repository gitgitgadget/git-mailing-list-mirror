From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 5/8] gitk: put temporary directory inside .git
Date: Mon,  4 Apr 2011 22:14:16 -0400
Message-ID: <1301969659-19703-6-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpX-0002JM-S1
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab1DECRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:17:02 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51652 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab1DECQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:56 -0400
Received: by qyk7 with SMTP id 7so1438075qyk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=HxMwLy4c8UwseCN03rnCc88DRnYlau34pWteRS6ifk8=;
        b=wCXHSMopt7D2OhmpGj4qFz+3+twE5+OWRjMzJneYeS//Om1AsCiZ3cE/vCmpbcskJr
         ll3+RXAnTavNdgdciwRvYXqlfVMcQ/p6bkdNZCH45VNJ1O9Ku+NNsrlKUZeaTNOJLVxx
         SxdEC/awtfRa8pCBxXMWoQ+sjFsmcBmoT2f3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lSnK0LimV2q5K+VsIdK1d1cmkbJeOX7GI3gBE9qE+biWUAgbk3PU9w4FEMn2QRWxvJ
         zB3CORz/3SSfV6wJeXr/oaoxVWc2upgIL8ZVu9Kjc12wnokCQQFOfwlvjjmdNOdceXfS
         Fx1o3/lZJsyDzZ6luirYMUJIWufkBBwB7Y+uk=
Received: by 10.224.27.10 with SMTP id g10mr6207452qac.204.1301969815552;
        Mon, 04 Apr 2011 19:16:55 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170858>

When running "External diff" from gitk, the "from" and "to" files will
first be copied into a directory that is currently
".git/../.gitk-tmp.$pid". When gitk is closed, the directory is
deleted. When the work tree is not at ".git/.." (which is supported
since the previous commit), that directory may not even be git-related
and it does not seem unlikely that permissions may not allow the
temporary directory to be created there. Move the directory inside
.git instead.

This patch introduces a regression in the case that the .git directory
is readonly, but .git/.. is writeable.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 gitk-git/gitk |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 58b98df..b925f3e 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3332,8 +3332,7 @@ proc gitknewtmpdir {} {
     global diffnum gitktmpdir gitdir
 
     if {![info exists gitktmpdir]} {
-	set gitktmpdir [file join [file dirname $gitdir] \
-			    [format ".gitk-tmp.%s" [pid]]]
+	set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
1.7.4.79.gcbe20

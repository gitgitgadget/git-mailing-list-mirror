From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Wed, 25 Jan 2012 03:37:02 +0200
Message-ID: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <matthieu.moy@imag.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 02:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rprnd-0003hQ-1S
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 02:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab2AYBhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 20:37:12 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52039 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751457Ab2AYBhI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 20:37:08 -0500
Received: by lagu2 with SMTP id u2so423520lag.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 17:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5rb2OkmW7eIgcIYbQPcW+Pyv1HvXIjDKutL5r2+moic=;
        b=UqeTan2B0ffz4XNlLP6twgpSmTFnn8XJFn9J+h+lgl5qbrwFrH8NwCQVr0XPrFIUkQ
         +C2xYw0ypJ1+l+MPci29dUHUQ7DRcveupwdpXa7T2XZ6UbOFC5jVC4eZjaMu1kEdIe5N
         y+91FbFaOYqaaVJXfawxTaZGm0r4CwJf8hfRE=
Received: by 10.112.27.162 with SMTP id u2mr3852787lbg.70.1327455426772;
        Tue, 24 Jan 2012 17:37:06 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id nu4sm14795985lab.4.2012.01.24.17.37.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 17:37:05 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.14.g248db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189089>

zsh adds a backslash (foo\ ) for each item in the COMPREPLY array if IFS
doesn't contain spaces. This issue has been reported[1], but there is no
solution yet.

This wasn't a problem due to another bug[2], which was fixed in zsh
version 4.3.12. After this change, 'git checkout ma<tab>' would resolve
to 'git checkout master\ '.

Aditionally, the introduction of __gitcomp_nl in commit a31e626
(completion: optimize refs completion) in git also made the problem
apparent, as Matthieu Moy reported.

The simplest and most generic solution is to hide all the changes we do
to IFS, so that "foo \nbar " is recognized by zsh as "foo bar". This
works on versions of git before and after the introduction of
__gitcomp_nl (a31e626), and versions of zsh before and after 4.3.12.

Once zsh is fixed, we should conditionally disable this workaround to
have the same benefits as bash users.

[1] http://www.zsh.org/mla/workers/2012/msg00053.html
[2] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=commitdiff;h=2e25dfb8fd38dbef0a306282ffab1d343ce3ad8d

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b0062ba..c83c734 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2631,6 +2631,10 @@ _git ()
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
 		typeset -h words
+
+		# another workaround for zsh because it would quote spaces in
+		# the COMPREPLY array if IFS doesn't contain spaces
+		typeset -h IFS
 	fi
 
 	local cur words cword prev
@@ -2687,6 +2691,10 @@ _gitk ()
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
 		typeset -h words
+
+		# another workaround for zsh because it would quote spaces in
+		# the COMPREPLY array if IFS doesn't contain spaces
+		typeset -h IFS
 	fi
 
 	local cur words cword prev
-- 
1.7.8.rc1.14.g248db

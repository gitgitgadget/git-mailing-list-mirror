From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] completion: fix completion of certain aliases
Date: Wed,  9 Apr 2014 13:50:04 -0500
Message-ID: <1397069404-7451-6-git-send-email-felipe.contreras@gmail.com>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxju-0006cA-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934190AbaDITAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:00:38 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34158 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDITAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:00:35 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so3219773oag.23
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dGqUgrQhTgBPOotLw0PCd6TsI1gL3haCDI4tZElnRxY=;
        b=xvs8vY1CxWtmL9C5vSb1/tfqHe4OWWHCImmFFNDnW+4xxVj4vPyZU07SlnEnHtiVlw
         WPbuVEkcx+h4g3pjh2ZdsUlsFFgTydvG7eYAqJXz4ZbJP49v4zfPVhp1Xf3rHREFbP4+
         ln/ske91rTklYQ29O60pMAS1tp9K7k1tJsCkj/TMcPF4wRE5DM1ZwRvzriGfuHrpdZXQ
         XX/YyP6GzOjOp9uF6ZKabD5ECeO8Ma6V4vsqhssalHmAi5k0AwHmdLVgGxr9GqpNwqP7
         LiXPg/gDFsnHibF/EewEuXIfLcMf23MZbCoXQpXxxtiCju4u+DmutC35oZ2a1f0nWhPt
         aeDw==
X-Received: by 10.182.225.137 with SMTP id rk9mr3453484obc.51.1397070034845;
        Wed, 09 Apr 2014 12:00:34 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cg5sm2872521obc.9.2014.04.09.12.00.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 12:00:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245993>

Some commands need the first word to determine the actual action that is
being executed, however, the command is wrong when we use an alias, for
example 'alias.p=push', if we try to complete 'git p origin ', the
result would be wrong because __git_complete_remote_or_refspec() doesn't
know where it come from.

So let's override words[1], so the alias 'p' is override by the actual
command, 'push'.

Reported-by: Aymeric Beaumet <aymeric.beaumet@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9525343..893ae5d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2547,6 +2547,7 @@ __git_main ()
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
+		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
 	fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6b77968..9f6f0fa 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -104,6 +104,7 @@ __git_zsh_bash_func ()
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
+		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
 	fi
-- 
1.9.1+fc1

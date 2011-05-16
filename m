From: Sergei Gavrikov <sergei.gavrikov@gmail.com>
Subject: [RFC/PATCH] completion: __git_ps1() returns exit status now
Date: Mon, 16 May 2011 16:23:29 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1105161615430.3397@sg-pc.belvok.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 16 15:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLxlt-0007Ph-UW
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 15:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab1EPNXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 09:23:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62025 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab1EPNXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 09:23:36 -0400
Received: by fxm17 with SMTP id 17so3045572fxm.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:message-id
         :user-agent:mime-version:content-type;
        bh=J8CTrVGNOHM5h2NlmUZtSa5zX6OxasQvB1JWsApFyJE=;
        b=FahkPWmdgRrRyRc9uT0r0y/Q0pBtG3gK0FxrCuZ3SSp4X3UhHYfgjaL59u2SQ6KBPL
         8QG+DhWXsAv/V7V+V1uC6E16DZxsURUv6mOJNDqI4QxRBwnFATKTkbvgyXCEMdGy2fKC
         B7Iw+gzErZ2XgDNHafmJ6nWpfycZjXaS929xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        b=qEzaXLdKQZVYGVcnODGOUl/wbDpJrbp7cAwp0s73qGOcKuKXYOvgD+sRn5uyTGgaRE
         RXxna++x5PSA5kq0DcNCC3l/PbOlvDjRBk0lT1cMSbQaqRT7t/Slt4j2u8bCyB664KgN
         Qo0aAKZMXSt8ghsAlfGoQsJLz2NAw0LSXF3q8=
Received: by 10.223.98.4 with SMTP id o4mr3461775fan.120.1305552215844;
        Mon, 16 May 2011 06:23:35 -0700 (PDT)
Received: from sg-pc.belvok.com ([86.57.137.251])
        by mx.google.com with ESMTPS id n7sm1850430fam.11.2011.05.16.06.23.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 May 2011 06:23:34 -0700 (PDT)
X-X-Sender: sg@sg-pc.belvok.com
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173734>

SYNOPSIS

        $(__git_ps1 || __other_vcs_ps1)

It would be great if __git_ps1() could return exit status on it's
finish, otherwise they have to check git_ps1 text output or recall
__gitdir() to suppress alternative VCS prompt(s).

Patch attached, although I would prefer to check it at once, e.g.,

        if [ -z "$g" ]; then return 1; fi
        ...
        return 0

however, I was in doubt about more verbose delta in such a case.

If I request the bad things or miss something, please, forget it.

Signed-off-by: Sergei Gavrikov <sergei.gavrikov@gmail.com>
---
 contrib/completion/git-completion.bash |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b81f444..8b660ca 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -222,7 +222,8 @@ __git_ps1_show_upstream ()
 
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-# returns text to add to bash PS1 prompt (includes branch name)
+# prints text to add to bash PS1 prompt (includes branch name),
+# returns 0 (exit status) if gitdir was processed, otherwise 1.
 __git_ps1 ()
 {
 	local g="$(__gitdir)"
@@ -313,7 +314,11 @@ __git_ps1 ()
 
 		local f="$w$i$s$u"
 		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+
+		return 0
 	fi
+
+	return 1
 }
 
 # __gitcomp_1 requires 2 arguments
-- 
1.7.0.4

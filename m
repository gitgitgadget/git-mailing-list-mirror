From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] completion: fix alias listings with newlines
Date: Wed,  7 Oct 2009 01:48:49 -0700
Message-ID: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 10:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvSKG-0004jY-Ry
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 10:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbZJGIrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 04:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbZJGIrW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 04:47:22 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:43829 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbZJGIrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 04:47:20 -0400
Received: by qyk3 with SMTP id 3so4151212qyk.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=8e5qVLaGsEj+yFwpGgkjCQZtKO7b8tglSyMhHsNF6z8=;
        b=xds1mGCpyLy5/z2hiZQdpIaP8GM+ZcvZpCr96sNRiRSUVQOhexURyyjlKxdTQ1wVa1
         ds6s9ebUwr8QsA7roRJk+k3TMqzBOFpykaOGgV+rmi9efm9stBuZfiSzGaoMTx1YU18w
         6I8Sk7B6hEbgOf0gIGFyHKIKLj23/0BCrwi+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G7IBMpOAmOD0BinL9Y4nT3Oo88kV9HUq/+B0C09GsYTZvfUoRX8wr4Op6XyB17LifQ
         icCT4+U5TX8DEk6DFE62iSGgyHGmDzKJqBJro6eI5nm6YLrnn773oxQtB9DLrXaLbdcD
         X4LjPklBPBc0OpP1DnQ0kcvkfAnU6YL/jtX38=
Received: by 10.224.54.206 with SMTP id r14mr2268618qag.204.1254905203203;
        Wed, 07 Oct 2009 01:46:43 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 26sm1011791qwa.50.2009.10.07.01.46.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 01:46:42 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 07 Oct 2009 01:48:51 -0700
X-Mailer: git-send-email 1.6.5.rc2.17.gdbc1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129641>

Since commit 518ef8f (completion: Replace config --list with
--get-regexp, 2009-09-11) an alias config value containing a newline
would break the completion of aliases. Instead of setting the IFS to the
newline, use git-config's null termination to separate aliases with the
null character.

An example .gitconfig causing the breakage.

[alias]
	whowhat = "log -1 --pretty='format:%an <%ae>\n%s'"
	wont-complete = ...

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is the best I can come up with. I'm not sure about using the
d option of read though.

 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c2a0d4..332be99 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -600,10 +600,10 @@ __git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
 
 __git_aliases ()
 {
-	local i IFS=$'\n'
-	for i in $(git --git-dir="$(__gitdir)" config --get-regexp "alias\..*" 2>/dev/null); do
-		i="${i#alias.}"
-		echo "${i/ */}"
+	local i
+	git --git-dir="$(__gitdir)" config -z --get-regexp "alias\..*" 2>/dev/null |
+	while IFS= read -rd '' i; do
+		echo ${i#alias.} | cut -d' ' -f1
 	done
 }
 
-- 
1.6.5.rc2.17.gdbc1b

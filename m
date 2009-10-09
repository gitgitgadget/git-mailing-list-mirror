From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] completion: fix alias listings with newlines
Date: Thu,  8 Oct 2009 23:21:44 -0700
Message-ID: <1255069304-8953-2-git-send-email-bebarino@gmail.com>
References: <1255069304-8953-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:23:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw8sg-0002i1-DF
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282AbZJIGUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbZJIGUn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:20:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:41885 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZJIGUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:20:43 -0400
Received: by qw-out-2122.google.com with SMTP id 3so2488341qwe.37
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=R8h1hLLigERTy9eiP7J+5IPZzC4rtwyQSeZTe514cS8=;
        b=xjEmwqubET2pvAzNmOxirIabRBI3eYk3FT0pxqj5KDvN0jWZ7skZzSZAd1H3n2i799
         jf35GYIKrBY2xacvX0Rnvii3//TKEaBSzWge7xllfkOC69QAP0lBA5c6bxaaDkNiAOuh
         6iDWuLAi4LC3ZybeboIOzkvnvO4ghixpbaiL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ba1GBMz97HoKOMOrNiv8imHi7FI6ry2Po+imXOTpTfJpMm74r0PM/kRL1AMOjoyzKB
         tmyyqQewSAYtsgwAMe8nv1udUtnVNgcR5KBveQK6ibWM/Z6f7NwObcWsx3YeL6jGQVH3
         P4IFXz8mu/cf6w1hNLVEQGIfLAcX8ChRS2TOg=
Received: by 10.224.111.12 with SMTP id q12mr2111913qap.330.1255069176138;
        Thu, 08 Oct 2009 23:19:36 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 6sm523099qwk.6.2009.10.08.23.19.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 23:19:35 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 08 Oct 2009 23:21:48 -0700
X-Mailer: git-send-email 1.6.5.rc3
In-Reply-To: <1255069304-8953-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129737>

Aliases with newlines have been a problem since commit 56fc25f (Bash
completion support for remotes in .git/config., 2006-11-05). The chance
of the problem occurring has been slim at best, until commit 518ef8f
(completion: Replace config --list with --get-regexp, 2009-09-11)
removed the case statement introduced by commit 56fc25f. Before removing
the case statement, most aliases with newlines would work unless they
were specially crafted as follows

[alias]
	foo = "log -1 --pretty='format:%s\nalias.error=broken'"

After removing the case statement, a more benign alias like

[alias]
	whowhat = "log -1 --pretty='format:%an <%ae>\n%s'"
	wont-complete = ...

would cause the completion to break badly.

For now, revert the removal of the case statement until someone comes up
with a better way to get keys from git-config.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is an alternate fix to my previous 1/3 patch.

Hannes has convinced me to go this route. I don't really see a problem, it
basically reverts to broken behavior that nobody's complained about in 3
years. At least it's less broken?

 contrib/completion/git-completion.bash |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 652a47c..e482c8d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -602,8 +602,12 @@ __git_aliases ()
 {
 	local i IFS=$'\n'
 	for i in $(git --git-dir="$(__gitdir)" config --get-regexp "alias\..*" 2>/dev/null); do
-		i="${i#alias.}"
-		echo "${i/ */}"
+		case "$i" in
+		alias.*)
+			i="${i#alias.}"
+			echo "${i/ */}"
+			;;
+		esac
 	done
 }
 
-- 
1.6.5.rc3

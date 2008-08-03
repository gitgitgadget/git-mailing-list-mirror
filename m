From: Russell Steicke <russellsteicke@gmail.com>
Subject: [PATCH] [TopGit] Check for pre-commit hook existence.
Date: Sun, 3 Aug 2008 22:14:01 +0800
Message-ID: <20080803141030.GC11179@maggie.localnet>
References: <20080803031424.GV32184@machine.or.cz>
Reply-To: Russell Steicke <russellsteicke@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeMj-0002An-07
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbYHCOOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbYHCOOK
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:14:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:46551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630AbYHCOOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:14:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1747348rvb.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:x-boo:x-message-flag:x-disclaimer
         :x-system:x-uptime:user-agent;
        bh=a2GCDJLW1KTpNALM8knBXKgsUfn3X245X9xcvhKLpDs=;
        b=KkF1J9kZewWJ0mDeKLmk9dWUd0TYL7FAmtnHjXORda4NwHhm3YADzJUk/qGBqh8STZ
         4L7Oyn82zyDGj3UC7GJomK6JEvs3vW9Ixqltj8cX5vrE8b+AiO/pic8Ji6w9+F84tWaL
         eRu2NLyNE9BmffUWXvOgblLHIHWfHDXrZ8T54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:x-boo:x-message-flag
         :x-disclaimer:x-system:x-uptime:user-agent;
        b=Tkl080DGhAvUOTm1eSsntSwpOOXpdD064LpLaBuWYJcNo6AH7A98A0QuhOztwEzeLt
         HdP6L2XIOCFlm/KrzrMP4eoXrKPMCfOK+HfwLLJX7FtvwS8KxrNiSHkOuYbcFl4umOIG
         bIOOxn0XSAiHYGLcjigHd7U930DByuQom/zQY=
Received: by 10.141.97.5 with SMTP id z5mr7019018rvl.197.1217772848136;
        Sun, 03 Aug 2008 07:14:08 -0700 (PDT)
Received: from localhost ( [203.33.247.40])
        by mx.google.com with ESMTPS id g22sm5145460rvb.7.2008.08.03.07.14.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 07:14:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080803031424.GV32184@machine.or.cz>
X-Boo: Boo!
X-message-flag: I see that you run Outlook...
X-Disclaimer: This message represents the official view of the voices in my head.
X-System: Linux maggie 2.6.18-6-powerpc64 
X-Uptime: 08:58:05 up 4 days, 15:17, 16 users,  load average: 4.74, 4.35, 3.89
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91240>

Running tg in a repo without an active pre-commit hook fails
saying

  grep: .git/hooks/pre-commit: No such file or directory
  cat: .git/hooks/pre-commit: No such file or directory

Even "tg help" does this!  So add extra checks for existence
of the pre-commit hook.

---
 tg.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tg.sh b/tg.sh
index 56c5709..15005db 100644
--- a/tg.sh
+++ b/tg.sh
@@ -21,9 +21,11 @@ die()
 setup_hook()
 {
 	hook_call="\"\$(tg --hooks-path)\"/$1 \"\$@\""
-	if fgrep -q "$hook_call" "$git_dir/hooks/$1"; then
-		# Another job well done!
-		return
+	if [ -x "$git_dir/hooks/$1" ]; then
+		if fgrep -q "$hook_call" "$git_dir/hooks/$1"; then
+			# Another job well done!
+			return
+		fi
 	fi
 	# Prepare incanation
 	if [ -x "$git_dir/hooks/$1" ]; then
@@ -35,7 +37,7 @@ setup_hook()
 	{
 		echo "#!/bin/sh"
 		echo "$hook_call"
-		cat "$git_dir/hooks/$1"
+		[ -x "$git_dir/hooks/$1" ] && cat "$git_dir/hooks/$1"
 	} >"$git_dir/hooks/$1+"
 	chmod a+x "$git_dir/hooks/$1+"
 	mv "$git_dir/hooks/$1+" "$git_dir/hooks/$1"
-- 
1.6.0.rc1


-- 
Russell Steicke

-- Fortune says:
I got the bill for my surgery.  Now I know what those doctors were
wearing masks for.
		-- James Boren

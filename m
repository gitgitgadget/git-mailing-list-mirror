From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH] Completion script must sort before using uniq
Date: Thu, 22 Nov 2012 15:02:20 -0500
Message-ID: <CAFj1UpEU+JVpN_BSUwCA91e8xu5JMtqcCEH5S6s80Kzx3qbXfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbcyw-0006Fx-1I
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 21:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192Ab2KVUCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 15:02:24 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58299 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab2KVUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 15:02:21 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2460559iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9L9jPW+SmoBDW6JvmCFiijccjbzcxYqAGE6PDVoxiAA=;
        b=mbSn5aUgDBJz6JeG/mVie904mMCDV47mdbEWHzWdDUFCWgsjikPaindjfAQvnHZ+uR
         ERAs+jEnLY0iu+LHCp4d0quaufJNnJxAn7Q0jOQBFguzCM1yYotAy+1b3zxoGGRv1ENJ
         jQC9YaoOB//SJK2akCFgnhcTsl9Ka5rMirXTPLFntTQAxQmJcAV5tVJ7zCCFJaNwgo/z
         d+o2RIZLF9eDCLleE+ygJGk3lK8vH2Iqr2LpSzW2HdwA0YSnPf04IaXoEC7k3itfMeat
         MbaxkGFbO+YxBHPZQn0Air5vXE+A0G9/ymu62mTONV6Wxj8otTYcVbpZZ9WG/88LJf8Y
         cNsw==
Received: by 10.50.182.230 with SMTP id eh6mr1535853igc.39.1353614540961; Thu,
 22 Nov 2012 12:02:20 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Thu, 22 Nov 2012 12:02:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210206>

The uniq program only works with sorted input.  The man page states
"uniq prints the unique lines in a sorted file".

When __git_refs use the guess heuristic employed by checkout for
tracking branches it wants to consider remote branches but only if
the branch name is unique.  To do that, it calls 'uniq -u'.  However
the input given to 'uniq -u' is not sorted.

For example if all available branches are:
  master
  remotes/GitHub/maint
  remotes/GitHub/master
  remotes/origin/maint
  remotes/origin/master

When performing completion on 'git checkout ma' the choices given are
  maint
  master
but when performing completion on 'git checkout mai', no choices
appear, which is obviously contradictory.

The reason is that, when dealing with 'git checkout ma',
"__git_refs '' 1" will find the following list:
  master
  maint
  master
  maint
  master
which, when passed to 'uniq -u' will remain the same.
But when dealing with 'git checkout mai', the list will be:
  maint
  maint
which happens to be sorted and will be emptied by 'uniq -u'.

The solution is to first call 'sort' and then 'uniq -u'.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

Sorry if you get this twice, my first try never showed up on the list.

I ran into this by fluke when testing the tcsh completion.

Thanks for considering the fix.

Marc

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index bc0657a..85ae419 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -321,7 +321,7 @@ __git_refs ()
                                if [[ "$ref" == "$cur"* ]]; then
                                        echo "$ref"
                                fi
-                       done | uniq -u
+                       done | sort | uniq -u
                fi
                return
        fi
--
1.8.0.1.g9fe2839

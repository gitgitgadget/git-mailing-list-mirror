From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH v2] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 06:17:07 -0500
Message-ID: <CAFj1UpHAqrNvpF+HAxJUPiWAiHbCn=7r1GDw3iMKy8FDW_-D_A@mail.gmail.com>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
	<CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 12:17:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbrG7-0007Ms-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 12:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814Ab2KWLRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 06:17:08 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44488 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab2KWLRH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 06:17:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so3187085iea.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YK0oomY8zShkTFnnXCTwsN54Rckn434q1Zov9LlF5SQ=;
        b=KgyA2ResAGU2jfdmlxN0tH6WV+Ho/oz4xjPIlqKsCUDwFtySgGYtTGHpmxJW3Nx02V
         RiyxNiTmclE2WDBGeWz73SCWH7TVpP3r5e8W1aeHvUYuqci9XZNB+49vOtcUCZhySLR5
         JO/hS/dZHjx65ICCdafVKJn11uFlWLojp5KSGHiFhI7JCYjNCAuns6HOn/AlTiPLyR1Z
         j27dqLY6J0Jy7h0O9AzwZ6mqb0PnYtrGEsYHrjFfX0KDyZnGts313Zt5HF0Nzon+awA6
         kyzdCVxFp3WNCVH2LaJqjf5yV3si7EKNvBKjSllf0t/79+BOEWyQZYiJiUh7PwWjIvSr
         BcGA==
Received: by 10.50.153.137 with SMTP id vg9mr5917144igb.40.1353669427221; Fri,
 23 Nov 2012 03:17:07 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Fri, 23 Nov 2012 03:17:07 -0800 (PST)
In-Reply-To: <CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210251>

The user can be presented with invalid completion results
when trying to complete a 'git checkout' command.  This can happen
when using a branch name prefix that matches multiple remote branches.
For example if available branches are:
  master
  remotes/GitHub/maint
  remotes/GitHub/master
  remotes/origin/maint
  remotes/origin/master

When performing completion on 'git checkout ma' the user will be
given the choices:
  maint
  master
However, 'git checkout maint' will fail in this case, although
completion previously said 'maint' was valid.
Furthermore, when performing completion on 'git checkout mai',
no choices will be suggested.  So, the user is first told that the
branch name 'maint' is valid, but when trying to complete 'mai'
into 'maint', that completion is no longer valid.

The completion results should never propose 'maint' as a valid
branch name, since 'git checkout' will refuse it.

The reason for this bug is that the uniq program only
works with sorted input.  The man page states
"uniq prints the unique lines in a sorted file".

When __git_refs uses the guess heuristic employed by checkout for
tracking branches it wants to consider remote branches but only if
the branch name is unique.  To do that, it calls 'uniq -u'.  However
the input given to 'uniq -u' is not sorted.

Therefore, in the above example, when dealing with 'git checkout ma',
"__git_refs '' 1" will find the following list:
  master
  maint
  master
  maint
  master
which, when passed to 'uniq -u' will remain the same.  Therefore
'maint' will be wrongly suggested as a valid option.
When dealing with 'git checkout mai', the list will be:
  maint
  maint
which happens to be sorted and will be emptied by 'uniq -u',
properly ignoring 'maint'.

A solution for preventing the completion script from suggesting
such invalid branch names is to first call 'sort' and then 'uniq -u'.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

>> The solution is to first call 'sort' and then 'uniq -u'.
>
> The solution to what? This seems to be the right thing indeed, but you
> don't explain what is the actual problem that is being solved. What
> does the user experience? What would (s)he experience after the patch?

I have re-worked the commit message to be more clear about the user
impacts.

Thanks for the feedback.

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

From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH v3] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 09:02:22 -0500
Message-ID: <CAFj1UpH8h6c7xHuRG6F+pLy5YMvsJ0QdXsotCpLKnht0PsdiNw@mail.gmail.com>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
	<CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
	<CAFj1UpHAqrNvpF+HAxJUPiWAiHbCn=7r1GDw3iMKy8FDW_-D_A@mail.gmail.com>
	<CAMP44s2bMub6T1YcUfsYWPQFU1bY4iU1WfSf+jFa7jSXAKTNaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 15:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbtqJ-0004we-6U
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 15:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab2KWOCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 09:02:31 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39318 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab2KWOCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 09:02:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so3382305iea.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Is992LhN7HR1XFjP18SItiBpQrGhl4E7aqD5gV9tS4k=;
        b=Ry/GHVAsexXDerXSSVmDGbkVZvmhKkUe4VZpkicj1Dx8zvnulyKsfzFo0W97PgRImN
         7A5tZGTfzy8NHhoFojrLi0ssOJZuIRtVpkUufZzELSmRtahh2wFr1qgM8R26tzwOVRar
         rvhXKbRy/cqL3y8hxGJCVwPvb48061HoWMTRycRUlUl5kOlk07aUVSuO96SJRsDDpzbD
         KL3fVAVT/bFNLJ38M7VGa0+xoqesX5FIX+45M2oShL7mOmbKcYOs8Z5QrHC4TuHpSHlG
         qoPFTcAXxPNcKRnufLchTfBZ7CygkNt1az+VnYHzbloja5GCeTq7BF2nY75B6PfO5iA6
         4nQw==
Received: by 10.50.153.137 with SMTP id vg9mr6326282igb.40.1353679343149; Fri,
 23 Nov 2012 06:02:23 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Fri, 23 Nov 2012 06:02:22 -0800 (PST)
In-Reply-To: <CAMP44s2bMub6T1YcUfsYWPQFU1bY4iU1WfSf+jFa7jSXAKTNaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210257>

The user can be presented with invalid completion results
when trying to complete a 'git checkout' command.  This can happen
when using a branch name prefix that matches multiple remote branches.

For example, if available branches are:
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
completion previously said 'maint' was valid.  Furthermore, when
performing completion on 'git checkout mai', no choices will be
suggested.  So, the user is first told that the branch name
'maint' is valid, but when trying to complete 'mai' into 'maint',
that completion is no longer valid.

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

> Mostly cosmetic suggestions, but it looks OK to me.

Thanks for the suggestions, I updated the commit message.

> With this explanation the patch looks good to me.

Thanks for the quick review.

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

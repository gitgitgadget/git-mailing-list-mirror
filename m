From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] Use reflog in 'pull --rebase . foo'
Date: Sat, 13 Nov 2010 07:09:43 -0500
Message-ID: <AANLkTiniwpk7ao=M4=5vuahczk6FscQYJE1rZx=wuBk_@mail.gmail.com>
References: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<m2pqu98urp.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, santi@agolina.net
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 13 13:10:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHEvo-00018W-1F
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 13:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab0KMMJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 07:09:45 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53876 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab0KMMJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 07:09:44 -0500
Received: by qyk4 with SMTP id 4so449693qyk.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 04:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WWG5JkHOLz6wRW/BDoRaeja6yox4fIER90IokG54ik4=;
        b=xrBJpPHZwkLQ+I1cIvEex+h0zNbOcMW08KKqhjkNvC+u2ztmDmFsoS3S8cIEmp+wqL
         GhvnlfdUf4FUez6KWzoi0kaldW6/ls0AAANb/EjJ4wMLcKrHyKwQ1cVoBKi3mE4JK9Zm
         zTYEvaT9LohGDi3KR4mKL1ZtIrkXSH3XRx/FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iJ6eOH/zE/+HhDc/40Z1L7CmyKA1NFhYZiEcFmmcoDKVftQMD8ZsYmR6urOSXeKeUM
         0WH5Ha7g+Prdo1+pBRHIhGdCSRyBiIktoLGIG6uaE7RSc6o01kox3RwnZGAzt8tZ1JEs
         ZU8iicNcLLaTCvuneuFG0QqSKcKIpsU4t2DnU=
Received: by 10.224.60.136 with SMTP id p8mr1708418qah.175.1289650183990; Sat,
 13 Nov 2010 04:09:43 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Sat, 13 Nov 2010 04:09:43 -0800 (PST)
In-Reply-To: <m2pqu98urp.fsf@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161387>

I see, maybe just dropping the middle part of the patch would be better.
I think it looks like I have lost a '.*' in there as well (test cases
pass though, so I'm not sure). Anyway, better be safe than sorry. The
following seems better.

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..2e1661d 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -63,11 +63,8 @@ get_default_remote () {
 get_remote_merge_branch () {
 	case "$#" in
 	0|1)
-	    origin="$1"
-	    default=$(get_default_remote)
-	    test -z "$origin" && origin=$default
 	    curr_branch=$(git symbolic-ref -q HEAD)
-	    [ "$origin" = "$default" ] &&
+	    test -z "$1" || test "$1" = $(get_default_remote) &&
 	    echo $(git for-each-ref --format='%(upstream)' $curr_branch)
 	    ;;
 	*)
@@ -89,7 +86,13 @@ get_remote_merge_branch () {
 	    refs/heads/*) remote=${remote#refs/heads/} ;;
 	    refs/* | tags/* | remotes/* ) remote=
 	    esac
-
-	    [ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
+	    [ -n "$remote" ] && case "$repo" in
+		.)
+		    echo "refs/heads/$remote"
+		    ;;
+		*)
+		    echo "refs/remotes/$repo/$remote"
+		    ;;
+	    esac
 	esac
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0b489f5..0470a81 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -222,4 +222,11 @@ test_expect_success 'git pull --rebase does not
reapply old patches' '
 	)
 '

+test_expect_success 'git pull --rebase against local branch' '
+	git checkout -b copy2 to-rebase-orig &&
+	git pull --rebase . to-rebase &&
+	test "conflicting modification" = "$(cat file)" &&
+	test file = "$(cat file2)"
+'
+
 test_done
-- 
1.7.3.2.167.ga361b

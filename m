From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Please pull the patch series "use the $( ... ) construct for command substitution"
Date: Wed, 14 May 2014 19:14:58 +0200
Message-ID: <vpqoaz0i8od.fsf@anie.imag.fr>
References: <CA+EOSBk4YvQHTG=gRd1TF9gX0OgjLpjRidh7NAa9wmjr6bSkBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 19:15:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkclx-0002pG-P4
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 19:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387AbaENRPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 13:15:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47599 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbaENRPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 13:15:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s4EHEuYt006784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 May 2014 19:14:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4EHEwCi009593;
	Wed, 14 May 2014 19:14:58 +0200
In-Reply-To: <CA+EOSBk4YvQHTG=gRd1TF9gX0OgjLpjRidh7NAa9wmjr6bSkBQ@mail.gmail.com>
	(Elia Pinto's message of "Wed, 14 May 2014 17:23:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 May 2014 19:14:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4EHEuYt006784
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400692497.07952@xgUK/5XGJ77G7KesM05jiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248927>

Elia Pinto <gitter.spiros@gmail.com> writes:

> The following changes since commit 6308767f0bb58116cb405e1f4f77f5dfc1589920:
>
>
>   Merge branch 'fc/prompt-zsh-read-from-file' (2014-05-13 11:53:14 -0700)
>
>
> are available in the git repository at:
>
>
>   https://github.com/devzero2000/git-core.git  ep/shell-command-substitution-v4

There's a mis-replacement of multiple `..` `..` on the same line in
t9300-fast-import.sh. I've sent you a pull request with a fixup.

I'm not sure about this one:

commit e69c77e580d56d587381066f56027c8a596c237a
Author: Elia Pinto <gitter.spiros@gmail.com>
Date:   Wed May 14 03:28:11 2014 -0700

    t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) construct for command substitution
[...]
@@ -38,20 +38,20 @@ test_expect_success 'some unrelated changes to git' "
        "
 
 test_expect_success 'change file but in unrelated area' "
-       test x\"\`sed -n -e 4p < file\`\" = x4 &&
-       test x\"\`sed -n -e 7p < file\`\" = x7 &&
+       test x"$(sed -n -e 4p < file)" = x4 &&
+       test x"$(sed -n -e 7p < file)" = x7 &&
              ^
            here

We're inside " from the test_expect_success line. We used to have a
literal " (because of the backslash), we now have a closing " because
you removed the \. So, the sed command used to be protected by
double-quotes, and it is now outside them. Compare:

$ sh -c "echo \"\`date\`\""                 
Wed May 14 18:47:54 MEST 2014
$ sh -c "echo "$(date)""                    
Wed

In your case, it doesn't break because the expected output of sed
contains no space, but that seems dangerous to me.

I do not understand the use of the \ in front of the ` in the original
code.

The correct code should be

	test x\"$(sed -n -e 4p < file)\" = x4 &&

I guess.

        perl -i.bak -p -e 's/^4\$/4444/' file &&
        perl -i.bak -p -e 's/^7\$/7777/' file &&
-       test x\"\`sed -n -e 4p < file\`\" = x4444 &&
-       test x\"\`sed -n -e 7p < file\`\" = x7777 &&
+       test x"$(sed -n -e 4p < file)" = x4444 &&
+       test x"$(sed -n -e 7p < file)" = x7777 &&

Likewise.

-               test x\"\`sed -n -e 4p < file\`\" = x4444 &&
-               test x\"\`sed -n -e 7p < file\`\" = x7777 &&
-               test x\"\`sed -n -e 58p < file\`\" = x5588 &&
-               test x\"\`sed -n -e 61p < file\`\" = x6611
+               test x"$(sed -n -e 4p < file)" = x4444 &&
+               test x"$(sed -n -e 7p < file)" = x7777 &&
+               test x"$(sed -n -e 58p < file)" = x5588 &&
+               test x"$(sed -n -e 61p < file)" = x6611

Likewise.


More or less the same issue with

commit 020568b9c36c023810a3482b7b73bcadd6406a85
Author: Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon Apr 28 05:49:50 2014 -0700

    t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for command substitution
[...]
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index fb41876..cf2e25f 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -68,8 +68,8 @@ test_expect_success 'setup git mirror and merge' '
 test_debug 'gitk --all & sleep 1'
 
 test_expect_success 'verify pre-merge ancestry' "
-       test x\`git rev-parse --verify refs/heads/svn^2\` = \
-            x\`git rev-parse --verify refs/heads/merge\` &&
+       test x\$(git rev-parse --verify refs/heads/svn^2\) = \
+            x\$(git rev-parse --verify refs/heads/merge\) &&
        git cat-file commit refs/heads/svn^ | grep '^friend$'
        "

I'm not sure what's the intent of the \ in front of ` in the original
code, but changing it to $(...) changes the meaning:

$ sh -c "echo \`date\`" 
Wed May 14 18:58:19 MEST 2014
$ sh -c "echo \$(date\)"
sh: 1: Syntax error: end of file unexpected (expecting ")")

I didn't investigate closely, but I'm getting test failures without your
patch, and the script stops in the middle with it so it does break
something.

@@ -80,10 +80,10 @@ test_expect_success 'git svn dcommit merges' "
 test_debug 'gitk --all & sleep 1'
 
 test_expect_success 'verify post-merge ancestry' "
-       test x\`git rev-parse --verify refs/heads/svn\` = \
-            x\`git rev-parse --verify refs/remotes/origin/trunk \` &&
-       test x\`git rev-parse --verify refs/heads/svn^2\` = \
-            x\`git rev-parse --verify refs/heads/merge\` &&
+       test x\$(git rev-parse --verify refs/heads/svn\) = \
+            x\$(git rev-parse --verify refs/remotes/origin/trunk \) &&
+       test x\$(git rev-parse --verify refs/heads/svn^2\) = \
+            x\$(git rev-parse --verify refs/heads/merge\) &&

Likewise.


commit 7e29ac501ce24aa5af3a50f839cd3ad176481a96
Author: Elia Pinto <gitter.spiros@gmail.com>
Date:   Wed Mar 26 04:48:40 2014 -0700

    t9100-git-svn-basic.sh: use the $( ... ) construct for command substitution
    
-test_expect_success 'able to dcommit to a subdirectory' "
+test_expect_success 'able to dcommit to a subdirectory' '

There is an actual change other than sed + review and trivial fix here.
That makes the review harder. Such change should IMHO not be part of the
same series.

-       git commit -m '/bar/d should be in the log' &&
+       git commit -m "bar/d should be in the log" &&

You lost a / here.

        git svn dcommit -i bar &&
-       test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
+       test -z $(git diff refs/heads/my-bar refs/remotes/bar) &&

Did you not loos the \"...\" whitespace protection here?

-       test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
+       test -z "$(git diff refs/heads/my-bar refs/remotes/bar)" &&

That seems to be the correct way of doing what you tried right above.

commit b438455b7b97d90a1b8da4ec4e9de0063c20f63c
Author: Elia Pinto <gitter.spiros@gmail.com>
Date:   Wed Mar 26 04:48:40 2014 -0700

    t9107-git-svn-migrate.sh: use the $( ... ) construct for command substitution

[...]

@@ -75,7 +75,7 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
        for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
                git rev-parse --verify refs/remotes/origin/\$i^0 >> refs.out || exit 1;
            done &&
-       test -z \"\`sort < refs.out | uniq -d\`\" &&
+       test -z \"\$(sort < refs.out | uniq -d\)\" &&

Same problem as above, this \$( is broken.

My advice: apply my small fix for multiple `...` `...`, and eject the
other patches from the series for now, they are distracting reviewers.

That should lead to a trivially-correct series with ~80 patches. Once
this one is accepted, the 4 remaining patches can be fixed and reviewed
more carefully (Cc Eric Wong <normalperson@yhbt.net> since the patches
are about git-svn).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

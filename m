From: Derek Moore <derek.p.moore@gmail.com>
Subject: RCS Keywords in Git done right
Date: Wed, 26 Nov 2014 10:44:07 -0600
Message-ID: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 17:44:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtfhN-0003ev-M2
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 17:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaKZQoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 11:44:09 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:57486 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaKZQoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 11:44:07 -0500
Received: by mail-oi0-f44.google.com with SMTP id e131so2264628oig.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 08:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vU66LJsMDcUJqmYb7xz29xVk2kaZySy1lGoZzkDBoCo=;
        b=HHTwXqJpdmPno9yTGT+TtGEZXXBxPu74aEBxh/irmfsESK50O52NFPpoFkdudLG9Hg
         mlWE5Wy4tPksy5H/YDqS1gxG+6X91owZUVmZjifZj2O18Jxa+wXncTt+EHN26kFkYJrC
         KXJQFYLVyD9GJMjw0AEOwMdFPyqibykuFounJslqYbCmScjYs5pMLORXeRvC5nyZhYYP
         uDtcnSouX4FAfzVZ63TePVJR9Xc2JXCLOY0+wNtQ1Dwl4N6wOS2dfmwYZ78Axt5buYsB
         eGwsgK9KrSOb1iy+RXLqKGlYuyXjIN7Zz19p1V9oTYQ8KCfciDi/J+B0DmrrMY+Hx3p6
         vxGA==
X-Received: by 10.202.181.213 with SMTP id e204mr4279171oif.117.1417020247282;
 Wed, 26 Nov 2014 08:44:07 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Wed, 26 Nov 2014 08:44:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260284>

Junio, et al.,

I've completed my first pass at RCS Keywords in Git. I believe I've
come up with a solution that is accurate, performant and complete (but
I have not tested it on big repos yet, I'm doing that today...).

https://github.com/derekm/git-keywords

This work basically takes advantage of all the state-machine
transitions in git to surgically perform "git update-index $(git
archive $(git log -1 --format=%H @ -- $path) -- $path | tar vx)"
overwrites in the work tree. (It also exposes some state transitions
that are entirely absent from git, creating a few edge cases, but they
are relatively unimportant edge cases if your deployed git repos will
be managed by an automated system [humans doing development workflows
can trigger the edge cases when cancelling certain operations, all
edge cases just leave you with un-substituted files, which will become
substituted again after checkouts, commits, merges, rewrites, etc.].)

Only $Author$, $Date$ and $Revision$ can be emulated presently. $Id$
and other tags requiring filename paths or basenames are possible, but
would require changes internal to git allowing "pretty format" codes
inside a file to triangulate filenames from blob hash and commit hash
pairs.

I believe this work fundamentally proves that the theory of RCS
keywords is sound in the context of Git, and that full support in
git-core is entirely achievable in short order. In fact, other areas
in git would become improved for several reasons if git devs ingested
some of the results of this work.

There is a lot of gainsaying and kneejerk reaction to the idea of
keywords under the assumption of distributed development because of
the fallacy of thinking in terms of shared/universal linear history
instead of in terms of relative spacetime events.

Keyword substitution can be done accurately relative to the history of
the possessor of that history. Last edit timestamps and last authors
and revision IDs are important to many workflows inside and outside
development.

Of the keywords emulated, the only thing I couldn't achieve
(obviously) were monotonically increasing revision numbers, instead I
went with the file's most recent commit short hash (which is more
proper for git anyway).

To test it out...

1) clone the repo:

git clone https://github.com/derekm/git-keywords

2) cd into the repo and setup the hooks:

ln -sf ../../post-checkout-filter.pl .git/hooks/post-checkout
ln -sf ../../pre-commit-check.pl .git/hooks/pre-commit
ln -sf ../../post-commit-filter.pl .git/hooks/post-commit
ln -sf ../../post-merge-filter.pl .git/hooks/post-merge
ln -sf ../../post-rewrite-filter.pl .git/hooks/post-rewrite

3) edit .git/config and setup the filters:

[filter "keywords"]
        smudge = ./keyword-smudge.pl %f
        clean = ./keyword-clean.pl

4) inspect the lack of substitutions:

head -4 *

5) initialize the repo with first substitutions:

for i in $(git ls-tree --name-only @); do
 git update-index \
  $(git archive \
   $(git log -1 --format=%H @ -- $i) -- $i | tar vx)
done

6) inspect the presence of substitutions:

head -4 *

7) ??? (start hacking, try to break it, etc.)

8) PROFIT!

PS: I may consider rewriting the hooks in Bash, but I need to audit
what commands are available under msys-git.

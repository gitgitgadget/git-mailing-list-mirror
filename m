From: Ovidiu Gheorghioiu <ovidiug@gmail.com>
Subject: Bug report: 'git commit --dry-run' corner case: returns error
 ("nothing to commit") when all conflicts resolved to HEAD
Date: Tue, 25 Aug 2015 19:21:03 -0700
Message-ID: <CAPHyNCVJaJPzQpZGAuQY=SOXOCJyRMxYCOyjzc51oOweO8wiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 04:21:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUQLA-00030Q-VT
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 04:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbbHZCVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 22:21:25 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34076 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbbHZCVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 22:21:24 -0400
Received: by widdq5 with SMTP id dq5so32279643wid.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=4WAVpdOq644LBg+1Kkk9PRvkUA4aue7V6xqtAR4T9+U=;
        b=KZGhyT9LIYsQXGQQsjy2yCbicWj1pPQs5Z9bRP6pmnmiZs/DR6EbhZ+z/PlX4gcOXa
         Ltsb6rA1u2Ck4mFkhnMbPOQzHWYnra5g2mAD3jKhO9iuxbGcP1MJPvwL+cbpVNimbfjO
         vAv+yra0Js7U78oxaoJGnwmjJDCQnc9m9v8Z5SOiC3K+sj1jHzDnVfJV9OfisTjoP+mY
         cgQwJbn4GLBHMbsk4HBmrlHF64qgWYClGpqFpa/8xJvRqLzyXkZ2JGoNLPtnqx7U+wDY
         d9DMy2u3lbkw9xfE2p/5M+t4zjhpTR2IPCGKW2gMO/gm4zSU5txx6G8DhL02TvNJ8yfx
         +enw==
X-Received: by 10.194.5.74 with SMTP id q10mr54647397wjq.27.1440555683421;
 Tue, 25 Aug 2015 19:21:23 -0700 (PDT)
Received: by 10.27.84.71 with HTTP; Tue, 25 Aug 2015 19:21:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276591>

Hi git guys,

The bug is fairly simple: if we have a conflicted merge, AND all the
conflicts have been resolved to the version in HEAD, the commit
--dry-run error code says nothing to commit. As expected, git commit
goes through.

The commit message IS correct (-ish), just not the error code:

"""
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

nothing to commit, working directory clean
"""

The script below demonstrates the problem; version tested was 2.5.0.
Let me know if you need any more details.

Best,
Ovidiu

------
#!/bin/bash
mkdir test-repository || exit 1
cd test-repository
git init
echo "Initial contents, unimportant" > test-file
git add test-file
git commit -m "Initial commit"
echo "commit-1-state" > test-file
git commit -m "commit 1" -i test-file
git tag commit-1
git checkout -b branch-2 HEAD^1
echo "commit-2-state" > test-file
git commit -m "commit 2" -i test-file

# Creates conflicted state.
git merge --no-commit commit-1

# Resolved entirely to commit-2, aka HEAD.
echo "commit-2-state" > test-file
# If we'd set to commit-1=state, all would work as expected (changes vs HEAD).
git add test-file

# =====  Bug is here.
git commit --dry-run && echo "Git said something to commit" \
        || echo "Git said NOTHING to commit"

git commit -m "Something to commit after all" && echo "Commit went through"

git log --pretty=oneline

cd ..

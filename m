From: Eric Frederich <eric.frederich@gmail.com>
Subject: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 09:57:33 -0500
Message-ID: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 15:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO64I-0005f1-T2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 15:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbBRO5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 09:57:34 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:60324 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbBRO5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 09:57:34 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so2602447obc.8
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=RKu60xLqVokSEUW1c2XHklIV5LE9hPmVRu3BK26b9w8=;
        b=PaoAmN5mKPCEZV7pj+wn5pxqglM4FICogc4JSSF0d9eLsdEsTGEEm0f3NzJoXHx132
         G/CQpf9cRFnDVG0BW7GmH6T5mqomEgJiIjmaBL+qIMmFxLwghnZX+SWHn3ftFMkyWlCz
         ++/+513ZXUcuMyWWqFpR3klhheEEAxx40N15hXexgvBRn0mCW2uDdFqCz1iA6JZ4/FIu
         TSxxOiYPkTPEn0MFNDwv+oyb/Zg3fWgNLVi+HA+LgEz3O+8KzF8B4unTc7UbRzCSUruj
         Sr4WlMw51WbButVgtKjyC/HwwlqrUI/G2e31skSMzug8x9bsBopIqUG7Z/UfZSBnUWYM
         Ez4g==
X-Received: by 10.182.65.97 with SMTP id w1mr22342144obs.73.1424271453560;
 Wed, 18 Feb 2015 06:57:33 -0800 (PST)
Received: by 10.202.12.193 with HTTP; Wed, 18 Feb 2015 06:57:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264020>

Some background.
I'm trying to use Git as an object store for trees.
I put trees into the repo and can retrieve them.
I'm having issues with diffing these trees that I retrieve from the repo.
If I use a "git checkout" the diffs seem to work but if I create the
tree myself user lower level ls-tree and cat-file commands then the
diff doesn't work.
It seems to take the index into account.

Below is a complete working example.
Should be able to copy / paste line by line.
I am trying to run the diff of form:
  git diff [--options] <commit> [--] [<path>...]
where it says it does a diff from working tree to a commit

Maybe git is interpreting my command as one of the other forms?
Can someone help me understand what is going on?

#
# EXAMPLE
#

# cleanup and create dummy data
rm -rf /tmp/mydatastore && mkdir -p /tmp/mydatastore
rm -rf /tmp/test /tmp/test2 && mkdir -p /tmp/test/d1 /tmp/test2
echo "this is f1" > /tmp/test/f1
echo "this is f2" > /tmp/test/d1/f2

# create a new branch called test with data from /tmp/test
git --git-dir=/tmp/mydatastore/.db init --bare
git --git-dir=/tmp/mydatastore/.db hash-object -w /tmp/test/d1/f2 /tmp/test/f1
echo -e "100644 blob c837441e09d13d3a0a2d906d7c3813adda504833\tf2" |
git --git-dir=/tmp/mydatastore/.db mktree --batch
echo -e "100644 blob
11ac5613caf504eec18b2e60f1e6b3c598b085eb\tf1\n40755 tree
055f1133fbc9872f3093cca5f182b16611e6789a\td1" | git
--git-dir=/tmp/mydatastore/.db mktree
commit_sha=`git --git-dir=/tmp/mydatastore/.db commit-tree -m "initial
commit" c427094b22e74d1eaeebdc9e49e6790b5b6a706a`
git --git-dir=/tmp/mydatastore/.db update-ref refs/heads/test $commit_sha

# why does this show diffs?
git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test diff $commit_sha

# after doing a checkout somewhere else it doesn't show any diffs
git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test2 checkout test .
git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test diff $commit_sha

# remove the index and it shows diffs again
rm /tmp/mydatastore/.db/index
git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test diff $commit_sha

# it was my understanding from "git help diff" that this form of diff
is supposed to
# compare a work tree against a commit or branch and not take into
account the index.
# Clearly it takes into account the index because we get different
results with and without it

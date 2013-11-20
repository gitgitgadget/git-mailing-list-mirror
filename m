From: Nathan Collins <nathan.collins@gmail.com>
Subject: [BUG] Rebase options '--whitespace=fix' and '--keep-empty' are incompatible
Date: Tue, 19 Nov 2013 16:05:23 -0800
Message-ID: <CAO8RVvc8iO-VcR+e3dvPtfV8DDZN+UVbFX5tCxyr65FbeDxDbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 01:06:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VivJ3-0004Aa-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 01:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab3KTAGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 19:06:06 -0500
Received: from mail-vb0-f53.google.com ([209.85.212.53]:56211 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab3KTAGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 19:06:04 -0500
Received: by mail-vb0-f53.google.com with SMTP id g10so2078369vbg.26
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 16:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=XBYd+EU1UTNAtey5fXLuqvsNU9a7gE1JymGq54qpUHU=;
        b=s/Isd2nu/1ZYrNfiMld27cSUvQSjekJylMWcwJN9ohukZe9tOHXRfqLqVT0hL7ombf
         ECUKwzizr9Dlsyv6i/Y83NDgFGtkKutuHXV1GCLeAe71Bbx2ctSY6TUuegrgNHRVwNvk
         kQOqsTwauMjd6UtVwowDpE/vnfN6wL/Z1UjHL71jBT1MOgfRo721QK7su5HCgIo27Lgo
         1KaZYEqJLI2MHwoVmBxXvSpjAX4XXvrve16l4hpzxtgHgQcrmTOzP6DaVTUYii+SNvwG
         n6TwEMYCw0+KCS/0scN/JsmVcBM5199SGooqVhP0GC2Og9BJocSGULacAgDRSsrn9Xpc
         EqIQ==
X-Received: by 10.52.65.136 with SMTP id x8mr20081888vds.23.1384905963742;
 Tue, 19 Nov 2013 16:06:03 -0800 (PST)
Received: by 10.220.7.202 with HTTP; Tue, 19 Nov 2013 16:05:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238055>

Bug
===

The command

  git rebase --whitespace=fix --keep-empty <commit>

does not fix whitespace in the rebased commits.

Example
=======

Set up a repo with a whitespace error commit and an empty commit:

  git init rebase-bug.git
  cd rebase-bug.git
  touch foo
  git add foo
  touch foo
  git add foo
  git commit -m "Empty foo"
  echo "xxx   " > foo
  git add foo
  git commit -m "Trailing whitespace foo"
  git commit --allow-empty -m "Empty commit

Now we have the following commits (adding '$' at EOL to make trailing
whitespace clear):

  git log --oneline --patch | sed -re 's/$/$/'

  d383707 Empty commit$
  4b71cd0 Trailing whitespace foo$
  diff --git foo foo$
  index e69de29..272a831 100644$
  --- foo$
  +++ foo$
  @@ -0,0 +1 @@$
  +xxx   $
  26d51d6 Empty foo$
  diff --git foo foo$
  new file mode 100644$
  index 0000000..e69de29$

Make a backup:

  cp -r ../rebase-bug.git{,.backup}

We can now fix the whitespace with 'git rebase --whitespace=fix', but
this drops the empty commit:

  git rebase --whitespace=fix HEAD~2

  Current branch master is up to date, rebase forced.
  First, rewinding head to replay your work on top of it...
  Applying: Trailing whitespace foo

  git log --oneline --patch | sed -re 's/$/$/'

  2f6f66d Trailing whitespace foo$
  diff --git foo foo$
  index e69de29..d6459e0 100644$
  --- foo$
  +++ foo$
  @@ -0,0 +1 @@$
  +xxx$
  26d51d6 Empty foo$
  diff --git foo foo$
  new file mode 100644$
  index 0000000..e69de29$

If we add '--keep-empty', then we keep the empty commit, but the
whitespace is not fixed:

  cd ../rebase-bug.git.backup
  git rebase --whitespace=fix --keep-empty HEAD~2

  Current branch master is up to date, rebase forced.
  First, rewinding head to replay your work on top of it...
  [detached HEAD a48c4c8] Trailing whitespace foo
   1 file changed, 1 insertion(+)
  [detached HEAD 8a15ca4] Empty commit

  git log --oneline --patch | sed -re 's/$/$/'

  f852c53 Empty commit$
  f8c3626 Trailing whitespace foo$
  diff --git foo foo$
  index e69de29..272a831 100644$
  --- foo$
  +++ foo$
  @@ -0,0 +1 @@$
  +xxx   $
  26d51d6 Empty foo$
  diff --git foo foo$
  new file mode 100644$
  index 0000000..e69de29$

Git version
===========

I'm using git version 1.8.2.3.

Motivation
==========

http://stackoverflow.com/a/15398512/470844

I wanted a Git alias to remove whitespace errors from the index and
tree. I tried this:

  fixws-global-tree-and-index = !"\
    git commit --allow-empty -m FIXWS_SAVE_INDEX && \
    git add -u :/ && \
    git commit --allow-empty -m FIXWS_SAVE_TREE && \
    git rebase --whitespace=fix --keep-empty HEAD~2 && \
    git reset HEAD~ && \
    git reset --soft HEAD~"

But, it does not work, because of the bug illustrated above.  So,
instead, I have this:

  fixws-global-tree-and-index = !"\
    if (! git diff-files --quiet .) && \
       (! git diff-index --quiet --cached HEAD) ; then \
      git commit -m FIXWS_SAVE_INDEX && \
      git add -u :/ && \
      git commit -m FIXWS_SAVE_TREE && \
      git rebase --whitespace=fix HEAD~2 && \
      git reset HEAD~ && \
      git reset --soft HEAD~ ; \
    elif (! git diff-files --quiet .) ; then \
      git add -u :/ && \
      git commit -m FIXWS_SAVE_TREE && \
      git rebase --whitespace=fix HEAD~ && \
      git reset HEAD~ ; \
    elif (! git diff-index --quiet --cached HEAD) ; then \
      git commit -m FIXWS_SAVE_INDEX && \
      git rebase --whitespace=fix HEAD~ && \
      git reset --soft HEAD~ ; \
    fi"

I.e., I calculate which commits are non-empty and only make those
commits.

Cheers,

-nathan

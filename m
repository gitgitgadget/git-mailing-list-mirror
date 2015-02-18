From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 10:06:30 -0500
Message-ID: <CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 16:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO6D5-0001VO-65
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 16:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbbBRPGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 10:06:32 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:56597 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbbBRPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 10:06:30 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so2710306obc.8
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=e+fHBsRgL1DBAX2gmasJEiZr8yVXVwYEZEKnJ1S4ltk=;
        b=FWlJm33W/IplHxpWCI85AXJzMgLTicldJ1BJFHRDCvPJivL/x8d/sKyaxNQTt/FL4c
         JG7EdHafSUQCpfooaVF/Y/ARgxInbSaEv1INdLJ2w8IhX+957DjAEQNAl6rVI28hyPPG
         UprN7x+4qWA66vVjVDn682f+LzBF4wWqrsZX87YWVA97XzU8kg7qnJStT5JUJ0PVZcv4
         ONBhx7GxQFKQtdl9RPWJujWK/os9Rlcx6wKzY/7VSWZV1WvSNwmdfQNnj2NcY+ok1PcI
         K6I29PGWE3cl8ip5P6ogYiuAfKUyPxD7k8eF31TLzo27fjy0xvQxN+SyekOxe//+Ucnd
         KPSw==
X-Received: by 10.202.212.214 with SMTP id l205mr20729151oig.117.1424271990048;
 Wed, 18 Feb 2015 07:06:30 -0800 (PST)
Received: by 10.202.12.193 with HTTP; Wed, 18 Feb 2015 07:06:30 -0800 (PST)
In-Reply-To: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264021>

More concise example:

cd /tmp
git clone --bare https://github.com/defnull/bottle.git
mkdir /tmp/bottlecopy
git --git-dir=/tmp/bottle.git --work-tree=/tmp/bottlecopy checkout master .

# this shows no diffs
git --git-dir=/tmp/bottle.git --work-tree=/tmp/bottlecopy diff master
rm /tmp/bottle.git/index

# why does this one now show a diff?
# how can I compare a working directory to a commit without taking the
index into account?
git --git-dir=/tmp/bottle.git --work-tree=/tmp/bottlecopy diff master

On Wed, Feb 18, 2015 at 9:57 AM, Eric Frederich
<eric.frederich@gmail.com> wrote:
> Some background.
> I'm trying to use Git as an object store for trees.
> I put trees into the repo and can retrieve them.
> I'm having issues with diffing these trees that I retrieve from the repo.
> If I use a "git checkout" the diffs seem to work but if I create the
> tree myself user lower level ls-tree and cat-file commands then the
> diff doesn't work.
> It seems to take the index into account.
>
> Below is a complete working example.
> Should be able to copy / paste line by line.
> I am trying to run the diff of form:
>   git diff [--options] <commit> [--] [<path>...]
> where it says it does a diff from working tree to a commit
>
> Maybe git is interpreting my command as one of the other forms?
> Can someone help me understand what is going on?
>
> #
> # EXAMPLE
> #
>
> # cleanup and create dummy data
> rm -rf /tmp/mydatastore && mkdir -p /tmp/mydatastore
> rm -rf /tmp/test /tmp/test2 && mkdir -p /tmp/test/d1 /tmp/test2
> echo "this is f1" > /tmp/test/f1
> echo "this is f2" > /tmp/test/d1/f2
>
> # create a new branch called test with data from /tmp/test
> git --git-dir=/tmp/mydatastore/.db init --bare
> git --git-dir=/tmp/mydatastore/.db hash-object -w /tmp/test/d1/f2 /tmp/test/f1
> echo -e "100644 blob c837441e09d13d3a0a2d906d7c3813adda504833\tf2" |
> git --git-dir=/tmp/mydatastore/.db mktree --batch
> echo -e "100644 blob
> 11ac5613caf504eec18b2e60f1e6b3c598b085eb\tf1\n40755 tree
> 055f1133fbc9872f3093cca5f182b16611e6789a\td1" | git
> --git-dir=/tmp/mydatastore/.db mktree
> commit_sha=`git --git-dir=/tmp/mydatastore/.db commit-tree -m "initial
> commit" c427094b22e74d1eaeebdc9e49e6790b5b6a706a`
> git --git-dir=/tmp/mydatastore/.db update-ref refs/heads/test $commit_sha
>
> # why does this show diffs?
> git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test diff $commit_sha
>
> # after doing a checkout somewhere else it doesn't show any diffs
> git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test2 checkout test .
> git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test diff $commit_sha
>
> # remove the index and it shows diffs again
> rm /tmp/mydatastore/.db/index
> git --git-dir=/tmp/mydatastore/.db --work-tree=/tmp/test diff $commit_sha
>
> # it was my understanding from "git help diff" that this form of diff
> is supposed to
> # compare a work tree against a commit or branch and not take into
> account the index.
> # Clearly it takes into account the index because we get different
> results with and without it

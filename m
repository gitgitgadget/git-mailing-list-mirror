From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Tue, 17 Jan 2012 09:45:24 +0100
Message-ID: <87ipkaogyj.fsf@thomas.inf.ethz.ch>
References: <loom.20120112T193624-86@post.gmane.org>
	<4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de>
	<4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de>
	<4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de>
	<87r4yzzcci.fsf@thomas.inf.ethz.ch> <4F152767.9010104@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	<git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Tue Jan 17 09:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn4fe-0007EF-R7
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 09:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab2AQIp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 03:45:29 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:7164 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab2AQIp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 03:45:28 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 17 Jan
 2012 09:45:23 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 17 Jan
 2012 09:45:25 +0100
In-Reply-To: <4F152767.9010104@unclassified.de> (Yves Goergen's message of
	"Tue, 17 Jan 2012 08:46:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188700>

Yves Goergen <nospam.list@unclassified.de> writes:

> On 16.01.2012 20:17 CE(S)T, Thomas Rast wrote:
>> If you work together with developers who have a case-sensitive FS (such
>> as Linux, or with the right options OS X), it's entirely possible that
>> this file exists in both spellings within the repository.
>
> Just FTR, I am working on the project alone, only on Windows with Visual
> Studio 2010 and I have two copies of the repository which I am
> occasionally synchronising via a USB memory stick when I work on the
> other machine. I have not pulled anything since the first issue came up
> on last Friday. No case-sensitive filesystem in the game.

Ok.

  $ git ls-tree -r HEAD
  100644 blob 5369994b8f905514661ee58b396dec31f8575a4d    PosterWantsItCensored.Designer.cs
  100644 blob 5369994b8f905514661ee58b396dec31f8575a4d    PosterWantsItCensored.designer.cs
  ^      ^    ^
  |      |    content hash
  |      type
  file mode

That tells us that you have identical file contents in two files whose
names differ only in case.

This is important: Different name for git.  Same name for OS.  Same
contents.

That should also settle your remark at the end:

> I find it interesting to see that both files with the equal file name
> (like what the only relevant file system considers equal) have the same
> hash value. Does that qualify for your description of the "pretty bad bug"?

No, not a bug, just the same contents.

[And before you sue me for disclosing the SHA1 above: inferring the
contents of the file from the SHA1 is equivalent to breaking SHA1.  If
anyone could, he'd already be busy writing a paper about it (or perhaps
working for the NSA).]

>> * You have the byte-for-byte identical file name listed twice in the
>>   index.  That would be a pretty bad bug.
>
> The index should usually be empty here, I guess. I really do not use
> it.  No index interaction at all.

Please read up on the index before making such statements.  You do use
the index, because it is a very important part of how git operates
whenever the operation also involves the worktree.  And except in border
cases (new empty repo etc.) it should never be empty.

Your paste of

  $ git status -s
  [no output]

tells us that the index has *no differences* to your worktree, nor to
HEAD.


So in summary, the picture in your repository is:

* Somehow you got a different-only-in-case file pair into your
  repository.  It's already in HEAD.  See below.

* The index and worktree are healthy and unchanged (w.r.t. HEAD) from
  Git's POV.  (This is possible despite the different-only-in-case files
  because they have the same contents.)

For now I'm siding with Erik's theory

Erik Faye-Lund wrote:
} Very speculative comment: This might be a bug in TortoiseGit. Looking
} at the sources, it seems they are using libgit2 to mess around with
} the index; perhaps it's case-sensitivity code isn't as well tested as
} Git for Windows'?

It would also be interesting to know for how long this problem has
existed.  You can search for the offending commit with something like

  git log --name-status --diff-filter=A -- "PosterWantsItCensored.*"

which should normally give you just one or two commits, namely the
one(s) that introduced the two files.

As for the fix, there are two-and-two-thirds cases.  First I'd like to
point out, however, that I have no idea how core.ignoreCase interacts
with rm --cached.  I'm assuming you have to set it to 'false' for the
recipes below to work.  Erik or Peff may correct me.  You should set it
to 'true' again for real work.

Case 1: The commit that introduced the second spelling is HEAD

  In this case you're sort of lucky because it's easy to fix.  You can
  do

    git rm --cached PosterWantsItCensored.designer.cs

  to get rid of the spelling you do not want.  Then run

    git status -s

  again to verify that it did the right thing; it should say

    D  PosterWantsItCensored.designer.cs

  where it's important that a) the other spelling does *not* show up in
  the list anywhere and b) the D is in the leftmost column.  Once you
  have verified this, run

    git commit --amend

  to fix HEAD.

Case 2a: The commit that introduced it is older, but you don't care if
         you cannot sanely checkout old commits

  This is the case that I personally would never choose, since I care
  about history, but for completeness: proceed as for case 1, except at
  the end run

    git commit  # no --amend

  and write a nice message saying that you fixed the
  different-only-in-case issue.

Case 2b: The commit that introduced it is older, but history since its
         parent has been linear (use gitk or some such to establish
         this)

  First run

    git log --full-history --oneline -- "PosterWantsItCensored.*"

  to see which commits touched the file.  Let C be the SHA1 (or a unique
  prefix) of the earliest commit that contains
  PosterWantsItCensored.designer.cs (i.e., the wrong spelling) as
  established earlier.  Then run

    git rebase -i C^

  (That's right, the SHA1 of C and then a hat.)

  In the editor that pops up, change 'pick' to 'edit' on every line that
  shows a SHA1 you found in the preceding git-log command.  Save and
  exit.

  Whenever rebase stops to let you edit (you can tell by the advice
  messages it gives you), run

    git ls-tree HEAD -- PosterWantsItCensored.designer.cs PosterWantsItCensored.Designer.cs

  and check whether the SHA1s are different.  Judging by what you said
  they should always be the same (otherwise please come back for more
  advice).  You can then again do something very similar to Case 1 to
  the commit you're editing, like

    git rm --cached PosterWantsItCensored.designer.cs
    git commit --amend

  and finally

    git rebase --continue

  to edit the next commit.  Repeat until the rebase is complete.

Case 2c: History wasn't linear since C; or you're just lazy and have a
         good backup

  The all-safeties-off, please-fix-it-for-me version goes

    git filter-branch --tag-name-filter cat --index-filter '
      git rm --ignore-unmatch --cached PosterWantsItCensored.designer.cs
    ' -- --all

  I'm dead serious about the safeties off.  You have been warned.

I have not tested most of this because it would simply take even more
time than writing an essay-length email.  If something fails or got you
confused, paste everything you did and the full output again so we can
establish what happened.

All sub-items of case 2 rewrite history.  You will have to force the
push to your "hub" repository that you use to exchange history, and you
may have to reset or rebase in the other repository.  Read e.g. the
'recovering from upstream rebase' section in man git-rebase.

> (What a mess it would be if I committed something different than my
> working directory, however that works.)

You should really read up on this, e.g.

  http://tomayko.com/writings/the-thing-about-git

AFAIK everyone who groks the feature uses it daily.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

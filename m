From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Diffs for submodule conflicts during rebase usually empty
Date: Thu, 11 Sep 2014 21:29:28 +0200
Message-ID: <5411F818.6030701@web.de>
References: <20140911135057.o7j9bwlnz4okgwsw@webmail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: ezyang <ezyang@mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 21:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSA3l-0007T0-LO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbaIKT3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:29:34 -0400
Received: from mout.web.de ([212.227.15.3]:57850 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755782AbaIKT3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:29:33 -0400
Received: from [192.168.178.41] ([79.193.78.148]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LoYWI-1XzY3v1THG-00gYFo; Thu, 11 Sep 2014 21:29:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20140911135057.o7j9bwlnz4okgwsw@webmail.mit.edu>
X-Provags-ID: V03:K0:5h6QEoTZ8BT+lcrX+dUkaRyX0J5ExuVospar67ybzPzW96wr2EO
 0YMQwwD7d9+fXGToCzkmUXuCAXnej4R6HJROdKSAddy1zRr/qEd8i3kVxT+eVJndIzqKBEI
 PFKz2QwfQb35cbShgy1imJRm3p/CGA+USAtne5JCgS6vBsw74KaAdqNoRxPGooKI+mfPt6B
 xo838sBeetUm5qFwCp9Qg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256868>

Am 11.09.2014 um 19:50 schrieb ezyang:
> Hello all,
>
> In many situations, if you have a submodule conflict during a rebase,
> and you type 'git diff' to get a summary of the situation, you will get
> an empty diff.  Here's a simple transcript for one such case (I'm sorry
> I can't make it much shorter), tested on git version 2.0.3.693.g996b0fd:
>
>      git init
>      mkdir b
>      cd b
>      git init
>      git commit --allow-empty -m "submodule initial"
>      cd ..
>      git submodule add ./b
>      git commit -am "parent initial"
>      git branch dev
>      cd b
>      touch a
>      git add a
>      git commit -m "submodule master"
>      cd ..
>      git commit -am "parent master"
>      git checkout dev
>      git submodule update
>      cd b
>      touch b
>      git add b
>      git commit -m "submodule dev"
>      cd ..
>      git commit -am "parent dev"
>      git rebase master
>      git diff b
>
> The last output is:
>
>      diff --cc b
>      index 4b1b6c6,c423df2..0000000
>      --- a/b
>      +++ b/b

Thanks for providing a simple way to reproduce what you are seeing.

> As it turns out, this behavior is logical in a perverse sort of way.
>
>      - The rebase operation doesn't go about updating your submodule
>        checkouts, so whatever is in the file is what the submodule
>        was pointing to before your initiated the rebase.
>
>      - By default, 'git diff' on a merge conflict (implicitly
>        'git diff --cc') only will report if the submodule's HEAD
>        differs from all of the merge heads.  So if you only had
>        one commit which changed the submodule, you're probably
>        on that commit, and so the "current state" of the submodule
>
> However, just because behavior is logical, doesn't mean it is user
> friendly.  There are a few problems here:
>
>      1. Git is treating the lagging submodule HEAD as if it were
>      actually a resolution that you might want for the conflict.
>      Actually, it's basically almost always wrong (in the example
>      above, if you commit it you'll be discarding commits made on
>      master.)  There is a sorter of wider UI issue here where Git
>      can't tell if you've legitimately changed the HEAD pointer
>      of a submodule, or if you checked out a new revision with different
>      submodule pointers and forgot to run 'git submodule update'.
>      (But by the way, you can't even do that here, because this is
>      a merge!)
>
>      2. The behavior of not reporting the diff when the diff for one
>      branch is non-empty is illogical: for submodules (whose "file
>      contents" are so short), you basically always want some hashes,
>      and not an empty diff.  Doubly so when the "resolution" is
>      bogus (c.f. (1)).
>
> Of course, changing behavior in a backwards-incompatible way is never a
> good way, so it's not exactly obvious what should be done here. I would
> recommend tweaking the default combined diff behavior for submodules and
> adding an admonition to the user that the submodules have not been
> updated in the rebase message (I can submit a patch for this if people
> agree if it's a good idea), but maybe that's too much of a behavior
> change.
>
> By the way, the difference between 'git diff -c' and 'git diff --cc'
> does not seem to be documented anywhere, except for an oblique comment
> in diff-format.txt "Note that 'combined diff' lists only files which
> were modified from all parents." -- the user expected, of course, to
> figure out that 'combined diff' here refers to --cc, but not -c.

It looks to me like your confusion is because current Git isn't
terribly good at displaying merge conflicts in submodules. While
diff produces rather confusing output:

	$ git diff
	diff --cc b
	index fc12d34,33d9fa9..0000000
	--- a/b
	+++ b/b

Git does know what's going on, just fails to display it properly
in the diff, as the output of ls-files shows:

	$git ls-files -u
	160000 6a6e215138b7f343fba67ba1b6ffc152019c6085 1	b
	160000 fc12d3455b120916ec508c3ccd04f23957c08ea5 2	b
	160000 33d9fa9f9e25de2a85f84993d8f6c752f84c769a 3	b

I agree that this needs to be improved, but am currently lacking
the time to do it myself. But I believe this will get important
rather soonish when we recursively update submodules too ...

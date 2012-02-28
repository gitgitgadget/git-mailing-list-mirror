From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Stash during incomplete merge
Date: Tue, 28 Feb 2012 14:22:19 -0600
Message-ID: <4F4D377B.2000206@gmail.com>
References: <4F4A7BC7.5010702@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 21:22:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2TZ2-00069Z-2N
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 21:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250Ab2B1UWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 15:22:18 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50817 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab2B1UWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 15:22:17 -0500
Received: by ggnh1 with SMTP id h1so2808655ggn.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 12:22:17 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.192.138 as permitted sender) client-ip=10.236.192.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.192.138 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.192.138])
        by 10.236.192.138 with SMTP id i10mr31725270yhn.3.1330460537234 (num_hops = 1);
        Tue, 28 Feb 2012 12:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NONCNddiI0nXngt7o1qekqswJcOPq/iR+ib86vzrZzc=;
        b=tDVgJP5rEzPV9Oszzich3jAuHjubUEGuyUMSoH7M/RjfnQOrFFc1cf7wafSa/N8qeS
         ggYe12uflr+MSgbk47aNu5QJ5+gXoVQ0l3sn9KxDh8o0h28qFx5yaPG/fYLWb1Oqvfbg
         1JTIZ/fBArhcPMv9BMrRKynIPpqAQYWJ4HRGI=
Received: by 10.236.192.138 with SMTP id i10mr24069251yhn.3.1330460537177;
        Tue, 28 Feb 2012 12:22:17 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c12sm30546448ann.7.2012.02.28.12.22.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 12:22:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F4A7BC7.5010702@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191782>

On 2/26/2012 12:36 PM, Phil Hord wrote:
> Hi list,
>
> I was cherry-picking changes from an old branch recently when I ran into
> unexpected behavior with git stash pop.  When I git-stash-save after
> resolving a  merge-conflict, the subsequent git-stash-pop does not
> restore my index.
>
> I think it is the same problem being asked about here:
> http://stackoverflow.com/questions/9009354/git-stash-during-a-merge-conflict
>
> Is this expected behavior or a bug?
>
> <http://stackoverflow.com/questions/9009354/git-stash-during-a-merge-conflict>Here's
> a script the demonstrates the anomaly, but my actual encounter involved
> more files, some of which I added to the index and some I did not:
>
> # Create a sample merge-conflict
> git init  tmp-repo&&  cd tmp-repo
> echo foo>  foo.txt&&  git add foo.txt&&  git commit -m "foo"
> git checkout -b A master&&  echo foo-A>  foo.txt&&  git commit -am "foo-A"
> git checkout -b B master&&  echo foo-B>  foo.txt&&  git commit -am "foo-B"
> git merge A
> git status
> # Resolve the conflict
> echo foo-AB>  foo.txt&&  git add foo.txt
> git status
> git stash
> # test test test...  Resume...
> git stash pop
>
>
> Here's some of the final output:
>
> $ git merge A
> Auto-merging foo.txt
> CONFLICT (content): Merge conflict in foo.txt
> Recorded preimage for 'foo.txt'
> Automatic merge failed; fix conflicts and then commit the result.
>
> $ git status
> # On branch B
> # Unmerged paths:
> #   (use "git add/rm<file>..." as appropriate to mark resolution)
> #
> #       both modified:      foo.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> $ # Resolve the conflict
> $ echo foo-AB>  foo.txt&&  git add foo.txt
> $ git status
> # On branch B
> # Changes to be committed:
> #
> #       modified:   foo.txt
> #
>
> $ # Now foo.txt is in my index.  But I have to test something before I
> commit.
> $ git stash
> Saved working directory and index state WIP on B: 80f2a13 foo-B
> HEAD is now at 80f2a13 foo-B
>
> $ # test test test...  Resume...
> $ git stash pop
>
> # On branch B
> # Changes not staged for commit:
> #   (use "git add<file>..." to update what will be committed)
> #   (use "git checkout --<file>..." to discard changes in working
> directory)
> #
> #       modified:   foo.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> Dropped refs/stash@{0} (460a6d5c67a3db613fd27f1854ecc7b89eeaa207)
>
Was the foo.txt in your worktree still the same as the one you resolved 
and added to the index?

If so, at that point you can just do "git add foo.txt" to put it back in 
your index.

(merge conflict)
git add conflict-resolution (file is in worktree and index)
git stash (file is in stash of worktree and stash of index)
git stash pop (file is back in worktree but not back in index)
git add conflict-resolution (file is back in the index)

If not, then you must have a more complicated case like a modified 
worktree version that differs from the index version (original conflict 
resolution) in which case you need to also consider whether or not it is 
an [a]"evil merge".  Ideally, you intend to commit the index (conflict 
resolution) as the merge commit and add any worktree mods in addition to 
that as a commit after the merge commit. If so, then I see your problem. 
The next time, you can get both the worktree version and the index 
version back with:

git stash apply --index

git stash does not apply the index by default so you have to specify the 
--index option if you want the index back also.  I recommend git stash 
apply instead of git stash pop in case you realize you forgot the index. 
Then you can rerun git stash apply --index.  git stash pop can only be 
run once because it throws away the stash after popping it.  You can run 
git stash drop after you confirm that you did the git stash apply 
correctly.

I assume you know that the stash is a stack and how to specify which 
stash you want by using the reflog syntax (see git-stash manpage: 
http://schacon.github.com/git/git-stash.html).  Stashes are really 
[b]"commit objects" of the worktree and index trees (you can see them in 
gitk by viewing all refs), but they are treated according to "stash 
rules" instead of "commit rules".

If you still want to try and get that conflict-resolution from the 
"lost" index from that stash you popped you can try this variation of 
the "Recovering stashes that were cleared/dropped erroneously" procedure 
at the end of manpage:

(1) Find the lost stash:
$ git fsck --unreachable | grep commit | cut -d" "  -f3 | xargs git log 
--no-walk --grep=WIP --grep="index on"

(2) Review the list of commits and decide which pair is for the stash 
you want.  Note on stash commit-object messages:
WIP = stash commit-object of the worktree
"index on" = stash commit-object of the index (this may not exist of the 
index didn't differ from the worktree)

(3) Reset the conflict-resolution-file(s) from the stash of the index:

$ git reset <sha1-of-stash-commit-object-of-index> -- 
<conflict-resolution-file>

git reset will just put it back in your index and leave the worktree alone.

You may also want to consider the --keep-index option on your "git stash 
save" if your "testing" workflow doesn't involve adds or commits before 
the git stash apply/pop.

Footnotes:
a. If you resolved the conflict and then made further mods that is 
called an "evil merge" because you really didn't just merge the changes 
of the two parents, but also made additional changes that were not part 
of the changes made by either of the parents your are merging.  The 
additional changes really should be their own commit after the merge. 
"Evil merges" are misleading (and also probably not documented in the 
merge commit message with a git commit --amend).
b. There are only 4 types of objects in git: tag, commit, tree, blob.

Hope this helps. Maybe someone else has a better way to do this.  Maybe 
my assumptions are incorrect and I'm missing something about what you 
are trying to do.

v/r,
neal

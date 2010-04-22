From: Johan Herland <johan@herland.net>
Subject: Re: 'git notes merge' implementation questions
Date: Thu, 22 Apr 2010 02:08:03 +0200
Message-ID: <201004220208.03706.johan@herland.net>
References: <201004210957.48138.johan@herland.net>
 <7viq7ka3zr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:08:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jxo-0002We-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613Ab0DVAIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:08:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38616 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab0DVAIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:08:07 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L19004FF4DIODD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 02:08:06 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L19007LZ4DG4O30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 02:08:05 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.21.235415
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <7viq7ka3zr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145481>

On Wednesday 21 April 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > For merges between notes refs with no common history the merge should
> > be a straightforward joining of trees. This also covers the
> > "history-less" notes refs, like Peff's notes-cache, and should work
> > whether the notes refs point to parentless commits, or point directly
> > to tree objects (if we want to support that). For merges between notes
> > refs with common history we want to do a (more or less regular)
> > three-way merge.
> 
> Note that a "history-less" merge is just a special three-way merge
> pretending as if their common ancestor is an empty tree.  There is no
> point in special casing the former.

Agreed.

> > In both cases (with or without common history), conflicts may ensue,
> > and these must of course be resolved in some way. Since the notes refs
> > have no accompanying worktree, we must find some other way to resolve
> > conflicts.
> 
> I would say we may not even have to "resolve" the conflicts in the usual
> sense of the word.
> 
> You can run "ls-tree" on three trees,

The three trees you mention are (I assume) <base>, <ours> and <theirs>. What 
if there is more than one merge-base? How do we re-use the recursive 
strategy's "pre-merge" of merge-bases?

Next, we will need to be somewhat careful about using "ls-tree", to avoid 
needlessly unpacking subtrees that are identical between <ours> and 
<theirs>.

> removing '/' from the output to
> obtain the list of objects that are annotated, and do a three-way merge
> at the object level first.  For the ones that do have diverging changes
> on both sides, you just run "git notes append" to add the data from the
> other side and be done with it ;-).

I believe "git notes append" might not be suitable for all types of notes, 
and that users would in some cases want to choose other strategies for 
resolving conflicting notes. I'm currently planning to offer three fully 
automatic resolvers: "ours", "theirs" and "union" (corresponding to the 
_ignore, _overwrite and _concatenate combine_notes functions, respectively, 
in notes.h).

> That way you don't have to worry about how "git merge" merges things, how
> it uses the index, nor how it uses the working tree, as you won't be
> using anything from "git merge" at all.

Ok, I'm just worried that it'll force us to re-implement much of the three-
way merge logic that's already implemented in the merge machinery.

> That would be the first step.
> 
> The second step would be to designate a special directory that would
> exist only during a conflicted "notes merge" in $GIT_DIR, just like
> MERGE_HEAD serves as the signal we are in a conflicted merge.  When
> 
>     $ git notes merge <other>
> 
> is run, if (and only if) you need a manual merge resolution, you would
> create this directory, which will have:
> 
>  - a temporary index that has the result of the tree level merge, but you
>    will:
> 
>    (1) only register the entries that have conflicted; and
>    (2) flatten the fan-out structure.
> 
>  - files that have conflicted merge result, whose names are 40-byte
> object names that are annotated; and
> 
>  - something like MERGE_HEAD to keep track of the <other>, so that you
> can create a merge commit when concluding the merge.
> 
> You can chdir to the directory and use "git diff" and "git ls-files -u"
> to inspect the conflicts, and run "git add <filename>" to mark a
> resolved note.
> 
> You would need a separate command ("git notes commit" perhaps) to
> conclude the merge.  At that point, you would iterate over this
> temporary index (which only has conflicted notes), pulling out the list
> of <object name being annotated, the annotation>, add these annotates to
> produce a new notes tree, record that tree as a merge commit in the
> notes namespace, and finally remove the notes merge working directory.

I agree that this is probably a better way to resolve conflicts in notes 
(i.e. better than designing a way to semi-manually resolve conflicts without 
a working tree).

We're then left with a few fully automatic conflict resolvers ("ours", 
"theirs" and "union") which will always succeed (and therefore need no 
special directory), and a "manual" resolver which sets up the special 
directory as you describe above, and instructs the user to resolve the 
merge, followed by 'git notes commit' to conclude the merge.


Thanks for the feedback. (BTW, I'm travelling next week, so don't expect any 
immediate patches from me).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

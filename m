From: Johan Herland <johan@herland.net>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Wed, 26 Nov 2014 12:46:20 +0100
Message-ID: <CALKQrgftttSpuw8kc+jC6E5RBet39wHKy3670Z5iG=KQSmrCAw@mail.gmail.com>
References: <20141126004242.GA13915@glandium.org>
	<20141126010051.GA29830@peff.net>
	<20141126012448.GA11183@peff.net>
	<20141126022553.GA16199@glandium.org>
	<20141126044642.GA15252@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Hommey <mh@glandium.org>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 12:46:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtb3L-0006d9-4g
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 12:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbaKZLqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 06:46:30 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:38673 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaKZLq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 06:46:29 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xtb3D-0000G6-7X
	for git@vger.kernel.org; Wed, 26 Nov 2014 12:46:27 +0100
Received: from mail-pa0-f41.google.com ([209.85.220.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xtb3C-000BgH-OS
	for git@vger.kernel.org; Wed, 26 Nov 2014 12:46:27 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so2724621pab.14
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 03:46:20 -0800 (PST)
X-Received: by 10.70.31.2 with SMTP id w2mr51758812pdh.128.1417002380326; Wed,
 26 Nov 2014 03:46:20 -0800 (PST)
Received: by 10.70.75.161 with HTTP; Wed, 26 Nov 2014 03:46:20 -0800 (PST)
In-Reply-To: <20141126044642.GA15252@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260279>

(First of all, thanks to both for great investigation and analysis)

On Wed, Nov 26, 2014 at 5:46 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 26, 2014 at 11:25:53AM +0900, Mike Hommey wrote:
>
>> Now, looking at the notes tree reflog, I see that at some point, some
>> notes were added at the top-level of the tree, without being nested,
>> which is strange.
>
> That's somewhat expected. The fanout is dynamic based on the number of
> notes, so early on I think some notes may be found at the top of the tree.
>
>> And it looks like it's related to how I've been adding them, through
>> git-fast-import. I was using notemodify commands, and was using the
>> filemodify command to load the previous notes tree instead of using the
>> from command because I don't care about keeping the notes history.

I'd very much like to see this fast-import stream (or a script
generating it). I'm assuming that it roughly follows along these lines:

 - Start a new commit from a clean slate (no 'from')

 - Do a single filemodify to "load" the previous notes tree.
   Exactly what does this filemodify command look like? I'm
   guessing you're using the root tree object from the previous
   notes tree as <dataref>, and an empty <path>, i.e.:

     M 040000 $previous_notes_tree_root_sha1 \n

 - Do a series of notemodify commands for the notes being added in
   this commit.

 - End of commit.

Browsing the fast-import code, I believe I can confirm some of the
behavior you're seeing. Your commit starts from a clean slate
(with branch->num_notes == 0). The initial filemodify command loads
the previous notes tree, but does not adjust branch->num_notes.
The subsequent notemodify commands each increment branch->num_notes.
Then, when wrapping up the commit, branch->num_notes is used to
calculate the new fanout (the fast-import code does a simple
divide-by-256 heuristic). If you happened to have added more than
256 notes in this commit, you get a 2/38 fanout, otherwise you get a
flat notes tree. This is obviously incorrect, because the notes that
were "preloaded" by the filemodify command are not being accounted in
the fanout calculation. Thus, you end up with a seriously suboptimal
(notes) tree structure, which kills your lookup times.

However, at the start of note_change_n() (which handles the "notemodify"
commands), there is some logic to deal with this. The initial comment
there suggests that it was written for the case when the commit uses
"from refs/notes/foo" to add notes to an existing notes tree, but I don't
really see why it should not also apply to the case where the notemodify
commands are preceded by a filemodify to "preload" the notes tree.

Furthermore, It is not obvious why this logic (that counts the number of
exiting notes before we add the first note) does not ALREADY trigger in
your case (both b->num_notes and *old_fanout should be == 0). However, I
wonder if the "counting mode" is in fact invoked, but that there is some
non-obvious interplay with how "struct tree_entry"s are prepared by your
use of filemodify:

When using 'from ...' to preload b->branch_tree, the code in parse_from()
prepares a b->branch_tree tree_entry looking like this:

  .versions[1].sha1 = $some_sha1
  .tree == NULL

Following this, parse_new_commit() goes on to call load_branch(b), which
AFAICS, populates the .tree:

  .versions[1].sha1 = $some_sha1
  .tree == <tree structure loaded from $some_sha1>

However, when you use the filemodify command to replace the root tree
object, we end up calling

  tree_content_replace(&b->branch_tree, sha1, mode, NULL);

near the end of file_change_m(), which causes the b->branch_tree tree_entry
to look like this:

  .versions[1].sha1 = $some_sha1
  .tree == NULL

(i.e. same as parse_from()), BUT there is never a follow-up call to
load_branch(b).

So, at the time we handle the first notemodify command, the
b->branch_tree.tree entry is either non-NULL (in the case of 'from ...'),
or NULL (in the case of your "preloading" filemodify). And when we start
the "counting mode" of change_note_fanout(), the for loop in
do_change_note_fanout() depends on the .tree entry being already loaded.

A possible fix would be to ensure .tree is loaded before starting the for
loop in do_change_note_fanout(). But it's been too long since I thoroughly
grokked the fast-import code to say if simply inserting a

  load_tree(&b->branch_tree);

before the for loop is Safe(tm) and Correct(tm)...

>> So fast-import was actually filling the notes tree as if it were
>> starting over with whatever new notes were added with notemodify (which,
>> in a case where there were many, it filled with one level of
>> indirection)
>
> Ah, that sort of makes sense. This confused the code to adjust the
> fanout, because we track "number of notes" independently of "number of
> files" (even though they are really the same thing in a notes tree).

Not always. There is no way to summarily prevent someone from adding
objects at arbitrary locations in a notes tree. There "non-notes" must be
(and are) handled by the notes code (albeit less than gracefully).

>> I'm not sure this is a case worth fixing in fast-import. I can easily
>> work around it.
>
> Yeah. Probably fast-import could be smarter here, but I think ultimately
> it makes sense to stick to using the note commands. I think what you
> want is a version of "from" that takes an existing tree (and number of
> notes!) from a commit, but does not add it as a parent. AFAIK,
> fast-import doesn't have a way to do that.
>
> Probably the simplest thing is to build it with history via fast-import,
> and then just truncate the history at the end with:
>
>   commit=$(echo "final notes tree" | git commit-tree refs/notes/foo^{tree})
>   git update-ref refs/notes/foo $commit

I agree that this is probably the best workaround for now.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

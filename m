From: Johan Herland <johan@herland.net>
Subject: Re: fast-import's notemodify doesn't work the same as git notes
Date: Mon, 5 Jan 2015 04:37:23 +0100
Message-ID: <CALKQrgdVp7cLER2DQxwdFT82Y=Pamrx6=oa3bY=X7mWy_r3QWA@mail.gmail.com>
References: <20141223000611.GB10980@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 05:01:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7yqj-0006yZ-K0
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 05:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbAEEAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 23:00:42 -0500
Received: from mail13.copyleft.no ([91.220.196.227]:36187 "EHLO
	mail13.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbbAEEAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 23:00:41 -0500
X-Greylist: delayed 1388 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jan 2015 23:00:40 EST
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail13.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Y7yTx-0005e1-Sa
	for git@vger.kernel.org; Mon, 05 Jan 2015 04:37:29 +0100
Received: from mail-pd0-f169.google.com ([209.85.192.169])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Y7yTx-000H1V-Iv
	for git@vger.kernel.org; Mon, 05 Jan 2015 04:37:29 +0100
Received: by mail-pd0-f169.google.com with SMTP id z10so27433014pdj.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:37:23 -0800 (PST)
X-Received: by 10.66.170.208 with SMTP id ao16mr16444121pac.1.1420429043072;
 Sun, 04 Jan 2015 19:37:23 -0800 (PST)
Received: by 10.70.105.4 with HTTP; Sun, 4 Jan 2015 19:37:23 -0800 (PST)
In-Reply-To: <20141223000611.GB10980@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262016>

(sorry for the late answer, I've been away from email over the holidays)

On Tue, Dec 23, 2014 at 1:06 AM, Mike Hommey <mh@glandium.org> wrote:
> Hi,
>
> There are two major differences between adding notes with fast-import
> and git notes, one of which is a serious problem:
>
> - fast-import doesn't want to add notes for non commits, while git notes
>   does.

True. I consider this a bug in fast-import. A first draft of a patch
series to fix that will be posted shortly.

> - fast-import and git notes have different, conflicting fanouts:

Yes. The relevant code in fast-import and git-notes is largely
separate and independent of each other.

The main reason for this, IIRC, is that fast-import uses its own data
structures and algorithms when building trees, and that makes it hard
to reuse the git-notes code (fast-import.c does not even #include
notes.h because of this).

fast-import is fundamentally built to solve a somewhat different use
case than the rest of the git tools, and I believe this is why it
"goes it alone" and implements its own (duplicate - to a certain
degree) data structures and algorithms: It is heavily geared towards
creating a _lot_ of trees in as little time and space as possible.

The fast-import documentation states that the packs it generates are
sub-optimal, and that you should always repack after fast-import to
get more optimal/usable packs. Although not documented, a similar
analogy applies to notes trees: fast-import will import a lot of notes
quickly and efficiently, but the resulting fanout might not be the
same (or as optimal) as what git-notes would produce.

IMHO, it is not optimal (at least not currently) to use a workflow
that interleaves notes tree manipulation from fast-import and
git-notes, like you do below. You risk a lot of fanout churn, since
the fanout calculation logic is different between the two. That said,
there are clearly also bugs in the current fast-import behavior that
we should fix... :)

>   - take e.g. the git repo (there needs to be a lot of commits to start
>     to see the problem)
>   - run the following to create notes for every commit:
>       (echo 'blob';
>        echo 'mark :1';
>        echo 'data 0';
>        echo 'commit refs/notes/foo';
>        echo 'committer <foo> 0 +0000';
>        echo 'data 0';
>        git rev-list --all | awk '{print "N :1", $1}';
>        echo) | git fast-import
>   - pick a random commit. I'll pick
>     bbcefffcea9789e4a1a2023a1c778e2c07db77a7 as it is current master as
>     of writing. Take the first two characters of that sha1, and look at
>     the ls-tree:
>       git ls-tree refs/notes/foo bb/
>     You'll see a number of blobs.

Ok, so fast-import yields a 2/38 fanout for ~50 000 notes (#commits in
git.git). fast-import keeps track of the total number of notes in the
tree (although there are bugs, see the patch series), and divides that
number repeatedly by 256 to find the fanout, so this result is
expected, AFAICS

>   - Now, remove the note for that commit with git notes:
>       git notes --ref foo remove bbcefffcea9789e4a1a2023a1c778e2c07db77a7
>   - ls-tree again, you'll now see a number of trees instead of blobs,
>     because git notes will have done a fanout. -> git notes does fanouts
>     for much less items than fast-import does.

Maybe. git-notes has a different heuristic that does not keep track of
the total number of notes in the tree. This is because git-notes only
loads the required parts of the notes tree, so when you remove that
single note, only the relevant parts of the notes tree (the bb/* tree)
is loaded and manipulated. Then, git-notes looks at the density of
note entries in that sub-tree (see determine_fanout() in notes.c for
the details) to figure out if the fanout needs to be adjusted (but
only in that sub-tree). In this case, it looks like the heuristic
triggers a nested fanout within the bb/* tree. However, the other 255
"top-level" trees are not loaded, and hence not "re-balanced" by
git-notes.

>   - Re-add a note for that commit with fast-import:
>       git fast-import <<EOF
>       blob
>       mark :1
>       data 0
>       commit refs/notes/foo
>       committer <foo> 0 +0000
>       data 0
>       from refs/notes/foo^0
>       N :1 bbcefffcea9789e4a1a2023a1c778e2c07db77a7
>
>       EOF
>   - ls-tree again, and you'll see a number of trees and *one* blob, for
>     bb/cefffcea9789e4a1a2023a1c778e2c07db77a7

Hmm... Here I'd expect fast-import to rewrite the entire notes tree,
not just a single entry. Not sure if this is a symptom of the bug
discussed in our previous thread, or if this is a deeper problem.

>   - See the thread starting with 20141126004242.GA13915@glandium.org,
>     this type of notes branch make things very slow.

I have a suggested fix for this in my upcoming patch series. Please
test this with your scenario to see if it makes a difference.

>   - Now, if you take an even bigger repository (as long as there are more
>     than 65536 commits, that's good ; I guess the linux kernel
>     qualifies, I've been checking with a mozilla-central clone), and
>     create exactly 65535 notes with git fast-import, you'll end up with
>     a 1-level tree (2/38). Add one more note, and the entire tree turns
>     into a 2-level tree (2/2/36). git notes would only add a level to
>     the tree containing the added note. git notes's behavior scales
>     better, because think about what happens on the next fanout with
>     fast-import... adding one note would need to create millions of trees.

True, this is a good illustration of the difference between the notes
code in fast-import and git-notes. It might be possible to change the
fast-import code to work more like the git-notes code, but it's been
quite a while since I looked closely at this, and I'm not sure it is
as easy as it sounds.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Mon, 13 Feb 2006 01:03:21 -0500
Message-ID: <20060213060321.GA32704@spearce.org>
References: <20060210195914.GA1350@spearce.org> <43EFF3D0.4090701@vilain.net> <20060213032903.GA32121@spearce.org> <43F00DB6.4040306@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 13 07:03:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Wo4-0006Rw-VT
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 07:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWBMGD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 01:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWBMGD0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 01:03:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36297 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750902AbWBMGDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 01:03:25 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F8Wnn-00015L-C6
	for git@vger.kernel.org; Mon, 13 Feb 2006 01:03:11 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 0D42C20FBA0; Mon, 13 Feb 2006 01:03:21 -0500 (EST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43F00DB6.4040306@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16049>

Sam Vilain <sam@vilain.net> wrote:
> ok.  Well, perhaps a nice solution might be just to aggregate the
> comments as each new commit is made.  ie, the previous comment is
> prepended to the new comment unless you use the editor or a special
> -M (or whatever) option that replaces the running comment.

Yea, that's not a bad idea.  If you are creating a new commit you
probably would want to edit the running description for the patch;
or at least be reminded of what it is.
 
> I tried importing a patchset into pg, and made some changes to it to see
> the patch revisioning going on.  However, I can't see this happening.
> Can you perhaps include this information in your tutorial?

Revisioning doesn't happen for the series, just the individual
patches.  But I've thought about series revisoning and keeping a
secondary GIT index/commit chain external to the main repository
for exactly this purpose.

Each change to a patch (pg-ci) is a new commit object in GIT with
the prior commit object as its parent; if you use pg-ci a few times
with the same patch on the stack then look at the log with git-log
or gitk you'll see the commits are chained together.

When you pop patches and reorder them in the series the resulting
merges are stored as commits with two parents: one for the HEAD
at the time of the merge and one for the commit which was the last
commit in the patch being pushed (HEAD^1 and HEAD^2 respectively).
For example:

	pg-new A
	echo a >>somefile
	pg-ci -m"This is a"
	pg-new B
	echo b >>somefile
	pg-ci -m"This is b"

	pg-pop -a
	pg-push B  # base used to be HEAD+A, now its HEAD
	pg-push A  # base used to be HEAD, now its HEAD+B

The challenge then becomes walking through the merge history.
If you look at pg's own history you'll see an interesting knot
in gitk at a7e73545e511c5c2daea1f6c7bf06cf3179e7f0da (Refreshed
patch Create-Rebase-Tool).  This was produced because I reorded
the patches in the stack and thus had to merge them.  It was an
automatic merge, but it still generated merge commit objects.

Good suggestion about including some details about it in the
tutorial.

> As far as other, more general critiques of the software goes:  What
> about merging?  stgit has a very nice way of merging; I specify how to
> merge using a config file, and when I rebase my patches with "stg pull",
> it fires up my custom editor.  All I really want is a way to specify how
> to handle merges, with the ancestor/left/right files on hand.  I want to
> use something as simple as this script:
> 
>     echo "falling back to ediff-merge"
>     emacs --eval "(ediff-merge-files-with-ancestor \"${branch1}\"
>                    \"${branch2}\" \"${ancestor}\" nil \"${output}\")"

pg doesn't currently invoke any user code when an automatic merge
fails during pg-push or pg-rebase.  It does attempt to produce
a 3 way merge and leaves the resulting portions for you in the
filesystem.  If you look at MERGING.txt you'll see that up to 5
files can come out of a merge (here I'm using the tracked file X.c):

	X.c
	X.c-head
	X.c-last
	X.c-pbase
	X.c-rej

These just get left in the filesystem for you to use as you want;
in your case it sounds like you'd want to invoke:

	emacs --eval "(ediff-merge-files-with-ancestor
		\"X.c-head\"
		\"X.c-last\"
		\"X.c-pbase\"
		nil
		\"X.c\"
		)"

X.c already contains the result of performing:

	diff X.c-pbase X.c-last | patch X.c

so it already has any hunks which were part of your patch and
which applied cleanly to X.c-head (which is the file coming in as
the new base).  Thus you are left only with the rejecting hunks,
which are in X.c-rej.

Personally I've always preferred being given the rejects from
patch to work out a merge problem then to be given the mess that
RCS merge leaves you with.  (I've _never_ been able to decipher
what I want from an RCS merge conflict.)

What is the desired behavior when multiple files have conflicts?
Stop and let the user work on one file before moving to the next?
Open all merge editors in parallel?  Neither seems right to me in
all situations, which is why I just left the `mess' in the filesystem
for the user to resolve at their own pace.

> That's all the features I'm really after.

I like what you are suggesting and will try to incorporate these
improvements this week.

-- 
Shawn.

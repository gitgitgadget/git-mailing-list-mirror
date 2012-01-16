From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/3] git-p4: Search for parent commit on branch creation
Date: Mon, 16 Jan 2012 13:57:38 -0500
Message-ID: <20120116185738.GA21996@padd.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
 <1326674360-2771-3-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmrkk-0005tq-5u
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 19:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab2APS5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 13:57:45 -0500
Received: from honk.padd.com ([74.3.171.149]:35497 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192Ab2APS5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 13:57:44 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 97E02E8B;
	Mon, 16 Jan 2012 10:57:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 01A9931446; Mon, 16 Jan 2012 13:57:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1326674360-2771-3-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188641>

vitor.hda@gmail.com wrote on Mon, 16 Jan 2012 00:39 +0000:
> To find out which is its parent the commit of the new branch is applied
> sequentially to each blob of the parent branch from the newest to the
> oldest. The first blob which results in a zero diff is considered the
> parent commit. If none is found, then the commit is applied to the top
> of the parent branch.
> 
> A fast-import "checkpoint" call is required for each comparison because
> diff-tree is only able to work with blobs on disk. But most of these
> commits will not be part of the final imported tree, making fast-import
> fail. To avoid this, the temporary branches are tracked and then removed
> at the end of the import process.

This looks much better without the need for "--force".  It'll be
great to fix this major branch detection problem.  Can you make a
couple of further minor changes?

> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> @@ -2012,7 +2014,28 @@ class P4Sync(Command, P4UserMap):
> -                        self.commit(description, filesForCommit, branch, [branchPrefix], parent)
> +                        parentFound = 0
> +                        if len(parent) > 0:
> +                            self.checkpoint()
> +                            for blob in read_pipe_lines("git rev-list --reverse --no-merges %s" % parent):
> +                                blob = blob.strip()
> +                                tempBranch = self.tempBranchLocation + os.sep + "%d-%s" % (change, blob)
> +                                if self.verbose:
> +                                    print "Creating temporary branch: " + tempBranch
> +                                self.commit(description, filesForCommit, tempBranch, [branchPrefix], blob)
> +                                self.tempBranches.append(tempBranch)
> +                                self.checkpoint()
> +                                if len( read_pipe("git diff-tree %s %s" % (blob, tempBranch)) ) == 0:
> +                                    parentFound = 1
> +                                    if self.verbose:
> +                                        print "Found parent of %s in commit %s" % (branch, blob)
> +                                    break
> +                        if parentFound:
> +                            self.commit(description, filesForCommit, branch, [branchPrefix], blob)
> +                        else:
> +                            if self.verbose:
> +                                print "Parent of %s not found. Committing into head of %s" % (branch, parent)
> +                            self.commit(description, filesForCommit, branch, [branchPrefix], parent)

1.  Move the tempBranch commit outside of the "for blob" loop.
    It can have no parent, and the diff-tree will still tell you
    if you found the same contents.  Instead of a ref for
    each blob inspected for each change, you'll just have one ref
    per change.  Only one checkpoint() after the tempBranch
    commit should be needed.

2.  Nit.  parentFound is boolean, use True/False, not 1/0.

> @@ -2347,6 +2370,12 @@ class P4Sync(Command, P4UserMap):
> +        # Cleanup temporary branches created during import
> +        if self.tempBranches != []:
> +            for branch in self.tempBranches:
> +                os.remove(".git" + os.sep + branch)
> +            os.rmdir(".git" + os.sep + self.tempBranchLocation)
> +

3.  Deleting refs should probably use "git update-ref -d"
    just in case GIT_DIR is not ".git".  I think you could just
    leave the "git-p4-tmp" directory around, but use
    os.environ["GIT_DIR"] instead of ".git" if you want to
    delete it.

4.  Paths are best manipulated with os.path.join(dir, file), to handle
    weirdnesses like drive letters.

Eventually if the fast-import protocol learns to delete the refs
it creates, we can clean up a bit more nicely.  I think there was
agreement this was a good idea, just needs someone to do it
sometime.

		-- Pete

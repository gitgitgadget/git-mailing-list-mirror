From: Derek Moore <derek.p.moore@gmail.com>
Subject: smudge filters during checkout & crash consistency
Date: Wed, 12 Nov 2014 11:46:19 -0600
Message-ID: <CAMsgyKbox7e2pv4+_=jG6Ywh3Km2gPsw+Qf6qj-28GWrVg7RZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 18:46:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xobzs-0008Ey-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 18:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbaKLRqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 12:46:20 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34087 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaKLRqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 12:46:19 -0500
Received: by mail-ob0-f175.google.com with SMTP id gq1so9558943obb.34
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wjT0xwEgG3mwk/yvLEiJEGMasWVVxJFhUYZs5rulJUk=;
        b=nXIVtZWpIy1ni5y1kZDyC7zcYRw22x46BJMPjJBg2DZPbn3wfPKzDSRteRz+Kf3pKE
         KXhsvqoh7kZvZY3hLyoa6qhhVL3HinWf9rc950xycZSq3aFYK81lIv7bVM5xjB/Vs/E1
         IjEKkk0bL52hrKonGmpP6xcartR/aFZTQPMEndq4X5o6SipClfKkfKQegtNYn1KLFpnU
         7RXg0jlCDp9elxa2gq2TvxK1gAzSaW8IOOHG/z9m0p1Kwe/E0DPTNuj7fEDJWxGC/3Hf
         9hRISFqEmMZzIGPh5qtrNYjQVH75kIh3eR+MiXUD3DUQIULUxUvMSd0neUJT/6Kbpq7z
         FdmA==
X-Received: by 10.182.63.17 with SMTP id c17mr2676806obs.65.1415814379197;
 Wed, 12 Nov 2014 09:46:19 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Wed, 12 Nov 2014 09:46:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a case where I would like to smudge files according to the
reflog information of the switching-to branch.

This is difficult to achieve because updating HEAD to the new
switched-to refname or commit hash is the last step performed in a
checkout prior to calling the post-checkout hook, and smudge filters
process content during the rewriting of the index and work-tree before
HEAD is updated.

I believe this weakness of checkout & filters also exposes a crash
consistency concern. Suppose power is lost during a long-running
checkout while the index/worktree is being updated but before the new
HEAD file is written.

Upon coming back up, your git status will show edits against your
switching-from branch, and possibilities of recovery would rely on
your memory of what you were doing (instead of git-status reporting
"Incomplete checkout to {branch,commit}, 'git checkout --continue' to
continue").

Maybe git could record a CHECKOUT_HEAD at the start of a checkout,
then at the end of the commit update_refs_for_switch() would move
CHECKOUT_HEAD over top HEAD instead of rewriting HEAD (but,
presumably, a lot of logic in update_refs_for_switch() would have to
be relocated to when CHECKOUT_HEAD is written, other implications
notwithstanding).

Crash consistency aside, my workaround for filtering will probably be
to use a fake smudge filter that records the file paths of all
to-be-smudged files to a file under .git/, and then use a post-commit
hook that will process those files from within the newly checked-out
branch (where I'll be using git-archive to overwrite files).

Seems git could fix these two concerns in one fell swoop.

Thanks,

Derek

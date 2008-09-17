From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: keep a subversion mirror in sync
Date: Wed, 17 Sep 2008 13:52:28 -0400
Message-ID: <32541b130809171052q4e32e353ld3fdd109d0d34b00@mail.gmail.com>
References: <B529992F-3C09-4708-A3F4-645DB23DF158@teti.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gaspard Bucher" <gaspard@teti.ch>
X-From: git-owner@vger.kernel.org Wed Sep 17 19:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg1Dg-0004Ps-3j
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 19:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbYIQRwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 13:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYIQRwb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 13:52:31 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49779 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbYIQRwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 13:52:30 -0400
Received: by gxk9 with SMTP id 9so30048055gxk.13
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fo0TsEs9AxV3Zpzll9UOuMAuuPam+hGOEEKBuOgACJ0=;
        b=SP/2RV+7GmmVNsqfZYvWCn17JTgagdpVGEXbvskMeADlltKxh4qY32L+VbVbBAnnGL
         DxRqQKf7StKqz9YTo9WPI8UFgWdtuw5tug/2H9yGDvKMpoAZe+R/A5goZuWMJx2TtKHr
         B4/2aboZu4FzSjFFkrRPqPv2QLmyzX2T9oOok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=huJd6GR52xcUiuN4kvsz0ME1ibHkrcGmisEE3Zp2/rxOv/5nEWaW1D0xSAUdF+/TsE
         cR3JrB62xj//MuVImw4pA8R3poOu2hEU09eM2ZBv6NRTzbmSBkW1vzOMvD4rt1ZRqvCO
         B7sNiFHsYsLlH3VM9CmAVKFtBbpUS5nni0kE0=
Received: by 10.150.49.15 with SMTP id w15mr508025ybw.238.1221673948525;
        Wed, 17 Sep 2008 10:52:28 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 17 Sep 2008 10:52:28 -0700 (PDT)
In-Reply-To: <B529992F-3C09-4708-A3F4-645DB23DF158@teti.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96132>

On Wed, Sep 17, 2008 at 7:58 AM, Gaspard Bucher <gaspard@teti.ch> wrote:
> I have been trying different strategies to keep subversion repository in
> sync with a git repository (on github).
>
> Some details with pictures can be found here:
> http://zenadmin.org/en/documentation/page439.html.
>
> I have tried to use a single database to pull/push from github and dcommit
> to the old subversion repository but I get lots of conflicts and duplicates
> (see link above).
>
> I have then tried to create a "pull" only clone to dcommit, but it looses
> the commit messages and replaces then with a merge message. At least this
> solution keeps the github repository clean.
>
> What is the canonical way to do this ?

The bad news is that a fully automatic two-way sync with svn is pretty
much impossible, AFAIK.  The act of committing to svn adds a
git-svn-id line to your commit, so your old commit object needs to be
thrown away and replaced with a new commit object.  This makes
everybody else's git commits totally confused.  It's possible that the
svn.noMetaData option will avoid this problem, but I've never tried
it, and it's dangerous: if you lose your svn rev-map database, you
can't get it back.

As for dcommits losing commit messages... yes.  There is no way to
represent the idea of parallel development in svn without creating
branches.  For example, if we fetch from svn at point A, and person #1
commits to svn based on point A producing point B, and person #2
commits to git based on point A producing point C, then in order to
have git-svn send point C back into svn, it will have to merge points
B and C.

Git can do the merge with no problem, but now it has to commit the
changes from the merged version into svn.  It doesn't make sense to
commit *each* of the commits from A to C, because it would have to do
it *on top of* B.  The best it can do it commit the entire set of
changes as a merge commit.

You have two options:

1) Manually git-rebase the changes from A..C onto B, then hurry up and
dcommit them before someone else commits to svn before you (otherwise
you'd have to rebase again).  git svn dcommit will then be smart
enough to commit each one separately.

2) Accept the merge commit.  The good news is that in the git repo,
history will still have all the interesting information; svn's history
isn't wrong, it's just incomplete.

You could also try to modify git-svn to implement a third solution:

3) Create a temporary branch in svn by copying commit A.  Commit each
of the changes from A..C in that branch one by one, then create a
merge back on the real branch that merges your temporary branch in,
using the commit message and files from your git merge commit.

Option #3 sounds hairy and gross, so it would be a lot of work and
there's no guarantee your patch would be accepted.

Basically, svn's limited ability to express history is preventing you
from committing your "full" git history back into svn.

At work, I currently use option #2.  As long as the full history is
available *somewhere*, the world is an okay place.

Have fun,

Avery

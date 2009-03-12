From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 21:14:15 -0400
Message-ID: <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <gp9jp7$uc3$1@ger.gmane.org>
	 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZWT-0004I5-SL
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 02:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbZCLBOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 21:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZCLBOS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 21:14:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:42577 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZCLBOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 21:14:17 -0400
Received: by rv-out-0506.google.com with SMTP id g37so272311rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FsjBMrOpIUaj2TOdOA79cQvHr2UDT/gZfanAlvXCq2E=;
        b=mWYcEGavuQqT4H59KIyyu4H/zNOT1Ck/qc0kh0wtpNNp/is5NaDTSiHUJ8hBD4o0R9
         W4q3zGBdr2cEKNrANLIkMp1Uywegqi6nJEK+pvPzv7w8IE2e4Q149Pv3TCMDPaLNQQoA
         VnQxo42khZJQb543bqRVZGJf0Tax8LMST7Zag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E9hc6PzkV7Hs1UvTS2qTkhsMDT8Gqh4+cKcsaULCf1mLIz7UXnnbJuIZynx1Lz4qiF
         TCfyG6DZIK8Jj89/GRauch6gjhljkEgSOdDt+S2DrfHCnqnIoTOa2VUTK3ZqDkTVdzMK
         Hm6Yu15AWeAJqGsijjafnTjyKvTFCAd2wUkvw=
Received: by 10.141.15.19 with SMTP id s19mr4682746rvi.259.1236820455710; Wed, 
	11 Mar 2009 18:14:15 -0700 (PDT)
In-Reply-To: <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112995>

On Wed, Mar 11, 2009 at 8:58 PM, Jay Soffian <jaysoffian@gmail.com> wrote:

> http://article.gmane.org/gmane.comp.version-control.git/54822/

Let me summarize that thread as best I can.

- The branches under refs/remotes (those shown by "git branch -r") are
remote tracking branches. This is because they typically match (i.e.
track) the corresponding branch on a remote.

- The branches under refs/heads (those shown by "git branch") are your
local branches.

- Local branches can be associated with remote tracking branches in
the repo's config (.git/config). This association is done
automatically in current git when creating a new local branch based on
a remote tracking branch (e.g, git checkout -b topic origin/master or
git branch topic origin/master). (You can use --track and --no-track
to be explicit about whether or not you want the association to
happen.)

The association itself is simply an entry in the repo's .git/config. e.g.:

[branch "topic"]
        remote = origin
        merge = refs/heads/master

So, what does this entry in the .git/config do for you? A number of things:

1) git branch -v, git status, and git checkout will tell you how far
ahead/behind the local branch is from the associated remote tracking
branch.

2) git fetch, w/o arguments, will look in the config, find the remote
for the currently checked out branch, and update the configured
remote-tracking branches for said remote. This requires a bit more
explanation. In the above example, while topic is checked out, git
fetch will find that the associated remote is called "origin". It will
then update origin per its configuration, also in .git/config. e.g.:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*

So that tells git fetch where to fetch from, which remote branches to
fetch, and where to store those branches locally. In this case, each
branch under refs/heads/ on git://git.kernel.org/pub/scm/git/git.git
will be fetched and stored locally as refs/remotes/origin/. Locally
the branches are called "remote tracking branches".

3) git pull, w/o arguments, will run git fetch per above. It then
knows (in this example) to merge refs/remotes/origin/master into
refs/heads/topic. (The value on the "merge =" line is arguably
confusing because it is relative to where the branch is stored on the
remote, not where it is stored locally.)

HTH,

j.

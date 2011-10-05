From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 15:02:30 +1100
Message-ID: <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 06:03:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBIhH-0007Jo-UD
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 06:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab1JEEDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 00:03:02 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34364 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab1JEEDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 00:03:01 -0400
Received: by bkbzt4 with SMTP id zt4so1575609bkb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 21:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6/d/x3mYotZDX6V8r9fdejQOX3SJ8um33FtWqvwPHKk=;
        b=gMd9REpNF3p/+C62hSDQv39yoH/YUFfbkre6vmgsemmyP6myJB3uCkwpsDA4v0KsjO
         PVNXwVvHMLpXvv9eDuIMg+7IUXhXPBKpsEaL6TCEhCNp+d4RKZV6/G91hsGxGH5gqpRK
         FMydtsmNlM31p2lpTMklP9cI1TTZQE+fmP3v4=
Received: by 10.204.137.72 with SMTP id v8mr1110167bkt.43.1317787380141; Tue,
 04 Oct 2011 21:03:00 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Tue, 4 Oct 2011 21:02:30 -0700 (PDT)
In-Reply-To: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182823>

On Wed, Oct 5, 2011 at 2:43 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> When using 'git new-workdir', there is no safety mechanism to prevent the
> same branch from being checked out twice, nor to prevent a checked out
> branch from being deleted.
>
> By teaching 'checkout' to record the workdir path using
> 'branch.<name>.checkout' when switching branches, we can easily check if a
> branch is already checked out in another workdir before switching to that
> branch. Similarly, we can now add a check before deleting a branch.
>
> Allow 'checkout -f' to force the checkout and issue a warning
> instead of an error.
>
> Guard this behavior behind 'core.recordCheckouts', which we will
> teach 'git new-workdir' to set in a followup commit.

I've wanted to to something like this, but you beat me to it ;)

Could you please consider a more generic approach? What I have in mind
is a mechanism to "lock" a branch, so that only commands that have the
key can update it.

So instead of branch.<name>.checkout, I would have something like
branch.<name>.locked = <key>, where <key> is just a string. Only
commands that provide the matching <key> are allowed to update the
branch. In checkout case, <key> could be "checkout: worktree".

This approach addresses more cases than just multiple workdir. We
could relax restrictions on pushing to a non-bare repository: we only
disallow pushing to locked branches. We can also use this to prevent
users from checking out another branch (by locking HEAD) while in the
middle of interactive rebase/bisect/...
-- 
Duy

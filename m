X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Sun, 26 Nov 2006 10:35:44 -0500
Message-ID: <9e4733910611260735g2b18e9d1p51a0dca153282cc7@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
	 <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>
	 <456969DA.6090702@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 15:36:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jZ7/lQ0YSzaziGmEiz8cS5xM1LGczqi/H4C0yws0482HUb3FjaCi0amlgtsDJg2J1pAk4Eq0TDXOcaHK5zfsI6nqrkLIM2WTGqB/MT83WQw+jTyyr7ZIG8uo5qPmr4xRFIoAzt3hTdq42UTZAtNp6Kp7QySojufoakfkGgZ4UX4=
In-Reply-To: <456969DA.6090702@gmx.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32352>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoM3S-0000Ob-Nn for gcvg-git@gmane.org; Sun, 26 Nov
 2006 16:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934367AbWKZPgT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 10:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934373AbWKZPgT
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 10:36:19 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:14319 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S934367AbWKZPgS
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 10:36:18 -0500
Received: by py-out-1112.google.com with SMTP id a29so904285pyi for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 07:35:44 -0800 (PST)
Received: by 10.35.75.1 with SMTP id c1mr10892781pyl.1164555344463; Sun, 26
 Nov 2006 07:35:44 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Sun, 26 Nov 2006 07:35:44 -0800 (PST)
To: "Marko Macek" <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

On 11/26/06, Marko Macek <marko.macek@gmx.net> wrote:
> Jon Smirl wrote:
>
> >
> > SVN hides the mini branch by creating a symbol like this:
> >
> > Symbol XXX, change set 70
> > copy All from change set 50
> > copy file A from change set 55
> > copy file B,C from change set 60
> > copy file D from change set 61
> > copy file E,F,G from change set 63
> > copy file H from change set 67
> >
> > It has to do all of those copies because the change sets weren't
> > constructed while taking symbol dependency information into account.
> >
> > Symbol XXX can't copy from change set 69 because commits from after
> > the symbol was created are included in change sets 51-69.
>
> Sometimes it is not actually possible to have a 'simple' symbol, even
> by following proper symbol dependencies.
>
> Some situations:
> - tags on some files are readjusted later, or tagged separately with an older
>  version
> - tag is created with a -D "date" and the file times are not in sync
> - tag is created from a mixed-revision working copy

I agree that there are a few exceptions to making simple symbols. But
the current cvs2svn makes no attempt at all to preserve simple
symbols. In my attempts at converting Mozilla 60% of the symbols ended
up as tiny branches. I investigated a couple by hand and was able to
rearrange things to create simple symbols in every case I looked at.

This can be dealt with during the topological sort. If there are
complex symbol creations you will end up with loops during the sort
process. At that point you need to start breaking up change sets to
remove the loops. You would use a heuristic at this point, something
like try breaking up to ten commit change sets to preserve a symbol,
if you can't preserve it with 10 breaks then break the symbol once and
try again, repeat until the loop is gone.

The current cvs2svn code effectively implements a heuristic when the
commits are always preserved at the expense of breaking the symbols.
Since some commit comments are very common comments (blank ones) those
commits get combined into bigger change sets and trash the simple
symbols.

Another note for doing a converter. When combining things into change
sets, for git import the comments in the branches should not be mixed
between branches and the trunk when detecting change set. Git doesn't
allow simultaneous commits to the trunk and branches.

> While in the cases of 'time warp' the revision sequence should be
> considered more important than timestamps, this is not necessarily
> true for tags, since it's easily possible to create them on mixed
> revisions.
>
> cvs2svn also has a problem with vendor branches because it creates
> tags/branches that contain files from vendor branch by copying some
> files from the trunk and other files from the vendor branch.
> If the vendor branch/tag was only used for the initial import,
> it's IMO best to skip them in the conversion (this needs a patch).
> There are however problems because keyword expansion causes file
> differences.
>
> It seems that mozilla CVS repository has vendor branches/imports in
> some parts of the tree.

I never got around to checking out problems with vendor branches in Mozilla.


>
> Mark
>
>


-- 
Jon Smirl

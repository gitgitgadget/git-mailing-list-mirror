From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 19:17:42 +0700
Message-ID: <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THD2s-0006K2-W4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 14:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab2I0MSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 08:18:13 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56198 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2I0MSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 08:18:12 -0400
Received: by ieak13 with SMTP id k13so4178065iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lskwle1Iq3VhdepAYexupRnyhIuE9bHrOyVltIFVXlA=;
        b=lJUIMppvWERlSYicBVizguu2vpXCJbKeX7hNAmDREaCHfskG1NPN0U5UKFYYXQAFHA
         lcoGggro+iCZPGv+I1ooSHanJ9ofaGFfiGsEIWVXOguhENgubEVHc18hKT1kKFNoV973
         EdrUBWc61vBrcH41QyMOrvrd1HAgwzlIBhowItolI5qxGx9zcM2D+DmX2zREJtDUrFf3
         6ty/9L8jbLgOJK489ZL2eboxQtX80RulgMC5eVdK3ZQ06CqVxf5xx3v8+bL1+fg2jwug
         KlOYwUZJqsBR3bsaSOO+7YTZSCYlJkMU6fX0pO/AEMCwt9pGEOYFa4W+xPeF12Qxm76c
         fFgA==
Received: by 10.50.220.129 with SMTP id pw1mr3812530igc.47.1348748292486; Thu,
 27 Sep 2012 05:18:12 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 27 Sep 2012 05:17:42 -0700 (PDT)
In-Reply-To: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206477>

On Thu, Sep 27, 2012 at 7:47 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Google has published a series of patches (see links below) to JGit to

Should discussions about this series happen in here, jgit mailing or
gerrit? I just want to make sure I'll discuss it at the right place.

> improve fetch and clone performance by adding compressed bitmaps to
> the pack-*.idx structure.
>
> Operation                   Index V2               Index VE003
> Clone                       37530ms (524.06 MiB)     82ms (524.06 MiB)
> Fetch (1 commit back)          75ms                 107ms
> Fetch (10 commits back)       456ms (269.51 KiB)    341ms (265.19 KiB)
> Fetch (100 commits back)      449ms (269.91 KiB)    337ms (267.28 KiB)
> Fetch (1000 commits back)    2229ms ( 14.75 MiB)    189ms ( 14.42 MiB)
> Fetch (10000 commits back)   2177ms ( 16.30 MiB)    254ms ( 15.88 MiB)
> Fetch (100000 commits back) 14340ms (185.83 MiB)   1655ms (189.39 MiB)

Beautiful. And curious, why do 100->1000 and 10000->10000 have such
big leaps in time (V2)?

> The basic gist of the implementation is a bitmap has a 1 bit set for
> each object that is reachable from the commit the bitmap is associated
> with. An index file may have a unique bitmap for hundreds of commits
> in the corresponding pack file. The set of objects to send is
> performed by doing a simple computation:
>
>   OR (all want lines) AND NOT OR (all have lines)
>
> There are two key patches in the series that implement the file format
> change and logic involved:
>
> * https://git.eclipse.org/r/7939
>
>   Defines the new E003 index format and the bit set
>   implementation logic.

I suppose the index format is not set in stone yet? My java-foo is
rusty and I'm not familiar with jgit, so I more likely read things
wrong.

It seems the bitmap data follows directly after regular index content.
I'd like to see some sort of extension mechanism like in
$GIT_DIR/index, so that we don't have to increase pack index version
often. What I have in mind is optional commit cache to speed up
rev-list and merge, which could be stored in pack index too.

In PackIndexVE003 class

+               // Read the bitmaps for the Git types
+               SimpleDataInput dataInput = new SimpleDataInput(fd);
+               this.commits = readBitmap(dataInput);
+               this.trees = readBitmap(dataInput);
+               this.blobs = readBitmap(dataInput);
+               this.tags = readBitmap(dataInput);

Am I correct in saying that you have four different on-disk bitmaps,
one for each object type? If so, for compression efficient reasons?

> :-)

Definitely :-). I have shown my interest in this topic before. So I
should probably say that I'm going to work on this on C Git, but
sllloooowwwly. As this benefits the server side greatly, perhaps a
GitHubber ;-) might want to work on this on C Git, for GitHub itself
of course, and, as a side effect, make the rest of us happy?
-- 
Duy

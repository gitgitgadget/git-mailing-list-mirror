From: Robin Munn <robin.munn@gmail.com>
Subject: Feature request: commit count in git-describe should use a different method
Date: Wed, 4 Nov 2015 12:11:27 +0700
Message-ID: <CAH=MseKsTvcWxLcVE3hdcJd3aXbn1GZA4=9zEyoCSvYT4L=yPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 06:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtqMd-0006Lv-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 06:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbbKDFLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 00:11:30 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33173 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbKDFL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 00:11:29 -0500
Received: by lfbf136 with SMTP id f136so35202175lfb.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 21:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yUb+ryY6zxBu19eVZAwu+Yx1K6dbzG4hDlbJSJzi+TU=;
        b=ts7CSBJAhXx1dkqOodvE+UyHiHMHsgaSRj3VKrT6hbMsKIGwDPJCRHDB4PzN+IcIr1
         rPKlfScL11H0/5vArxF0E4QyrBHeXbwfXmojv829c89TLam7tp0Eh1jlASyYRjqM2icA
         1kk+TC6tZ0SoFuHfXljYrjUNWxa2SVY4LSofFWhno3LNZz6qhGp2MJtuono3Ebbdsjcz
         5yu51z0gn35pcONTBoIsyLyK893wNv6v6EYPCQzt99si4spznFJSiGAZdnWVB0XR2V9H
         c0ZSS6/5eA9JbIG0XBGfEVQfxRXZLFeCczZQp1lKlicGtGgQXbNl4c35BCapYofgSb4L
         YxRg==
X-Received: by 10.25.89.9 with SMTP id n9mr9840664lfb.9.1446613887755; Tue, 03
 Nov 2015 21:11:27 -0800 (PST)
Received: by 10.25.152.133 with HTTP; Tue, 3 Nov 2015 21:11:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280850>

Several people (including me) seem to expect git-describe's commit
count to be calculated differently than how it's actually calculated.
For example, see the following three Stack Overflow questions:

http://stackoverflow.com/questions/31852885/git-describe-inexplicable-commit-count
http://stackoverflow.com/questions/33116182/can-i-change-how-git-describe-counts-commits
http://stackoverflow.com/questions/13568372/commit-count-calculation-in-git-describe

The scenario that all three questions is asking about is the following:

1) I'm working along on a branch whose most recent tag is v1.1,
created 96 commits ago.
2) Someone else merges some work into master, and tags with v1.2. I
want to incorporate their work into my own, so I merge master into my
branch.
3) I now have a branch that is one commit "forward" from tag v1.2. I
therefore expect git-describe to say "v1.2-1-g1234567". Instead, I get
"v1.2-97-g1234567".

Now, git-describe is working precisely as documented here. The
documentation describes the commit count as being "the number of
commits which would be displayed by 'git log (tag commit)..(described
commit)' " and that is indeed what I'm getting. If I do "git log
v1.2..HEAD", there will be 97 log entries, because the latest commit
that is an ancestor of both v1.2 and HEAD is where my branch was
created from master 97 commits ago.

However, this is unexpected behavior for me. I was expecting to get a
commit count of 1, not a commit count of 97. Instead of a count of all
the commits since I forked from master 97 commits ago, I was expecting
a count of all the commits since the tag that git-describe has picked
as the latest tag. In other words, instead of the count to match "git
log v1.2..HEAD", I was expecting the count to match "git log
--ancestry-path v1.2..HEAD".

As shown by the Stack Overflow questions above (one of which is mine),
I am not alone in finding this behavior to be surprising. I would like
to request that git-describe acquire an additional option,
"--ancestry-path", to use the same method as "git log --ancestry-path"
to count commits. I would prefer that this become the default, but I
realize that that might be a breaking change (some people might have
build scripts that relied on git-describe's current behavior).

This is either a bug report or a feature request, depending on how
intended the current commit-count behavior is.

I've reproduced this behavior on both older versions of git (1.9.1)
and recent versions (2.6.2).

-- 
Robin Munn
Robin.Munn@gmail.com
GPG key 0x4543D577

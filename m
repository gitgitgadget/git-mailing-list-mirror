From: "Matt Pearson" <404emailnotfound@gmail.com>
Subject: Re: git-pull sets write bit, git-push does not
Date: Sat, 2 Aug 2008 21:15:53 -0400
Message-ID: <706b4240808021815h68db2179y7ceb35501f7f4f66@mail.gmail.com>
References: <ee521d6f0808021532k66bc5b24ma2eeb51021fb5f36@mail.gmail.com>
	 <706b4240808021618y5604b7c9h915237c30d87dace@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander E Genaud" <alex@genaud.net>
X-From: git-owner@vger.kernel.org Sun Aug 03 03:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPSDW-0001XB-V7
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 03:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbYHCBPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 21:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYHCBPz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 21:15:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:47352 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbYHCBPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 21:15:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so914914ywe.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=v7N7FG2BuNBllQI32psMAA3an6GGyeimV1y8AZx5rVA=;
        b=BSgfZ5Kk8EiZ0Lw5TUSohQ5P4sYDXkrLdydNOXhATM1D4/kDDjNm12WT91Mya1ztoF
         pL2EnuBRcS+qQy55nAIqoF5Tzh60k7r98U16TuIK1O6cjiUNbzl0BpYN3VTPQ5cavSbw
         0M7jo6jDPOjTV4OePY0MWWK1Zhs0RO2m9yjD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gKGQixLYjZOOqiHm+l4vHBwl/OyDJ70NzxiJ5DJsO4d8XULZLTmYsoB+ERi2ewWaRP
         WP+4ifRX6lbz5VCeq2ndX28SkawGfWAAGBVrZBkU675bZ8/VMkpCmivYNz+DeAhM02U8
         1gXfGqxcgrw/qvbdeEAG3SjJqcB9Tir9X2XI4=
Received: by 10.151.46.17 with SMTP id y17mr5814981ybj.120.1217726153428;
        Sat, 02 Aug 2008 18:15:53 -0700 (PDT)
Received: by 10.151.99.15 with HTTP; Sat, 2 Aug 2008 18:15:53 -0700 (PDT)
In-Reply-To: <706b4240808021618y5604b7c9h915237c30d87dace@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91195>

On Sat, Aug 2, 2008 at 7:18 PM, Matt Pearson <404emailnotfound@gmail.com> wrote:
> The working copy in r2 was not updated with the changes you pushed to
> it (both the content and the mode change).

Hm, your test case is more complicated than I originally thought. I
get that result with the git from Ubuntu Hardy, but current master
dies on the pull complaining B is not uptodate (has local changes). I
guess this was a bug that was fixed, but there's no way I'm going to
bisect or look at release notes over half a year (or more) of changes
:)

What it mainly comes down to is that git has only two possible file
modes: 644 and 755. These are the only ones that will ever be stored
in the object database. It seems like older git would ignore
permission changes to the working copy, and reset the permissions to
the "normalized" version when updating a file that was modified by the
pull.

Here's a blow-by-blow explanation. I'll use numbers to refer to the
commits, where 1 is the initial commit, 2 is the commit you pushed,
and 3 is the one you pulled. After the cp -r, both repos have a clean
working tree; the chmod dirties the working tree of r2.

The push causes both repos to have 2 be the HEAD commit, but r2 keeps
the dirty working tree changes, including (what now appears to be,
from git's POV) a change in the content of A from 'AA' to the 'A' in
the initial commit. (The content change will appear as a staged change
when running status in r2, because the index isn't updated either)

When pulling 3, git thinks that these changes were made on top of 2,
and you want to keep them. So it doesn't modify the contents of A
because A was not changed in commit 3---if it was, you'd get a "not
uptodate" message.

B, however, *was* changed in 3, so it tries to apply those changes.
With the older version, it seems to ignore the permissions change and
simply fast-forward to the state B was in after commit 3 (content
'BB', mode 644). With the newer version, it does see that the mode has
been changed, and aborts due to a conflict. In fact, it doesn't seem
to like any mode change---it still dies with a conflict if I change
the chmod to 'a+x'.

Hope that clears it up better---figuring this out helped me learn some
stuff about git. Now I'll wait for someone more knowledgeable than I
to tell me I'm wrong. :)

Matt

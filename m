From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Wed, 14 Sep 2011 22:19:39 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109122139110.12564@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com> <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com> <alpine.DEB.2.00.1109082123300.12564@debian> <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com> <alpine.DEB.2.00.1109090900301.12564@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Francis Moreau <francis.moro@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 04:25:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41e7-0005KJ-D9
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab1IOCZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:25:40 -0400
Received: from mail-vw0-f45.google.com ([209.85.212.45]:49483 "EHLO
	mail-vw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1IOCZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:25:39 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Sep 2011 22:25:39 EDT
Received: by vws17 with SMTP id 17so3800035vws.4
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=mhXTOXppGOA/w0H3Dg+YZreSKtmDH6fUpk38WR49meU=;
        b=xAW+vg/Z4PWenEYrcnSCl1Zh8ZUp6CpHJXa2yBN0MUPQ//4iu7/lo18oGWPie3hIzC
         mOYnq8+JK/niBrhlNKLzB7hwcc4KQb6Hpz5MZ1JXq/Q5YTlKviR2b+Bh31VuQuSkOBsC
         HjNncvOCthlZ19v5CyDe8bzjgjk1aBGZycb7Q=
Received: by 10.52.38.200 with SMTP id i8mr460696vdk.355.1316053183529;
        Wed, 14 Sep 2011 19:19:43 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca. [24.37.77.94])
        by mx.google.com with ESMTPS id bd20sm4120359vdc.8.2011.09.14.19.19.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:19:41 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1109090900301.12564@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181427>

On Fri, 9 Sep 2011, Martin von Zweigbergk wrote:

> On Fri, 9 Sep 2011, Francis Moreau wrote:
> 
> > please let me know when you submitting your work, I'm interested to see it.
> 
> Will do. It's not really that much work [...]

It seems to be a little less straight-forward than I had first
expected.

We want to get all commits in $oldbase..$branch that do not share
patch-id with commits in $oldbase..$newbase. These are the commits
prefixed by '+' in 'git cherry $newbase $branch $oldbase'. However,
just getting the list of commits is not enough, because we currently
don't explicitly provide a list of commits to create patches from, but
instead run something like 'git format-patch --ignore-if-in-upstream
--stdout | git am --rebasing'.

I can see a few different solutions.

 1. Teach git-format-patch a --stdin option that makes it read the
    list of commits from the command line. git-format-patch currently
    itself walks the history, so I'm not sure how such an option
    should interact with current option. The options should probably
    be mutually exclusive.

 2. Somehow modify git-rebase--am.sh not to depend on format-patch. In
    [1], Junio mentions rewriting git-rebase--am.sh "to have
    format-patch avoid the cost of actually generating the patch text"
    and "when using "am" for rebasing we do not really care anything
    but the commit object names". If all we need is the commit name,
    why would we not use cherry-pick/sequencer instead of git-am?
    Sorry if this makes no sense; I'm not familiar with the git-am
    code.

 3. If I'm reading the code correctly, 'git cherry $upstream $branch
    $limit' does one walk to find patch-ids for "$upstream
    ^$branch". It then walks "$branch ^$upstream ^$limit" and removes
    the commits that have the same patch-id as a commit found in the
    first walk. Since format-patch uses the revision walking
    machinery, we could make it possible to ask git-rev-list directly
    what git-cherry does, i.e. to ask for "commits in a..b that don't
    share patch-id with commits in c..d". We could even make it more
    generic by allowing queries like "commits in
    $rev_list_expression_1 that don't share patch-id with commits in
    $rev_list_expression_2".

I'm not sure which option is better. Option 1 seems easiest to
implement. Option 3 seems a bit harder, but may bring more value. I'm
just not sure if teaching rev-list about patch-ids is generally useful
or if it would feel more like a hack for this specific case. Option 2
is less clear to me and I would probably need more input before
implementing, but I trust Junio that it would be a good long-term
solution.

I will be moving soon and I don't know how much time I will have to
implement any of this. Still, I would be happy to hear your
opinions. Maybe I'm just missing something and there is even a simple
solution to my problem.


Martin


[1] http://thread.gmane.org/gmane.comp.version-control.git/180976/focus=181085

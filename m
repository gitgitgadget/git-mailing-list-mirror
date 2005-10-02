From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.7
Date: Sun, 2 Oct 2005 20:33:54 +0100
Message-ID: <b0943d9e0510021233n39daa5bao@mail.gmail.com>
References: <1128244627.9740.6.camel@localhost.localdomain>
	 <20051002121059.GA32367@elte.hu>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 02 21:35:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM9b1-0004C4-UW
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 21:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVJBTdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVJBTdz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 15:33:55 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:11882 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750953AbVJBTdz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 15:33:55 -0400
Received: by xproxy.gmail.com with SMTP id t15so126074wxc
        for <git@vger.kernel.org>; Sun, 02 Oct 2005 12:33:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C/aJj52n0HyCFiYRTFRtVKoZ/ul5zP2JGaPJr0lY23J6lyK2N8DhJc6V+3QOCg3BewoXtqjzS9lj1vvlLDvOcJu4mYcB2FmVml3F2US5XgXrNUFiOYMyA0numYpJrZ4C9unxRaQRbRbsa9araOnq1mPS9uQkqOU3fGdPv0ajsEI=
Received: by 10.70.62.13 with SMTP id k13mr1472778wxa;
        Sun, 02 Oct 2005 12:33:54 -0700 (PDT)
Received: by 10.70.31.3 with HTTP; Sun, 2 Oct 2005 12:33:54 -0700 (PDT)
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051002121059.GA32367@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9621>

On 02/10/05, Ingo Molnar <mingo@elte.hu> wrote:
> i'm wondering - have you (or anyone else) done performance comparisons
> of quilt vs. stgit, using the same stack of patches? One of the most
> important features of quilt (for me) is that it's very fast at
> popping/pushing through hundreds of patches.

I've done some basic comparison and I must admit that Quilt is much
faster than StGIT. Popping is done in O(1) and it is equivalent to a
switch between two branches with 'git checkout' (can be less than 2
seconds with warm caches). Pushing without merging required (i.e.
fast-forwarding) is the same as popping.

What's time consuming is pushing when the base of the stack was
changed and merging is required. If the base changes do not involve
file removals/additions, a push operations takes ~1.5s per patch with
warm caches. Most of the time is spent in "git-read-tree -m" (StGIT
doesn't consume resources since it mainly calls GIT tools). If the
base changes involve file removals/additions, it can take considerably
longer since for each file GIT needs to call an external merger. This
could be solved by providing a smarter git-merge-index to deal with
file removals/additions but the time won't be shorter than ~1.5s per
patch.

An optimisation would be to keep the patches in diff format and apply
them but this would mean losing the advantages of the three-way
merging. Another issue is that git-apply doesn't support fuzzy
patches, though I could emulate it using patch. But I'm not sure
that's a good approach since I don't intend to re-write Quilt in
Python. My hope is that git-read-tree will get faster :-).

--
Catalin

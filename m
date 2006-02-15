From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 17:12:55 +0000
Message-ID: <b0943d9e0602150912h55fb87d0r@mail.gmail.com>
References: <20060210195914.GA1350@spearce.org> <tnxy80fe2zo.fsf@arm.com>
	 <20060214045618.GA12844@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Feb 15 18:13:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9QDO-0005Aj-B2
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 18:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946037AbWBORNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 12:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946038AbWBORNP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 12:13:15 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:39647 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946037AbWBORNP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 12:13:15 -0500
Received: by xproxy.gmail.com with SMTP id h30so1054995wxd
        for <git@vger.kernel.org>; Wed, 15 Feb 2006 09:13:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1DEVKnmSI5s9JAYTl8FV0bzAM+lY4jnRcOCeGqPz36mxtu7WaoQV0h/0oVKDXDj1Q03nIJOw8bTu1aU4OusUonQC+62OoCbeae9MLL6pO+Im0ei/E6UvNRWN/TqEk4uoWOEU34NmIENKtdZ+keNNcOCCT9I1ldMov0IC+FT0Xw=
Received: by 10.70.113.20 with SMTP id l20mr304517wxc;
        Wed, 15 Feb 2006 09:12:55 -0800 (PST)
Received: by 10.70.53.7 with HTTP; Wed, 15 Feb 2006 09:12:55 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060214045618.GA12844@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16247>

On 14/02/06, Shawn Pearce <spearce@spearce.org> wrote:
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > - Automatic detection (and cancellation) of returning patches.
[...]
> > StGIT has been doing this from the beginning. You would need to run a
> > 'stg clean' after a rebase (or push). I prefer to run this command
> > manually so that 'stg series -e' would show the empty patches and let
> > me decided what to do with them.
>
> Actually StGIT didn't do this correctly for one of my use cases
> and that's one of the things that drove me to trying to write pg
> (because I wondered if there was a way to resolve it automatically).
> Try building a patch series such as:
[...]
> StGIT seemed to not handle this when it tried to reapply the two
> already applied patches.  A won't apply because the file coming
> down is actually A+B, not A's predecessor and not A.  B won't apply
> because the file also isn't A (B's predecessor).

You are right, if two patches modify the same line and both were
merged upstream, the three-way merging would report a conflict for the
first patch and maybe the second (depending on how the first conflict
was resolved).

> pg resolves this by attempting to automatically fold patches during
> a pg-rebase (equiv. of stg pull).  If a patch fails to push cleanly
> and there's another patch immediately behind it which also should
> be reapplied pg aborts and retries pushing the combination of the
> patches.  This fixes my A+B case quite nicely during a rebase.  :-)

But what would happen if there was a third-party patch that's
modifying the same line? A+B application would fail in this case. Does
pg go back to only apply A and report a conflict?

There is another problem with this approach if you have tens of
patches. Would pg try to fold all of them?

Some time ago I had a look at Darcs and its patch theory (patch
commuting). Their approach to conflicts was to include the conflicts
in patch A and propagate them to the last patch to be merged. It's
like creating two versions of the conflicting hunk, one of them
corresponding to the local tree (that in patch A) and the other to the
upstream tree. Merging patch B is only done in the local hunk in the
end both conflicting hunks would be identical and one of them removed.

While the above algrithm seems to work OK in Darcs (but quite resource
intensive), it's pretty hard to implement and I don't think it's worth
for a small number of cases this could occur.

--
Catalin

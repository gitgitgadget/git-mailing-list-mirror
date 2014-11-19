From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 21:48:21 +0100
Message-ID: <1615472.VQOo6NAl26@al>
References: <6997784.RuzRO1AFsK@al> <1456931.yaNzKr1t0X@al> <20141119201721.GC10361@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCB1-00046O-JV
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbaKSUs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:48:28 -0500
Received: from lekensteyn.nl ([178.21.112.251]:38949 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756610AbaKSUs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=Y78ovFIzNQBuuSombhHTGP7WsAjyoISusFcQWT1godY=;
	b=AWz03p0Gc7lHGv+RfIPyUFdicwZSZD1vNeeUvu5th2Dgf/q2z4AsA4ZUDF/f3QxzZzw7xbUuritceo3ahyAsrG06ABJHrt9sOH+lM2ilrjVFqGvlg1v5tp7c6x9kX1hT4PePUtBSnup2bNJxuKzDAEJ54fH9dwQrEcPsUr52xn4cqzWgrKBhMrphgLYVubOYUB09S/xM6gz3gqqy6RHofvFfnl/gX2VeppHl5umsG3I99coOdft2pPnOw2ikeFphsjLa3kZSjCuaheMRo8HVKpzasMIGirIkk7SdCvQ0XE04EAaGjIrcDe+fXhysta/6oXXM8WhH++RM4I+CG7BYTg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XrCAo-0008M8-GL; Wed, 19 Nov 2014 21:48:22 +0100
User-Agent: KMail/4.13.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.2; x86_64; ; )
In-Reply-To: <20141119201721.GC10361@peff.net>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 19 November 2014 15:17:21 Jeff King wrote:
> On Wed, Nov 19, 2014 at 08:42:19PM +0100, Peter Wu wrote:
> >     git remote set-url --fetch new-fetch-url
> > 
> > This is less verbose and is much more intuitive.
> 
> I agree your suggestion is a nicer way to do this. I'm just not sure
> that this swapping is all that common an operation. If there were no
> cost, I wouldn't mind. But I'm mostly concerned about the funny,
> non-intuitive behavior of "git remote set-url foo" that is created by
> this.

It is not about swapping, but setting a new fetch while keeping the push
URL intact. Likely not common, but nice to have for the times it is
needed. I am sure there are other features which are not used a lot, but
still exist ;)

> > > would replace both the "url" _and_ "pushurl" values in the third step,
> > > since we did not specify --fetch.  But it is in fact identical whether
> > > you run it with "--fetch" or not.  That is, it creates a weirdly
> > > non-orthogonal interface.
> > 
> > Step three currently only replaces the fetch URL as an explicit push URL
> > (remote.gh.pushurl) is set in step two (and therefore remote.gh.url does
> > not become the implicit push URL).
> > 
> > This might be a bug, but since it has been so long this way I was
> > worried that people actually rely on this behavior.
> 
> I don't think this is a bug. I think that "git fetch set-url" without
> "--push" is a de-facto "--fetch" already. Which makes sense, as there
> isn't a "--fetch" now (and the "--push" variant and "pushurl" grew after
> the fact, so the "url" option serves double-duty as both the single url
> and the "fetch" half).
> 
> And that's what makes the proposed interface funny. Omitting "--fetch"
> is already a de-facto "--fetch", and sometimes the two behave the same,
> and sometimes differently. Calling the option "--keep-push" would be a
> more accurate description, but that is rather clunky.
 
Before this patch I did not even know that "git remote set-url name url"
would have different user-visible behavior depending on whether a
pushurl is set or not. In my opinion, the proposed functionality does
not make the interface more confusing. Instead, the new option establish
a behavior which is consistent with the existing '--push' name.

(Aside, I intended to name this option "--pull" which seemed more
natural given the opposite direction "--push", but decided to stay
consistent with the "git remote show" terminology.)

I think that your confusion is caused by the meaning of '--push' and
'--fetch'. These options form a group and are not as independent as
"--add". Something like "--change=[push|fetch|all]" would describe the
functionality better:

    git remote set-url --change=fetch gh fetchurl

But then the "--push" option becomes redundant.
-- 
Kind regards,
Peter
https://lekensteyn.nl

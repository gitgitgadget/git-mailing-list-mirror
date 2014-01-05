From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 22:27:19 +0100
Message-ID: <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Jan 05 22:27:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzvEV-0002MO-SU
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 22:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbaAEV1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 16:27:40 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52202 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaAEV1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 16:27:39 -0500
Received: by mail-ob0-f174.google.com with SMTP id wn1so17626524obc.33
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 13:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vBcaXDiR4F0H5Rd1PMk4DgBuTTXbwwg0tswWCwbkxaE=;
        b=Fcb5U2eW+H2Vusd1zF2d7ts6PRqNwf+/p2iLpxdI0MPfnE2W+QHBSQA4uf/xWoeupU
         LGxgSjWMmug6B+NG36IsOHksbLmDd3Nol90mGGiOH+dyIn1WrUEduE0PWxJ/6VRDI1aG
         OXT0YX2VmfFNTZs+AHrugM9hTcuGurWhG2tFZTY+YERa3nvRTOFlRLmzXlHWKtOo0vgk
         TzGHJStzwPBZn8Y0Md04y5TP7WPNmOd+eJC/vWH7aIlhn0MmdR1BVuzkzhL5z+b6rvFW
         Fh6v4kDj9vi6ZNn4Wle63w/UHKnsDft10gqodk7wT50MPchlQYmL5Kqnwe7zVEyrQrMT
         bwIA==
X-Received: by 10.182.29.33 with SMTP id g1mr129579obh.59.1388957259281; Sun,
 05 Jan 2014 13:27:39 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Sun, 5 Jan 2014 13:27:19 -0800 (PST)
In-Reply-To: <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239974>

2014/1/5 W. Trevor King <wking@tremily.us>:
> On Sun, Jan 05, 2014 at 04:53:12AM +0100, Francesco Pretto wrote:
>> Also it could break some users that rely on the current behavior.
>
> The current code always has a detached HEAD after an initial-clone
> update, regardless of submodule.<name>.update, which doesn't match
> those docs either.

I perfectly agree with you that the documentation is a bit
contradictory with regard to "update" command and detached HEAD.
That's why it's so hard to add a feature and keep the same spirit of
those that coded submodules at first. Also, I think that submodules
didn't get much feedback with regards to these pitfalls because many
people try to setup them, they see that "update" detaches the HEAD and
they think "hmmm, maybe submodules are not what I was looking for".

> Adding a check to only checkout
> submodule.<name>.branch if submodule.<name>.update was 'rebase',
> 'merge', or 'none' would be easy, but I don't think that makes much
> sense.  I can't see any reason for folks who specify
> submodule.<name>.branch to prefer a detached HEAD over a local branch
> matching the remote branch's name.

I think the reason is that it still matches the original use case of
submodules devs:
- the maintainer decides the specific commit developers should have;
- developers checkout that commit and don't pull (you can't do "git
pull" in a detached HEAD);
- they optionally get the upstream commit from the specified
"submodule.<name>.branch" with "--remote". They are still in a
detached HEAD and can't do "git pull".

Maybe who coded submodules at first was thinking that the best way to
contribute to a project is to checkout that repository, and not work
in the submodule. As said, this works well when the submodule
repository is a full project, and not a bunch of shared code.

> If they prefer checkout updates,
> the first such update will return them to a detached HEAD.  If they
> prefer merge/rebase updates, future updates will keep them on the same
> branch.  All my commit does is setup that initial branch for folks who
> get the submodule via 'update', in the same way it's currently setup
> for folks who get the submodule via 'add'.
>

My patch is in the same spirit but wants to obtain the same by being
100% additive and by not altering existing behavior in any way. Also
it covers:
- an "autoremote" behavior when the user wants an attached HEAD: with
your patch "--remote" is still needed to really update the branch with
"git submodule update":
- voluntary reattach/detach the HEAD with command line;
- ff-only merge of changes in the case of "checkout" in an attached
HEAD (doing "git checkout <branch>" is not enough);
- reattach of the HEAD with orphaned commits.

Unfortunately our patches are already a bit colliding. I'll wait for
other comments from git maintainers and let see. Anyway, I'm happy
because things are moving: after this debate git submodules will be
better for sure.

Cheers,
Francesco

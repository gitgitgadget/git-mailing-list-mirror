From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 08:02:31 -0700
Message-ID: <20080924150231.GO3669@spearce.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com> <20080923165247.GO21650@dpotapov.dyndns.org> <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com> <20080924140358.GX21650@dpotapov.dyndns.org> <81b0412b0809240742g2918b300h9114579c4ebf05b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:08:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVu0-0005on-Uy
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYIXPCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbYIXPCc
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:02:32 -0400
Received: from george.spearce.org ([209.20.77.23]:34193 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYIXPCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:02:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1DD9A3835F; Wed, 24 Sep 2008 15:02:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0809240742g2918b300h9114579c4ebf05b4@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96643>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 2008/9/24 Dmitry Potapov <dpotapov@gmail.com>:
> 
> > Frankly, I don't have strong preference here neither for making this
> > fast version always work nor leave it conditional (perhaps, with the
> > default setting use-fast-version). So, whatever the majority decides
> > is fine with me.
> 
> I'm voting for compile-time configuration then.

To be consistent with everything else, compile-time sounds like
what we should do, its how just about every other part of Git
is configured.

However Dmitry pointed out that he has cases where this faster
function doesn't work correctly, and it was path specific.  Some
areas of the filesystem work, others don't, on the same system.
A current example of a feature more like this is core.filemode.

A compile-time option makes the feature useful only to those users
who don't ever have a repository which has a mount contained within
the working directory.  My understanding of Dmitry's explanation
is he has such cases, which is why I was voting for a runtime
configuration.

A compile-time option means that Git will work fine for years, until
you put a mount in a working directory and *wham* it suddenly stops
working like it should, because of that compile-time optimization
you made long ago and forgot about.
 
> >> Besides it will remove your setup code, which looks bigger and provoked
> >> more discussion than the real subject itself.
> >
> > I believe Shawn wanted it to be configurable on per-repository basis.
> 
> which, I believe, is pointless.

See above.  I suggested configurable per-repository because
Dmitry seemed to be saying this feature only works in some of his
repositories and not others.  Controlling it by an environment
variable isn't very easy to use as you move between repositories
on the same system.

Maybe I should have leaned more towards compile-time earlier in
the discussion, but Dmitry lead off the patch though with a remark
about users just running the Cygwin package, without building
their own Git.  We can't expect the Cygwin maintainers to enable
a feature in a software package that makes it work on 90% of the
Cygwin installs out there; that's just asking for trouble.

But we can compile in a user-configurable switch, where the user can
shoot their own foot off in the name of speed, especially if they
can easily disable it on the oddball repositories where it fails.

Of course it might be even better if the code could auto-sense
when its busted and just switch itself off.  E.g. if four or
more consecutive "fast" stat calls fail but the original Cygwin
call succeeds then just always use Cygwin calls for the rest of
the process.

-- 
Shawn.

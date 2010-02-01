From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Mon, 1 Feb 2010 08:01:41 -0800
Message-ID: <20100201160141.GG8916@spearce.org>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com> <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org> <20100201152010.GC8916@spearce.org> <6f8b45101002010750t5541faefv5b4640dfb9949306@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arun Raghavan <ford_prefect@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 17:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbyoZ-0000Ph-8q
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 17:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab0BAQHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 11:07:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:22727 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab0BAQHo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 11:07:44 -0500
Received: by qw-out-2122.google.com with SMTP id 8so804030qwh.37
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 08:07:44 -0800 (PST)
Received: by 10.224.22.132 with SMTP id n4mr2065645qab.176.1265040104693;
        Mon, 01 Feb 2010 08:01:44 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm3858566qyk.5.2010.02.01.08.01.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 08:01:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6f8b45101002010750t5541faefv5b4640dfb9949306@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138618>

Arun Raghavan <ford_prefect@gentoo.org> wrote:
> On 1 February 2010 20:50, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Arun Raghavan <ford_prefect@gentoo.org> wrote:
> >> This patch set reintroduces the post-upload-pack hook and adds a
> >> pre-upload-pack hook. These are now only built if 'ALLOW_INSECURE_HOOKS' is set
> >> at build time. The idea is that only system administrators who need this
> >> functionality and are sure the potential insecurity is not relevant to their
> >> system will enable it.
> >
> > *sigh*
> >
> > I guess this is better, having it off by default, but allowing an
> > administrator who needs this feature to build a custom package.
> >
> > Unfortunately... I'm sure some distro out there is going to think
> > they know how to compile Git better than we do, and enable this by
> > default, exposing their users to a security hole. ?Ask the OpenSSL
> > project about how well distros package code... ?:-\
> >
> > I'd like a bit more than just a compile time flag.
> 
> I was hoping the all-caps INSECURE in the name would give
> distributors pause. :)
> 
> Suggestions on what else might work?

At one point we were talking about checking the owner of the hook
script itself.  If it was uid 0 or the current actual user uid,
then we run the hook, otherwise we don't.

That only really works on POSIX platforms, but it does make some
sense.  Root can already screw with you by replacing the binary
you are executing, so any hook they own is no more risky than the
git-upload-pack you just started.

If its the actual user uid, then systems like gitosis can still
make use of the hook by making the hook owned by the "git" user
that gitosis is executing all sessions under.

But mixed user systems, the hook would only run for the user who
created it, and be skipped for everyone else.

I'm not really sure what to do on Win32 here.  Everyone is usually
Administrator these days which makes the test for "root" there
somewhat pointless.  Maybe its just not enabled on Win32.


> >> At some point if the future, if needed, this could also be made a part of the
> >> negotiation between the client and server.
> >
> > I'm not sure I follow.
> >
> > Are you proposing the server advertises that it wants to run hooks,
> > and lets the client decide whether or not they should be executed?
> 
> Something like that. I was thinking the client could always advertise
> whether the it wants to allow the hooks to be executed or not (which
> would override the default value of the global variable I introduced).
> Either approach would work, though the second is simpler but also
> dumber.
> 
> Again, this might be over-complicating things, which is why I did not
> implement it. I just wanted to make a note of the fact that this could
> be done if the need is felt.

My concern with this is, users might disable the hook all of the
time, and then servers that actually want the hook (e.g. gentoo's
use of the pre-upload-pack to avoid initial clones over git://)
would be stuck, just like they are today.

No, its just not sane to give the user a choice whether or not they
should execute something remotely.

-- 
Shawn.

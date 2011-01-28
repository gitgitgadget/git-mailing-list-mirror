From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 06:37:22 -0800
Message-ID: <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org> <4D42878E.2020502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Hawley <warthog19@eaglescrag.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 28 15:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PipSR-0007Vf-06
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 15:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab1A1Ohp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 09:37:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55683 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab1A1Oho convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 09:37:44 -0500
Received: by fxm20 with SMTP id 20so3399564fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 06:37:43 -0800 (PST)
Received: by 10.223.120.193 with SMTP id e1mr2431202far.106.1296225462877;
 Fri, 28 Jan 2011 06:37:42 -0800 (PST)
Received: by 10.223.70.205 with HTTP; Fri, 28 Jan 2011 06:37:22 -0800 (PST)
In-Reply-To: <4D42878E.2020502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165616>

On Fri, Jan 28, 2011 at 01:08, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 1/28/2011 9:06, schrieb Shawn O. Pearce:
>> A cache pack is all objects reachable from a single commit that is
>> part of the project's stable history and won't disappear, and is
>> accessible to all readers of the repository. =A0By containing only t=
hat
>> commit and its contents, if the commit is reached from a reference w=
e
>> know immediately that the entire pack is also reachable. =A0To help
>> ensure this is true, the --create-cache flag looks for a commit alon=
g
>> refs/heads and refs/tags that is at least 1 month old, working under
>> the assumption that a commit this old won't be rebased or pruned.
>
> In one of my repositories, I have two stable branches and a good scor=
e of
> topic branches of various ages (a few hours up to two years 8). The t=
opic
> branches will either be dropped eventually, or rebased.
>
> What are the odds that this choice of a tip commit picks one that is =
in a
> topic branch? Or is there no point in using --create-cache in a repos=
itory
> like this?

Argh, you are right.  Its quite likely this would pick a topic
branch... and that isn't really what is desired.

My original concept here was for distribution point repositories,
which are less likely to have these topic branches that will rebase
and disappear.  Though git.git has one called "pu".  *sigh*

A simple fix is to use --heads --tags by default like I do here, but
make the actual parameters we feed to rev-list configurable.  A
repository owner could select only the master branch as input to
rev-list, making it less likely the topic branches would be
considered.  Unfortunately that requires direct access to the
repository.  It fails for a site like GitHub, where you don't manage
the repository at all.

git.git also is problematic because of the man, html and todo
branches.  Branches that are disconnected from the main history but
are very small (e.g. todo) might be selected instead and create a
nearly useless cache file.  Fortunately disconnected branches could
each have their own cache file (with only the inode overhead of having
an additional 3 files per disconnected branch), and pack-objects could
concat all of those packs together when sending.  Its just a challenge
to identify these branches and keep them from being used for that main
project pack.


This started because I was looking for a way to speed up clones coming
from a JGit server.  Cloning the linux-2.6 repository is painful, it
takes a long time to enumerate the 1.8 million objects.  So I tried
adding a cached list of objects reachable from a given commit, which
speeds up the enumeration phase, but JGit still needs to allocate all
of the working set to track those objects, then go find them in packs
and slice out each compressed form and reformat the headers on the
wire.  Its a lot of redundant work when your kernel repository has
360MB of data that you know a client needs if they have asked for your
master branch with no "have" set.

Later I realized, we can get rid of that cached list of objects and
just use the pack itself.  Its far cleaner, as there is no redundant
cache.  But either way (object list or pack) its a bit of a challenge
to automatically identify the right starting points to use.  Linus
Torvalds' linux-2.6 repository is the perfect case for the RFC I
posted, its one branch with all of the history, and it never rewinds.
But maybe Linus is just very unique in this world.  :-)

--=20
Shawn.

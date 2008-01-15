From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: How to structure a project distributed with varyingly
	interdependent feature branches?
Date: Tue, 15 Jan 2008 14:02:08 -0500
Message-ID: <1200423728.3865.69.camel@localhost>
References: <1199139613.2360.83.camel@localhost>
	 <7vwsqrvpur.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:04:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEr5B-0001PT-Fu
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 20:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYAOTDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2008 14:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYAOTDn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 14:03:43 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:43026 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbYAOTDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 14:03:42 -0500
Received: from jankymail-a2.g.dreamhost.com (sd-green-bigip-66.dreamhost.com [208.97.132.66])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E44A417A3EF
	for <git@vger.kernel.org>; Tue, 15 Jan 2008 11:03:41 -0800 (PST)
Received: from [192.168.1.46] (pool-71-163-191-46.washdc.east.verizon.net [71.163.191.46])
	by jankymail-a2.g.dreamhost.com (Postfix) with ESMTP id 0CA43B6A72;
	Tue, 15 Jan 2008 11:02:09 -0800 (PST)
In-Reply-To: <7vwsqrvpur.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.21.3 (2.21.3-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70541>

Junio, thanks for the response.  I am finally getting around to
following up.

On Wed, 2008-01-02 at 14:12 -0800, Junio C Hamano wrote:=20
> > 1. How to properly represent the history of an individual branch an=
d
> > update it when the trunk (or the branch on which it depends) change=
s.
> > Right now, Wayne updates the branch by rebasing; unfortunately, if =
the
> > trunk changes in such a way that one of the intermediate commits no
> > longer makes sense, it is impossible to update the branch while
> > preserving a record that the intermediate commit once existed.
>=20
> I take this to mean a situation like this:
>=20
>  * There is a series of patch X Y Z that implements some nicety
>    not present in the mainline yet.  This set applies to older
>    codebase at point A.
>=20
>  * Newer codebase B does things differently from codebase A and
>    patch X is no longer needed --- IOW, what X achieves on top
>    of A has already been incorporated somewhere between A and B.
>    Applying Y and Z suffices to obtain that nice feature on top
>    of B.

Actually, I was thinking of a change to the mainline that causes a
conflict with the patch series.  For example, my repository of git was
at point A when I made the first draft X of my "gitweb: snapshot
cleanups & support for offering multiple formats" change.  Then I
updated my repository and got commit B, "gitweb.perl - Optionally send
archives as .zip files", among others.  When I rebased X on top of the
new master C, there was a conflict, which I resolved to produce X':

     X                   X'
    /                   /
---A---...---B---...---C

But now, with refs only to C and X', I have lost the information that
the previous incarnation of X' was X.

Essentially, my objection to rebasing is that I want to keep a history
for the patch series containing all of the patched versions that I have
released (here X and X'), especially when they differ in interesting
ways (i.e., conflict resolutions), and this history should be a
first-class object that others can pull from me via the git remote
system.

I only want to use a separate patch management tool if it is integrated
with git.  I have some familiarity with StGIT, and I assume guilt is
similar.  StGIT uses rebasing and keeps an additional "patch changelog"
viewable by "stg log" which might seem to be what I want.  The trouble
is that this changelog behaves more like a reflog than an orderly
history, and "stg refresh" does not support storing a user-entered
message describing *the change to the patch* in the patch changelog.
One option I am considering is to use StGIT and track some subset of th=
e
StGIT area itself=EF=BB=BF (.git/patches) in git.

The other approach is to maintain the feature patches/branches by
merging instead of rebasing.  This has two significant advantages: patc=
h
history is naturally kept and the full power of git's distributed merge
is available.  However, it also has two significant disadvantages: the
complaint by Linus about "useless merges" mentioned in the git-rerere
manpage applies, and it's impossible to fully revert a merge (the
ancestry remains and will cause trouble if the merge is redone later).

Matt

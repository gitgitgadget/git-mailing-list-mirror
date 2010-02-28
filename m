From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/9] revert: add --ff option to allow fast forward when cherry-picking
Date: Sun, 28 Feb 2010 23:22:54 +0100
Message-ID: <201002282322.54856.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org> <20100205231112.3689.67634.chriscool@tuxfamily.org> <7vpr4jnsm9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:23:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrXp-0006Rr-M1
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032160Ab0B1WXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:23:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48660 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032135Ab0B1WXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:23:07 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1006E8180DC;
	Sun, 28 Feb 2010 23:22:57 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 27B11818043;
	Sun, 28 Feb 2010 23:22:55 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vpr4jnsm9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141284>

On Saturday 06 February 2010 00:57:18 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > As "git merge" fast forwards if possible, it seems sensible to
> > have such a feature for "git cherry-pick" too, especially as it
> > could be used in git-rebase--interactive.sh.
> >
> >
> > +	if (!(flags & PICK_REVERSE) && ff_ok && commit->parents) {
> > +		unsigned char head_sha1[20];
> > +		if (get_sha1("HEAD", head_sha1))
> > +			die("You do not have a valid HEAD.");
> > +		if (!hashcmp(commit->parents->item->object.sha1, head_sha1)) {
> > +			char *hex = sha1_to_hex(commit->object.sha1);
> 
> With this check, you are saying:
> 
> 	If we are cherry-picking commit $C, and if the current HEAD is
>         the first parent of $C, then just reset to $C instead of running a
>         cherry-pick.
> 
> I didn't check if you have access to commit->parents->item->object.sha1 at
> this point in the codepath, though (e.g. have you parsed "commit" yet?).

Yes it is parsed by the call to lookup_commit_reference() in parse_args().

> If the goal is to make untouched 'pick' in rebase-i to fast forward
> without actually running cherry-picking, perhaps it is much cleaner to do
> this kind of comparison in the caller of cherry-pick (i.e. rebase-i and
> anything that runs cherry-pick)?

At least Daniel Barkalow and Paolo Bonzini have stated before that they would 
find natural that git cherry-pick itself can fast forward.

The argument in the commit message is that as "git merge" can and does fast 
forward by default it seems strange that "git cherry-pick" cannot fast 
forward. It's not just because rebase-i tries to fast forward, as I think it 
is just simpler to fast forward if possible when using cherry-pick by hand.

> The whole series is titled as if "cherry-pick --ff" is the primary goal,
> but I am puzzled why earlier patches in the series were necessary for this
> change.

Earlier patches are just refactoring and making the needed functions extern to 
make the implementation of cherry-pick --ff possible and clean.

> One more thing, in the same part of the code:
> >> +	if (!(flags & PICK_REVERSE) && ff_ok && commit->parents) {
> >> +		unsigned char head_sha1[20];
> >> +		if (get_sha1("HEAD", head_sha1))
> >> +			die("You do not have a valid HEAD.");
> >> +		if (!hashcmp(commit->parents->item->object.sha1, head_sha1)) {
> >> +			char *hex = sha1_to_hex(commit->object.sha1);
> 
> Is there a need to check commit->parents->next?
> 
> Should this code work the same way if the commit being cherry-picked is a
> merge?  Should "-m <parent-num>" option affect this codepath in any way?

Yeah I had not even checked what happens with merge commits and/or "-m 
<parent-num>". The next version of the patch series takes care of that.

Thanks,
Christian.

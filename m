From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git commit -v does not removes the patch
Date: Sat, 22 Nov 2008 16:55:41 +0100
Message-ID: <20081122155541.GC6885@neumann>
References: <20081110181023.GA22753@coredump.intra.peff.net>
	<adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
	<7vej1j40x5.fsf@gitster.siamese.dyndns.org>
	<20081111000706.GA26223@coredump.intra.peff.net>
	<adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
	<20081111102914.GA30330@coredump.intra.peff.net>
	<7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
	<20081112081609.GA3720@coredump.intra.peff.net>
	<20081120130851.GA17608@neumann>
	<20081120152015.GA6283@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 22 16:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ur3-0000sG-2r
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 16:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758484AbYKVPzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Nov 2008 10:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758483AbYKVPzs
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 10:55:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:57733 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479AbYKVPzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 10:55:47 -0500
Received: from [127.0.1.1] (p5B132AAD.dip0.t-ipconnect.de [91.19.42.173])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1L3uph14Ng-0002Sd; Sat, 22 Nov 2008 16:55:45 +0100
Content-Disposition: inline
In-Reply-To: <20081120152015.GA6283@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX18PLza7FbPsl6sa6QLbjzyd8kvHOfPUyfuniDn
 uEmpgSpuVKDqo2pE/8aL5vwUrzGNug1D8a2IwLhM0ZEzKUwKvA
 x1YbdtSzP2voq/RAC5F1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101554>

Hi Jeff,

On Thu, Nov 20, 2008 at 10:20:16AM -0500, Jeff King wrote:
> On Thu, Nov 20, 2008 at 02:09:28PM +0100, SZEDER G=E1bor wrote:

> Hmm. I am sad that this change has broken somebody's existing workflo=
w.
> OTOH, I'm not convinced that workflow wasn't a little crazy to begin
> with, depending on this undocumented munging.

Well, the docs didn't say that the patch is only removed in verbose
mode (;  But I agree with you that this is (was) an undocumented
"feature" that I should not have relied upon.

> > So, what is the/is there a preferred way to always include the diff=
 in
> > the commit message template and get it removed automatically?  Are
> > there any workarounds other than revert that commit locally?
>=20
> How about:
>=20
>     $ cat .git/hooks/prepare-commit-msg
>     #!/bin/sh
>     git diff --cached >>"$1"
>=20
>     $ cat .git/hooks/commit-msg
>     #!/bin/sh
>     sed -i '/^diff --git/Q' "$1"
>=20
> which is more or less the original behavior. The only downside I see =
is
> that "--no-verify" will turn off the commit-msg hook, but not the
> prepare-commit-msg hook.

Thanks for the tip.  Junio's suggestion about '# Everything under this
line is deleted.' could be implemented this way fairly easily (just an
additional echo in prepare-commit-msg, and other pattern in
commit-msg).  But 'git commit --no-verify' is indeed a problem.
Although I never use it explicitly, 'git rebase -i' does so.

However.

'git rebase -i' uses 'git commit --no-verify' since c5b09feb (Avoid
update hook during git-rebase --interactive, 2007-12-19) to avoid
squashing commits together when the pre-commit hook fails because of
whitespace errors.  But note that at that time the 'git commit'
calls looked like this (after that patch):

  $USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT
  git commit --no-verify -F "$DOTEST"/message -e

Witness that it's not checked whether 'git commit' succeeded or
failed.
However, nowadays those lines look like this:

  $USE_OUTPUT git commit --no-verify $MSG_OPT "$MSG_FILE" $EDIT_COMMIT =
|| failed=3Dt
  git commit --no-verify -F "$DOTEST"/message -e || { ...

There is a check for failed 'git commit', so if the pre-commit hook
finds whitespace errors, then 'git commit' will error out, and,
consequently, 'git rebase -i' will error out, too, and commits won't
be squashed accidentaly.

So, I wonder whether those '--no-verify' options are still required in
'git rebase -i'.

Any thoughts?

Thanks,
G=E1bor

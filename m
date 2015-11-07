From: John Keeping <john@keeping.me.uk>
Subject: Re: Git potential bug with fork-point
Date: Sat, 7 Nov 2015 16:01:20 +0000
Message-ID: <20151107160120.GG19802@serenity.lan>
References: <a3db24afbc3247c3a8466c8d7ce0c785@SEGOTNC5113-N2.vcn.ds.volvo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Stenberg Jim (2)" <jim.stenberg.2@volvo.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 17:01:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zv5vq-0006LT-RD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 17:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbbKGQBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2015 11:01:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33940 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbbKGQB3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2015 11:01:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5AC77CDA55D;
	Sat,  7 Nov 2015 16:01:28 +0000 (GMT)
X-Quarantine-ID: <0z9QI4UV5YTl>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0z9QI4UV5YTl; Sat,  7 Nov 2015 16:01:27 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 84E6ECDA591;
	Sat,  7 Nov 2015 16:01:22 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <a3db24afbc3247c3a8466c8d7ce0c785@SEGOTNC5113-N2.vcn.ds.volvo.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281020>

On Mon, Nov 02, 2015 at 06:27:52AM +0000, Stenberg Jim (2) wrote:
> My problem:
> "Git merge-base --fork-point" acts unexpected when I refer to remote
> branches (typically "origin/".) With unexpected I mean that if I swap
> the position of the two references that the function takes as argumen=
t
> I get different results.  I highly suspect that this isn't a feature
> but a bug, or maybe I'm using the function in a way it wasn't intende=
d
> to be used.
> I don't need you to fix it (swapping the arguments solves it), I just
> want you to be aware of it.
>=20
> History & procedure:
> When=A0 I was working on my automatic build script I came across the
> oddity that "Git merge-base --fork-point" behaved differently
> depending on the order in which the two references are passed.

I think this is expected.  The documentation for `--fork-point` says:

	git merge-base --fork-point <ref> [<commit>]

	Find the point at which a branch (or any history that leads to
	<commit>) forked from another branch (or any reference) <ref>.
	This does not just look for the common ancestor of the two
	commits, but also takes into account the reflog of <ref> to see
	if the history leading to <commit> forked from an earlier
	incarnation of the branch <ref> (see discussion on this mode
	below).

Clearly the order of the arguments matters because the reflog is only
inspected for the `<ref>` argument.  Since the reflog is involved this
also means that the results are likely to be different between separate
copies of the same repository.

I suspect you do not want to be using `--fork-point` in your build
script; it is intended to help `git rebase` recover from history being
rewritten and if you do not need that behaviour you are probably better
off using the normal `git merge-base <commit> <commit>` mode, which
should give consistent results regardless of the order of the commits.

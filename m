From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Dangerous "git am --abort" behavior
Date: Tue, 21 Dec 2010 10:46:27 -0800
Message-ID: <AANLkTimqxCBpF2tCqjsPMnc11nh4MZx2bh0gD7Q=duG+@mail.gmail.com>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
 <7vtyi8arxp.fsf@alter.siamese.dyndns.org> <7vsjxr7zdn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 19:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV7Es-0001Dn-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 19:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab0LUSqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 13:46:51 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38251 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab0LUSqt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 13:46:49 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id oBLIkmS8023146
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 21 Dec 2010 10:46:48 -0800
Received: by iyi12 with SMTP id 12so3385899iyi.19
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 10:46:47 -0800 (PST)
Received: by 10.231.36.195 with SMTP id u3mr5852036ibd.41.1292957207316; Tue,
 21 Dec 2010 10:46:47 -0800 (PST)
Received: by 10.231.31.72 with HTTP; Tue, 21 Dec 2010 10:46:27 -0800 (PST)
In-Reply-To: <7vsjxr7zdn.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.979 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164046>

On Tue, Dec 21, 2010 at 10:29 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> So here is the first step in that direction. =A0I suspect that stop_h=
ere
> should also record what the current branch is, and safe_to_abort shou=
ld
> check it (the potentially risky sequence is "after a failed am, check=
 out
> a different branch and then realize you need to 'am --abort'"), but t=
hat
> is left to interested others ;-) or a later round.

Yeah, this patch looks good to me.

And if you've switched branches, and do a "git am --abort" which still
sees the expected commit, I actually think your patch does the right
thing: we will rewind that new branch to ORIG_HEAD, and I think that
is actually the semantics we want.

So what you can do with this is:

 - "git am <mbox-file>" fails in the middle

 - you go "hmm. I'm happy with what we did so far, but let's go back
to check what's up"

 - "git checkout -b test-branch ; git am --abort"

 - work on the original base and maybe try to re-apply the mbox with
soem manual editing or whatever...

and that's exactly the semantics that your patch allows, which seems
to be very flexible and useful. No?

So the only thing it disallows is having "git am --abort" actually
abort some unrelated commit, which is I think the exact behavior we
want. In fact, if somebody has done a "git pull" or something, then
"ORIG_HEAD" really doesn't mean what git am thinks it means. So I
wonder if we should check ORIG_HEAD against "beginning of 'git am'"
too, the way you check HEAD against the "abort-safely" point?

Again, if ORIG_HEAD doesn't match (for whatever reason - maybe
somebody switched branches and did a 'git reset --hard" in that other
branch, and then switched back?), then "git am --abort" shouldn't
abort to some random point that came from some non-am workflow, no?

But with the HEAD check, you'd really have to _work_ at screwing up,
so the ORIG_HEAD check seems to be much less important.

                              Linus

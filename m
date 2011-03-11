From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 17:16:25 -0800
Message-ID: <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu> <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org> <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com> <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 02:16:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxqyJ-0000cH-Po
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 02:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab1CKBQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 20:16:46 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41870 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151Ab1CKBQq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 20:16:46 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p2B1Gjlt026900
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 10 Mar 2011 17:16:45 -0800
Received: by iwn34 with SMTP id 34so2133425iwn.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 17:16:45 -0800 (PST)
Received: by 10.231.177.69 with SMTP id bh5mr6710675ibb.62.1299806205106; Thu,
 10 Mar 2011 17:16:45 -0800 (PST)
Received: by 10.231.12.10 with HTTP; Thu, 10 Mar 2011 17:16:25 -0800 (PST)
In-Reply-To: <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-104.981 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168875>

On Thu, Mar 10, 2011 at 4:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> How many characters do we need to name master uniquely today?
>
> =A0 =A0$ ./git -c core.abbrevguard=3D0 rev-parse --short=3D1 master
> =A0 =A083c3c
>
> Ok, so there are more than one object with 83c3 and 83c3c is the abso=
lute
> minimum.

Actually, that's just lucky.

Do this:

  git rev-list --abbrev=3D4 --abbrev-commit --all --objects | grep '^..=
=2E......*$'

and you'll see several commits in the git tree that need eight
characters to be unique. The fact that your current 'master' isn't one
of them, and in fact happens to be one that only needs five, is just
pure luck.

So even in the (much smaller) git repo, 7 is not a sufficient unique
minimum even today. Never mind any future guarding.

And your argument fails for exactly that reason: yes, for an
_individual_ SHA1, you may think that "five characters is sufficient",
and when you then use that random number (5) as a basis for forming
your "max 8 character" logic, it fails miserably for other cases.

Now, if the "abbrevguard" was based not one one random data-point, but
on the _whole_ current state of the repository, things would be
different.  Then it would actually become a "let's pick a good default
abbreviation length for this repo". But that's now that it does. The
abbrevguard depends on the one particular SHA1 you're looking at, so
you can actually be asking for a longer abbreviation, but still get a
_shorter_ end result than when you asked for a shorter abbreviation.

IOW, try your example thing not just with "master", but with two
extreme commits. For example, try

  git -c core.abbrevguard=3D2 rev-parse --short=3D5 83c3c622
  git -c core.abbrevguard=3D2 rev-parse --short=3D4 979f7929

and tell me what you get. I _think_ you should get 7 digits for the
first case, and 8 digits for the second one. Even though you "asked"
for a longer name in the first case, and you had the same abbrevguard.

See what I'm saying? I think that's just insane. And it comes exactly
from the fact that abbreviation ends up being a "local" thing.

                          Linus

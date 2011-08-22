From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Mon, 22 Aug 2011 09:54:47 -0700
Message-ID: <CAGdFq_gx+NutDCU7egr_fYUvVG=g1t76LiV1SV-W=0KWBTjHyQ@mail.gmail.com>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org> <20110817231922.GA28966@sigill.intra.peff.net>
 <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com> <20110822161932.GA1945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 18:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvXme-0000X8-RL
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 18:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab1HVQz3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 12:55:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39750 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1HVQz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 12:55:27 -0400
Received: by vws1 with SMTP id 1so4097874vws.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oevLdLAJHVQ6/0sXQhrKucURjIPg4lHZybrpORnK48w=;
        b=FcYDWCthQWGOXXmqgLAg9vycJD53dhwuqXgg8hipWM1urOperDD0c9LzIvS8UfY/Rd
         uSCjvlUGlGcW8M+qW+sJoKk9cprPRnE6ic+M608A4mgjFyIeZThbrGnEMDNmzXKKS93m
         JcZciPKsaBfkrFOLArZHvHz/v4cWHEOCqTVmI=
Received: by 10.52.92.52 with SMTP id cj20mr2592950vdb.410.1314032127112; Mon,
 22 Aug 2011 09:55:27 -0700 (PDT)
Received: by 10.52.161.201 with HTTP; Mon, 22 Aug 2011 09:54:47 -0700 (PDT)
In-Reply-To: <20110822161932.GA1945@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179871>

Heya,

On Mon, Aug 22, 2011 at 09:19, Jeff King <peff@peff.net> wrote:
> Hmm. Maybe I am misremembering the problem, but I thought that worked
> already. If you say:
>
> =C2=A0git fast-export refs/heads/foo
>
> you should get only reset/commit lines in the output for refs/heads/f=
oo,
> no?
>
> Now I can't seem to replicate the case where refs/heads/master is
> mentioned, but you didn't want it to be. I may have to go back and
> re-read the thread from a month or two ago when we discussed these
> issues.

Do you agree that this is expected behavior?

$ git init test
Initialized empty Git repository in /home/sverre/code/test/.git/
$ cd test/
$ echo content >> foo
sverre@laptop-sverre:~/code/test
$ git add foo
$ git commit -m first
[master (root-commit) 821176f] first
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ echo content >> foo
$ git commit -am second
[master 1934282] second
 1 files changed, 1 insertions(+), 0 deletions(-)
$ git branch other
$ git fast-export ^master other
reset refs/heads/other
from 1934282469e3a83a5ef827fd31e074cfb4f3eadf

Because in current git.git, this doesn't work (the above is generated
using a git that has the patch series Dscho and I sent out). Current
git will instead do the following:

$ git fast-export ^master other
reset refs/heads/other
from :0

The 'from :0' here is obviously a bug (which is fixed by our patch seri=
es).

You might wonder, 'why would anyone do that', well, for example, they
might be using marks:

$ git fast-export --export-marks=3Dmarksfile  master > /dev/null
$ git fast-export --import-marks=3Dmarksfile  other
reset refs/heads/other
from :4

Again, the above is generated with my patched git, current git.git
simply outputs nothing.

$ git fast-export --import-marks=3Dmarksfile other

--=20
Cheers,

Sverre Rabbelier

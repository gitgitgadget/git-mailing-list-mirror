From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 09:27:14 +0200
Message-ID: <vpqegkvnfe5.fsf@anie.imag.fr>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<xmqqwpyoe1aj.fsf@gitster.dls.corp.google.com>
	<558FDAF9.3010300@alum.mit.edu>
	<xmqqh9prekdw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 09:27:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9TTY-0007pN-U0
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 09:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbF2H13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 03:27:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46949 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbbF2H10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 03:27:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5T7REcO029040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 09:27:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5T7REkd019571;
	Mon, 29 Jun 2015 09:27:15 +0200
In-Reply-To: <xmqqh9prekdw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 28 Jun 2015 11:51:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Jun 2015 09:27:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5T7REcO029040
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436167639.30907@yfpNUlLr3tNaAjYlcylrXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272941>

Junio C Hamano <gitster@pobox.com> writes:

> I _think_ bulk of Antoine and Matthieu's work can be salvaged/reused
> to implement the proposal,

I'm obviously biaised since I already spent time on the "bisect terms"
idea, and I would hate to see my work and Antoine & Louis' thrown away.
But I have to admit that I do like the idea of "git bisect" figuring out
which commit is the old and which commit is the new one.

It's much easier to implement after the series. I'm currently forbidding
redefining "good" as "bad" and vice versa, but that's just to avoid
confusion and because I didn't test this case, but it should just work.
So, essentially an implementation of this "guess who's old and who's
new" could be: if we find a good commit that is an ancestor of an old
commit, swap the terms in BISECT_TERMS. When this happens before we
started to set any refs, this should do the trick. In general, we should
rename the good-$sha1 reference to good and the bad to bad-$sha1 (there
are corner-cases where the user already specified several good-$sha1
refs, in which case we would need to discard some of them).

I'm getting out of Git time budget, so I can't be the one doing this, at
least not soon.

So, one option is to take the series as-is, and wait for someone to
implement the "guess who's old and who's new" later on top of it. One
drawback would be that we'd end up having the not-so-useful feature
"bisect terms" in the user-interface. At least, I am now convinced that
hardcoding the pair old/new is not needed. In the short term, we can
have "git bisect start --name-old foo --name-new bar" which avoids the
"One needs to remember in which order to give terms" issue we used to
have, so we don't need to clutter the user-interface with many ways to
do the same thing. OTOH, the "bisect terms" feature wouldn't be
completely useless: not everything is good or bad, so leaving the option
to the user to tag "slow/fast", "present/absent", ... still makes sense.

So, my proposal would be to remove the "old/new" patch from the series,
and keep the other patches.

What do you think?

> but now it would be more clear that $name_good and $name_bad is a bad
> way to name internal variables and files in $GIT_DIR. The inferred 'ah
> you are hunting for regression' mode would call old ones 'bad' and new
> ones 'good', they have to be given value neutral names, e.g. $name_old
> and $name_new.

Ideally, the whole code would be ported to use old/new, but the more I
read the code the more I agree with Christian actually: we still have
many more instances of good/bad in the code (e.g. functions
check_good_are_ancestors_of_bad, for_each_good_bisect_ref, ...), so
having just name_new/name_old would make the code very inconsistant.
It's easier to read the code thinking "good revs are old, bad revs are
recent; maybe some magic swapped the terms but I don't need to worry
about this" for now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

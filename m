From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Sun, 16 Jun 2013 13:08:18 +0200
Message-ID: <87ip1e2tzx.fsf@hexa.v.cablecom.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 13:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoAou-0001CT-UM
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 13:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab3FPLIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 07:08:24 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:54428 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab3FPLIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 07:08:24 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 16 Jun
 2013 13:08:21 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 16 Jun
 2013 13:08:21 +0200
In-Reply-To: <7vk3lvlmat.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 15 Jun 2013 03:07:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228005>

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Pimlott <andrew@pimlott.net> writes:
>
>> Excerpts from Andrew Pimlott's message of Fri Jun 14 12:31:57 -0700 2013:
>>> It happened to work and I added a test.  But then it occurred to me that
>>> it might have been better to fix commit --fixup/--squash to strip the
>>> fixup! or squash! from the referenced commit in the first place.
>>> Anyhow, below is my patch for --autosquash, but unles someone has an
>>> objection to doing it in commit, I'll work on that.
>
> Is it always true that you would squash and fixup in the same order
> as these follow-up commits happened?
>
> That is, if you did this (time flows from top to bottom):
>
> 	1 A
>         2 B
>         3 fixup A
>         4 squash B
>         5 fixup fixup A
>         6 fixup A
>
> I am wondering if applying 6 on top of 5 is always what you want, or
> you would want to apply it to 3 instead.  Otherwise you would have
> written
>
> 	6 fixup fixup fixup A
>
> instead.
>
> The two reordering possibilities are:
>
>         1 A                        1 A             
>         3 fixup A                  3 fixup A       
>         5 fixup fixup A            6 fixup A       
>         6 fixup A                  5 fixup fixup A
>         2 B                        2 B             
>         4 squash B                 4 squash B      
>
> If you strip out the prefix when you make commits, you may lose the
> information if you want to use in order to express these different
> orders.  I am not sure if it matters in practice, but I am not yet
> convinced it is a good idea.

Isn't it a bit of an academic question?

All 'fixup* A' are clearly intended to be squashed into A eventually.
You could reorder them, but unless you arranged your fixups as nonlinear
history (does anyone do that?) they have been built sequentially.  So at
best the extra reordering does not buy you anything, because you're
going to fix up A anyways.  You may even get extra conflicts during the
reordering, which make the process less automatic and more error-prone.

  [If you did actually arrange things nonlinearly, so that you have

    * A
    |\
    | * fixup A
    | |
    * | fixup A
    |/
    * M  (you need M so that you can rebase both fixups simultaneously)

  then you might actually use the number of 'fixup' prefixes to determine
  their order.  However, if you actually generate such history, you have
  to go out of your way to look at the other branches too, and make sure
  that the number of prefixes is sufficiently unique to disambiguate the
  order as far as you want it to do that, etc.  It sounds like too much of
  a headache to be worth using like that.]

And once you have that, it seems a nicer and cleaner idea to generate
'fixup! A' each time, instead of a successive sequence of

  fixup! A
  fixup! fixup! A
  fixup! fixup! fixup! A
  ...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

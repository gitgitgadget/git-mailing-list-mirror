From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 20:26:44 +0100
Message-ID: <4c8ef71001111126k46626cfas3cb324291cbf44f@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
	 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
	 <20100104053125.GA5083@coredump.intra.peff.net>
	 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
	 <20100104064408.GA7785@coredump.intra.peff.net>
	 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
	 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
	 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
	 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUPuc-0006CI-H1
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 20:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab0AKT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946Ab0AKT0q
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 14:26:46 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:62669 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0AKT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 14:26:46 -0500
Received: by fxm7 with SMTP id 7so31366fxm.28
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=urr4+bfZAXKJesMeNEbw+dhgyOOVl8TtpKMI0nu7l6c=;
        b=RJAo+zldA7Ibmas7AWfRtEjgK+Fx8SMO6bfwjqTBeN9n+L5uAoTLbcY3gQuv48HFah
         4IauZqUONqe7x65Xhspl4ATEbLSkE4dl6SMy7zI4yrjRscM0mxlopWuwU21oSEBOOpws
         MQ53oVDpS3doQ2og+Q3KtYkn7+2oYirHfLia4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vyeFyWaNdbiqVQdctSGV1rvRd3q3vxcbHYCjLmUt1OhlmS7ceHsr4KlUsPo1CCsfJn
         ime0qbk8Dv7UdAnQER/LdVdf2eqg0oNPQkJEjmcUTZZqn4rIk47V6vgj4wg4f76YJ77V
         TRsrW5Rj2BjexZ2xFEaaJdXx80VLn6LNwhrgY=
Received: by 10.239.139.6 with SMTP id r6mr2267482hbr.205.1263238004917; Mon, 
	11 Jan 2010 11:26:44 -0800 (PST)
In-Reply-To: <7vvdf9402f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136656>

[Resending as the first copy didn't reach the list.]

On Mon, Jan 11, 2010 at 07:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > It doesn't matter. Since we do the line-by-line thing, the input is always
> > so short that DFA vs NFA vs BM vs other-clever-search doesn't matter.
> > There is no scaling - the grep buffer tends to be too small for the
> > algorithm to matter.
> >
> > And the reason we do things line-by-line is that we need to then output
> > things line-per-line.
>
> Here is an experimental patch; first, some numbers (hot cache best of 5 runs).

I get some very unexpected results with this patch. (best of 5 runs):

before:

time git grep --no-ext-grep qwerty
drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"
         /* 0x10 - 0x1f */

real 0m3.531s
user 0m3.056s
sys 0m0.468s

after:

time git grep --no-ext-grep qwerty
drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"
         /* 0x10 - 0x1f */

real    0m4.794s
user    0m4.380s
sys    0m0.404s

with external grep:
time git grep qwerty
drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"
         /* 0x10 - 0x1f */

real    0m1.236s
user    0m0.668s
sys    0m0.544s


So, if I haven't messed up the benchmark, it seems that Junio's patch
makes things go _slower_. I don't understand at all why I get these
results...

This is on a laptop with an Intel T2080 processor running Ubuntu 9.10.

Any ideas on how this can be explained?

- Fredrik

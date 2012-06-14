From: Lawrence Mitchell <wence@gmx.li>
Subject: Re: [PATCH 1/3] git-blame.el: Do not use goto-line in lisp code
Date: Thu, 14 Jun 2012 10:14:36 +0100
Message-ID: <87k3za9rwj.fsf@gmx.li>
References: <20120610073803.GA29461@burratino>
	<1339329484-12088-1-git-send-email-wence@gmx.li>
	<20120614050854.GG27586@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>,
	davidk@lysator.liu.se, user42@zip.com.au, osv@javad.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 11:15:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf68p-0000Nq-PO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab2FNJOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 05:14:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:48948 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393Ab2FNJOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:14:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Sf68f-0008DJ-E0
	for git@vger.kernel.org; Thu, 14 Jun 2012 11:14:49 +0200
Received: from e4300lm.epcc.ed.ac.uk ([129.215.63.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 11:14:49 +0200
Received: from wence by e4300lm.epcc.ed.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 11:14:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: e4300lm.epcc.ed.ac.uk
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.1.50 (gnu/linux)
Cancel-Lock: sha1:TG0JsmUsm0Jg6r1lb5rbpDSnJPs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199986>

Jonathan Nieder wrote:
> Hi Lawrence,

> Lawrence Mitchell wrote:

>> From: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>

>> goto-line is a user-level command, instead use the lisp-level
>> construct recommended in Emacs documentation.
> [...]
>> Here we go, all R=C3=BCdiger's changes look sensible, I've split the=
m into bits though

> Thanks for looking them over.

> Would you mind indulging my curiosity a little by describing what bad
> behavior or potential bad behavior this change prevents?


goto-line sets the mark, and respects the variable
selective-display.  It also widens the buffer before moving to
the relevant line.  The first two are almost never what you'd
want in lisp code, the latter you'd probably want to make
explicit in the calls I guess.

the with-current-buffer issue is a bit more subtle, and I realise
my patch for this didn't actually fix the bug, or describe the
problem properly (reroll to come).

Basically:

save-excursion saves point, mark and current-buffer in the buffer
in scope when it is called, but if we do:

(save-excursion
  (set-buffer buf)
  ;; modify point and mark in buf
  ...)

hoping to save point and mark in buf, it doesn't happen.
Instead, we need to make buf current before calling
save-excursion.  And we want to restore the value of
current-buffer in scope at the beginning of the call afterward,
hence the correct idiom is:

(with-current-buffer buf
  (save-excursion ...))

Cheers,

Lawrence

--=20
Lawrence Mitchell <wence@gmx.li>

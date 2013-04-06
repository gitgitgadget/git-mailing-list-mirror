From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of closing
Date: Sat, 6 Apr 2013 10:07:40 +0200
Message-ID: <878v4wrsj7.fsf@linux-k42r.v.cablecom.net>
References: <20130404011653.GA28492@dcvr.yhbt.net>
	<801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
	<20130405144828.GX6137@machine.or.cz>
	<7vsj34byb4.fsf@alter.siamese.dyndns.org>
	<20130405233450.GA6137@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWT2-0001b9-QP
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747Ab3DFIHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 04:07:46 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:39467 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422744Ab3DFIHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 04:07:43 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 6 Apr
 2013 10:07:35 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (87.231.156.75) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sat, 6 Apr 2013 10:07:39 +0200
In-Reply-To: <20130405233450.GA6137@machine.or.cz> (Petr Baudis's message of
	"Sat, 6 Apr 2013 01:34:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [87.231.156.75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220231>

Petr Baudis <pasky@ucw.cz> writes:

> On Fri, Apr 05, 2013 at 11:57:19AM -0700, Junio C Hamano wrote:
>   The thing is, I was confused about dup2() all along as my old UNIX
> masters taught me that I must close() the original descriptor first
> and since that's what's commonly done anyway, I never thought to
> double-check. Now I did and I learned something new, thanks!

Indeed, that's the crucial point here.  dup2() is defined to close the
original FD first if needed.

It's much saner this way for the case of stderr, as there is no time
when we have no stderr available to report errors: the FD is replace
atomically from the POV of the program.

The manpage for dup2 does, however, say

   If newfd was open, any errors  that  would  have  been  reported  at
   close(2) time are lost.  A careful programmer will not use dup2() or
   dup3() without closing newfd first.

which is probably what you were referring to.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

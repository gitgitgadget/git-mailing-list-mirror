From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 20:29:07 +0100
Message-ID: <87r4lejpx8.fsf@pctrast.inf.ethz.ch>
References: <50D861EE.6020105@giref.ulaval.ca>
	<50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
	<50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
	<CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
	<50F8273E.5050803@giref.ulaval.ca>
	<871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
	<50F829A9.7090606@calculquebec.ca>
	<871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
	<50F98B53.9080109@giref.ulaval.ca>
	<CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
	<87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <kusmabite@gmail.com>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:29:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxN3k-0001YN-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447Ab3AUT3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:29:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50978 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182Ab3AUT3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:29:09 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 21 Jan
 2013 20:29:05 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.154) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 21 Jan 2013 20:29:07 +0100
In-Reply-To: <kdk2ss$498$1@ger.gmane.org> (Brian J. Murrell's message of "Mon,
	21 Jan 2013 13:54:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214154>

Please don't drop the Cc list!

"Brian J. Murrell" <brian@interlinx.bc.ca> writes:

>> What's odd is that while I cannot reproduce the original problem, there
>> seems to be another issue/bug with utime():
>
> I wonder if this is related to http://jira.whamcloud.com/browse/LU-305.
>  That was reported as fixed in Lustre 2.0.0 and 2.1.0 but I thought I
> saw it on 2.1.1 and added a comment to the above ticket about that.

Aha, that's a very interesting bug report.  My observations support
yours: I managed to get EINTR during utime().

>> In the absence of it, wouldn't we in theory have to write a simple
>> loop-on-EINTR wrapper for *all* syscalls?
>
> IIUC, that's what SA_RESTART is all about.

Yes, but there's precious little clear language on when SA_RESTART is
supposed to act.  In all cases?

The wording on

  http://www.delorie.com/gnu/docs/glibc/libc_485.html
  http://www.delorie.com/gnu/docs/glibc/libc_498.html

leads me to believe that SA_RESTART is actually used on the glibc side
of things, so that any glibc syscall wrapper not specifically equipped
with the restarting behavior would return EINTR unmodified.  This might
explain why utime() doesn't restart like it should (assuming we work on
the theory that POSIX doesn't allow an EINTR from utime() to begin
with).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

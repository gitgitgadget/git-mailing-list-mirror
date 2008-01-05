From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Fri, 04 Jan 2008 17:17:39 -0800
Message-ID: <7v4pdtgjf0.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<1199040667-31850-1-git-send-email-dpotapov@gmail.com>
	<7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
	<20080104155114.GS3373@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 03:14:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAyYo-0003kF-HL
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 03:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbYAECOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbYAECOY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 21:14:24 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:43112 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbYAECOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 21:14:24 -0500
X-Greylist: delayed 3397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2008 21:14:23 EST
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 69D39468F6D
	for <git@vger.kernel.org>; Fri,  4 Jan 2008 20:20:38 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4B1D517E3B5;
	Fri,  4 Jan 2008 20:18:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EFA8617E3B2;
	Fri,  4 Jan 2008 20:18:02 -0500 (EST)
In-Reply-To: <20080104155114.GS3373@dpotapov.dyndns.org> (Dmitry Potapov's
	message of "Fri, 4 Jan 2008 18:51:15 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69630>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Thu, Jan 03, 2008 at 01:27:27PM -0800, Junio C Hamano wrote:
>> ... I had an
>> impression that we try to stick to a subset of BRE (namely, no
>> \{m,n\}, [::], [==], nor [..]).
>
> I was not aware about this policy, and I am not aware about
> existing any grep that does not grok the expressions I used
> above. So, I thought they are commonly accepted, but I might
> be wrong.

Well I might be wrong too, as I did not vet all the existing use
of grep in our code.  That's why I said I had "an impression".

Now I have ("git grep 'grep ' -- 'git-*.sh'"), and it seems to
be that we do stick to a narrow subset of BRE.

 * We do not use \{m,n\};

 * We do not use -E;

 * We do not use ? nor + (which are \{0,1\} and \{1,\}
   respectively in BRE) but that goes without saying as these
   are ERE elements not BRE (note that \? and \+ you wrote are
   not even part of BRE -- making them accessible from BRE is a
   GNU extension).

IOW, our scripts' use of grep is very 80'sh ;-)

I do not mind using things that are available in POSIX BRE, but
let's not rely on GNU extension that may cause issues to other
people.

Other things I noticed while looking at "t/*.sh":

 * t/t3600-rm.sh and t/5401-update-hooks.sh have unnecessary
   uses of egrep that can instead be grep;

 * t/t3800-mktag.sh uses egrep but I think it can be grep; also,
   I think the use of temporary file expect.pat is unnecessary.

 * t/t5510-fetch.sh does use '^[0-9a-f]\{40\} '.

 * t/t7001-mv.sh uses -E only to use '.+' when it can just as
   easily say '..*' instead.

 * t/t7600-merge.sh has two occurrences of (GNU extended) " \+"
   that should be "  *" for portability.  An alternative is to
   use grep -E and say " +" instead, but then the other plus
   sign on the same line needs to be quoted.

Other than the one in 5510 I consider them log hanging fruits
for janitors.

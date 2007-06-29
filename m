From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 00:07:03 -0700
Message-ID: <7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
	<20070626171127.GA28810@thunk.org>
	<alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
	<20070628190406.GC29279@thunk.org>
	<20070628213451.GB22455@coredump.intra.peff.net>
	<20070628235319.GD29279@thunk.org>
	<20070629010507.GL12721@planck.djpig.de>
	<20070629034838.GF29279@thunk.org>
	<20070629063819.GA23138@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 09:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4AZd-0000Qe-Bw
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 09:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXF2HHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 03:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbXF2HHH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 03:07:07 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39509 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbXF2HHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 03:07:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629070705.CQHY1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 03:07:05 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HK731X0061kojtg0000000; Fri, 29 Jun 2007 03:07:04 -0400
In-Reply-To: <20070629063819.GA23138@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jun 2007 02:38:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51158>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 28, 2007 at 11:48:38PM -0400, Theodore Tso wrote:
>
>> +void maybe_flush_or_die(FILE *f, const char *desc)
>> +{
>> +	static int stdout_is_file = -1;
>> +	struct stat st;
>> +	char *cp;
>> +
>> +	if (f == stdout) {
>> +		if (stdout_is_file < 0) {
>> +			cp = getenv("GIT_FLUSH");
>> +			if (cp)
>> +				stdout_is_file = (atoi(cp) == 0);
>> +			else if ((fstat(fileno(stdout), &st) == 0) &&
>> +				 S_ISREG(st.st_mode))
>> +				stdout_is_file = 1;
>> ...
>
> Looks much better to me, but I have one minor nit: stdout_is_file is a
> poor name,...

Thanks for bringing it up, as I had the same "Huh?" moment.
I would probably call that simply "do_not_flush".  Or name the
variable "flush_stdout" and swap all the logic.

	if (f == stdout) {
        	if (flush_stdout < 0) {
                	cp = getenv("GIT_FLUSH_STDOUT");
                        if (cp)
                        	flush_stdout = !!atoi(cp);
			else if ((fstat(fileno(stdout), &st) == 0) &&
				!S_ISREG(st.st_mode))
				flush_stdout = 0;
			else
                        	flush_stdout = 1;
		}
                if (!flush_stdout)
                	return;
	}

From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff hunk header regex.
Date: Sat, 23 Mar 2013 09:48:30 +0000 (UTC)
Message-ID: <loom.20130323T101131-456@post.gmane.org>
References: <loom.20130322T144107-601@post.gmane.org> <7vehf78olw.fsf@alter.siamese.dyndns.org> <514CD34F.70107@kdbg.org> <7vhak35ami.fsf@alter.siamese.dyndns.org> <514CE53F.3080308@kdbg.org> <loom.20130323T011153-345@post.gmane.org> <m2y5de34bz.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 10:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJL4j-0004AT-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 10:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab3CWJsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 05:48:53 -0400
Received: from plane.gmane.org ([80.91.229.3]:54219 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab3CWJsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 05:48:52 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UJL4b-00044k-JE
	for git@vger.kernel.org; Sat, 23 Mar 2013 10:49:13 +0100
Received: from ip-208.net-89-3-60.rev.numericable.fr ([89.3.60.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 10:49:13 +0100
Received: from vz-git by ip-208.net-89-3-60.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 10:49:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.3.60.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218903>

Andreas Schwab <schwab <at> linux-m68k.org> writes:

> Vadim Zeitlin <vz-git <at> zeitlins.org> writes:
> 
> >   "!^[ \t]*[A-Za-z_][A-Za-z_0-9]+[ \t]*:([^:]|$)\n"
> 
> That would fail to match single-character identifiers.

 Oops, yes, you're right, of course, sorry. I have no idea why did I write
that we needed to change this "*" to "+", the only explanation I see is that
it was simply too late at night when I did it. So the final version of the
exclusion regex is

	"!^[ \t]*[A-Za-z_][A-Za-z_0-9]*[ \t]*:([^:]|$)\n"


 But I feel like I'm still missing something about what is going on here.
Because after looking carefully at the (positive) regex for matching function
and method names, which is

	"^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*"
	"([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"

(split over 2 lines for readability), I actually don't understand how does it
manage to match my declaration. Yet match it does, I do get

@@ -438,6 +438,10 @@ firebird_statement_backend::execute(int number)

in my diff. But how is this possible? The "[ \t*]+" part has nowhere to match
but between "int" and "number" but it can't match there because there must be
only alphanumeric characters before it. Yet, not only it does match but if I
test with GNU grep -E, it matches too (after replacing "\\(" with just "\("
and removing "\n"). However if I test with perl or "sed -r", it does *not*
match. Can anyone see what's going on here?


 FWIW I've started looking into this because I thought that the current
regex wouldn't detect something like

	foo::nested_type foo::method()

as a start of a method. However it does detect this just fine as well which
I can't understand at all. I'm out of lame excuses (it's not too late here
yet...) so I just hope that I'm missing something about the way Git creates
hunk headers and not some obvious problem with the regex itself because
I've been staring at it for half an hour but still can't see how does it
manage to match here. Could anyone who does see it please explain?

 Thanks in advance,
VZ

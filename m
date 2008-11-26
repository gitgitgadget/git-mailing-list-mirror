From: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] send-email: Fix Pine address book parsing
Date: Tue, 25 Nov 2008 21:59:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0811252137250.5161@t2.domain.actdsltmp>
References: <1227668100-5563-1-git-send-email-tpiepho@freescale.com>
 <7vod03hyna.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 07:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5DSy-000788-1k
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 07:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYKZGAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 01:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYKZGAU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 01:00:20 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:64029 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbYKZGAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 01:00:19 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id mAQ60AAZ003556;
	Tue, 25 Nov 2008 23:00:10 -0700 (MST)
Received: from [10.213.160.8] (vpn-10-213-160-8.am.freescale.net [10.213.160.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mAQ609w0013745;
	Wed, 26 Nov 2008 00:00:09 -0600 (CST)
X-X-Sender: xyzzy@t2.domain.actdsltmp
In-Reply-To: <7vod03hyna.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101704>

On Tue, 25 Nov 2008, Junio C Hamano wrote:
> Trent Piepho <tpiepho@freescale.com> writes:
>> See:  http://www.washington.edu/pine/tech-notes/low-level.html
>>
>> Entries with a fcc or comment field after the address weren't parsed
>> correctly.
>>
>> Continuation lines, identified by leading spaces, were also not handled.
>>
>> Distribution lists which had ( ) around a list of addresses did not have
>> the parenthesis removed.
>
>> +	pine => sub { my $fh = shift; my $f='\t[^\t]*';
>> +	        for (my $x = ''; defined($x); $x = $_) {
>> +			chomp $x;
>> +		        $x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
>> +			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;
>
> Hmm, so you chomp each continuation line with /^ +(.*)$/ and concatenate
> that to the hold buffer ($x) as long as you see continuation lines,
> a non-continuation line that you read ahead is given to the next round
> (the third part of for(;;) control), checked if you hit an EOF and then
> chomped.  Which means the complicated regexp about the parentheses is
> applied to a logical single line in $x that does not have any newline in
> it, right?

Yes.  The previous regex would just grab the email address with (\S+)$, but
that's not right.  There can be email address with spaces in them, like
"John Doe <jdoe@anon.org>".  And the email address isn't always the last
field.  So each field has to be put in the regex and \S+ and \s* have to
become [^\t]* and \t to count fields properly.  That's why the regex got so
complex.

> I wonder what this does:
>
> 	$x .= $1 while (defined($_ = <$fh>) && /^ +(.*)$/);
>
> when you have "a b" in $x and feed " c\n d\ne\n" to it.  When it leaves
> the loop, you would have "e\n" in $_ for the next round, and "a bcd" (note
> that "bcd" becomes one word) in $x, which I suspect may not be what you
> want.

The tech docs I linked to just say pine continues lines with leading space,
but not how many spaces exactly.  From what I can see it appears to usually
use three spaces, but sometimes it uses one space when wrapping a very long
comment field.  It also appears to only split lines between whitespace and
non-whitespace.  So if "a b c d\n" were to be wrapped, it would be something
like "a b \n   c \n   d\n".  If I didn't eat the leading spaces in the
continuations, it would be re-assembled as "a b    c    d".  This might cause
an address to become "John     Doe <jdoe@anon.org>"

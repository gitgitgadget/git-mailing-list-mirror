From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCHv4] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 15:47:31 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <877gmmqyho.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
	<7vhalqsfkf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pQq-0003w7-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202Ab3BEUre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 15:47:34 -0500
Received: from z.lifelogs.com ([173.255.230.239]:50142 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755621Ab3BEUrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:47:33 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 9561EDE0E3;
	Tue,  5 Feb 2013 20:47:32 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vhalqsfkf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 11:53:20 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215536>

On Tue, 05 Feb 2013 11:53:20 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>> Changes since PATCHv3:
>> 
>> - simple tests in Makefile
>> - support multiple files, code refactored
>> - documentation and comments updated
>> - fix IO::File for GPG pipe
>> - exit peacefully in almost every situation, die on bad invocation or query
>> - use log_verbose() and -v for logging for the user
>> - use log_debug() and -d for logging for the developer
>> - use Net::Netrc parser and `man netrc' to improve parsing
>> - ignore 'default' and 'macdef' netrc entries
>> - require 'machine' token in netrc lines
>> - ignore netrc files with bad permissions or owner (from Net::Netrc)

JCH> Please place the above _after_ the three-dashes.

JCH> The space here, above "---", is to justify why this change is a good
JCH> idea to people who see this patch for the first time who never saw
JCH> the earlier rounds of this patch, e.g. reading "git log" output 6
JCH> months down the road (see Documentation/SubmittingPatches "(2)
JCH> Describe your changes well").

Will do in PATCHv5.

JCH> Avoid starting an argument to "echo" with a dash; some
JCH> implementations choke with "unknown option".

Nice, thanks.  It's purely decorative so I use '=>' now.

>> +my %options = (
>> +               help => 0,
>> +               debug => 0,
>> +               verbose => 0,
>> +	       file => [],

JCH> Looks like there is some funny indentation going on here.

Fixed.

>> +  -f|--file AUTHFILE : specify netrc-style files.  Files with the .gpg extension
>> +                       will be decrypted by GPG before parsing.  Multiple -f
>> +                       arguments are OK, and the order is respected.

JCH> Saying "order is respected" without mentioning the collision
JCH> resolution rules is not helpful to the users when deciding in what
JCH> order they should give these files.  First one wins, or last one
JCH> wins?  Later you say "looks for the first entry", but it will be
JCH> much easier to read the above to mention it here as well.

Right.  Reworded.

>> +Thus, when we get this query on STDIN:
>> +
>> +protocol=https
>> +username=tzz
>> +
>> +this credential helper will look for the first entry in every AUTHFILE that
>> +matches
>> +
>> +port https login tzz
>> +
>> +OR
>> +
>> +protocol https login tzz
>> +
>> +OR... etc. acceptable tokens as listed above.  Any unknown tokens are
>> +simply ignored.
>> +
>> +Then, the helper will print out whatever tokens it got from the entry, including
>> +"password" tokens, mapping back to Git's helper protocol; e.g. "port" is mapped
>> +back to "protocol".

JCH> Isn't "hostname" typically what users expect to see?  It is somewhat
JCH> unnerving to see an example that throws the same password back to
JCH> any host you happen to have an accoutn "tzz" on, even though that is
JCH> not technically an invalid way to use this helper.

Yeah, I changed it to show "machine" in the query (which would be more typical).

>> +			if ($stat[2] & 077) {
>> +				log_verbose("Insecure $file (mode=%04o); skipping it",
>> +					    $stat[2] & 07777);

JCH> Nice touch, although I am not sure rejecting world or group readable
JCH> encrypted file is absolutely necessary.

Right.  Fixed.

>> +			if ($stat[4] != $<) {
>> +				log_verbose("Not owner of $file; skipping it");
>> +				next FILE;

JCH> OK.  A group of local users may share the same account at the
JCH> remote, but that would be unusual.

I added --insecure/-k to override this check.

>> +	if ($mode & 077)

JCH> Again?  Didn't you just do this?

Damn, sorry.

JCH> I think the prevalent style is to

JCH> 	if (condition) {
JCH>         	do this;
JCH> 	} elsif (another condition) {
JCH> 		do that
JCH> 	} else {
JCH> 		do that other thing;
JCH> 	}

JCH> (this comment applies to all if/elsif/else cascades in this patch).

Yup.  I was working with Net::Netrc code and forgot to reformat it.  Sorry.

>> +
>> +		next FILE;

JCH> Isn't this outermost loop, by the way?  What the motivation to have
JCH> an explicit label everywhere (not complaining---it could be your own
JCH> discipline thing---just wondering).

I think it's more readable with large loops, and it actually makes sense
when you read the code.  Not a big deal to me either, I just felt for
this particular script it was OK.

>> +	if ($file =~ m/\.gpg$/) {
>> +		log_verbose("Using GPG to open $file");
>> +		# GPG doesn't work well with 2- or 3-argument open

JCH> If that is the case, please quote $file properly against shell
JCH> munging it.

Ahhh that gets ugly.  OK, quoted.

JCH> The only thing you do on $io is to read from it via "while (<$io>)",
JCH> so I would personally have written this part like this without
JCH> having to use IO::File(), though:

JCH> 	$io = open("-|", qw(gpg --decrypt), $file);

That doesn't work for me, unfortunately.  I'm trying to avoid the IPC::*
modules and such.  Please test it yourself with GPG.  I'm on Perl
5.14.2.

I think it's OK with the quoting, as you'll see in PATCHv5.

JCH> Similarly for the plain file:

JCH> 	$io = open("<", $file);

You mean "open $io, '<', $file".  open() returns nonzero on success and
undef on failure.  OK, I'll use open() instead of IO::File.

>> +	my ($mach, $macdef, $tok, @tok) = (0, 0);

JCH> I think you meant to use $mach as a reference to a hash and $macdef
JCH> as a reference to an array; do you want to initialize them to
JCH> numeric zeros?

That actually came from Net::Netrc.  The $mach default is OK either way;
I left it undefined so it's clearer. I think the $macdef initial value
is a bug (which, I guess, shows macros are very rare); I just made it a
boolean for our purposes.

Ted

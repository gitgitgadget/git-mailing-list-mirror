From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 12:01:31 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87k3qmr8yc.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 18:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lu9-0001Gd-AL
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab3BERBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 12:01:33 -0500
Received: from z.lifelogs.com ([173.255.230.239]:55447 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330Ab3BERBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 12:01:33 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 4D616DE0E3;
	Tue,  5 Feb 2013 17:01:32 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vvca6u47f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 08:15:48 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215519>

On Tue, 05 Feb 2013 08:15:48 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>> +# build reverse token map
>> +my %rmap;
>> +foreach my $k (keys %{$options{tmap}}) {
>> +	push @{$rmap{$options{tmap}->{$k}}}, $k;
>> +}

JCH> Mental note: "$rmap{foo} -eq 'bar'" means that what Git calls 'bar'
JCH> is found as 'foo' in the netrc/authinfo file.  Keys in %rmap are
JCH> what we expect to read from the netrc/authinfo file.

I'll document that better in PATCHv4.

JCH> So you grabbed one line of input, split them into token pairs, and
JCH> built %tokens = ('key Git may want to see' => 'value read from file')
JCH> mapping.

This will be fixed with PATCHv4 to do multiple lines (as defined by the
netrc manpage, etc.).

>> +	# for "host X port Y" where Y is an integer (captured by
>> +	# $num_port above), set the host to "X:Y"
>> +	$tokens{host} = join(':', $tokens{host}, $num_port)
>> +		if defined $tokens{host} && defined $num_port;

JCH> What happens when 'host' does not exist?  netrc/authinfo should be a
JCH> stream of SP/HT/LF delimited tokens and 'machine' token (or
JCH> 'default') begins a new entry, so it would mean the input file is
JCH> corrupt if we do not have $tokens{host} when we get here, I think.

Yes.  I'll make the host/machine token required, which will avoid this
issue.

JCH> Oh, another thing. 'default' is like 'machine' followed by any
JCH> machine name, so the above while loop that reads two tokens
JCH> pair-wise needs to be aware that 'default' is not followed by a
JCH> value.  I think the loop will fail to parse this:

JCH>         default       login anonymous    password me@home
JCH>         machine k.org login me           password mysecret

I'd prefer to ignore "default" because it should not be used for the Git
credential helpers (its only use case is for anonymous services AFAIK).
So I'll add a case to ignore it in PATCHv4, if that's OK.

JCH> Hmph, aren't you checking what you read a bit too early?  This is a
JCH> valid input:

JCH>         default       
JCH>                 login anonymous
JCH>                 password me@home
JCH>         machine k.org
JCH>                 login me
JCH>                 password mysecret

JCH> but does this loop gives mysecret back to me when asked for
JCH> host=k.org and user=me? 

To be fixed in PATCHv4, which will require the host/machine, use it as
the primary key, and only examine entries with it.

JCH> I would probably structure this part like this: [...]

I will do it like that, thank you for the suggestion.

I'll also add a simple testing Makefile for my own use, and you can
consider adding tests to the general framework later.

Ted

From: Sam Vilain <sam@vilain.net>
Subject: Re: WIP: asciidoc replacement
Date: Thu, 04 Oct 2007 17:13:41 +1300
Message-ID: <47046875.1050605@vilain.net>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <4702F6BB.60908@vilain.net> <Pine.LNX.4.64.0710030506360.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 06:14:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdI64-0003yu-DR
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 06:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXJDENx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 00:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757464AbXJDENx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 00:13:53 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:56893 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXJDENw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 00:13:52 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 9D03620C2D8; Thu,  4 Oct 2007 16:13:48 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id CAF7521CF14;
	Thu,  4 Oct 2007 16:13:44 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <Pine.LNX.4.64.0710030506360.28395@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59918>

Johannes,

Given other people have answered some points, I'll answer the rest.

Johannes Schindelin wrote:
>>> -- snip --
>>> #!/usr/bin/perl
>> Add -w for warnings, also use strict;
> 
> <dumb>What does "use strict;" imply?</dumb>

Three things;

1. variables must be declared with 'my', 'our' or 'use var' before they
are used, to catch typos

2. when subroutine calls are found, they are checked to exist otherwise
they throw a compile-time error

3. force all dereferences to follow real references and not allow symbol
table access (don't worry about that ;-))


>>> sub handle_text {
>> this function acts on globals; make them explicit arguments to the 
>> function.
> 
> Actually, it resets the global $par.  Should I rather make it a class?

Well, just channelling Dijkstra really.  Functions should take all their
input as formal arguments rather than globals.

ie

  sub handle_text {
      my $par = shift;
  }

If it really should be a global, it is perhaps best declared up front
with "our" or "use vars".  "use strict" will force you to do one of these.

>> also consider making this a "tabular ternary" with the actions in 
>> separate functions.
>>
>> ie
>>
>> $result = ( $par =~ /^\. /s      ? $conv->do_enum($par)    :
>>             $par =~ /^\[verse\]/ ? $conv->do_verse($par)  :
>>             ... )
> 
> I do not like that way... is it Perl standard to code like that?

It's in Perl Best Practices, but these are always suggestions and not
hard and fast rules.  It just means that you have a big table of regex
-> function that you can quickly check rather than looking at a lot of
spaced out 'elsif's

>>> 		s/gitlink:([^\[ ]*)\[(\d+)\]/sprintf "%s",
>>> 			$conv->get_link($1, $2)/ge;
>>> 		# handle link:
>>> 		s/link:([^\[ ]*)\[(.+)\]/sprintf "%s",
>>> 			$conv->get_link($1, $2, 'external')/ge;
>> These REs suffer from LTS (Leaning Toothpick Syndrome).  Consider using 
>> s{foo}{bar} and adding the 'x' modifier to space out groups.
> 
> I guess you mean the forward slash.  Alas, that's what I'm used to, and 
> I'd rather not change it unless forced to... lest I stop understanding my 
> own code!
> 
> (Besides, I did not find _any_ example showing why "x" should be useful.)

Before:

s/link:([^\[ ]*)\[(.+)\]/sprintf "%s",
 			$conv->get_link($1, $2, 'external')/ge;

After:

s{ link: ([^\[\040]*) \[(.+)\] }
 { sprintf "%s", $conv->get_link($1, $2, 'external') }gex;

>>> 	if ($self->{preamble_shown} == undef) {
>>> 		print '.\" disable hyphenation' . "\n"
>>> 			. '.nh' . "\n"
>>> 			. '.\" disable justification (adjust text to left'
>>> 				. ' margin only)' . "\n"
>>> 			. '.ad l' . "\n";
>> Using commas rather than "." will safe you a concat when printing to
>> filehandles, but that's a very small nit to pick :)
> 
> Does that also work with older perl?  IIRC there was some strange problem 
> with my perl when lots of code in git.git was changed to using commata.

That should go back all the way to perl 4, if not earlier.  If you're
assigning to a scalar, then you need to use concat.  But very minor.

>> Hmm, that regex would not match for <<foo > bar>>, if you care you'd 
>> need to write something like <<((?:[^>]+|>[^>])*)>>
> 
> I'd rather leave it as is -- this script is not meant to grok all kind of 
> sh*t.  It is meant to make translating the docs as fast and uncumbersome 
> as possible.  Which will involve making the documentation more consistent 
> (in and of itself something I rather like).
> 
> So unless there comes a compelling reason, I'd rather leave it.

Sure, KISS.

> Another thing: if I want to add some documentation, what would be the 
> common way to do it?  =pod...=cut?

That's right.  If you're an emacs user, in cperl-mode with abbrevs on
you type '=head1' and you'll get:

=head1 NAME

scriptname

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

See perlpod(3) for more!

Sam.

From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH][GIT.PM 2/3] Getting rid of throwing Error::Simple objects
 in favour of simple Perl scalars which can be caught in eval{} blocks
Date: Sat, 19 May 2012 10:38:41 +0100
Message-ID: <4FB76A21.7000801@pileofstuff.org>
References: <7vobpulhbk.fsf@alter.siamese.dyndns.org> <1337411317-14931-1-git-send-email-subs.zero@gmail.com> <1337411317-14931-2-git-send-email-subs.zero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Subho Sankar Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 11:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVg8E-0004Fd-GF
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 11:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab2ESJir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 05:38:47 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:5825 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab2ESJip (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 05:38:45 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120519093843.SMYR10903.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Sat, 19 May 2012 10:38:43 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120519093843.LAJD10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 19 May 2012 10:38:43 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <1337411317-14931-2-git-send-email-subs.zero@gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=dNJI9zxkJdgA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=_IEhM8lNAAAA:8 a=cTdpbaNVsSqkOdlXf6kA:9 a=wPNLvfGTeEIA:10 a=aBILhjSp524A:10 a=SCGJ5URyfrLuDl1I:21 a=g4V6W6VTMkAgnepz:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198027>

I'll limit myself to a style review here - other people can say better
than me about the deeper issues.

On 19/05/12 08:08, Subho Sankar Banerjee wrote:
<snip>
> @@ -160,7 +160,7 @@ sub repository {
>  	if (defined $args[0]) {
>  		if ($#args % 2 != 1) {
>  			# Not a hash.
> -			$#args == 0 or throw Error::Simple("bad usage");
> +			$#args == 0 or die "bad usage";

This is valid and no worse than before, but I find this use of the "or"
operator slightly confusing.  I find it easier to read either:

	<verb> or <fail>
	OR:
	<fail> unless <noun>

For example:

	do_something($foo) or die "couldn't do_something with '$foo'";
	OR:
	die "'$foo' is not a something" unless is_something($foo);

<snip>
> @@ -1041,7 +1041,7 @@ sub _temp_cache {
>  
>  		($$temp_fd, $fname) = File::Temp->tempfile(
>  			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
> -			) or throw Error::Simple("couldn't open new temp file");
> +			) or die "couldn't open new temp file";

This is a good example of where I think "or" is appropriate.

Think of it in terms of an English sentence.  Which of these would you
find easier to read:

	It is raining or go out and play
	OR:
	Go out and play unless it is raining

	Find your umbrella or cancel the trip
	OR:
	Cancel the trip unless find your umbrella


A bit of background for people who aren't (primarily) Perl programmers:

As an expressive language that promotes "more than one way to do it",
Perl has a long tradition of supporting many redundant ways of spelling
"if (...) { ... }".  Common examples include:

	if ( $x ) { do_something() }
	do_something() if $x;

	unless ( $x ) { do_something() }
	do_something() unless $x;

	$x && do_something();
	$x || do_something();

	$x and do_something();
	$x or do_something();

Sometimes people find very practical reasons why these aren't good
programming practice, but the rest of the time everyone just argues
about whether they're good grammar.

The "&&" and "||" operators are an example of bad programming practice -
these operators have relatively high precedence, so tend to behave
unintuitively when used in (often regrettably) complex ways.  The "and"
and "or" operators behave just like "&&" and "||", but with a precedence
low enough to avoid weirdness.  See [1] for an example.

Some people consider anything but a traditional prefix-if() statement to
be bad grammar (I believe "Perl Best Practices" makes the argument,
which is definitive for many people).  Other people say anything in the
language is by definition fair game.  The rest of us spend a lot of time
making arguments like the above, and frankly I think we gain more from
the debate than the conclusion.

	- Andrew

[1] http://perldoc.perl.org/perlop.html#C-style-Logical-Defined-Or

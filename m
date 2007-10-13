From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 18:38:21 +0200
Message-ID: <4710F47D.2070306@gmx.ch>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 18:39:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igk0j-0001dk-Ie
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 18:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbXJMQib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 12:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbXJMQia
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 12:38:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:46189 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755750AbXJMQia (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 12:38:30 -0400
Received: (qmail invoked by alias); 13 Oct 2007 16:38:27 -0000
Received: from 123-188.0-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.0.188.123]
  by mail.gmx.net (mp046) with SMTP; 13 Oct 2007 18:38:27 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1+INadQfjyIPXaMI2LIX2S462MrCmdrDI7MJlpbUm
	d4Kg7IDon7J+Bc
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
In-Reply-To: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

I really like the idea of colorizing git add -i, especially the
prompt.  Here are my two cents.

Wincent Colaiuta wrote:
> +sub print_ansi_color($$;$) {
> +    my $color = shift;
> +    my $string = shift;
> +    my $trailer = shift;

None of the other subs in this file have a prototype, so for
consistency I'd suggest to not add it on this function either.
However maybe a patch that adds it to all subs would be welcome.
(I wouldn't see the necessity though.)

And the common way of getting the arguments is reading @_ (see all
other subs in the file).  So maybe instead write:

[...]
sub print_ansi_color {
	my ($color, $string, $trailer) = @_;
[...]

> +    if ($use_color) {
> +        printf '%s%s%s', Term::ANSIColor::color($color), $string,
> +            Term::ANSIColor::color('clear');
> +    } else {

Why use printf when you could directly use print here?  It's only
used for concatenating.

> +    if ($trailer) {
> +        print $trailer;
> +    }

This will fail to print $trailer when $trailer happens to be a
string that evaluates to false in bool context, like '0'.  Write
this as:

	if (defined $trailer) {
	    print $trailer;
	}

IMHO, parsing the output of 'git diff-files --color' is a very bad
idea and it makes all regexes uglier and more difficult to read.
You're much better off recolorizing it yourself, which makes it a
more localized change.  Especially, I don't think that you have
any guarantee that escape sequences won't ever contain the
characters '+', '-' or ' ' (space), which would break your code on
lines like this:

> +        if ($line =~ /^[^-+ ]*\+/) { 

Finally -- and this might be just my eyes -- blue is a very nice
color, but it looks a bit too dark on black background.  Maybe
choose a default color that looks reasonable on black *and* white
background.

Cheers,
jlh

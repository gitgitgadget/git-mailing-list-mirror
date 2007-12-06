From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 3/3] Color support for "git-add -i"
Date: Thu, 6 Dec 2007 20:59:48 +0100
Message-ID: <5055E3DF-E01D-41B5-9F59-DAD69885CAE8@wincent.com>
References: <475697BC.2090701@viscovery.net> <1196906706-11170-1-git-send-email-gitster@pobox.com> <1196906706-11170-2-git-send-email-gitster@pobox.com> <1196906706-11170-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 21:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Mvl-00029Y-15
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 21:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbXLFUCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2007 15:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXLFUCV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 15:02:21 -0500
Received: from wincent.com ([72.3.236.74]:40261 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355AbXLFUCS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 15:02:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB6JxmIh026497;
	Thu, 6 Dec 2007 13:59:49 -0600
In-Reply-To: <1196906706-11170-3-git-send-email-gitster@pobox.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67330>

El 6/12/2007, a las 3:05, Junio C Hamano escribi=F3:

> +sub colored_diff_hunk {
> +	my ($text) =3D @_;
> +	# return the text, so that it can be passed to print()
> +	my @ret;
> +	for (@$text) {
> +		if (!$diff_use_color) {
> +			push @ret, $_;
> +			next;
> +		}
> +
> +		if (/^\+/) {
> +			push @ret, colored($new_color, $_);
> +		} elsif (/^\-/) {
> +			push @ret, colored($old_color, $_);
> +		} elsif (/^\@/) {
> +			push @ret, colored($fraginfo_color, $_);
> +		} elsif (/^ /) {
> +			push @ret, colored($normal_color, $_);
> +		} else {
> +			push @ret, colored($metainfo_color, $_);
> +		}
> +	}
> +	return @ret;
> +}


My one concern here is that as Git's awareness of whitespace problems =20
becomes more sophisticated it will be harder and harder to do diff =20
colorization in a way that matches that which is performed by the =20
builtin diff tools. Here I'm talking about the whole core.whitespace =20
series which allows the user to define per-path attributes specifying =20
what kinds of things are to be considered whitespace errors; so far we =
=20
have three classes of error proposed as far as I know: trailing =20
whitespace, spaces before tabs, and indents with non-tabs.

I think it's very important that "git add --interactive" be 100% =20
consistent with the other tools here because in many cases the =20
previewing you do during an interactive session is what you rely upon =20
to review whether a change should be committed. In other words, you =20
don't want to think stuff is ok because "git add --interactive" leads =20
you to believe that it's ok when it really isn't, and you don't want =20
to have to run "git diff" as a separate step either just to double =20
check.

We can replicate the core.whitespace logic here but it's likely to be =20
an error prone process as it involves repeating the same logic in two =20
different places using two different implementations in two different =20
languages.

What are the other options?

- Make git-add--interactive part of builtin-add so as to be able to =20
use the core.whitespace code directly? (ideally yes and at some point =20
in the future it seems inevitable that this will happen, but it will =20
require a fair bit of work)

- Fork a second "git diff-files" process to capture the colorized =20
version of the output? (may set off the "kludge" alarm)

- Something else?

Cheers,
Wincent

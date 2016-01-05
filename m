From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] t6050-replace: make failing editor test more robust
Date: Tue, 5 Jan 2016 10:39:33 -0500
Message-ID: <20160105153933.GA5586@sigill.intra.peff.net>
References: <1451990010-15458-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 16:39:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGTi0-0000U0-FP
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 16:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbcAEPjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 10:39:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:48927 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751603AbcAEPjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 10:39:36 -0500
Received: (qmail 16499 invoked by uid 102); 5 Jan 2016 15:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jan 2016 10:39:35 -0500
Received: (qmail 13811 invoked by uid 107); 5 Jan 2016 15:39:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jan 2016 10:39:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jan 2016 10:39:33 -0500
Content-Disposition: inline
In-Reply-To: <1451990010-15458-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283381>

On Tue, Jan 05, 2016 at 11:33:30AM +0100, SZEDER G=C3=A1bor wrote:

> However, this editor doesn't actually modify the edited object,
> because start_command() turns this editor into:
>=20
>   /bin/sh -c './fakeeditor;false "$@"' './fakeeditor;false' \
>           '.../.git/REPLACE_EDITOBJ'

Thanks for thorough explanation. I think your patch makes sense.

> Should we be more thorough, perhaps, and check the error message to b=
e
> extra sure that 'git replace --edit' errors out for the expected
> reason?  There are oh so many 'test_must_fail's in our test scripts
> and we don't check the error message in most of the cases...

We usually try to avoid hard-coding error messages, because they end up
brittle. I think if we've isolated the failure, it's a reasonable test
(in an ideal world, you check that "foo" doesn't fail, and "foo -wrong"
does fail; i.e., just changing one variable in your experiment).

>  test_expect_success '--edit with and without already replaced object=
' '
> @@ -372,7 +376,7 @@ test_expect_success '--edit with and without alre=
ady replaced object' '
>  test_expect_success '--edit and change nothing or command failed' '
>  	git replace -d "$PARA3" &&
>  	test_must_fail env GIT_EDITOR=3Dtrue git replace --edit "$PARA3" &&
> -	test_must_fail env GIT_EDITOR=3D"./fakeeditor;false" git replace --=
edit "$PARA3" &&
> +	test_must_fail env GIT_EDITOR=3D"./failingfakeeditor" git replace -=
-edit "$PARA3" &&

We have the same problem when running aliases, or any git command that
you want to expand into more complex shell. The usual solution for
one-off is something like:

  test_must_fail env GIT_EDITOR=3D"f() { ./fakeeditor; false; } f" git =
=2E..

That might be preferable to yours, because a reader can see immediately
in the test what is going on, without wondering what it is that
failingfakeeditor does. OTOH, it is perhaps somewhat non-obvious. It
came to mind to me because it is an idiom we use elsewhere; I remember
thinking it was very clever the first time somebody showed it to me. :)

I'd be OK with the patch using either method.

-Peff

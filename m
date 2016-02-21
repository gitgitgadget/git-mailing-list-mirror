From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 23:41:35 +0000
Message-ID: <20160221234135.GA14382@river.lan>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
 <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
 <20160221231913.GA4094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:41:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXddW-0005Pa-QJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbcBUXly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:41:54 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:49022 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcBUXly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:41:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 03E04CDA525;
	Sun, 21 Feb 2016 23:41:53 +0000 (GMT)
X-Quarantine-ID: <bLiI+n80Fo1n>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bLiI+n80Fo1n; Sun, 21 Feb 2016 23:41:52 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2FB5DCDA5D6;
	Sun, 21 Feb 2016 23:41:41 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20160221231913.GA4094@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286850>

On Sun, Feb 21, 2016 at 06:19:14PM -0500, Jeff King wrote:
> On Sun, Feb 21, 2016 at 04:01:27PM -0500, Eric Sunshine wrote:
> 
> > On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
> > > GNU grep 2.23 detects the input used in this test as binary data so it
> > > does not work for extracting lines from a file.  We could add the "-a"
> > > option to force grep to treat the input as text, but not all
> > > implementations support that.  Instead, use sed to extract the desired
> > > lines since it will always treat its input as text.
> > >
> > > While touching these lines, modernize the test style to avoid hiding the
> > > exit status of "git blame" and remove a space following a redirection
> > > operator.
> > >
> > > Signed-off-by: John Keeping <john@keeping.me.uk>
> > > ---
> > > diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
> > > @@ -35,8 +35,8 @@ EOF
> > >  test_expect_success !MINGW \
> > >         'blame respects i18n.commitencoding' '
> > > -       git blame --incremental file | \
> > > -               egrep "^(author|summary) " > actual &&
> > > +       git blame --incremental file >output &&
> > > +       sed -ne "/^\(author\|summary\) /p" output >actual &&
> > 
> > These tests all crash and burn with BSD sed (including Mac OS X) since
> > you're not restricting yourself to BRE (basic regular expressions).
> > You _could_ request extended regular expressions, which do work on
> > those platforms, as well as with GNU sed:
> > 
> >     sed -nEe "/^(author|summary) /p" ...
> 
> At that point, I think we may as well use grep, because obscure
> platforms are probably broken either way.

Also GNU sed doesn't understand "-E", it uses "-r" for --regexp-extended.

> I'm tempted to just go the perl route. We already depend on at least a
> baisc version of perl5 being installed for many of the other tests, so
> it's not really introducing a new dependency.
> 
> Something like the patch below works for me. I think we could make it
> shorter by using $PERLIO to get the raw behavior, but using binmode will
> work even on ancient versions of perl.
> 
> John, if you agree on the direction, feel free to combine it with your
> patch.

My original sed version was:

	sed -ne "/^author /p" -e "/^summary /p"

which I think will work on all platforms (we already use it in
t0000-basic.sh) but then I decided to be too clever :-(

I still think sed is simpler than introducing a new function to wrap a
perl script.

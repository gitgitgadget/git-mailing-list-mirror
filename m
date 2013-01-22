From: Jeff King <peff@peff.net>
Subject: Re: Build broken for contrib/remote-helpers...
Date: Tue, 22 Jan 2013 14:41:35 -0500
Message-ID: <20130122194135.GA23521@sigill.intra.peff.net>
References: <CAEBDL5U+Yrny-YgN1fZj1T+XTJRVaiFvMixT13Zzb2DhhYgQsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 20:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxjjM-0001rN-IN
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 20:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab3AVTlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 14:41:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab3AVTli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 14:41:38 -0500
Received: (qmail 28064 invoked by uid 107); 22 Jan 2013 19:42:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jan 2013 14:42:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2013 14:41:35 -0500
Content-Disposition: inline
In-Reply-To: <CAEBDL5U+Yrny-YgN1fZj1T+XTJRVaiFvMixT13Zzb2DhhYgQsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214247>

On Tue, Jan 22, 2013 at 12:49:31AM -0500, John Szakmeister wrote:

> I tried running make in contrib/remote-helpers and it died with:
> 
>     :: make
>     make -e -C ../../t test
>     rm -f -r test-results
>     duplicate test numbers: /Users/jszakmeister/sources/git
>     make[1]: *** [test-lint-duplicates] Error 1
>     make: *** [test] Error 2
> 
> The path shown is not quite correct.  I have the sources extracted to
> /Users/jszakmeister/sources/git-1.8.1.1.  It appears that the Makefile
> in contrib/remote-helpers is exporting T, which is causing the
> duplicate test detection to fail.

It has to set T, because that is how t/Makefile knows what the set of
tests is. The problem is that test-lint-duplicates does not understand
absolute pathnames, as its regex is too simplistic:

  sed 's/-.*//' | sort | uniq -d

So it finds whatever is before the first "-", which would be the test
number in "t0000-basic.sh" or similar, and then looks for duplicates.

We can make the regex more strict to handle full paths, like:

  perl -lne 'print $1 if m{(?:^|/)(t\d{4})-}'

but that still would not help, as the tests in remote-helpers do not
follow the tXXXX convention. So I think even running
test-lint-duplicates on them is nonsensical.

Maybe something like this would be more appropriate, though it kills off
all test-lint checks, not just test-lint-duplicates:

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 9a76575..9c18ed8 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -3,6 +3,7 @@ export PATH := $(CURDIR):$(PATH)
 export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
 export PATH := $(CURDIR):$(PATH)
+export TEST_LINT :=
 
 test:
 	$(MAKE) -C ../../t $@

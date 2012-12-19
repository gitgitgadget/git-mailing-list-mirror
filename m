From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0200: "locale" may not exist
Date: Wed, 19 Dec 2012 08:18:22 -0500
Message-ID: <20121219131822.GB7134@sigill.intra.peff.net>
References: <7vlicubkt4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 14:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJXn-0008EX-ON
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab2LSNS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 08:18:27 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58438 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab2LSNSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:18:25 -0500
Received: (qmail 28675 invoked by uid 107); 19 Dec 2012 13:19:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 08:19:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 08:18:22 -0500
Content-Disposition: inline
In-Reply-To: <7vlicubkt4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211821>

On Tue, Dec 18, 2012 at 10:47:03PM -0800, Junio C Hamano wrote:

> On systems without "locale" installed, t0200-gettext-basic.sh leaked
> error messages when checking if some test locales are available.
> Hide them, as they are not very useful.

Obviously correct, though there is another way:

> diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
> index 0f76f6c..ae8883a 100644
> --- a/t/lib-gettext.sh
> +++ b/t/lib-gettext.sh
> @@ -14,12 +14,14 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
>  if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON

If we turn this line into:

  test_expect_success GETTEXT,!GETTEXT_POISON 'setup locale' '

then people can see the error output of the setup step in verbose mode.

Annoyingly, though, it means tweaking the quoting throughout the block
to handle embedded single-quotes (if there is one feature I could take
from perl back into shell, it would be arbitrary quote delimiters).

Patch is below. I don't know if it is worth the complexity.

-Peff

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 0f76f6c..d962c00 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -11,18 +11,17 @@ then
 
 . "$GIT_BUILD_DIR"/git-sh-i18n
 
-if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
-then
+test_expect_success GETTEXT,!GETTEXT_POISON 'setup locale' '
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
-	is_IS_locale=$(locale -a | sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
+	is_IS_locale=$(locale -a | sed -n "/^is_IS\.[uU][tT][fF]-*8\$/{
 		p
 		q
-	}')
+	}")
 	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
-	is_IS_iso_locale=$(locale -a | sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
+	is_IS_iso_locale=$(locale -a | sed -n "/^is_IS\.[iI][sS][oO]8859-*1\$/{
 		p
 		q
-	}')
+	}")
 
 	# Export them as an environment variable so the t0202/test.pl Perl
 	# test can use it too
@@ -37,7 +36,7 @@ then
 		# Exporting for t0202/test.pl
 		GETTEXT_LOCALE=1
 		export GETTEXT_LOCALE
-		say "# lib-gettext: Found '$is_IS_locale' as an is_IS UTF-8 locale"
+		say "# lib-gettext: Found \"$is_IS_locale\" as an is_IS UTF-8 locale"
 	else
 		say "# lib-gettext: No is_IS UTF-8 locale available"
 	fi
@@ -48,8 +47,8 @@ then
 		# Some of the tests need the reference Icelandic locale
 		test_set_prereq GETTEXT_ISO_LOCALE
 
-		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1 locale"
+		say "# lib-gettext: Found \"$is_IS_iso_locale\" as an is_IS ISO-8859-1 locale"
 	else
 		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
 	fi
-fi
+'

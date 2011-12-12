From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Makefile: optionally exclude code that needs Unix
 sockets
Date: Mon, 12 Dec 2011 16:39:51 -0500
Message-ID: <20111212213951.GB9754@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104130.GI16648@sigill.intra.peff.net>
 <4EE66DAB.5070407@kdbg.org>
 <4EE66E58.6040404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDbL-0007mU-08
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab1LLVjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:39:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48333
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415Ab1LLVjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:39:54 -0500
Received: (qmail 5655 invoked by uid 107); 12 Dec 2011 21:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 16:46:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 16:39:51 -0500
Content-Disposition: inline
In-Reply-To: <4EE66E58.6040404@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186956>

On Mon, Dec 12, 2011 at 10:12:56PM +0100, Johannes Sixt wrote:

> Introduce a configuration option NO_UNIX_SOCKETS to exclude code that
> depends on Unix sockets and use it in MSVC and MinGW builds.

Makes sense, thanks.

> Notice that unix-socket.h was missing from LIB_H before; fix that, too.

Oops, thanks.

> All or most of the tests introduced by the series fail on Windows.
> What is the preferred way to exclude them? Mark the all with a
> prerequisite? Or exit early at the beginning of the test file?

The cache daemon is the only thing that uses sockets. I would suggest
just exiting early from its script (patch below).

The rest of the tests should pass under Windows. If they don't, then
they should be fixed (I'm happy to work on that, with the limitation
that I don't actually have a Windows box, and if at all possible I'd
like to keep it that way).

In theory we should also disable the documentation for credential-cache.
But that means surgery not only to Documentation/Makefile, but figuring
out how to pass the flags down to the actual asciidoc process (since
gitcredentials(7) mentions it in the text). Certainly possible, but I
don't know if it's worth the effort or not.

---
diff --git a/Makefile b/Makefile
index e3ee884..6e7e190 100644
--- a/Makefile
+++ b/Makefile
@@ -2220,6 +2220,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@
 endif
 	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@
+	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 3a65f99..82c8411 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -4,6 +4,11 @@ test_description='credential-cache tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
+test -z "$NO_UNIX_SOCKETS" || {
+	skip_all='skipping credential-cache tests, unix sockets not available'
+	test_done
+}
+
 # don't leave a stale daemon running
 trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
 

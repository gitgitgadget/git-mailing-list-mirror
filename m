From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu, 2 Feb 2012 15:02:40 -0500
Message-ID: <20120202200240.GC9246@sigill.intra.peff.net>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2rq-0004Ml-0D
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab2BBUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:02:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119Ab2BBUCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:02:43 -0500
Received: (qmail 24809 invoked by uid 107); 2 Feb 2012 20:09:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 15:09:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 15:02:40 -0500
Content-Disposition: inline
In-Reply-To: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189689>

On Thu, Feb 02, 2012 at 02:32:15PM -0500, Ben Walton wrote:

> Solaris' /bin/sh was making the IFS setting permanent instead of
> temporary when using it to slurp in credentials in the generated
> 'dump' script of the 'setup helper scripts' test in t0300-credentials.

Hmm. Presumably you are setting SHELL_PATH, as Solaris /bin/sh would be
useless for running the rest of the tests. Usually scripts inside the
tests use #!$SHELL_PATH, but I often don't bother if it's a simple "even
Solaris /bin/sh could run this" script. But in this case I either
underestimated the complexity of my script or overestimated the quality
of the Solaris /bin/sh.

I wonder if a better solution is to use a known-good shell instead of
trying to work around problems in a bogus shell. Does the patch below
fix it for you?

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 885af8f..edf6547 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -14,15 +14,15 @@ test_expect_success 'setup helper scripts' '
 	done
 	EOF
 
-	cat >git-credential-useless <<-\EOF &&
-	#!/bin/sh
+	cat >git-credential-useless <<-EOF &&
+	#!$SHELL_PATH
 	. ./dump
 	exit 0
 	EOF
 	chmod +x git-credential-useless &&
 
-	cat >git-credential-verbatim <<-\EOF &&
-	#!/bin/sh
+	echo "#!$SHELL_PATH" >git-credential-verbatim &&
+	cat >>git-credential-verbatim <<-\EOF &&
 	user=$1; shift
 	pass=$1; shift
 	. ./dump

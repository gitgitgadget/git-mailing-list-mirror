From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] t0300: use write_script helper
Date: Sat, 4 Feb 2012 01:30:18 -0500
Message-ID: <20120204063018.GB21559@sigill.intra.peff.net>
References: <20120204062712.GA20076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:30:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZ8k-0004Au-Aa
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab2BDGaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 01:30:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57310
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2BDGaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 01:30:20 -0500
Received: (qmail 6371 invoked by uid 107); 4 Feb 2012 06:37:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 01:37:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 01:30:18 -0500
Content-Disposition: inline
In-Reply-To: <20120204062712.GA20076@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189851>

t0300 creates some helper shell scripts, and marks them with
"!/bin/sh". Even though the scripts are fairly simple, they
can fail on broken shells (specifically, Solaris /bin/sh
will persist a temporary assignment to IFS in a "read"
command).

Rather than work around the problem for Solaris /bin/sh,
using write_script will make sure we point to a known-good
shell that the user has given us.

Signed-off-by: Jeff King <peff@peff.net>
---
This works fine on my Linux box, but just to sanity check that I didn't
screw anything up in the whopping 5 lines of changes, can you confirm
this fixes the issue for you, Ben?

 t/t0300-credentials.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 885af8f..0b46248 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -14,14 +14,13 @@ test_expect_success 'setup helper scripts' '
 	done
 	EOF
 
-	cat >git-credential-useless <<-\EOF &&
+	write_script git-credential-useless <<-\EOF &&
 	#!/bin/sh
 	. ./dump
 	exit 0
 	EOF
-	chmod +x git-credential-useless &&
 
-	cat >git-credential-verbatim <<-\EOF &&
+	write_script git-credential-verbatim <<-\EOF &&
 	#!/bin/sh
 	user=$1; shift
 	pass=$1; shift
@@ -29,7 +28,6 @@ test_expect_success 'setup helper scripts' '
 	test -z "$user" || echo username=$user
 	test -z "$pass" || echo password=$pass
 	EOF
-	chmod +x git-credential-verbatim &&
 
 	PATH="$PWD:$PATH"
 '
-- 
1.7.9.rc1.28.gf4be5

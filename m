From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] tests: add write_script helper function
Date: Sat, 4 Feb 2012 01:29:01 -0500
Message-ID: <20120204062901.GA21559@sigill.intra.peff.net>
References: <20120204062712.GA20076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:29:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZ7V-0003hl-F3
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab2BDG3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 01:29:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57306
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2BDG3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 01:29:03 -0500
Received: (qmail 6340 invoked by uid 107); 4 Feb 2012 06:36:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 01:36:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 01:29:01 -0500
Content-Disposition: inline
In-Reply-To: <20120204062712.GA20076@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189850>

From: Junio C Hamano <gitster@pobox.com>

Many of the scripts in the test suite write small helper
shell scripts to disk. It's best if these shell scripts
start with "#!$SHELL_PATH" rather than "#!/bin/sh", because
/bin/sh on some platforms is too buggy to be used.

However, it can be cumbersome to expand $SHELL_PATH, because
the usual recipe for writing a script is:

	cat >foo.sh <<-\EOF
	#!/bin/sh
	echo my arguments are "$@"
	EOF

To expand $SHELL_PATH, you have to either interpolate the
here-doc (which would require quoting "\$@"), or split the
creation into two commands (interpolating the $SHELL_PATH
line, but not the rest of the script). Let's provide a
helper function that makes that less syntactically painful.

While we're at it, this helper can also take care of the
"chmod +x" that typically comes after the creation of such a
script, saving the caller a line.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect you already have this in your repo, but maybe the commit
message is useful.

 t/test-lib.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b22bee7..254849e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -400,6 +400,14 @@ test_config_global () {
 	git config --global "$@"
 }
 
+write_script () {
+	{
+		echo "#!${2-"$SHELL_PATH"}" &&
+		cat
+	} >"$1" &&
+	chmod +x "$1"
+}
+
 # Use test_set_prereq to tell that a particular prerequisite is available.
 # The prerequisite can later be checked for in two ways:
 #
-- 
1.7.9.rc1.28.gf4be5

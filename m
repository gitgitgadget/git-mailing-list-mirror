From: Jeff King <peff@peff.net>
Subject: [PATCH] t0300: work around bug in dash 0.5.6
Date: Fri, 2 Mar 2012 19:37:35 -0500
Message-ID: <20120303003735.GA804@sigill.intra.peff.net>
References: <93904081120af9a646b8bda96aa2da8e85cc063d.1330700524.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 01:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3cyx-000851-Jy
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 01:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405Ab2CCAhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 19:37:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35700
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab2CCAhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 19:37:38 -0500
Received: (qmail 32728 invoked by uid 107); 3 Mar 2012 00:37:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Mar 2012 19:37:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2012 19:37:35 -0500
Content-Disposition: inline
In-Reply-To: <93904081120af9a646b8bda96aa2da8e85cc063d.1330700524.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192077>

From: Michael J Gruber <git@drmicha.warpmail.net>

The construct 'while IFS== read' makes dash 0.5.6 execute
read without changing IFS, which results in test breakages
all over the place in t0300.  Neither dash 0.5.5.1 and older
nor dash 0.5.7 and newer are affected: The problem was
introduded resp. fixed by the commits

  55c46b7 ([BUILTIN] Honor tab as IFS whitespace when
           splitting fields in readcmd, 2009-08-11)

  1d806ac ([VAR] Do not poplocalvars prematurely on regular
           utilities, 2010-05-27)

in http://git.kernel.org/?p=utils/dash/dash.git

Putting 'IFS==' before that line makes all versions of dash
work.

This looks like a dash bug, not a misinterpretation of the
standard. However, it's worth working around for two
reasons. One, this version of dash was released in Fedora
14-16, so the bug is found in the wild. And two, at least
one other shell, Solaris /bin/sh, choked on this by
persisting IFS after the read invocation. That is not a
shell we usually care about, and I think this use of IFS is
acceptable by POSIX (which allows other behavior near
"special builtins", but "read" is not one of those). But it
seems that this may be a subtle, not-well-tested case for
some shells. Given that the workaround is so simple, it's
worth just being defensive.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Jeff King <peff@peff.net>
---
Michael and I discussed this off-list. The patch is his, but I've
rewritten much of the commit message to incorporate the recent thread
over this exact same bit of code on Solaris:

  http://thread.gmane.org/gmane.comp.version-control.git/189680

This patch is basically the same as Ben Walton's from that thread, but
we ended up creating and using the write_script function to avoid using
Solaris /bin/sh at all.

 t/t0300-credentials.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 8621ab0..20e28e3 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -8,10 +8,13 @@ test_expect_success 'setup helper scripts' '
 	cat >dump <<-\EOF &&
 	whoami=`echo $0 | sed s/.*git-credential-//`
 	echo >&2 "$whoami: $*"
-	while IFS== read key value; do
+	OIFS=$IFS
+	IFS==
+	while read key value; do
 		echo >&2 "$whoami: $key=$value"
 		eval "$key=$value"
 	done
+	IFS=$OIFS
 	EOF
 
 	write_script git-credential-useless <<-\EOF &&
-- 
1.7.6.6.7.g65e2

From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] git-sh-setup: refactor ident-parsing functions
Date: Thu, 18 Oct 2012 03:25:22 -0400
Message-ID: <20121018072522.GA9999@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOkU4-000334-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab2JRHZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:25:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37527 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab2JRHZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:25:25 -0400
Received: (qmail 2548 invoked by uid 107); 18 Oct 2012 07:26:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 03:26:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 03:25:22 -0400
Content-Disposition: inline
In-Reply-To: <20121018072207.GA1605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207972>

The only ident-parsing function we currently provide is
get_author_ident_from_commit. This is not very
flexible for two reasons:

  1. It takes a commit as an argument, and can't read from
     commit headers saved on disk.

  2. It will only parse authors, not committers.

This patch provides a more flexible interface which will
parse multiple idents from a commit provide on stdin. We can
easily use it as a building block for the current function
to retain compatibility.

Signed-off-by: Jeff King <peff@peff.net>
---
Since we are counting processes in this series, I should note that this
actually adds a subshell invocation for each call, since it went from:

  script='...'
  sed $script

to:

  sed "$(make_script)"

For filter-branch, which is really the only high-performance caller we
have, this is negated by the fact that it will do author and committer
at the same time, saving us an extra subshell (in addition to an extra
sed invocation).

 git-sh-setup.sh | 62 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ee0e0bc..22f0aed 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -191,28 +191,52 @@ get_author_ident_from_commit () {
 	fi
 }
 
+# Generate a sed script to parse identities from a commit.
+#
+# Reads the commit from stdin, which should be in raw format (e.g., from
+# cat-file or "--pretty=raw").
+#
+# The first argument specifies the ident line to parse (e.g., "author"), and
+# the second specifies the environment variable to put it in (e.g., "AUTHOR"
+# for "GIT_AUTHOR_*"). Multiple pairs can be given to parse author and
+# committer.
+pick_ident_script () {
+	while test $# -gt 0
+	do
+		lid=$1; shift
+		uid=$1; shift
+		printf '%s' "
+		/^$lid /{
+			s/'/'\\\\''/g
+			h
+			s/^$lid "'\([^<]*\) <[^>]*> .*$/\1/'"
+			s/.*/GIT_${uid}_NAME='&'/p
+
+			g
+			s/^$lid "'[^<]* <\([^>]*\)> .*$/\1/'"
+			s/.*/GIT_${uid}_EMAIL='&'/p
+
+			g
+			s/^$lid "'[^<]* <[^>]*> \(.*\)$/@\1/'"
+			s/.*/GIT_${uid}_DATE='&'/p
+		}
+		"
+	done
+	echo '/^$/q'
+}
+
+# Create a pick-script as above and feed it to sed. Stdout is suitable for
+# feeding to eval.
+parse_ident_from_commit () {
+	LANG=C LC_ALL=C sed -ne "$(pick_ident_script "$@")"
+}
+
+# Parse the author from a commit given as an argument. Stdout is suitable for
+# feeding to eval to set the usual GIT_* ident variables.
 get_author_ident_from_commit () {
-	pick_author_script='
-	/^author /{
-		s/'\''/'\''\\'\'\''/g
-		h
-		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-		g
-		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-		g
-		s/^author [^<]* <[^>]*> \(.*\)$/@\1/
-		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-		q
-	}
-	'
 	encoding=$(git config i18n.commitencoding || echo UTF-8)
 	git show -s --pretty=raw --encoding="$encoding" "$1" -- |
-	LANG=C LC_ALL=C sed -ne "$pick_author_script"
+	parse_ident_from_commit author AUTHOR
 }
 
 # Clear repo-local GIT_* environment variables. Useful when switching to
-- 
1.8.0.rc3.3.gba630e1

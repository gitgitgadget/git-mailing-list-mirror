From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] completion: improve shell expansion of items
Date: Wed, 26 Sep 2012 17:51:19 -0400
Message-ID: <20120926215119.GC18653@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGzVy-0007KJ-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 23:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab2IZVvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 17:51:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59365 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab2IZVvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 17:51:21 -0400
Received: (qmail 28094 invoked by uid 107); 26 Sep 2012 21:51:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Sep 2012 17:51:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2012 17:51:19 -0400
Content-Disposition: inline
In-Reply-To: <20120926214653.GA18628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206451>

The current completion code doesn't deal properly with items
(tags, branches, etc.) that have ${} in them because they
get expanded by bash while using compgen.

This patch is a rewrite of Felipe Contreras's 25ae7cf, which
attempted to fix the problem by quoting the values we pass
to __gitcomp_nl. However, that patch ended up quoting the
whole list as a single item, which broke other completions.
Instead, we need to split the newline-delimited list into
elements and quote each one individually.

This is not a complete fix, as the completion result does
will still contain metacharacters, so it would need extra
quoting to actually be used on a command line. But it's
still a step in the right direction, because:

  1. The current code's expansion means that things that are
     broken expansions (e.g., "${foo:bar}") will actually
     cause the completion function to barf, breaking all
     completion (even if you weren't going to complete that
     item). This patch fixes that so you can at least
     complete "foo" when "${foo:bar}" exists.

  2. We don't know yet what the final fix will look like,
     but this is probably the first step towards it. It
     handles quoting on the input side of compgen; the next
     step will likely be handling the quoting on the output
     side of compgen to yield a usable string for the
     command line.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/completion/git-completion.bash | 14 +++++++++++++-
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..b0416ea 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,6 +225,18 @@ fi
 fi
 fi
 
+# Quotes each element of an IFS-delimited list for shell reuse
+__git_quote()
+{
+	local i
+	local delim
+	for i in $1; do
+		local quoted=${i//\'/\'\\\'\'}
+		printf "${delim:+$IFS}'%s'" "$quoted"
+		delim=t
+	done
+}
+
 # Generates completion reply with compgen, appending a space to possible
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -261,7 +273,7 @@ __gitcomp_nl ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1")" -- "${3-$cur}"))
 }
 
 __git_heads ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..da67705 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -278,7 +278,7 @@ test_expect_success 'complete tree filename with spaces' '
 	EOF
 '
 
-test_expect_failure 'complete tree filename with metacharacters' '
+test_expect_success 'complete tree filename with metacharacters' '
 	echo content >"name with \${meta}" &&
 	git add . &&
 	git commit -m meta &&
-- 
1.7.12.10.g31da6dd

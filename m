From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] do not read beyond end of malloc'd buffer
Date: Fri, 20 May 2011 19:20:12 +0200
Message-ID: <877h9lb86r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 19:20:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNTNC-0007G3-OU
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab1ETRUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 13:20:21 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:45150 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab1ETRUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 13:20:21 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 53DE394004B
	for <git@vger.kernel.org>; Fri, 20 May 2011 19:20:14 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 07B6C600AE; Fri, 20 May 2011 19:20:12 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174070>

I was surprised to see "git diff --word-diff" output a ton of
garbage, and tracked it down to a bug that's triggered when the
diff.suppress-blank-empty config option to true and when at least
one of the context lines is empty.

Here's a quick demo you can run in an empty directory:

    printf 'a\n\n[-b-]{+c+}\n' > exp
    git init && git config diff.suppress-blank-empty true
    printf 'a\n\nb\n' > f && git add . && git commit -m. .
    printf 'a\n\nc\n' > f
    git diff --word-diff | tail -3 > out
    diff out exp

Before the patch, the git diff ... command would read from beyond
the end of a heap buffer, and "out" would contain far more than the
expected 5 bytes.

Here's the patch:

-- >8 --
Subject: [PATCH] do not read beyond end of malloc'd buffer

With diff.suppress-blank-empty=true, "git diff --word-diff" would
output data that had been read from uninitialized heap memory.
The problem was that fn_out_consume did not account for the
possibility of a line with length 1, i.e., the empty context line
that diff.suppress-blank-empty=true converts from " \n" to "\n".
Since it assumed there would always be a prefix character (the space),
it decremented "len" unconditionally, thus passing len=0 to emit_line,
which would then blindly call emit_line_0 with len=-1 which would
pass that value on to fwrite as SIZE_MAX.  Boom.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 diff.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index ba5f7aa..57eea74 100644
--- a/diff.c
+++ b/diff.c
@@ -1117,8 +1117,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			emit_line(ecbdata->opt, plain, reset, line, len);
 			fputs("~\n", ecbdata->opt->file);
 		} else {
-			/* don't print the prefix character */
-			emit_line(ecbdata->opt, plain, reset, line+1, len-1);
+			/* If there is a prefix character, skip it.
+			   With diff_suppress_blank_empty, there may be none. */
+			if (line[0] != '\n') {
+			      line++;
+			      len--;
+			}
+			emit_line(ecbdata->opt, plain, reset, line, len);
 		}
 		return;
 	}
--
1.7.5.2.316.gbcebc8b

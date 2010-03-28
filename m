From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 13:34:20 -0400
Message-ID: <20100328173420.GA18047@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <4BAF7F3F.5020604@drmicha.warpmail.net>
 <20100328161728.GA2828@coredump.intra.peff.net>
 <20100328161921.GA3435@coredump.intra.peff.net>
 <20100328165646.GA10293@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:34:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwNg-0002cf-6W
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab0C1Reb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:34:31 -0400
Received: from peff.net ([208.65.91.99]:59736 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab0C1Rea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:34:30 -0400
Received: (qmail 26224 invoked by uid 107); 28 Mar 2010 17:35:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 13:35:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 13:34:20 -0400
Content-Disposition: inline
In-Reply-To: <20100328165646.GA10293@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143405>

On Sun, Mar 28, 2010 at 12:56:46PM -0400, Jeff King wrote:

> Better, but not perfect. My script is below. I get:
> 
>   $ time git show >/dev/null
>   real    0m1.036s
>   user    0m0.412s
>   sys     0m0.672s
> 
> which is still a 2.5x speedup (versus my other fast-textconv solution
> earlier in the thread), but I suspect we can do better. The notes
> mechanism does some up-front work to get very fast lookups, but because
> we invoke git-notes repeatedly, we never get the amortized benefit of
> that up-front work.  Doing it in-core would fix that.

Here is a quick and dirty in-core implementation. The most notable
defect is that all textconvs store under refs/notes/textconv, which is
obviously bogus if you might textconv the same blob in two different
ways.

It was relatively easy to code thanks to a very nice notes interface
from Johan Herland. That same commit is now:

  $ time git show >/dev/null
  real    0m0.350s
  user    0m0.172s
  sys     0m0.176s

which is starting to feel sufficiently snappy.

Patch is on top of 1/3 from my earlier series (it uses some of the
centralizing cleanup).

diff --git a/diff.c b/diff.c
index 3ddc05e..e1ef25e 100644
--- a/diff.c
+++ b/diff.c
@@ -14,6 +14,8 @@
 #include "userdiff.h"
 #include "sigchain.h"
 #include "submodule.h"
+#include "notes.h"
+#include "refs.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3881,19 +3883,57 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	return strbuf_detach(&buf, outsize);
 }
 
+static struct notes_tree textconv_notes;
+static int textconv_notes_initialized;
+
+static const unsigned char *run_and_cache_textconv(const char *cmd,
+		struct diff_filespec *df)
+{
+	char *data;
+	size_t size;
+	unsigned char blob_sha1[20];
+	unsigned char tree_sha1[20];
+
+	data = run_textconv(cmd, df, &size);
+	if (!data)
+		die("unable to read files to diff");
+	if (write_sha1_file(data, size, "blob", blob_sha1) < 0)
+		die("unable to write textconv cache blob");
+	free(data);
+
+	add_note(&textconv_notes, df->sha1, blob_sha1, combine_notes_overwrite);
+	if (write_notes_tree(&textconv_notes, tree_sha1) < 0)
+		die("unable to write textconv cache notes tree");
+	update_ref("textconv cache update", "refs/notes/textconv",
+			tree_sha1, NULL, 0, DIE_ON_ERR);
+
+	return get_note(&textconv_notes, df->sha1);
+}
+
 static size_t fill_textconv(const char *cmd,
 			    struct diff_filespec *df,
 			    char **outbuf)
 {
-	size_t size;
+	const unsigned char *sha1;
+	unsigned long size;
+	enum object_type type;
 
 	if (!cmd) {
 		*outbuf = df->data;
 		return df->size;
 	}
 
-	*outbuf = run_textconv(cmd, df, &size);
+	if (!textconv_notes_initialized) {
+		init_notes(&textconv_notes, "refs/notes/textconv", 0, 0);
+		textconv_notes_initialized = 1;
+	}
+
+	sha1 = get_note(&textconv_notes, df->sha1);
+	if (!sha1)
+		sha1 = run_and_cache_textconv(cmd, df);
+
+	*outbuf = read_sha1_file(sha1, &type, &size);
 	if (!*outbuf)
-		die("unable to read files to diff");
+		die("unable to read textconv cache object");
 	return size;
 }

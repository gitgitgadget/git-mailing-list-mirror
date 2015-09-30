From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Tue, 29 Sep 2015 20:23:47 -0400
Message-ID: <20150930002347.GA23406@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 02:24:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zh5C0-0006nz-1k
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 02:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbI3AXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 20:23:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:37935 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751084AbbI3AXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 20:23:50 -0400
Received: (qmail 21339 invoked by uid 102); 30 Sep 2015 00:23:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Sep 2015 19:23:50 -0500
Received: (qmail 6917 invoked by uid 107); 30 Sep 2015 00:24:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Sep 2015 20:24:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Sep 2015 20:23:47 -0400
Content-Disposition: inline
In-Reply-To: <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278837>

On Tue, Sep 29, 2015 at 04:50:39PM -0700, Michael Blume wrote:

> I see compile errors on my mac:
> 
> First a whole bunch of
> 
> ./compat/precompose_utf8.h:30:45: warning: declaration of 'struct
> strbuf' will not be visible outside of this function [-Wvisibility]
> void probe_utf8_pathname_composition(struct strbuf *path);

Wow, my patch isn't even close to reasonable. I didn't realize because
we do not compile this code at all for non-Mac platforms. Sorry.

It probably needs something like this squashed in (completely untested):

diff --git a/builtin/init-db.c b/builtin/init-db.c
index cf6a3c8..c643054 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -283,7 +283,7 @@ static int create_default_files(const char *template_path)
 		path = git_path_buf(&buf, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
-		probe_utf8_pathname_composition(path);
+		probe_utf8_pathname_composition(&buf);
 	}
 
 	strbuf_release(&buf);
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index b4dd3c7..d2d2405 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
+#include "strbuf.h"
 
 typedef char *iconv_ibp;
 static const char *repo_encoding = "UTF-8";
@@ -45,17 +46,17 @@ void probe_utf8_pathname_composition(struct strbuf *path)
 	if (precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
 	strbuf_addstr(path, auml_nfc);
-	output_fd = open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	output_fd = open(path->buf, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >= 0) {
 		close(output_fd);
 		strbuf_setlen(path, baselen);
 		strbuf_addstr(path, auml_nfd);
-		precomposed_unicode = access(path, R_OK) ? 0 : 1;
+		precomposed_unicode = access(path->buf, R_OK) ? 0 : 1;
 		git_config_set("core.precomposeunicode", precomposed_unicode ? "true" : "false");
 		strbuf_setlen(path, baselen);
 		strbuf_addstr(path, auml_nfc);
-		if (unlink(path))
-			die_errno(_("failed to unlink '%s'"), path);
+		if (unlink(path->buf))
+			die_errno(_("failed to unlink '%s'"), path->buf);
 	}
 	strbuf_setlen(path, baselen);
 }
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 7fc7be5..229e772 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -4,6 +4,7 @@
 #include <dirent.h>
 #include <iconv.h>
 
+struct strbuf;
 
 typedef struct dirent_prec_psx {
 	ino_t d_ino;            /* Posix */

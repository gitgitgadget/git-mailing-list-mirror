From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sun, 8 Apr 2012 03:07:51 -0400
Message-ID: <20120408070751.GA13662@sigill.intra.peff.net>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
 <7v398gywb1.fsf@alter.siamese.dyndns.org>
 <20120407050913.GA4211@sigill.intra.peff.net>
 <7vaa2myfsz.fsf@alter.siamese.dyndns.org>
 <20120408064059.GA6727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 09:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGmEk-0000TF-Sq
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 09:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab2DHHH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 03:07:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2DHHH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 03:07:56 -0400
Received: (qmail 384 invoked by uid 107); 8 Apr 2012 07:07:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 03:07:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 03:07:51 -0400
Content-Disposition: inline
In-Reply-To: <20120408064059.GA6727@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194982>

On Sun, Apr 08, 2012 at 02:40:59AM -0400, Jeff King wrote:

> One way to implement that is by just wrapping the real helper inside a
> caching layer. That can even be generic.

Here's a C implementation of the shell sketch I posted earlier.
Obviously missing documentation, and only lightly tested, but just to
give a sense of what it would look like. You can exercise it manually
with:

  {
    # simulate git's input
    echo protocol=https
    echo host=example.com
  } |
  git credential-wrap cache '!f() {
    # note whether we ran or not
    echo >&2 Generating...
    # and simulate output
    echo username=fake.username
    echo password=fake.password
  }; f' get

or configure it with:

  git config credential.helper 'wrap cache your-real-helper'

---
 Makefile          |    1 +
 credential-wrap.c |   32 ++++++++++++++++++++++++++++++++
 credential.c      |    4 ++--
 credential.h      |    3 +++
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 credential-wrap.c

diff --git a/Makefile b/Makefile
index be1957a..c91bb23 100644
--- a/Makefile
+++ b/Makefile
@@ -463,6 +463,7 @@ PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += credential-store.o
+PROGRAM_OBJS += credential-wrap.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
diff --git a/credential-wrap.c b/credential-wrap.c
new file mode 100644
index 0000000..f4aadc4
--- /dev/null
+++ b/credential-wrap.c
@@ -0,0 +1,32 @@
+#include "cache.h"
+#include "credential.h"
+
+int main(int argc, const char **argv)
+{
+	struct credential c = CREDENTIAL_INIT;
+	const char *storage, *source, *action;
+
+	if (argc != 4)
+		usage("git credential-wrap <storage> <source> <action>");
+	storage = argv[1];
+	source = argv[2];
+	action = argv[3];
+
+	if (credential_read(&c, stdin) < 0)
+		die("unable to read input credential");
+
+	if (!strcmp(action, "get")) {
+		credential_do(&c, storage, "get");
+		if (!c.username || !c.password) {
+			credential_do(&c, source, "get");
+			if (!c.username || !c.password)
+				return 0;
+			credential_do(&c, storage, "store");
+		}
+		credential_write(&c, stdout);
+	}
+	else
+		credential_do(&c, storage, action);
+
+	return 0;
+}
diff --git a/credential.c b/credential.c
index 813e77a..13409e1 100644
--- a/credential.c
+++ b/credential.c
@@ -191,7 +191,7 @@ static void credential_write_item(FILE *fp, const char *key, const char *value)
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
-static void credential_write(const struct credential *c, FILE *fp)
+void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol);
 	credential_write_item(fp, "host", c->host);
@@ -241,7 +241,7 @@ static int run_credential_helper(struct credential *c,
 	return 0;
 }
 
-static int credential_do(struct credential *c, const char *helper,
+int credential_do(struct credential *c, const char *helper,
 			 const char *operation)
 {
 	struct strbuf cmd = STRBUF_INIT;
diff --git a/credential.h b/credential.h
index 96ea41b..daf3e81 100644
--- a/credential.h
+++ b/credential.h
@@ -30,4 +30,7 @@ void credential_from_url(struct credential *, const char *url);
 int credential_match(const struct credential *have,
 		     const struct credential *want);
 
+int credential_do(struct credential *, const char *helper, const char *action);
+void credential_write(const struct credential *, FILE *);
+
 #endif /* CREDENTIAL_H */
-- 
1.7.10.11.g901cee

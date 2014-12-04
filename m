From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] credential: let helpers tell us to quit
Date: Wed, 3 Dec 2014 22:46:48 -0500
Message-ID: <20141204034647.GA21492@peff.net>
References: <20141204034206.GA1493@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 04:46:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwNNW-0005lz-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 04:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbaLDDqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 22:46:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:48132 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752712AbaLDDqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 22:46:49 -0500
Received: (qmail 9436 invoked by uid 102); 4 Dec 2014 03:46:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 21:46:50 -0600
Received: (qmail 2956 invoked by uid 107); 4 Dec 2014 03:46:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 22:46:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2014 22:46:48 -0500
Content-Disposition: inline
In-Reply-To: <20141204034206.GA1493@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260725>

When we are trying to fill a credential, we loop over the
set of defined credential-helpers, then fall back to running
askpass, and then finally prompt on the terminal. Helpers
which cannot find a credential are free to tell us nothing,
but they cannot currently ask us to stop prompting.

This patch lets them provide a "quit" attribute, which asks
us to stop the process entirely (avoiding running more
helpers, as well as the askpass/terminal prompt).

This has a few possible uses:

  1. A helper which prompts the user itself (e.g., in a
     dialog) can provide a "cancel" button to the user to
     stop further prompts.

  2. Some helpers may know that prompting cannot possibly
     work. For example, if their role is to broker a ticket
     from an external auth system and that auth system
     cannot be contacted, there is no point in continuing
     (we need a ticket to authenticate, and the user cannot
     provide one by typing it in).

Signed-off-by: Jeff King <peff@peff.net>
---
+cc spearce, as I recall that you may do something similar to the second
scenario (and this would prevent annoying useless prompts when the
helper fails).

 Documentation/technical/api-credentials.txt | 5 ++++-
 credential.c                                | 5 +++++
 credential.h                                | 1 +
 t/t0300-credentials.sh                      | 9 +++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index c1b42a4..e44426d 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -248,7 +248,10 @@ FORMAT` in linkgit:git-credential[7] for a detailed specification).
 For a `get` operation, the helper should produce a list of attributes
 on stdout in the same format. A helper is free to produce a subset, or
 even no values at all if it has nothing useful to provide. Any provided
-attributes will overwrite those already known about by Git.
+attributes will overwrite those already known about by Git.  If a helper
+outputs a `quit` attribute with a value of `true` or `1`, no further
+helpers will be consulted, nor will the user be prompted (if no
+credential has been provided, the operation will then fail).
 
 For a `store` or `erase` operation, the helper's output is ignored.
 If it fails to perform the requested operation, it may complain to
diff --git a/credential.c b/credential.c
index 1886ea5..b146ad8 100644
--- a/credential.c
+++ b/credential.c
@@ -173,6 +173,8 @@ int credential_read(struct credential *c, FILE *fp)
 			c->path = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
+		} else if (!strcmp(key, "quit")) {
+			c->quit = !!git_config_bool("quit", value);
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -274,6 +276,9 @@ void credential_fill(struct credential *c)
 		credential_do(c, c->helpers.items[i].string, "get");
 		if (c->username && c->password)
 			return;
+		if (c->quit)
+			die("credential helper '%s' told us to quit",
+			    c->helpers.items[i].string);
 	}
 
 	credential_getpass(c);
diff --git a/credential.h b/credential.h
index 0c3e85e..6b0cd16 100644
--- a/credential.h
+++ b/credential.h
@@ -7,6 +7,7 @@ struct credential {
 	struct string_list helpers;
 	unsigned approved:1,
 		 configured:1,
+		 quit:1,
 		 use_http_path:1;
 
 	char *username;
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 57ea5a1..d7ef44b 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -289,4 +289,13 @@ test_expect_success 'http paths can be part of context' '
 	EOF
 '
 
+test_expect_success 'helpers can abort the process' '
+	test_must_fail git \
+		-c credential.helper="!f() { echo quit=1; }; f" \
+		-c credential.helper="verbatim foo bar" \
+		credential fill >stdout &&
+	>expect &&
+	test_cmp expect stdout
+'
+
 test_done
-- 
2.2.0.390.gf60752d

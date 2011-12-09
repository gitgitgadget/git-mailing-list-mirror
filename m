From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Thu, 8 Dec 2011 21:29:13 -0500
Message-ID: <20111209022913.GA2600@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
 <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 03:29:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYqDB-0004CZ-Dk
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 03:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1LIC3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 21:29:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44716
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab1LIC3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 21:29:16 -0500
Received: (qmail 421 invoked by uid 107); 9 Dec 2011 02:35:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 21:35:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 21:29:13 -0500
Content-Disposition: inline
In-Reply-To: <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186605>

On Thu, Dec 08, 2011 at 01:34:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Because the pattern takes 0 or more lines and no terminator, we can't
> > distinguish between empty or truncated input and the empty pattern.
> 
> I agree that such a positive "Ok here is the end of specification" marker
> is a good idea, even if we do not worry about "an empty set".
> 
> When the requestor wants to specify the credentials with host and user,
> but the wire is cut after host is communicated but before user is, we do
> want to notice the communication error, instead of silently erasing all
> the credentials on the host regardless of the user.

OK, I've tweaked the series to require an end-of-credential marker (a
blank line) both in input and output.

In addition, I've changed the code that runs helpers to make reading
from the helpers an all-or-nothing thing (instead of incrementally
ovewriting our credential as we read from it). Before, if a helper
exited with error, we would happily use its partial result. Instead, we
now read its response into a holding area, and only copy it into our
credential when we get a successful exit code. This lets us detect
truncation when reading from the helper, too.

It works, and it detects truncated output both ways properly (I know
because I had to update every test, since the old output was missing the
end-of-credential marker).

It makes me a little sad, because the original format (relying on EOF)
was so Unix-y. You could make a helper like this:

  echo password=`gpg -qd ~/.secret.gpg`

and now you must remember to tack an extra "echo" at the end. Not a big
deal, but it somehow just feels less elegant to my gut.  OTOH, classic
Unix constructs have always been a nightmare for robustness and error
checking[1], so this is certainly nothing new.

The diff from this tip to the old tip is below to give you a sense of
the magnitude of the change (the individual changes are squashed into
their respective patches for the next re-roll, of course). I'll hold off
on posting the whole series to see if we get any more comments.

-Peff

[1] I mean things like:

      grep foo bar | sed 's/some/transformation/'

    where we totally ignore errors from grep, and where a truncated
    output on the pipe would just subtly generate wrong answers.
---

 Documentation/technical/api-credentials.txt |    2 +-
 credential-cache--daemon.c                  |    1 +
 credential-cache.c                          |    2 +
 credential-store.c                          |    1 +
 credential.c                                |   39 +++++++++++++++++++++++---
 t/lib-credential.sh                         |    1 +
 t/t0300-credentials.sh                      |    3 ++
 t/t5550-http-fetch.sh                       |    1 +
 8 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..0aac899 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -199,7 +199,7 @@ followed by a newline. The key may contain any bytes except `=`,
 newline, or NUL. The value may contain any bytes except newline or NUL.
 In both cases, all bytes are treated as-is (i.e., there is no quoting,
 and one cannot transmit a value with newline or NUL in it). The list of
-attributes is terminated by a blank line or end-of-file.
+attributes is terminated by a blank line.
 
 Git will send the following attributes (but may not send all of
 them for a given credential; for example, a `host` attribute makes no
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..38403645 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -138,6 +138,7 @@ static void serve_one_client(FILE *in, FILE *out)
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
+			fprintf(out, "\n");
 		}
 	}
 	else if (!strcmp(action.buf, "exit"))
diff --git a/credential-cache.c b/credential-cache.c
index dc98372..5b8d8c9 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -70,6 +70,8 @@ static void do_cache(const char *socket, const char *action, int timeout,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("unable to relay credential");
 	}
+	else
+		strbuf_addch(&buf, '\n');
 
 	if (!send_request(socket, &buf))
 		return;
diff --git a/credential-store.c b/credential-store.c
index ed58768..00e38f0 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -43,6 +43,7 @@ static void print_entry(struct credential *c)
 {
 	printf("username=%s\n", c->username);
 	printf("password=%s\n", c->password);
+	printf("\n");
 }
 
 static void print_line(struct strbuf *buf)
diff --git a/credential.c b/credential.c
index a17eafe..6d2a37d 100644
--- a/credential.c
+++ b/credential.c
@@ -147,8 +147,10 @@ int credential_read(struct credential *c, FILE *fp)
 		char *key = line.buf;
 		char *value = strchr(key, '=');
 
-		if (!line.len)
-			break;
+		if (!line.len) {
+			strbuf_release(&line);
+			return 0;
+		}
 
 		if (!value) {
 			warning("invalid credential line: %s", key);
@@ -181,7 +183,7 @@ int credential_read(struct credential *c, FILE *fp)
 	}
 
 	strbuf_release(&line);
-	return 0;
+	return -1;
 }
 
 static void credential_write_item(FILE *fp, const char *key, const char *value)
@@ -198,6 +200,26 @@ static void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path);
 	credential_write_item(fp, "username", c->username);
 	credential_write_item(fp, "password", c->password);
+	putc('\n', fp);
+}
+
+static void credential_merge_one(char **dst, char **src)
+{
+	if (!*src)
+		return;
+	free(*dst);
+	*dst = *src;
+	*src = NULL;
+}
+
+static void credential_merge(struct credential *dst,
+			     struct credential *src)
+{
+	credential_merge_one(&dst->protocol, &src->protocol);
+	credential_merge_one(&dst->host, &src->host);
+	credential_merge_one(&dst->path, &src->path);
+	credential_merge_one(&dst->username, &src->username);
+	credential_merge_one(&dst->password, &src->password);
 }
 
 static int run_credential_helper(struct credential *c,
@@ -206,6 +228,7 @@ static int run_credential_helper(struct credential *c,
 {
 	struct child_process helper;
 	const char *argv[] = { NULL, NULL };
+	struct credential response = CREDENTIAL_INIT;
 	FILE *fp;
 
 	memset(&helper, 0, sizeof(helper));
@@ -227,17 +250,23 @@ static int run_credential_helper(struct credential *c,
 
 	if (want_output) {
 		int r;
+
 		fp = xfdopen(helper.out, "r");
-		r = credential_read(c, fp);
+		r = credential_read(&response, fp);
 		fclose(fp);
 		if (r < 0) {
+			credential_clear(&response);
 			finish_command(&helper);
 			return -1;
 		}
 	}
 
-	if (finish_command(&helper))
+	if (finish_command(&helper)) {
+		credential_clear(&response);
 		return -1;
+	}
+
+	credential_merge(c, &response);
 	return 0;
 }
 
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index fc34447..c0de4e9 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -5,6 +5,7 @@
 # separated by "--".
 check() {
 	read_chunk >stdin &&
+	echo >>stdin &&
 	read_chunk >expect-stdout &&
 	read_chunk >expect-stderr &&
 	test-credential "$@" <stdin >stdout 2>stderr &&
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 885af8f..f0e77dc 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -9,6 +9,7 @@ test_expect_success 'setup helper scripts' '
 	whoami=`echo $0 | sed s/.*git-credential-//`
 	echo >&2 "$whoami: $*"
 	while IFS== read key value; do
+		test -z "$key" && break
 		echo >&2 "$whoami: $key=$value"
 		eval "$key=$value"
 	done
@@ -28,6 +29,7 @@ test_expect_success 'setup helper scripts' '
 	. ./dump
 	test -z "$user" || echo username=$user
 	test -z "$pass" || echo password=$pass
+	echo
 	EOF
 	chmod +x git-credential-verbatim &&
 
@@ -196,6 +198,7 @@ HELPER="!f() {
 		cat >/dev/null
 		echo username=foo
 		echo password=bar
+		echo
 	}; f"
 test_expect_success 'respect configured credentials' '
 	test_config credential.helper "$HELPER" &&
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 95a133d..b817c69 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -106,6 +106,7 @@ test_expect_success 'http auth respects credential helper config' '
 		cat >/dev/null
 		echo username=user@host
 		echo password=user@host
+		echo
 	}; f" &&
 	>askpass-query &&
 	echo wrong >askpass-response &&

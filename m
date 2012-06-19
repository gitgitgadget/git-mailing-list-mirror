From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] remove the impression of unexpectedness when access is
	denied
Date: Tue, 19 Jun 2012 20:24:50 +0200
Message-ID: <20120619182449.GA99957@book.hvoigt.net>
References: <20120610182310.GB2427@book.hvoigt.net> <20120611190207.GA20889@sigill.intra.peff.net> <20120614071259.GA51076@book.hvoigt.net> <7v395xg6oh.fsf@alter.siamese.dyndns.org> <20120614203712.GA51783@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 20:25:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh36t-0004D4-3M
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab2FSSY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 14:24:58 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:33412 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2FSSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:24:57 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sh36g-0007R4-Oz; Tue, 19 Jun 2012 20:24:51 +0200
Content-Disposition: inline
In-Reply-To: <20120614203712.GA51783@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200218>

If a server accessed through ssh is denying access git will currently
issue the message

	"fatal: The remote end hung up unexpectedly"

as the last line. This sounds as if something really ugly just happened.
Since this is a quite typical situation in which users regularly get
we do not say that if it happens at the beginning when reading the
remote heads.

If its in the very first beginning of reading the remote heads it is
very likely an authentication error or a missing repository.

If it happens later during reading the remote heads we still indicate
that it happened during this initial contact phase.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 connect.c            | 18 +++++++++++++++++-
 pkt-line.c           | 32 ++++++++++++++++++++++++++------
 pkt-line.h           |  1 +
 t/t5512-ls-remote.sh |  5 ++++-
 4 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 912cdde..3e19d67 100644
--- a/connect.c
+++ b/connect.c
@@ -49,6 +49,16 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
 	extra->nr++;
 }
 
+static void die_initial_contact(int got_at_least_one_head)
+{
+	if (got_at_least_one_head)
+		die("The remote end hung up upon initial contact");
+	else
+		die("Could not read from remote repository.\n\n"
+		    "Please make sure you have the correct access rights\n"
+		    "and the repository exists.");
+}
+
 /*
  * Read all the refs from the other end
  */
@@ -56,6 +66,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			      unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
+	int got_at_least_one_head = 0;
+
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
@@ -64,7 +76,10 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read_line(in, buffer, sizeof(buffer));
+		len = packet_read(in, buffer, sizeof(buffer));
+		if (len < 0)
+			die_initial_contact(got_at_least_one_head);
+
 		if (!len)
 			break;
 		if (buffer[len-1] == '\n')
@@ -95,6 +110,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		hashcpy(ref->old_sha1, old_sha1);
 		*list = ref;
 		list = &ref->next;
+		got_at_least_one_head = 1;
 	}
 	return list;
 }
diff --git a/pkt-line.c b/pkt-line.c
index 5a04984..eaba15f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -135,13 +135,19 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	strbuf_add(buf, buffer, n);
 }
 
-static void safe_read(int fd, void *buffer, unsigned size)
+static int safe_read(int fd, void *buffer, unsigned size, int return_line_fail)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
 	if (ret < 0)
 		die_errno("read error");
-	else if (ret < size)
+	else if (ret < size) {
+		if (return_line_fail)
+			return -1;
+
 		die("The remote end hung up unexpectedly");
+	}
+
+	return ret;
 }
 
 static int packet_length(const char *linelen)
@@ -169,12 +175,14 @@ static int packet_length(const char *linelen)
 	return len;
 }
 
-int packet_read_line(int fd, char *buffer, unsigned size)
+static int packet_read_internal(int fd, char *buffer, unsigned size, int return_line_fail)
 {
-	int len;
+	int len, ret;
 	char linelen[4];
 
-	safe_read(fd, linelen, 4);
+	ret = safe_read(fd, linelen, 4, return_line_fail);
+	if (return_line_fail && ret < 0)
+		return ret;
 	len = packet_length(linelen);
 	if (len < 0)
 		die("protocol error: bad line length character: %.4s", linelen);
@@ -185,12 +193,24 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
-	safe_read(fd, buffer, len);
+	ret = safe_read(fd, buffer, len, return_line_fail);
+	if (return_line_fail && ret < 0)
+		return ret;
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
 	return len;
 }
 
+int packet_read(int fd, char *buffer, unsigned size)
+{
+	return packet_read_internal(fd, buffer, size, 1);
+}
+
+int packet_read_line(int fd, char *buffer, unsigned size)
+{
+	return packet_read_internal(fd, buffer, size, 0);
+}
+
 int packet_get_line(struct strbuf *out,
 	char **src_buf, size_t *src_len)
 {
diff --git a/pkt-line.h b/pkt-line.h
index 1e5dcfe..8cfeb0c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -13,6 +13,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 int packet_read_line(int fd, char *buffer, unsigned size);
+int packet_read(int fd, char *buffer, unsigned size);
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 ssize_t safe_write(int, const void *, ssize_t);
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6764d51..2af5c2a 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -87,7 +87,10 @@ test_expect_success 'use branch.<name>.remote if possible' '
 test_expect_success 'confuses pattern as remote when no remote specified' '
 	cat >exp <<-\EOF &&
 	fatal: '\''refs*master'\'' does not appear to be a git repository
-	fatal: The remote end hung up unexpectedly
+	fatal: Could not read from remote repository.
+
+	Please make sure you have the correct access rights
+	and the repository exists.
 	EOF
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
-- 
1.7.11.rc2.3.g49b071d

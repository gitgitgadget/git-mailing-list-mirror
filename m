From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] strbuf_expand: convert "%%" to "%"
Date: Tue, 12 Jan 2010 10:41:00 -0500
Message-ID: <20100112154100.GA24957@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUirq-0005RN-KB
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab0ALPlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840Ab0ALPlK
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:41:10 -0500
Received: from peff.net ([208.65.91.99]:54255 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab0ALPlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:41:09 -0500
Received: (qmail 8017 invoked by uid 107); 12 Jan 2010 15:45:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 10:45:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 10:41:00 -0500
Content-Disposition: inline
In-Reply-To: <20100112153656.GA24840@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136729>

The only way to safely quote arbitrary text in a
pretty-print user format is to replace instances of "%" with
"%x25". This is slightly unreadable, and many users would
expect "%%" to produce a single "%", as that is what printf
format specifiers do.

This patch converts "%%" to "%" for all users of
strbuf_expand:

 1. git-daemon interpolated paths

 2. pretty-print user formats

 3. merge driver command lines

Case (1) was already doing the conversion itself outside of
strbuf_expand. Case (2) is the intended beneficiary of this
patch. Case (3) users probably won't notice, but as this is
user-facing behavior, consistently providing the quoting
mechanism makes sense.

Signed-off-by: Jeff King <peff@peff.net>
---
Because of the %x25 thing, this isn't strictly necessary for my series.
I do think it's the right thing to do, though. If you want to drop it
because of the user-visible behavior change, I can re-roll the rest of
my series around %x25 quoting (though it makes the helper in 2/3 less
useful, as the quoting doesn't work for printf anymore).

 Documentation/pretty-formats.txt |    1 +
 daemon.c                         |    1 -
 strbuf.c                         |    6 ++++++
 t/t6006-rev-list-format.sh       |    7 +++++++
 4 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 53a9168..1686a54 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -134,6 +134,7 @@ The placeholders are:
 - '%C(...)': color specification, as described in color.branch.* config option
 - '%m': left, right or boundary mark
 - '%n': newline
+- '%%': a raw '%'
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
   linkgit:git-shortlog[1].
diff --git a/daemon.c b/daemon.c
index 918e560..360635e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -147,7 +147,6 @@ static char *path_ok(char *directory)
 			{ "IP", ip_address },
 			{ "P", tcp_port },
 			{ "D", directory },
-			{ "%", "%" },
 			{ NULL }
 		};
 
diff --git a/strbuf.c b/strbuf.c
index a6153dc..6cbc1fc 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -227,6 +227,12 @@ void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 			break;
 		format = percent + 1;
 
+		if (*format == '%') {
+			strbuf_addch(sb, '%');
+			format++;
+			continue;
+		}
+
 		consumed = fn(sb, format, context);
 		if (consumed)
 			format += consumed;
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 5719315..b0047d3 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -19,6 +19,13 @@ test_cmp expect.$1 output.$1
 "
 }
 
+test_format percent %%h <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+%h
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+%h
+EOF
+
 test_format hash %H%n%h <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
 131a310eb913d107dd3c09a65d1651175898735d
-- 
1.6.6.138.g309fc.dirty

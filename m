From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Do not unquote + into ' ' in URLs
Date: Sat, 24 Jul 2010 16:49:04 +0200
Message-ID: <ed2d311355fca478f97b82f8d955494509d6b9de.1279982471.git.trast@student.ethz.ch>
References: <201007240104.25341.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, <avarab@gmail.com>,
	<jstpierre@mecheye.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 16:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocg2e-0007Et-Qf
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 16:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab0GXOt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 10:49:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:33815 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab0GXOt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 10:49:27 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 24 Jul
 2010 16:49:24 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 24 Jul
 2010 16:49:03 +0200
X-Mailer: git-send-email 1.7.2.278.g76edd.dirty
In-Reply-To: <201007240104.25341.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151632>

Since 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23) the URL
logic unquotes escaped URLs.  For the %2B type of escape, this is
conformant with RFC 2396.  However, it also unquotes + into a space
character, which is only appropriate for the query strings in HTTP.
This notably broke fetching from the gtk+ repository.

We cannot just remove the corresponding code since the same
url_decode_internal() is also used by the HTTP backend to decode query
parameters.  Introduce a new argument that controls whether the +
decoding happens, and use it only in the (client-side) url_decode().

Reported-by: Jasper St. Pierre <jstpierre@mecheye.net>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I wrote:
> Junio C Hamano wrote:
> > 
> >   http-backend.c::get_info_refs()
> >    -> http-backend.c::get_parameter()
> >      -> http-backend.c::get_parameters()
> >        -> url.c::url_decode_parameter_value()
> >          -> url.c::url_decode_internal()
> 
> You're right, I forgot about those.  I imagine it would be one of two
> cases:
[...]
> Shawn, can you help with this?

The third case, of course, is:

* It only uses these functions for parameter decoding, which of course
  was correct to begin with.

So after hopefully drinking enough coffee, I made this one.  The catch
is that I'm not entirely clear whether *not* decoding the +
client-side anywhere in the URL is correct for http:// URLs?  If the
client decodes and re-encodes the URL, then the + would be turned into
a %2B on the re-encoding.  Then again maybe UI-facing URLs should
never have a query part at all?


 t/t5601-clone.sh |   10 ++++++++--
 url.c            |   11 ++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8abb71a..4431dfd 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -178,8 +178,14 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 
 test_expect_success 'respect url-encoding of file://' '
 	git init x+y &&
-	test_must_fail git clone "file://$PWD/x+y" xy-url &&
-	git clone "file://$PWD/x%2By" xy-url
+	git clone "file://$PWD/x+y" xy-url-1 &&
+	git clone "file://$PWD/x%2By" xy-url-2
+'
+
+test_expect_success 'do not query-string-decode + in URLs' '
+	rm -rf x+y &&
+	git init "x y" &&
+	test_must_fail git clone "file://$PWD/x+y" xy-no-plus
 '
 
 test_expect_success 'do not respect url-encoding of non-url path' '
diff --git a/url.c b/url.c
index 2306236..cd8f74f 100644
--- a/url.c
+++ b/url.c
@@ -67,7 +67,8 @@ static int url_decode_char(const char *q)
 	return val;
 }
 
-static char *url_decode_internal(const char **query, const char *stop_at, struct strbuf *out)
+static char *url_decode_internal(const char **query, const char *stop_at,
+				 struct strbuf *out, int decode_plus)
 {
 	const char *q = *query;
 
@@ -90,7 +91,7 @@ static char *url_decode_internal(const char **query, const char *stop_at, struct
 			}
 		}
 
-		if (c == '+')
+		if (decode_plus && c == '+')
 			strbuf_addch(out, ' ');
 		else
 			strbuf_addch(out, c);
@@ -110,17 +111,17 @@ char *url_decode(const char *url)
 		strbuf_add(&out, url, colon - url);
 		url = colon;
 	}
-	return url_decode_internal(&url, NULL, &out);
+	return url_decode_internal(&url, NULL, &out, 0);
 }
 
 char *url_decode_parameter_name(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
-	return url_decode_internal(query, "&=", &out);
+	return url_decode_internal(query, "&=", &out, 1);
 }
 
 char *url_decode_parameter_value(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
-	return url_decode_internal(query, "&", &out);
+	return url_decode_internal(query, "&", &out, 1);
 }
-- 
1.7.2.278.g76edd.dirty

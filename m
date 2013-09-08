From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] config: factor out integer parsing from range checks
Date: Sun, 8 Sep 2013 04:29:27 -0400
Message-ID: <20130908082927.GA29554@sigill.intra.peff.net>
References: <20130908082724.GA27184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaNF-0001sE-5L
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab3IHI3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:29:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:43727 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab3IHI3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:29:31 -0400
Received: (qmail 11062 invoked by uid 102); 8 Sep 2013 08:29:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:29:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:29:27 -0400
Content-Disposition: inline
In-Reply-To: <20130908082724.GA27184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234220>

When we are parsing integers for config, we use an intmax_t
(or uintmax_t) internally, and then check against the size
of our result type at the end. We can parameterize the
maximum representable value, which will let us re-use the
parsing code for a variety of range checks.

Unfortunately, we cannot combine the signed and unsigned
parsing functions easily, as we have to rely on the signed
and unsigned C types internally.

Signed-off-by: Jeff King <peff@peff.net>
---
The fact that we have two nearly-identical functions next to each other
really bugs me (especially since I'm going to make identical changes to
them later in this series). But I think trying to factor them out into a
single function would end up being even less readable. I'd be happy if
somebody wants to prove me wrong.

 config.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 9f9bf0c..ee7c1f8 100644
--- a/config.c
+++ b/config.c
@@ -468,7 +468,7 @@ static int parse_unit_factor(const char *end, uintmax_t *val)
 	return 0;
 }
 
-static int git_parse_long(const char *value, long *ret)
+static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -484,8 +484,7 @@ static int git_parse_long(const char *value, long *ret)
 			return 0;
 		uval = abs(val);
 		uval *= factor;
-		if ((uval > maximum_signed_value_of_type(long)) ||
-		    (abs(val) > uval))
+		if (uval > max || abs(val) > uval)
 			return 0;
 		val *= factor;
 		*ret = val;
@@ -494,7 +493,7 @@ static int git_parse_long(const char *value, long *ret)
 	return 0;
 }
 
-int git_parse_ulong(const char *value, unsigned long *ret)
+int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -508,8 +507,7 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 		oldval = val;
 		if (!parse_unit_factor(end, &val))
 			return 0;
-		if ((val > maximum_unsigned_value_of_type(long)) ||
-		    (oldval > val))
+		if (val > max || oldval > val)
 			return 0;
 		*ret = val;
 		return 1;
@@ -517,6 +515,24 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 0;
 }
 
+static int git_parse_long(const char *value, long *ret)
+{
+	intmax_t tmp;
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(long)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
+int git_parse_ulong(const char *value, unsigned long *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(long)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 static void die_bad_config(const char *name)
 {
 	if (cf && cf->name)
-- 
1.8.4.2.g87d4a77

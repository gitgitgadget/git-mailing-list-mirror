From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] config: properly range-check integer values
Date: Tue, 20 Aug 2013 18:42:57 -0400
Message-ID: <20130820224256.GA24766@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 00:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBudn-0004MT-UY
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3HTWnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:43:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:41056 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab3HTWnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:43:01 -0400
Received: (qmail 13476 invoked by uid 102); 20 Aug 2013 22:43:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 17:43:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 18:42:57 -0400
Content-Disposition: inline
In-Reply-To: <20130820223953.GA3429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232660>

When we look at a config value as an integer using the
git_config_int function, we carefully range-check the value
we get and complain if it is out of our range. But the range
we compare to is that of a "long", which we then cast to an
"int" in the function's return value. This means that on
systems where "int" and "long" have different sizes (e.g.,
LP64 systems), we may pass the range check, but then return
nonsense by truncating the value as we cast it to an int.

We can solve this by converting git_parse_long into
git_parse_int, and range-checking the "int" range. Nobody
actually cared that we used a "long" internally, since the
result was truncated anyway, and there were no other callers
of git_parse_long.

Of the existing callers, all of them expect small-ish values
that are fine for an "int", and should not be impacted
except when nonsense is fed to them. The one arguable
exception is http.lowSpeedLimit, which is given in bytes per
second, and is fed to curl as a long. However, nobody is
likely to consider 2GB/sec as "low speed", and even if they
did, the new behavior is much better (it barfs and complains
rather than considering the value negative and silently
ignoring it).

Signed-off-by: Jeff King <peff@peff.net>
---
I added a test. It would not fail on existing 32-bit systems, but would
on existing LP64 systems. It will pass with the new code on both.
However, it will fail on ILP64 systems (because their int is large, and
can represent 3GB). I'm not sure if any such systems are in wide use
(SPARC64?), but we would want a prereq in that case, I guess. I'm
inclined to wait to see if it actually fails for anybody.

 config.c               | 12 ++++++------
 t/t1300-repo-config.sh |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index e13a7b6..9237d4b 100644
--- a/config.c
+++ b/config.c
@@ -468,7 +468,7 @@ static int parse_unit_factor(const char *end, uintmax_t *val)
 	return 0;
 }
 
-static int git_parse_long(const char *value, long *ret)
+static int git_parse_int(const char *value, int *ret)
 {
 	if (value && *value) {
 		char *end;
@@ -484,7 +484,7 @@ static int git_parse_long(const char *value, long *ret)
 			return 0;
 		uval = abs(val);
 		uval *= factor;
-		if ((uval > maximum_signed_value_of_type(long)) ||
+		if ((uval > maximum_signed_value_of_type(int)) ||
 		    (abs(val) > uval))
 			return 0;
 		val *= factor;
@@ -526,8 +526,8 @@ int git_config_int(const char *name, const char *value)
 
 int git_config_int(const char *name, const char *value)
 {
-	long ret = 0;
-	if (!git_parse_long(value, &ret))
+	int ret;
+	if (!git_parse_int(value, &ret))
 		die_bad_config(name);
 	return ret;
 }
@@ -559,10 +559,10 @@ int git_config_maybe_bool(const char *name, const char *value)
 
 int git_config_maybe_bool(const char *name, const char *value)
 {
-	long v = git_config_maybe_bool_text(name, value);
+	int v = git_config_maybe_bool_text(name, value);
 	if (0 <= v)
 		return v;
-	if (git_parse_long(value, &v))
+	if (git_parse_int(value, &v))
 		return !!v;
 	return -1;
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c4a7d84..3c5ec4b 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -652,6 +652,11 @@ test_expect_success numbers '
 	test_cmp expect actual
 '
 
+test_expect_success 'out-of-range integers are detected' '
+	git config giga.crash 3g &&
+	test_must_fail git config --int giga.crash
+'
+
 test_expect_success 'invalid unit' '
 	git config aninvalid.unit "1auto" &&
 	echo 1auto >expect &&
-- 
1.8.4.rc2.28.g6bb5f3f

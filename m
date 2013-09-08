From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] config: properly range-check integer values
Date: Sun, 8 Sep 2013 04:33:08 -0400
Message-ID: <20130908083308.GB29554@sigill.intra.peff.net>
References: <20130908082724.GA27184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaQr-00048B-QI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab3IHIdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:33:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43753 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab3IHIdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:33:13 -0400
Received: (qmail 11287 invoked by uid 102); 8 Sep 2013 08:33:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:33:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:33:08 -0400
Content-Disposition: inline
In-Reply-To: <20130908082724.GA27184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234221>

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
result was truncated anyway. And the only other caller of
git_parse_long is git_config_maybe_bool, which should be
fine to just use int (though we will now forbid out-of-range
nonsense like setting "merge.ff" to "10g" to mean "true",
which is probably a good thing).

Signed-off-by: Jeff King <peff@peff.net>
---

I tested this with:

	diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
	index b1a6365..5444952 100755
	--- a/t/t6500-gc.sh
	+++ b/t/t6500-gc.sh
	@@ -25,4 +25,8 @@ test_expect_success 'gc -h with invalid configuration' '
	 	test_i18ngrep "[Uu]sage" broken/usage
	 '
	 
	+test_expect_success 'gc complains about out-of-range integers' '
	+	test_must_fail git -c gc.auto=3g gc --auto
	+'
	+
	 test_done

but that test is horrible for a few reasons:

  1. It depends on knowing that gc.auto uses git_config_int internally.

  2. It passes without the patch on 32-bit platforms.

  3. It won't pass with the patch on ILP64 systems.

We can't use "git config --int" to test it, because it's going to stop
using git_config_int later in the series. So I think we should just go
without a test.

 config.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index ee7c1f8..0a65ac2 100644
--- a/config.c
+++ b/config.c
@@ -515,10 +515,10 @@ static int git_parse_long(const char *value, long *ret)
 	return 0;
 }
 
-static int git_parse_long(const char *value, long *ret)
+static int git_parse_int(const char *value, int *ret)
 {
 	intmax_t tmp;
-	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(long)))
+	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
 		return 0;
 	*ret = tmp;
 	return 1;
@@ -542,8 +542,8 @@ int git_config_int(const char *name, const char *value)
 
 int git_config_int(const char *name, const char *value)
 {
-	long ret = 0;
-	if (!git_parse_long(value, &ret))
+	int ret;
+	if (!git_parse_int(value, &ret))
 		die_bad_config(name);
 	return ret;
 }
@@ -575,10 +575,10 @@ int git_config_maybe_bool(const char *name, const char *value)
 
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
-- 
1.8.4.2.g87d4a77

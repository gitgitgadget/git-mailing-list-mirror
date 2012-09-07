From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Prevent git-config from storing section keys that are too long
Date: Thu,  6 Sep 2012 20:47:09 -0400
Message-ID: <1346978829-4486-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 02:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9mjf-00018L-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 02:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250Ab2IGArf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 20:47:35 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:44753 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213Ab2IGArQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 20:47:16 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51383 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1T9mj3-00023B-Gh; Thu, 06 Sep 2012 20:47:13 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1T9mj3-0001At-Fh; Thu, 06 Sep 2012 20:47:13 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204941>

Key names have a length limit defined by MAXNAME in config.c.  When
reading the config file, we reserve half of this limit for the section
identifier and the other half for the key name within that section.

For example, if setting a key named url.foo.insteadOf, url.foo may use
at most half of MANXNAME.

The parser will throw an error if this condition is violated.

This patch ensures that git-config enforces the same restriction
during the creation of a section identifier so that it doesn't allow
the generate a configuration file that cannot be re-read later.

This patch also adds a test to t1303-wacky-config to catch any future
issues with this check.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---

Hi All,

I happened to notice this while running the test suite in a deeply
nested directory...

The check for baselen exceeding half of MAXNAME could be done earlier
in the function but doing it late allowed the error message to be
clearer without extra hassle.

I also wonder if MAXNAME should be increased somewhat.  Section
identifiers generated from keys like:

url./some/really/long/path.insteadOf

could overrun the current limit.  It's not a common case, of course,
or this issue would have been found sooner.  Would doubling the
current limit be out of the question?

Thanks
-Ben



 config.c                |    8 ++++++++
 t/t1303-wacky-config.sh |    4 ++++
 2 files changed, 12 insertions(+)

diff --git a/config.c b/config.c
index 2b706ea..d3f4854 100644
--- a/config.c
+++ b/config.c
@@ -1276,6 +1276,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	}
 	(*store_key)[i] = 0;
 
+	if (baselen > MAXNAME / 2) {
+		/* ok to destroy this value now since it will be freed */
+		(*store_key)[baselen] = '\0';
+		error("section identifier for key is too long (> %d): %s",
+		      MAXNAME / 2, *store_key);
+		goto out_free_ret_1;
+	}
+
 	return 0;
 
 out_free_ret_1:
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 46103a1..12f0850 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -47,4 +47,8 @@ test_expect_success 'do not crash on special long config line' '
 	check section.key "$LONG_VALUE"
 '
 
+test_expect_success 'do not accept long section identifiers for key names' '
+	test_must_fail git config some.REALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlongREALLYlong.key value
+'
+
 test_done
-- 
1.7.9.5

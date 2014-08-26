From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Tue, 26 Aug 2014 14:21:26 -0400
Message-ID: <20140826182125.GC17546@peff.net>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
 <1409066605-4851-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMLN7-0003bQ-Af
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 20:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbaHZSV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 14:21:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:59447 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752062AbaHZSV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 14:21:28 -0400
Received: (qmail 5002 invoked by uid 102); 26 Aug 2014 18:21:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 13:21:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 14:21:26 -0400
Content-Disposition: inline
In-Reply-To: <1409066605-4851-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255933>

On Tue, Aug 26, 2014 at 05:23:21PM +0200, Steffen Prohaska wrote:

> +/*
> + * Use default if environment variable is unset or empty string.
> + */
> +unsigned long git_env_ulong(const char *k, unsigned long val)
> +{
> +	const char *v = getenv(k);
> +	if (v && *v && !git_parse_ulong(v, &val))
> +		die("failed to parse %s", k);
> +	return val;
> +}

I think the "empty string" behavior here is sensible. I notice that
git_env_bool is not so careful. I think we should probably do this
(independent of your series):

-- >8 --
Subject: git_env_bool: treat empty string as "not set"

If an environment variable we treat as a boolean is not set,
we use some default value provided by the caller. If it is
set but is the empty string, however, we treat it as
"false". This can be rather confusing, as it is easy to set
the variable to the empty string in the shell (e.g., by
calling GIT_SMART_HTTP= instead of "unset").

Instead, let's treat unset and empty variables the same.
This should not have any negative backwards-compatibility
consequences, because:

  1. The existing behavior was confusing and undocumented in
     the first place.

  2. For most variables, the default _is_ false, and so this
     change is a noop. The only affected variables are
     GIT_IMPLICIT_WORK_TREE (which is undocumented and
     internally always set to "0" or "1") and GIT_SMART_HTTP
     (which is also undocumented, and we use only for
     testing).

Since there won't be any fallout with the current variables,
this is a good time to make the switch (before any other
variables are added).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c                    | 2 +-
 t/t5551-http-fetch-smart.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 058505c..7bf0704 100644
--- a/config.c
+++ b/config.c
@@ -1119,7 +1119,7 @@ const char *git_etc_gitconfig(void)
 int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
-	return v ? git_config_bool(k, v) : def;
+	return v && *v ? git_config_bool(k, v) : def;
 }
 
 int git_config_system(void)
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6cbc12d..831f9e4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -168,6 +168,13 @@ test_expect_success 'GIT_SMART_HTTP can disable smart http' '
 	 test_must_fail git fetch)
 '
 
+test_expect_success 'empty GIT_SMART_HTTP leaves smart http enabled' '
+	(GIT_SMART_HTTP= &&
+	 export GIT_SMART_HTTP &&
+	 cd clone &&
+	 git fetch)
+'
+
 test_expect_success 'invalid Content-Type rejected' '
 	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual
 	grep "not valid:" actual
-- 
2.1.0.346.ga0367b9

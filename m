From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/4] Change GIT_ALLOC_LIMIT check to use
 git_parse_ulong()
Date: Mon, 25 Aug 2014 07:38:56 -0400
Message-ID: <20140825113856.GA17288@peff.net>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
 <1408896466-23149-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 13:39:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLsc7-0003MI-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 13:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbaHYLjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 07:39:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:58343 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753795AbaHYLjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 07:39:01 -0400
Received: (qmail 6364 invoked by uid 102); 25 Aug 2014 11:39:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 06:39:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 07:38:56 -0400
Content-Disposition: inline
In-Reply-To: <1408896466-23149-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255820>

On Sun, Aug 24, 2014 at 06:07:44PM +0200, Steffen Prohaska wrote:

> diff --git a/wrapper.c b/wrapper.c
> index bc1bfb8..69d1c9b 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -11,14 +11,18 @@ static void (*try_to_free_routine)(size_t size) = do_nothing;
>  
>  static void memory_limit_check(size_t size)
>  {
> -	static int limit = -1;
> -	if (limit == -1) {
> -		const char *env = getenv("GIT_ALLOC_LIMIT");
> -		limit = env ? atoi(env) * 1024 : 0;
> +	static size_t limit = SIZE_MAX;
> +	if (limit == SIZE_MAX) {

You use SIZE_MAX as the sentinel for "not set", and 0 as the sentinel
for "no limit". That seems kind of backwards.

I guess you are inheriting this from the existing code, which lets
GIT_ALLOC_LIMIT=0 mean "no limit". I'm not sure if we want to keep that
or not (it would be backwards incompatible to change it, but we are
already breaking compatibility here by assuming bytes rather than
kilobytes; I think that's OK because this is not a documented feature,
or one intended to be used externally).

> +		const char *var = "GIT_ALLOC_LIMIT";
> +		unsigned long val = 0;
> +		const char *env = getenv(var);
> +		if (env && !git_parse_ulong(env, &val))
> +			die("Failed to parse %s", var);
> +		limit = val;
>  	}

This and the next patch both look OK to me, but I notice this part is
largely duplicated between the two. We already have git_env_bool to do a
similar thing for boolean environment variables. Should we do something
similar like:

diff --git a/config.c b/config.c
index 058505c..11919eb 100644
--- a/config.c
+++ b/config.c
@@ -1122,6 +1122,14 @@ int git_env_bool(const char *k, int def)
 	return v ? git_config_bool(k, v) : def;
 }
 
+unsigned long git_env_ulong(const char *k, unsigned long val)
+{
+	const char *v = getenv(k);
+	if (v && !git_parse_ulong(k, &val))
+		die("failed to parse %s", k);
+	return val;
+}
+
 int git_config_system(void)
 {
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);

It's not a lot of code, but I think the callers end up being much easier
to read:

  if (limit == SIZE_MAX)
	limit = git_env_ulong("GIT_ALLOC_LIMIT", 0);

>  	if (limit && size > limit)
> -		die("attempting to allocate %"PRIuMAX" over limit %d",
> -		    (intmax_t)size, limit);
> +		die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
> +		    (uintmax_t)size, (uintmax_t)limit);

This part is duplicated, too, though I do not know if the infrastructure
to avoid that is worth the trouble. Unless you wanted to do a whole:

  check_limit(&limit, "GIT_ALLOC_LIMIT", size);

or something, but I am also not convinced that is not just obfuscating
things.

-Peff

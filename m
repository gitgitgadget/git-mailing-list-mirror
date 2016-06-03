From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] builtin/commit.c: convert trivial snprintf calls
 to xsnprintf
Date: Fri, 3 Jun 2016 04:49:18 -0400
Message-ID: <20160603084917.GA28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:49:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8knI-0003Hj-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 10:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbcFCItY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 04:49:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:48308 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbcFCItW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 04:49:22 -0400
Received: (qmail 1136 invoked by uid 102); 3 Jun 2016 08:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:49:22 -0400
Received: (qmail 19138 invoked by uid 107); 3 Jun 2016 08:49:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:49:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 04:49:18 -0400
Content-Disposition: inline
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296286>

On Fri, Jun 03, 2016 at 07:47:15AM +0000, Elia Pinto wrote:

> With the commits f2f02675 and 5096d490 we have been converted in some files the call
> from snprintf/sprintf/strcpy to xsnprintf. This patch converts the remaining calls
> to snprintf with xsnprintf under the following conditions:
> 
> - The call to snprintf does not control the outcome of the command
>   or the presence of truncation errors.
> - A call to snprintf can generate a fatal error, directly or indirectly.
> 
> The other few remaining cases in which a call to snprintf can generate a soft error
> have not been changed.

I see that all 10 of these commits have the same commit message. IMHO,
that is a good sign that they should just be a single commit.

It is a good idea to break your changes up into small commits, but I
think it only makes sense to do so on _logical_ boundaries. For a
cross code-base change like this, it doesn't really matter what file
these are in. They are all the same logical change; they have the same
prerequisites to be a good candidate for the change, and the mechanism
itself is the same in all cases. Somebody reviewing them would apply the
same criteria in all cases.

I haven't looked carefully at each call site in detail yet, but from the
previous rounds of sprintf handling, I'd guess each site falls into one
of two categories:

  1. We've sized the buffer appropriately earlier in the function, so
     this is a "should never truncate" case. Using xsnprintf gives us a
     run-time assurance that there was no programming error.

  2. The original author didn't give much thought to the buffer size and
     figured "probably big enough". These ones might actually cause
     truncation in pathological cases, but we'd prefer to generate a
     fatal error, since that's better than continuing with bogus data.

But again, that's just a guess. There might be other ways of grouping
the changes logically.

For this particular change:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 443ff91..c65abaa 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1552,7 +1552,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>  	code = start_command(&proc);
>  	if (code)
>  		return code;
> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
> +	n = xsnprintf(buf, sizeof(buf), "%s %s\n",
>  		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));

I think it's the first type, as earlier we have:

	/* oldsha1 SP newsha1 LF NUL */
	static char buf[2*40 + 3];

So unless that calculation is wrong, this would never truncate. The move
to xsnprintf is an improvement, but I wonder if we would be happier
still with:

  buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));

Then we do not even have to wonder about the size computation. True, it
uses a heap buffer when we do not need to, but I find it hard to care
about grabbing 80 bytes of heap when we are in the midst of exec-ing an
entirely new process.

By the way, there are some other uses of snprintf in the same file, that
I think would fall into the type 2 I mentioned above (they use PATH_MAX,
which I think is shorter than necessary on some systems).

Those ones would also benefit from using higher-level constructs. Like:

diff --git a/builtin/commit.c b/builtin/commit.c
index 443ff91..9336724 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1563,24 +1563,23 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
 {
-	const char *hook_env[3] =  { NULL };
-	char index[PATH_MAX];
+	struct argv_array hook_env = ARGV_ARRAY_INIT;
 	va_list args;
 	int ret;
 
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-	hook_env[0] = index;
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		hook_env[1] = "GIT_EDITOR=:";
+		argv_array_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
 	ret = run_hook_ve(hook_env, name, args);
 	va_end(args);
 
+	argv_array_clear(&hook_env);
 	return ret;
 }
 

-Peff

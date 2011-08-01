From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] describe: Refresh the index when run with --dirty
Date: Sun, 31 Jul 2011 21:51:54 -0600
Message-ID: <20110801035153.GA2207@sigill.intra.peff.net>
References: <20110731062055.GB14384@sigill.intra.peff.net>
 <1312163561-77072-1-git-send-email-allan.caffee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjaF-0004hk-D0
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1HADv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:51:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49278
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab1HADv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:51:57 -0400
Received: (qmail 14973 invoked by uid 107); 1 Aug 2011 03:52:29 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Jul 2011 23:52:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jul 2011 21:51:54 -0600
Content-Disposition: inline
In-Reply-To: <1312163561-77072-1-git-send-email-allan.caffee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178305>

On Sun, Jul 31, 2011 at 09:52:41PM -0400, Allan Caffee wrote:

> When running git describe --dirty the index should be refreshed.  Previously
> the cached index would cause describe to think that the index was dirty when,
> in reality, it was just stale.
> 
> The issue was exposed by python setuptools which hardlinks files into another
> directory when building a distribution.

Overall, looks good to me. A few minor nits, though:

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 66fc291..792af76 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -24,6 +24,7 @@ static int longformat;
>  static int abbrev = -1; /* unspecified */
>  static int max_candidates = 10;
>  static struct hash_table names;
> +static struct lock_file index_lock; /* real index */

This line was presumably copied straight from builtin/commit.c. You can
drop the "real index" comment here. Commit may deal with multiple
indices, which is what this comment was clarifying, but here it doesn't
make any sense.

>  static int always;
> @@ -399,6 +400,7 @@ static void describe(const char *arg, int last_one)
>  int cmd_describe(int argc, const char **argv, const char *prefix)
>  {
>  	int contains = 0;
> +	int fd;

If a variable is only going to be used for one deep conditional, IMHO
it's nice to declare it inside the conditional block, so readers of the
code don't have to wonder under what conditions fd is valid.

> +		if (dirty) {
> +			read_cache();
> +			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
> +			fd = hold_locked_index(&index_lock, 0);
> +			if (0 <= fd)
> +				update_index_if_able(&the_index, &index_lock);

A few questions about this read_cache call:

  1. Should this actually be:

          if (read_cache() < 0)
                  die("unable to read cache");

     ? I notice that cmd_status also does not check the error code. But
     it seems like if we fail to read, we would then potentially write
     out a bogus index. Probably unlikely, as failure to read probably
     implies failure to write.

  2. Should the read and refresh happen while we hold the lock?
     Otherwise our read-modify-update is not atomic, and we risk
     overwriting another index writer. Again, cmd_status suffers from
     the same problem, so this is not something you are introducing.

  3. Is there any reason not to use the multi-threaded
     read_cache_preload here?

-Peff

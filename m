From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] gc: Clean garbage .bitmap files from pack dir
Date: Tue, 15 Dec 2015 18:23:14 -0500
Message-ID: <20151215232313.GB30353@sigill.intra.peff.net>
References: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
 <1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
 <1447461987-35450-3-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:23:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ywF-0001KU-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965651AbbLOXXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:23:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:42664 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965540AbbLOXXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:23:16 -0500
Received: (qmail 19199 invoked by uid 102); 15 Dec 2015 23:23:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 17:23:16 -0600
Received: (qmail 21221 invoked by uid 107); 15 Dec 2015 23:23:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 18:23:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2015 18:23:14 -0500
Content-Disposition: inline
In-Reply-To: <1447461987-35450-3-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282507>

On Fri, Nov 13, 2015 at 04:46:27PM -0800, Doug Kelly wrote:

> Similar to cleaning up excess .idx files, clean any garbage .bitmap
> files that are not otherwise associated with any .idx/.pack files.
> 
> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> ---
>  builtin/gc.c     | 12 ++++++++++--
>  t/t5304-prune.sh |  2 +-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c583aad..7ddf071 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -58,8 +58,16 @@ static void clean_pack_garbage(void)
>  
>  static void report_pack_garbage(unsigned seen_bits, const char *path)
>  {
> -	if (seen_bits == PACKDIR_FILE_IDX)
> -		string_list_append(&pack_garbage, path);
> +	if (seen_bits & PACKDIR_FILE_IDX ||
> +	    seen_bits & PACKDIR_FILE_BITMAP) {

So here we're relying on report_helper to have culled the boring cases,
right? (Sorry if that is totally obvious; I'm mostly just thinking out
loud). That makes sense, then.

> +		const char *dot = strrchr(path, '.');
> +		if (dot) {
> +			int baselen = dot - path + 1;
> +			if (!strcmp(path+baselen, "idx") ||
> +				!strcmp(path+baselen, "bitmap"))
> +				string_list_append(&pack_garbage, path);
> +		}
> +	}

I was confused at first why we couldn't just pass "path" here. But it's
because we will get a garbage report for each related file, and we want
to keep some of them (like .keep). Which I guess makes sense.

I wonder if this would be simpler to read as just:

  if (ends_with(path, ".idx") ||
      ends_with(path, ".bitmap"))
          string_list_append(&pack_garbage, path);

Technically it is less efficient because we will compute strlen(path)
twice, but that seems like premature optimization (not to mention that
ends_with is an inline, so a good compiler can probably optimize out the
second call anyway).

> -test_expect_failure 'clean pack garbage with gc' '
> +test_expect_success 'clean pack garbage with gc' '
>  	test_when_finished "rm -f .git/objects/pack/fake*" &&
>  	test_when_finished "rm -f .git/objects/pack/foo*" &&
>  	: >.git/objects/pack/foo.keep &&

Should we be checking at the end of this test that "*.keep" didn't get
blown away? It might be nice to just test_cmp the results of "ls" on the
pack directory to confirm exactly what got deleted and what didn't.

-Peff

From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] describe: Add --left-only option
Date: Fri, 17 May 2013 16:03:29 +0100
Message-ID: <20130517150329.GA27005@serenity.lan>
References: <1368800666-5222-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Fri May 17 17:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdMC8-0006r3-Al
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 17:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab3EQPDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 11:03:40 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42431 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3EQPDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 11:03:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 0A7D06064D7;
	Fri, 17 May 2013 16:03:39 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5cSFgcxo0Z21; Fri, 17 May 2013 16:03:38 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 79E2C606515;
	Fri, 17 May 2013 16:03:35 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1368800666-5222-1-git-send-email-mac@mcrowe.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224694>

On Fri, May 17, 2013 at 03:24:26PM +0100, Mike Crowe wrote:
> Only consider the first parent commit when walking the commit history. This
> is useful if you only wish to match tags on your branch after a merge.

For consistency with "git log" should this be called "--first-parent"?

In "git log" --left-only takes effect only when considering a symmetric
range, which "git describe" isn't.  Whereas --first-parent triggers
precisely the behaviour described here.

> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> ---
>  Documentation/git-describe.txt | 9 ++++++++-
>  builtin/describe.c             | 5 +++++
>  t/t6120-describe.sh            | 3 +++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index 28e5ec0..67f7d8e 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -88,6 +88,11 @@ OPTIONS
>  --always::
>  	Show uniquely abbreviated commit object as fallback.
>  
> +--left-only::
> +	Consider only the left-most parent of any commit with multiple
> +	parents. This is useful when you wish to not match tags on branches
> +	merged in the history of the target commit.
> +
>  EXAMPLES
>  --------
>  
> @@ -149,7 +154,9 @@ is found, its name will be output and searching will stop.
>  If an exact match was not found, 'git describe' will walk back
>  through the commit history to locate an ancestor commit which
>  has been tagged.  The ancestor's tag will be output along with an
> -abbreviation of the input committish's SHA-1.
> +abbreviation of the input committish's SHA-1. If '--left-only' was
> +specified then the walk will only consider the first parent of each
> +commit.
>  
>  If multiple tags were found during the walk then the tag which
>  has the fewest commits different from the input committish will be
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 6636a68..44a4ca5 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -21,6 +21,7 @@ static int debug;	/* Display lots of verbose info */
>  static int all;	/* Any valid ref can be used */
>  static int tags;	/* Allow lightweight tags */
>  static int longformat;
> +static int left_only;
>  static int abbrev = -1; /* unspecified */
>  static int max_candidates = 10;
>  static struct hash_table names;
> @@ -336,6 +337,9 @@ static void describe(const char *arg, int last_one)
>  				commit_list_insert_by_date(p, &list);
>  			p->object.flags |= c->object.flags;
>  			parents = parents->next;
> +
> +			if (left_only)
> +				break;
>  		}
>  	}
>  
> @@ -404,6 +408,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  		OPT_BOOLEAN(0, "all",        &all, N_("use any ref")),
>  		OPT_BOOLEAN(0, "tags",       &tags, N_("use any tag, even unannotated")),
>  		OPT_BOOLEAN(0, "long",       &longformat, N_("always use long format")),
> +		OPT_BOOLEAN(0, "left-only",  &left_only, N_("only follow left parent")),
>  		OPT__ABBREV(&abbrev),
>  		OPT_SET_INT(0, "exact-match", &max_candidates,
>  			    N_("only output exact matches"), 0),
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index f67aa6f..aea7463 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -110,6 +110,9 @@ check_describe tags/e --all HEAD^^^
>  check_describe B-0-* --long HEAD^^2^
>  check_describe A-3-* --long HEAD^^2
>  
> +check_describe c-7-* --tags
> +check_describe e-3-* --left-only --tags
> +
>  : >err.expect
>  check_describe A --all A^0
>  test_expect_success 'no warning was displayed for A' '
> -- 
> 1.8.3.rc2.14.g3089c4d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

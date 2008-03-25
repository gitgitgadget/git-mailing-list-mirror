From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix branches file configuration
Date: Tue, 25 Mar 2008 16:56:43 -0700
Message-ID: <7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeJ1W-0002Ds-Tr
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758256AbYCYX5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 19:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbYCYX5E
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:57:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231AbYCYX5D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 19:57:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 608C71F67;
	Tue, 25 Mar 2008 19:57:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4A9F41F66; Tue, 25 Mar 2008 19:56:54 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803251931500.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 25 Mar 2008 19:35:28 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78234>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It turns out that .git/branches/foo should fetch into refs/heads/foo.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> We still don't have a test for that bit of the behavior, so I could have 
> it still doing the wrong thing. But it at least should do what I think 
> people want.
>
> Andrew, could you give this a try, on top of current master (or, for that 
> matter, any released version that doesn't work), and let me know if it 
> does the wrong thing?

To give bystanders a bit of context, Andrew had an old Cogito-style

	.git/branches/foo

that had a URL (and no #frag) in it.  "git fetch foo" should have fetched
from the 'master' branch of the named repository and stored it in his
refs/heads/foo, and git up to 1.5.3.X series do so correctly, but we had
this uncaught regression in 1.5.4 (the support for "branches" file is not
deprecated, even though I personally do not see a reason to use it in new
repositories).

Now, Daniel, I was independently fixing this one and had a question about
this code.

What is the deal with this "slash" magic?  It appears that when you are
fed:

	git fetch foo/bar

you look up ".git/branches/foo" for $URL and #$branch, then use "$URL/bar"
as the URL and $branch (or 'master' if you did not see '#') as the branch
to fetch from, and store it in "foo/bar" locally.  Is that really what
should have happened?  I am reasonably sure about "fetching from $URL/bar"
part, but I am unsure about "store in foo/bar" part.

Any Cogito survivers out there who knows how this was supposed to have
worked?  We can go back and look at git-fetch.sh (in contrib/examples),
but I'd rather be lazy ;-)

>  remote.c |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 40ed246..a027bca 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -232,7 +232,7 @@ static void read_branches_file(struct remote *remote)
>  {
>  	const char *slash = strchr(remote->name, '/');
>  	char *frag;
> -	char *branch;
> +	struct strbuf branch;
>  	int n = slash ? slash - remote->name : 1000;
>  	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
>  	char *s, *p;
> @@ -258,17 +258,16 @@ static void read_branches_file(struct remote *remote)
>  	strcpy(p, s);
>  	if (slash)
>  		strcat(p, slash);
> +	strbuf_init(&branch, 0);
>  	frag = strchr(p, '#');
>  	if (frag) {
>  		*(frag++) = '\0';
> -		branch = xmalloc(strlen(frag) + 12);
> -		strcpy(branch, "refs/heads/");
> -		strcat(branch, frag);
> -	} else {
> -		branch = "refs/heads/master";
> -	}
> +		strbuf_addf(&branch, "refs/heads/%s", frag);
> +	} else
> +		strbuf_addstr(&branch, "refs/heads/master");
>  	add_url_alias(remote, p);
> -	add_fetch_refspec(remote, branch);
> +	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
> +	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
>  	remote->fetch_tags = 1; /* always auto-follow */
>  }

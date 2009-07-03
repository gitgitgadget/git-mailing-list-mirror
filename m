From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add --summary option to git-push and git-fetch
Date: Fri, 03 Jul 2009 02:20:18 -0700
Message-ID: <7viqiat965.fsf@alter.siamese.dyndns.org>
References: <20090703044801.GA2072@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 11:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMewZ-0008Sw-Vd
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 11:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbZGCJUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 05:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZGCJUS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 05:20:18 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47170 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZGCJUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 05:20:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090703092019.WFQU17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Jul 2009 05:20:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id BMLK1c0014aMwMQ04MLKPc; Fri, 03 Jul 2009 05:20:19 -0400
X-VR-Score: -300.00
X-Authority-Analysis: v=1.0 c=1 a=tVKm3lmElsYA:10 a=YnUW0e-6AAAA:8
 a=2X-KxJ_YPZvCR7ESX6cA:9 a=XS85kmNMrA0i96wTdGoA:7
 a=wDCp2HVOmZlfkWz6nPc4uM7JvFMA:4 a=SBuGkJxYsgkA:10
X-CM-Score: 0.00
In-Reply-To: <20090703044801.GA2072@cthulhu> (Larry D'Anna's message of "Fri\, 3 Jul 2009 00\:48\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122691>

Larry D'Anna <larry@elder-gods.org> writes:

> --summary will cause git-push to output a one-line of each commit pushed.
> --summary=n will display at most n commits for each ref pushed.
>
> $ git push --dry-run --summary origin :
> To /home/larry/gitsandbox/a
>    80f0e50..5593a38  master -> master
>     > 5593a38 foo
>     > 81c03f8 bar
>
> Fetch works the same way.
>
> Signed-off-by: Larry D'Anna <larry@elder-gods.org>
> ---

With this rewrite not to call cmd_log() directly, it looks much better
than the previous round.  It allows us more freedom to do things slightly
differently than the stock cmd_log() lets us, such as giving "..." after
"n" commits by default, much like fmt-merge-msg does.

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index cd5eb9a..b79d870 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -29,6 +29,7 @@ static const char *depth;
>  static const char *upload_pack;
>  static struct strbuf default_rla = STRBUF_INIT;
>  static struct transport *transport;
> +static int summary = 0;

Don't initialize statics with "= 0;".  BSS will take care of it.

>  static struct option builtin_fetch_options[] = {
>  	OPT__VERBOSITY(&verbosity),
> @@ -47,6 +48,9 @@ static struct option builtin_fetch_options[] = {
>  		    "allow updating of HEAD ref"),
>  	OPT_STRING(0, "depth", &depth, "DEPTH",
>  		   "deepen history of shallow clone"),
> +	{ OPTION_INTEGER, 0, "summary", &summary, "n", "print a summary of [at most n] fetched commits",
> +	  PARSE_OPT_OPTARG, NULL, -1
> +	},
>  	OPT_END()
>  };

I think I'd prefer some reasonable default instead of making it unlimited,
much like how fmt-merge-msg does.  We might want to make this configurable
(I think fmt-merge-msg uses a hardcoded 20), and perhaps even use them the
same configuration variable (summary.length or something).

> @@ -260,11 +265,12 @@ static int update_local_ref(struct ref *ref,
>  		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
>  			SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
>  			r ? "  (unable to update local ref)" : "");
> +		if (!r)
> +			strcpy (quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));

We do not leave extra whitespace between function name and open
parenthesis (you have other instances of this style violation); on the
other hand, we do keep one whitespace after keywords like if, while, and
for (this is just fyi; I do not think I saw any violation of the latter in
the patch).

> diff --git a/builtin-log.c b/builtin-log.c
> index 44f9a27..cc4dc0a 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -1293,3 +1293,38 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
> ...
> +void print_summary_for_push_or_fetch (const char *quickref, int limit)
> +{
> +...
> +	temp = stdout;
> +	stdout = stderr;

Is this even a valid C?  stdout and friends are described in POSIX.1 as
"Normally, there are three open streams with constant pointers declared in
the <stdio.h> header and associated with the standard open files."

At least Solaris 11 Clib headers does not seem to like it.  I do not know
about Windows.

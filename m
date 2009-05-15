From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Fri, 15 May 2009 14:51:40 -0700
Message-ID: <7vljoyrq4z.fsf@alter.siamese.dyndns.org>
References: <1242349041.646.8.camel@Joe-Laptop.home>
	<7v63g2tewu.fsf@alter.siamese.dyndns.org>
	<1242418762.3373.90.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M55KQ-0000Ol-E4
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbZEOVvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbZEOVvv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:51:51 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42151 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbZEOVvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:51:50 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515215141.FXFQ2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Fri, 15 May 2009 17:51:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rxrg1b00E4aMwMQ04xrgKt; Fri, 15 May 2009 17:51:40 -0400
X-Authority-Analysis: v=1.0 c=1 a=80QVIHGmj5cA:10 a=52mTYfW24d0A:10
 a=IJv9LcIfAAAA:8 a=n5Qf0dLB7KDUxZcf3BgA:9 a=eXguZq82s8dxO8mlqgoA:7
 a=lz0vt4cA9YGsgW7TwD_A1BiRYw0A:4 a=K6kUPx8HyhEA:10
X-CM-Score: 0.00
In-Reply-To: <1242418762.3373.90.camel@Joe-Laptop.home> (Joe Perches's message of "Fri\, 15 May 2009 13\:19\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119302>

Joe Perches <joe@perches.com> writes:

> On Fri, 2009-05-15 at 11:11 -0700, Junio C Hamano wrote:
>> I think it makes sense to let users affect how the short-log in the cover
>> letter is generated.  I do not think overloading the --cover-letter option
>> for doing it is the ideal approach, though.
>
> OK.  How about this patch?

I'd suggest...

> diff --git a/builtin-log.c b/builtin-log.c
> index 5eaec5d..49fd42a 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -460,6 +460,11 @@ static void add_header(const char *value)
>  static int thread = 0;
>  static int do_signoff = 0;
>  
> +static int coverletter_wrap = 1;

Do not change the default behaviour before people agree it is a good
feature;

	static int coverletter_wrap;

> +static int coverletter_wrappos = 72;
> +static int coverletter_indent1 = 2;
> +static int coverletter_indent2 = 4;
> +
>  static int git_format_config(const char *var, const char *value, void *cb)
>  {
>  	if (!strcmp(var, "format.headers")) {
> @@ -668,10 +673,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	strbuf_release(&sb);
>  
>  	shortlog_init(&log);
> -	log.wrap_lines = 1;
> -	log.wrap = 72;
> -	log.in1 = 2;
> -	log.in2 = 4;
> +	log.wrap_lines = coverletter_wrap;
> +	log.wrap = coverletter_wrappos;
> +	log.in1 = coverletter_indent1;
> +	log.in2 = coverletter_indent2;
>  	for (i = 0; i < nr; i++)
>  		shortlog_add_commit(&log, list[i]);
>  
> @@ -868,6 +873,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			fmt_patch_suffix = argv[i] + 9;
>  		else if (!strcmp(argv[i], "--cover-letter"))
>  			cover_letter = 1;
> +		else if (!prefixcmp(argv[i], "--cover-letter-wrap=")) {
> +			if (sscanf(argv[i] + 20, "%d,%d,%d",
> +				   &coverletter_wrappos,
> +				   &coverletter_indent1,
> +				   &coverletter_indent2) <= 0)
> +				die("Need options for --cover-letter-wrap=");
> +			if (coverletter_wrappos == 0)
> +				coverletter_wrap = 0;

... lose this "if ()"; if you are asking for --cover-letter-wrap from the
command line explicitly, you do want the result to be wrapped.

In order to prepare yourself for change of default in the future (or
adding configurable defaults), the command line parser (the sscanf()
above) needs to understand something like "--cover-letter-linewrap=no", in
addition to the up-to-three integers it currently takes via sscanf().
Treating "the resulting line should be wrapped at 0 column" as "please do
not wrap" may work in practice but I do not think it is a good style.

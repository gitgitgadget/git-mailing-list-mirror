From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun, 3 Feb 2013 23:15:49 +0000
Message-ID: <20130203231549.GV1342@serenity.lan>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 00:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U28nN-0001I4-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 00:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3BCXQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 18:16:00 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:53289 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab3BCXP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 18:15:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E4E496064E2;
	Sun,  3 Feb 2013 23:15:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWlKkgtNd0mo; Sun,  3 Feb 2013 23:15:56 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 2F11D6064A8;
	Sun,  3 Feb 2013 23:15:51 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v8v7585sr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215342>

On Sun, Feb 03, 2013 at 01:07:48PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > A quick search turned up the original thread where this feature was
> > added to Clang [1].  It seems that it does find genuine bugs where
> > people try to log values by doing:
> >
> >     log("failed to handle error: " + errno);
> 
> To be perfectly honest, anybody who writes such a code should be
> sent back to school before trying to touch out code ever again ;-).

Yeah, I can't see that getting through review here :-).

> It is not even valid Python, Perl nor Java, I would think.

It is valid Java, although I can't think of any other languages that let
you do that.

> > Are you happy to change COLONS to a const char[] instead of a #define?
> 
> Happy?  Not really.
> 
> It could be a good change for entirely different reason. We will
> save space if we ever need to use it in multiple places.  But the
> entire "COLONS + offset" thing was a hack we did, knowing that it
> will break when we end up showing a muiti-way diff for more than 32
> blobs.
> 
> If we were to be touching that area of code, I'd rather see a change
> to make it more robust against such a corner case.  If it results in
> squelching misguided clang warnings against programmers who should
> not be writing in C, that is a nice side effect, but I loathe to see
> any change whose primary purpose is to squelch pointless warnings.

This seems like a sensible change.

I generally like to get rid of the pointless warnings so that the useful
ones can't hide in the noise.  Perhaps "CFLAGS += -Wno-string-plus-int"
would be better for this particular warning, but when there's only one
bit of code that triggers it, tweaking that seemed simpler.

>  combine-diff.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/combine-diff.c b/combine-diff.c
> index bb1cc96..7f6187f 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -982,14 +982,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  	free(sline);
>  }
>  
> -#define COLONS "::::::::::::::::::::::::::::::::"
> -
>  static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct rev_info *rev)
>  {
>  	struct diff_options *opt = &rev->diffopt;
> -	int i, offset;
> -	const char *prefix;
> -	int line_termination, inter_name_termination;
> +	int line_termination, inter_name_termination, i;
>  
>  	line_termination = opt->line_termination;
>  	inter_name_termination = '\t';
> @@ -1000,17 +996,14 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
>  		show_log(rev);
>  
>  	if (opt->output_format & DIFF_FORMAT_RAW) {
> -		offset = strlen(COLONS) - num_parent;
> -		if (offset < 0)
> -			offset = 0;
> -		prefix = COLONS + offset;
> +		/* As many colons as there are parents */
> +		for (i = 0; i < num_parent; i++)
> +			putchar(':');
>  
>  		/* Show the modes */
> -		for (i = 0; i < num_parent; i++) {
> -			printf("%s%06o", prefix, p->parent[i].mode);
> -			prefix = " ";
> -		}
> -		printf("%s%06o", prefix, p->mode);
> +		for (i = 0; i < num_parent; i++)
> +			printf("%06o ", p->parent[i].mode);
> +		printf("%06o", p->mode);
>  
>  		/* Show sha1's */
>  		for (i = 0; i < num_parent; i++)

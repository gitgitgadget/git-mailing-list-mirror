From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 11:26:00 -0700
Message-ID: <7v64ld2uyv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 20:26:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU6W9-0006ks-NR
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 20:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDMS0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 14:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWDMS0E
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 14:26:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60130 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964797AbWDMS0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 14:26:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413182601.JITE2467.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 14:26:01 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 13 Apr 2006 03:02:10 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18664>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now you can say "git diff --stat" (to get an idea how many changes are
> uncommitted), or "git log --stat" (to get an idea how many changes were
> committed).

I like what this tries to do (as I already said), but there are
issues with the way it does it; here are some comments.

> +static int fn_diffstat(void *priv, mmbuffer_t *mb, int nbuf)
> +{
> +...
> +	for (i = 0; i < nbuf; i++)
> +		if (mb[i].ptr[0] == '+')
> +			x->added++;
> +		else if (mb[i].ptr[0] == '-')
> +			x->deleted++;
> +	return 0;
> +}

This is broken if you have a hunk that adds, deletes or
leaves a line that happens to begin with a plus or a minus.

A demonstration.

        : siamese; ./git-diff-files -p
        diff --git a/Makefile b/Makefile
        index 1130af4..389143e 100644
        --- a/Makefile
        +++ b/Makefile
        @@ -1,3 +1,4 @@
        +-this new line begins with a minus
         # The default target of this Makefile is...
         all:
         
        : siamese; ./git-diff-files --stat
        ---
         Makefile |    2 +-
         1 files changed, 1 insertions(+), 1 deletions(-)

For an added line, xdl_emit_diffrec(rec, size, " ", 1, ecb) is
called, which gives mb[0].ptr = " " and mb[1].ptr = <the
contents of the line>; fn_diffstat() is called with (nbuf == 2).
You are counting the addition mark '+', but you are counting the
minus at the beginning of '-this new line...'.

A fragile workaround would be to make fn_diffstat() aware of
what the caller does and look only at mb[0], with a note to the
poor soul who needs to debug future breakage if xdiff side ever
changes.

A less efficient but more futureproof alternative is to use
xdiff-interface.c::xdiff_outf() to make sure your callback is
fed one line at a time (an example of how this can be done is
found in combine-diff.c::combine_diff()).

For the original "emit everything to stdout" code Linus did,
this was not a problem, because that usage does not care about
the record boundary.  For this "counting '+' and '-' at the
beginning of each hunk data", you do.

> @@ -221,43 +367,49 @@ static void builtin_diff(const char *nam
>  	b_two = quote_two("b/", name_b);
>  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
>  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
>...
> +	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
> +		if (diffstat)
> +			diffstat_binary(diffstat, lbl[0]);
> +		else
> +			printf("Binary files %s and %s differ\n",
> +					lbl[0], lbl[1]);
> +	} else {
>...
> @@ -690,16 +843,19 @@ static void run_diff_cmd(const char *pgm
>  			 struct diff_filespec *one,
>  			 struct diff_filespec *two,
>  			 const char *xfrm_msg,
> -			 int complete_rewrite)
> +			 int complete_rewrite,
> +			 struct diffstat_t *diffstat)
>  {
>  	if (pgm) {
> +		if (diffstat)
> +			die ("Cannot use diffstat with external diff");
>  		run_external_diff(pgm, name, other, one, two, xfrm_msg,
>  				  complete_rewrite);
>  		return;
>  	}

Instead of driving diffstat code from run_diff(),
run_diff_cmd(), and builtin_diff(), I think it would be much
cleaner to define diff_flush_stat() as a sibling to
diff_flush_raw() and diff_flush_patch(), and bypass the
run_diff() chain.  There will be some stuff you can reuse from
builtin_diff() (mostly how it interfaces with xdiff library), so
split that out as a separate function, and call it from both
builtin_diff() and diff_flush_stat().  Then you do not have to
say "Cannot use diffstat with external diff"; even when you
usually use your wdiff based external diff, you would want an
option to get diffstat, no?  This is even more true if we are to
have three bools to toggle which format to enable like I said in
my previous message with --with-raw --with-stat --with-patch
options.

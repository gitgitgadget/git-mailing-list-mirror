From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange
Date: Tue, 17 Jul 2012 00:16:03 -0400
Message-ID: <20120717041603.GD20945@sigill.intra.peff.net>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Vrana <jakub@vrana.cz>
X-From: git-owner@vger.kernel.org Tue Jul 17 06:16:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqzDI-0003XR-0w
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 06:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011Ab2GQEQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 00:16:27 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33889
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab2GQEQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 00:16:07 -0400
Received: (qmail 3560 invoked by uid 107); 17 Jul 2012 04:16:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jul 2012 00:16:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2012 00:16:03 -0400
Content-Disposition: inline
In-Reply-To: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201588>

On Mon, Jul 16, 2012 at 05:27:00PM -0700, Jakub Vrana wrote:

> If external diff is specified through diff.external then it is used even if
> `git diff --no-ext-diff` is used when there is a typechange.

Eek. That has some minor security implications, as it means that it is
dangerous to run even plumbing inspection command in somebody else's
repository.

However...

>  diff.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index 208096f..898d610 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3074,6 +3074,9 @@ static void run_diff(struct diff_filepair *p, struct
> diff_options *o)
>  	if (o->prefix_length)
>  		strip_prefix(o->prefix_length, &name, &other);
>  
> +	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
> +		pgm = NULL;
> +
>  	if (DIFF_PAIR_UNMERGED(p)) {
>  		run_diff_cmd(pgm, name, NULL, attr_path,
>  			     NULL, NULL, NULL, o, p);

run_diff_cmd already checks the ALLOW_EXTERNAL bit and sets pgm to NULL
there. So as far as I can tell, we are not actually running the external
diff. However, there is still a problem. Later in run_diff we do:

        if (!pgm &&
            DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
            (S_IFMT & one->mode) != (S_IFMT & two->mode)) {
                /*
                 * a filepair that changes between file and symlink
                 * needs to be split into deletion and creation.
                 */
                struct diff_filespec *null = alloc_filespec(two->path);
                run_diff_cmd(NULL, name, other, attr_path,
                             one, null, &msg, o, p);
                free(null);
                strbuf_release(&msg);

                null = alloc_filespec(one->path);
                run_diff_cmd(NULL, name, other, attr_path,
                             null, two, &msg, o, p);
                free(null);
        }
        else
                run_diff_cmd(pgm, name, other, attr_path,
                             one, two, &msg, o, p);

IOW, we split up a typechange if we are feeding it to the internal diff
generator, because builtin_diff will not show diffs between different
types. But the check for "!pgm" here is not right; we don't know yet
whether we will be builtin or external, because we have not checked
ALLOW_EXTERNAL yet.

So I think your fix is the right thing, but the bug it is fixing is not
"do not run external diff even when --no-ext-diff is specified". It is
"do not accidentally feed typechange diffs to builtin_diff".

You can see the difference in output with this script (and it works fine
with your patch applied):

    git init -q repo && cd repo &&
    echo content >file && git add file && git commit -q -m regular &&
    rm file && ln -s dest file && git commit -q -a -m typechange &&
    export GIT_PAGER=cat &&
    export GIT_EXTERNAL_DIFF='echo doing external diff' &&
    git show HEAD^ --format='=== %s, ext ===' --ext-diff &&
    git show HEAD^ --format='=== %s, no-ext ===' --no-ext-diff &&
    git show HEAD  --format='=== %s, ext ===' --ext-diff &&
    git show HEAD  --format='=== %s, no-ext ===' --no-ext-diff

-Peff

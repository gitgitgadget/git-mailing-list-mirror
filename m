From: "Jakub Vrana" <jakub@vrana.cz>
Subject: RE: [PATCH] diff: respect --no-ext-diff with typechange
Date: Tue, 17 Jul 2012 18:07:40 -0700
Message-ID: <000e01cd6481$bbd63970$3382ac50$@vrana.cz>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz> <20120717041603.GD20945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 03:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrIk0-0004Lq-1N
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 03:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152Ab2GRBHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 21:07:44 -0400
Received: from maxipes.logix.cz ([93.89.80.122]:40133 "EHLO maxipes.logix.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab2GRBHm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2012 21:07:42 -0400
Received: from JAKUBVT420S (unknown [IPv6:2620:0:1cfe:28:9c40:6f50:d34b:ae59])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by maxipes.logix.cz (Postfix) with ESMTP id B8D085D3BBB;
	Wed, 18 Jul 2012 13:14:16 +1200 (NZST)
In-Reply-To: <20120717041603.GD20945@sigill.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHNUK23Q4/5aKcOeEiJ6/FPuCGGwQKtnXLzlxjzj3A=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201641>

Yes, I was fixing the invalid (!pgm) condition, sorry for a non-precise description.

Does it mean that my patch is accepted or is there something else I need to do?

-- 
Jakub Vrana


-----Original Message-----
From: Jeff King [mailto:peff@peff.net] 
Sent: Monday, July 16, 2012 9:16 PM
To: Jakub Vrana
Cc: git@vger.kernel.org; gitster@pobox.com
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange

On Mon, Jul 16, 2012 at 05:27:00PM -0700, Jakub Vrana wrote:

> If external diff is specified through diff.external then it is used 
> even if `git diff --no-ext-diff` is used when there is a typechange.

Eek. That has some minor security implications, as it means that it is dangerous to run even plumbing inspection command in somebody else's repository.

However...

>  diff.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index 208096f..898d610 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3074,6 +3074,9 @@ static void run_diff(struct diff_filepair *p, 
> struct diff_options *o)
>  	if (o->prefix_length)
>  		strip_prefix(o->prefix_length, &name, &other);
>  
> +	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
> +		pgm = NULL;
> +
>  	if (DIFF_PAIR_UNMERGED(p)) {
>  		run_diff_cmd(pgm, name, NULL, attr_path,
>  			     NULL, NULL, NULL, o, p);

run_diff_cmd already checks the ALLOW_EXTERNAL bit and sets pgm to NULL there. So as far as I can tell, we are not actually running the external diff. However, there is still a problem. Later in run_diff we do:

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

IOW, we split up a typechange if we are feeding it to the internal diff generator, because builtin_diff will not show diffs between different types. But the check for "!pgm" here is not right; we don't know yet whether we will be builtin or external, because we have not checked ALLOW_EXTERNAL yet.

So I think your fix is the right thing, but the bug it is fixing is not "do not run external diff even when --no-ext-diff is specified". It is "do not accidentally feed typechange diffs to builtin_diff".

You can see the difference in output with this script (and it works fine with your patch applied):

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

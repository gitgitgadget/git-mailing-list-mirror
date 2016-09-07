Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5239F1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756999AbcIGRBA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:01:00 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36709 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbcIGRA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:00:59 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BEF2CA80E6;
        Wed,  7 Sep 2016 19:00:56 +0200 (CEST)
Date:   Wed, 7 Sep 2016 10:00:55 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: format-patch base-commit: moving to above the patch?
Message-ID: <20160907170055.GA23347@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh99rpud4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 09:06:31AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > Currently, format-patch puts base-commit and prerequisite-patch-id
> > information below the patch, and below the email signature.  Most mail
> > clients automatically trim everything below the signature marker as
> > unimportant when quoting a mail for a reply, which would make it
> > difficult for someone to reply, quote the base-commit, and say something
> > like "I don't have this commit, where did it come from?" or "Can you
> > please rebase this on ...".
> >
> > Might it make sense to move this information adjacent to the diffstat,
> > instead?  Or, at least, above the email signature?
> 
> I personally feel that it would be annoying to have them near
> diffstat, especially given that unbounded many prereq patches can be
> listed.  It would not be too bad to flip the order between the call
> to print_signature() and print_bases(), though.

I can live with that; having it above the signature was a much bigger
concern for me than moving it above the patch.

> The extent of the change needed to (note: not even compile-tested)
> does does not look too bad, either.
> 
> I did not carefully think what the right adjustment for the MIME
> case is, though.

Seems plausible to me.

> I would expect some tests that expect the current order of the tail
> end of the output to break, which you would need to adjust.  And if
> there is no such test right now, you should add one, as your inquiry
> and this patch _sets_ a concrete expectation as to what should come
> before the signature line, which future updates should not break.

I can do that; arguably we should also have a test that nothing *except*
the git version appears after the signature line.

> 
>  builtin/log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 92dc34d..d69d5e6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1042,7 +1042,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	diff_flush(&opts);
>  
>  	fprintf(rev->diffopt.file, "\n");
> -	print_signature(rev->diffopt.file);
>  }
>  
>  static const char *clean_message_id(const char *msg_id)
> @@ -1720,6 +1719,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		make_cover_letter(&rev, use_stdout,
>  				  origin, nr, list, branch_name, quiet);
>  		print_bases(&bases, rev.diffopt.file);
> +		print_signature(rev.diffopt.file);
>  		total++;
>  		start_number--;
>  	}
> @@ -1779,13 +1779,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		if (!use_stdout)
>  			rev.shown_one = 0;
>  		if (shown) {
> +			print_bases(&bases, rev.diffopt.file);
>  			if (rev.mime_boundary)
>  				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
>  				       mime_boundary_leader,
>  				       rev.mime_boundary);
>  			else
>  				print_signature(rev.diffopt.file);
> -			print_bases(&bases, rev.diffopt.file);
>  		}
>  		if (!use_stdout)
>  			fclose(rev.diffopt.file);

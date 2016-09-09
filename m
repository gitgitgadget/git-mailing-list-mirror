Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E271F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbcIIUHa (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:07:30 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52962 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbcIIUH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:07:29 -0400
Received: from mfilter10-d.gandi.net (mfilter10-d.gandi.net [217.70.178.139])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 34999172098;
        Fri,  9 Sep 2016 22:07:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter10-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter10-d.gandi.net (mfilter10-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id K-hfJ88BMWBT; Fri,  9 Sep 2016 22:07:25 +0200 (CEST)
X-Originating-IP: 45.61.26.130
Received: from x (unknown [45.61.26.130])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 333111720A4;
        Fri,  9 Sep 2016 22:07:23 +0200 (CEST)
Date:   Fri, 9 Sep 2016 13:07:21 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before
 email signature
Message-ID: <20160909200721.xfkbud377ja4wkrt@x>
References: <20160908011200.qzvbdt4wjwiji4h5@x>
 <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
 <20160908185408.5qtfnztjbastlrtw@x>
 <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
 <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
 <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20160827 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 12:41:56PM -0700, Junio C Hamano wrote:
> So here is a suggested replacement.  I notice that in the MIME case,
> we do not leave any blank line between the last line of the patch
> and the baseinfo, which makes it look a bit strange, e.g. output of
> "format-patch --attach=mimemime -1" may end like this:
> 
>     +       test_write_lines 1 2 >expect &&
>     +       test_cmp expect actual
>     +'
>     +
>      test_expect_success 'format-patch --pretty=mboxrd' '
>             sp=" " &&
>             cat >msg <<-INPUT_END &&
>     base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
> 
>     --------------mimemime--
> 
> We may want to tweak it a bit further.
> 
> -- >8 --
> From: Josh Triplett <josh@joshtriplett.org>
> Date: Wed, 7 Sep 2016 18:12:01 -0700
> Subject: [PATCH] format-patch: show base info before email signature
> 
> Any text below the "-- " for the email signature gets treated as part of
> the signature, and many mail clients will trim it from the quoted text
> for a reply.  Move it above the signature, so people can reply to it
> more easily.
> 
> Similarly, when producing the patch as a MIME attachment, the
> original code placed the base info after the attached part, which
> would be discarded.  Move the base info to the end of the part,
> still inside the part boundary.
> 
> Add tests for the exact format of the email signature, and add tests
> to ensure that the base info appears before the email signature when
> producing a plain-text output, and that it appears before the part
> boundary when producing a MIME attachment.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good to me.

>  builtin/log.c           |  4 ++--
>  t/t4014-format-patch.sh | 30 +++++++++++++++++++++++++-----
>  2 files changed, 27 insertions(+), 7 deletions(-)
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
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b0579dd..535857e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -754,9 +754,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  	git format-patch --ignore-if-in-upstream HEAD
>  '
>  
> +git_version="$(git --version | sed "s/.* //")"
> +
> +signature() {
> +	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
> +}
> +
> +test_expect_success 'format-patch default signature' '
> +	git format-patch --stdout -1 | tail -n 3 >output &&
> +	signature >expect &&
> +	test_cmp expect output
> +'
> +
>  test_expect_success 'format-patch --signature' '
> -	git format-patch --stdout --signature="my sig" -1 >output &&
> -	grep "my sig" output
> +	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
> +	signature "my sig" >expect &&
> +	test_cmp expect output
>  '
>  
>  test_expect_success 'format-patch with format.signature config' '
> @@ -1502,12 +1515,11 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
>  
>  test_expect_success 'format-patch --base' '
>  	git checkout side &&
> -	git format-patch --stdout --base=HEAD~3 -1 >patch &&
> -	grep "^base-commit:" patch >actual &&
> -	grep "^prerequisite-patch-id:" patch >>actual &&
> +	git format-patch --stdout --base=HEAD~3 -1 | tail -n 6 >actual &&
>  	echo "base-commit: $(git rev-parse HEAD~3)" >expected &&
>  	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
>  	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
> +	signature >> expected &&
>  	test_cmp expected actual
>  '
>  
> @@ -1605,6 +1617,14 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'format-patch --base with --attach' '
> +	git format-patch --attach=mimemime --stdout --base=HEAD~ -1 >patch &&
> +	sed -n -e "/^base-commit:/s/.*/1/p" -e "/^---*mimemime--$/s/.*/2/p" \
> +		patch >actual &&
> +	test_write_lines 1 2 >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'format-patch --pretty=mboxrd' '
>  	sp=" " &&
>  	cat >msg <<-INPUT_END &&
> -- 
> 2.10.0-339-gc0c747f
> 

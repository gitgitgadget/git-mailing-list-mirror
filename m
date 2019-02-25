Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F24220248
	for <e@80x24.org>; Mon, 25 Feb 2019 18:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfBYSqZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Feb 2019 13:46:25 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39738 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYSqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 13:46:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1PIkIPt050582
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Feb 2019 13:46:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Matthew Booth'" <mbooth@redhat.com>
Cc:     <git@vger.kernel.org>
References: <CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com> <20190225171817.GA17524@sigill.intra.peff.net>
In-Reply-To: <20190225171817.GA17524@sigill.intra.peff.net>
Subject: RE: [BUG] git log -L ... -s does not suppress diff output
Date:   Mon, 25 Feb 2019 13:46:11 -0500
Message-ID: <001701d4cd3a$6441d420$2cc57c60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUXmbXI5eD7QoYnnCtFU5BJcMIkQJFGhm+pl+OxLA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 25, 2019 12:18, Jeff King wrote:
> To: Matthew Booth <mbooth@redhat.com>
> Cc: git@vger.kernel.org
> Subject: Re: [BUG] git log -L ... -s does not suppress diff output
> 
> On Mon, Feb 25, 2019 at 05:03:50PM +0000, Matthew Booth wrote:
> 
> > Example output:
> >
> > =========
> > $ git --version
> > git version 2.20.1
> >
> > $ git log -L 2957,3107:nova/compute/manager.py -s commit
> > 35ce77835bb271bad3c18eaf22146edac3a42ea0
> > <snip>
> >
> > diff --git a/nova/compute/manager.py b/nova/compute/manager.py
> > --- a/nova/compute/manager.py
> > +++ b/nova/compute/manager.py
> > @@ -2937,152 +2921,151 @@
> >      def rebuild_instance(self, context, instance, orig_image_ref, image_ref,
> >                           injected_files, new_pass, orig_sys_metadata,
> > <snip> =========
> 
> At first I wondered why you would want to do this, since the point of -L is to
> walk through that diff. But I suppose you might want to see just the commits,
> without the actual patch, and that's what "-s" ought to do.
> 
> > git log docs suggest it should not do this:
> >
> >        -s, --no-patch
> >            Suppress diff output. Useful for commands like git show
> > that show the patch by default, or to cancel
> >            the effect of --patch.
> >
> > Couldn't find anything in a search of the archives of this mailing
> > list, although that's obviously far from conclusive. Seems to be
> > longstanding, as it was mentioned on StackOverflow back in 2015:
> 
> I think the issue is just that "-L" follows a very different code path than the
> normal diff generator. Perhaps something like this helps?
> 
> diff --git a/line-log.c b/line-log.c
> index 63df51a08f..ed46a3a493 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1106,7 +1106,8 @@ int line_log_print(struct rev_info *rev, struct
> commit *commit)
>  	struct line_log_data *range = lookup_line_range(rev, commit);
> 
>  	show_log(rev);
> -	dump_diff_hacky(rev, range);
> +	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT))
> +		dump_diff_hacky(rev, range);
>  	return 1;
>  }

I hit this about 6 months ago while trying to show off git to some colleagues - it was on 2.8.5. Sadly I forgot about it. Glad it came back.
Thanks.


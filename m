Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532761F404
	for <e@80x24.org>; Tue, 28 Aug 2018 06:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeH1Kml (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 06:42:41 -0400
Received: from mail135-4.atl141.mandrillapp.com ([198.2.135.4]:19407 "EHLO
        mail135-4.atl141.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbeH1Kml (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 06:42:41 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 06:42:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=uL4pecZedmADwcYdly1ZpvsEFOJ7xH7CtbtqOgeqMDE=;
 b=gcl0YYVVRT547+ho2cE8evHFq4Jxf7/D32Rt4nm+n1Wp0cvy/H77cg/7hjOSIT0wh7+Yg5wQUQs+
   ZhfEsYQlTqHyUM1xEGID5EDSUa6knWmh/cnzqhIFxb/QzpPupP+2+h6So51PY2nMCZLXozD9TOuC
   Eum1Oz3FTtq13GNWAkU=
Received: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail135-4.atl141.mandrillapp.com id hgjoiq1sau83 for <git@vger.kernel.org>; Tue, 28 Aug 2018 06:37:28 +0000 (envelope-from <bounce-md_31050260.5b84eda8.v1-0dfe0dfee7da4991b6205f10b65062ed@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1535438248; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=uL4pecZedmADwcYdly1ZpvsEFOJ7xH7CtbtqOgeqMDE=; 
 b=PldzenLxCna8Vz+V7XG5HpK/CKxZgFeiAunb6AHDLfVRRjzEUE/rSRLQ10Fqvxwoqcax4f
 y9V7olctN0qAbbxsl+Yb5J/s/R2vcLOenrmQyCn7bzrCzw5D6ZnxxhOA6i/wEGizRbFLcehu
 M9lZdUcZwq8W51B5XwZlxts08DRTU=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
Received: from [87.98.221.171] by mandrillapp.com id 0dfe0dfee7da4991b6205f10b65062ed; Tue, 28 Aug 2018 06:37:28 +0000
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
Message-Id: <20180828063723.GA10059@deco.navytux.spb.ru>
References: <20180814114721.25577-1-szeder.dev@gmail.com> <20180827102238.GA26738@deco.navytux.spb.ru> <20180827230452.GC10402@sigill.intra.peff.net>
In-Reply-To: <20180827230452.GC10402@sigill.intra.peff.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.0dfe0dfee7da4991b6205f10b65062ed
X-Mandrill-User: md_31050260
Date:   Tue, 28 Aug 2018 06:37:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 07:04:52PM -0400, Jeff King wrote:
> On Mon, Aug 27, 2018 at 10:22:46AM +0000, Kirill Smelkov wrote:
> 
> > A minor comment from outside observer: running tests under something
> > like
> > 
> > 	-e and -o pipefail
> > 
> > would automatically catch the mistake in the first place. Maybe `-o
> > pipefail` is bashism (I had not checked), but `git grep " | " t/` shows
> > there are a lot of pipelines being used, and thus similar errors might be
> > silently resting there. Something like -o pipefail would catch all such
> > problems automatically.
> 
> Yes, "pipefail" is a bash-ism that we can't rely on.
> 
> I will say that I have been bitten before by "set -e -o pipefail" and
> its subtle handling of SIGPIPE. Try this:
> 
>   set -e -o pipefail
>   yes | head

Thanks for the information. Oh well...

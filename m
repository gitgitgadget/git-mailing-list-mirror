Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91E21F463
	for <e@80x24.org>; Mon, 23 Sep 2019 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393368AbfIWLga (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 07:36:30 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:45921 "EHLO
        kylie.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbfIWLga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 07:36:30 -0400
X-Greylist: delayed 1019 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 07:36:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=JKuBeH+ei+px+HhRFXEUugJHxyBK92ldRF1CGI9LG8I=; b=m0kBFPL12P/8J4pS7CLHC+/UKF
        nxSFm5SjY55lD6QdKL6qPkXZCKFwze3K+0os1jj1q3Tuy/jykdCEJuCSSlLI7N7e7dJ+jXIAL01nJ
        47ZjXP65Nn85ONdjQhwb9E9krEo30j0mjfRejbfcgen0dpdlQVDujVITrtJXUYAoW7asX6zl2/W6/
        fVl/DOLivT+Acv623CgdwS/VpS+5lMzR6O0tYvQf3uvb6FgBWDX7UF2No8aTc4BnVpU1NLEm3SgYn
        6iJ1Y75ZHPvUx8v6vEVC75TiL4TLGnpmefXeuY6btS0N2iO2zepU75aUjyHJJD8czQ4KrI83p6tKc
        WiqHnpwvz2y7QRS/PQn4OL/iQxwv3nfJPX8Ngn7NnigqA579wnhhqbv5LFuJAVR06AtYB/g4xmGGk
        FatQh4coe/Q1Jf7iGMbTCRfx1wmdlk69ajYUU6ECmNVuncKIw3U1eTi90E7iOYRgdT6DcjgFTlDws
        LOHtnHSIhMnFnnkAnOa3oXpFMWuiTdOiqZg84u22TYR6dYN67vIH9P/utHLKpe4zPVWAxyygB9h34
        CVuM8tTg1Bs5O9rNT24Y4q4G7VUSmikci2hCTIAbKxhrih2g88y6DLrl5BmNp1h17FDFDhInblu+4
        XlwI5dOnYcAsyIjcNicfaUQQ7B1PFgZ727UaUEHNM=;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     qemu-devel@nongnu.org
Cc:     Jeff King <peff@peff.net>, Eric Blake <eblake@redhat.com>,
        berrange@redhat.com, stefanha@gmail.com,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        Greg Kurz <groug@kaod.org>, dgilbert@redhat.com,
        antonios.motakis@huawei.com, git@vger.kernel.org
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
Date:   Mon, 23 Sep 2019 13:19:18 +0200
Message-ID: <56046367.TiUlWITyhT@silver>
In-Reply-To: <20190909142511.GA20726@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com> <305577c2-709a-b632-4056-6582771176ac@redhat.com> <20190909142511.GA20726@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Montag, 9. September 2019 16:25:12 CEST Jeff King wrote:
> On Mon, Sep 09, 2019 at 09:05:45AM -0500, Eric Blake wrote:
> > > But as you can already read from the manual, the overall behaviour of
> > > git
> > > regarding a separate "From:" line in the email body was intended solely
> > > for
> > > the use case sender != author. So in practice (at least in my git
> > > version) git always makes a raw string comparison between sender (name
> > > and email) string and author string and only adds the separate From:
> > > line to the body if they differ.
> > > 
> > > Hence also "git format-patch --from=" only works here if you use a
> > > different author string (name and email) there, otherwise on a perfect
> > > string match it is simply ignored and you end up with only one "From:"
> > > in the email header.> 
> > git folks:
> > 
> > How hard would it be to improve 'git format-patch'/'git send-email' to
> > have an option to ALWAYS output a From: line in the body, even when the
> > sender is the author, for the case of a mailing list that munges the
> > mail headers due to DMARC/DKIM reasons?
> 
> It wouldn't be very hard to ask format-patch to just handle this
> unconditionally. Something like:
> 
> diff --git a/pretty.c b/pretty.c
> index e4ed14effe..9cf79d7874 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -451,7 +451,8 @@ void pp_user_info(struct pretty_print_context *pp,
>  		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
> 
>  	if (cmit_fmt_is_mail(pp->fmt)) {
> -		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
> +		if (pp->always_use_in_body_from ||
> +		    (pp->from_ident && ident_cmp(pp->from_ident, &ident))) {
>  			struct strbuf buf = STRBUF_INIT;
> 
>  			strbuf_addstr(&buf, "From: ");
> 
> but most of the work would be ferrying that option from the command line
> down to the pretty-print code.
> 
> That would work in conjunction with "--from" to avoid a duplicate. It
> might require send-email learning about the option to avoid doing its
> own in-body-from management. If you only care about send-email, it might
> be easier to just add the option there.

Would it simplify the changes in git if that would be made a
"git config [--global]" setting only? That is, would that probably simplify 
that task to one simple function call there in pretty.c?

On the other hand, considering the already existing --from argument and 
"format.from" config option:
https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatfrom

Wouldn't it make sense to just drop the currently existing sender != author 
string comparison in git and simply always add the "From:" line to the email's 
body if "format.from yes" is used, instead of introducing a suggested 2nd 
(e.g. "always-from") option? I mean sure automatically removing redundant 
information in the generated emails if sender == author sounds nice on first 
thought, but does it address anything useful in practice to justify 
introduction of a 2nd related option?

Best regards,
Christian Schoenebeck



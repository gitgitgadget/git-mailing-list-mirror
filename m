Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C392023D
	for <e@80x24.org>; Wed,  1 Mar 2017 19:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdCATjn (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 14:39:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:36579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdCATjl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 14:39:41 -0500
Received: (qmail 7170 invoked by uid 109); 1 Mar 2017 19:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 19:32:12 +0000
Received: (qmail 7128 invoked by uid 111); 1 Mar 2017 19:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 14:32:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 14:32:10 -0500
Date:   Wed, 1 Mar 2017 14:32:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Adrian Dudau <Adrian.Dudau@enea.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] pretty: use fmt_output_email_subject()
Message-ID: <20170301193210.tgvnjgc2hfaeebqf@sigill.intra.peff.net>
References: <1488297556.2955.11.camel@enea.com>
 <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
 <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
 <xmqqfuiwhnud.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuiwhnud.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 10:08:10AM -0800, Junio C Hamano wrote:

> >  	strbuf_grow(sb, title.len + 1024);
> > -	if (pp->subject) {
> > -		strbuf_addstr(sb, pp->subject);
> > +	if (pp->print_email_subject) {
> > +		if (pp->rev)
> > +			fmt_output_email_subject(sb, pp->rev);
> 
> A hidden assumption this code makes is that anybody who does not
> want .rev (aka "doing it as part of format-patch that may want
> nr/total etc") does not want _any_ "Subject: ".  It obviously holds
> true in today's code (the one in shortlog-add-commit is the only one
> and it sets an empty string to .subject).
> 
> Does the loss of flexibility to the future callers matter, though?
> I cannot tell offhand.
> 
> Thanks.  Let's see what others think.

I would think that future callers would just need to provide a dummy
pp->rev. I guess that logic could be pushed down into
fmt_output_email_subject(), so that it skips looking at
opt->subject_prefix, etc, when "opt" is NULL, and just hits the
"Subject:" case arm.

I don't think it's a big deal, but it would be easy to fix now, like:

diff --git a/log-tree.c b/log-tree.c
index 4618dd04c..c73df6857 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -334,13 +334,13 @@ void fmt_output_commit(struct strbuf *filename,
 
 void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 {
-	if (opt->total > 0) {
+	if (opt && opt->total > 0) {
 		strbuf_addf(sb, "Subject: [%s%s%0*d/%d] ",
 			    opt->subject_prefix,
 			    *opt->subject_prefix ? " " : "",
 			    digits_in_number(opt->total),
 			    opt->nr, opt->total);
-	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
+	} else if (opt && opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
 		strbuf_addf(sb, "Subject: [%s] ",
 			    opt->subject_prefix);
 	} else {
diff --git a/pretty.c b/pretty.c
index d0f86f5d8..6b321c68c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1608,8 +1608,7 @@ void pp_title_line(struct pretty_print_context *pp,
 
 	strbuf_grow(sb, title.len + 1024);
 	if (pp->print_email_subject) {
-		if (pp->rev)
-			fmt_output_email_subject(sb, pp->rev);
+		fmt_output_email_subject(sb, pp->rev);
 		if (needs_rfc2047_encoding(title.buf, title.len, RFC2047_SUBJECT))
 			add_rfc2047(sb, title.buf, title.len,
 						encoding, RFC2047_SUBJECT);

-Peff

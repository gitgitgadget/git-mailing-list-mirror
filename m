Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4AF1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759437AbcHaSMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:12:17 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:38245 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752273AbcHaSMP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Aug 2016 14:12:15 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DD6642691C9;
        Wed, 31 Aug 2016 18:12:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: verse65_122af4574d458
X-Filterd-Recvd-Size: 3568
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Aug 2016 18:12:04 +0000 (UTC)
Message-ID: <1472667123.4176.27.camel@perches.com>
Subject: Re: [PATCH] git-send-email: Add ability to cc: any "trailers" from
 commit message
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2016 11:12:03 -0700
In-Reply-To: <xmqqpooo259c.fsf@gitster.mtv.corp.google.com>
References: <b2aa91d59a6cdd468bcbe85b45807cc1b82b23ed.1472588158.git.joe@perches.com>
         <xmqqpooo259c.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-08-31 at 10:54 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > 
> > Many commits have various forms of trailers similar to
> >      "Acked-by: Name " and "Reported-by: Name "
> > 
> > Add the ability to cc these trailers when using git send-email.
> I thought you were asking what we call these " followed by
> " at the end of the log message, and "footers or trailers"
> was the answer.
> 
> I do not have a strong objection against limiting to "-by:" lines;
> for one thing, it would automatically avoid having to worry about
> "Bug-ID:" and other trailers that won't have e-mail address at all.
> 
> But if you are _only_ picking up "-by:" lines, then calling this
> option "trailers" is way too wide and confusing.  I do not think
> there is any specific name for "-by:" lines, though.  Perhaps you
> would need to invent some name that has "-by" as a substring.
> 
> "any-by"?  or just "by"?  I dunno.

Thinking about this a little, "bylines" seems much better.

> >@@ -1545,7 +1545,7 @@ foreach my $t (@files) {
> >  	# Now parse the message body
> >  	while(<$fh>) {
> >  		$message .=  $_;
> > -		if (/^(Signed-off-by|Cc): (.*)$/i) {
> > +		if (/^(Signed-off-by|Cc|[^\s]+[_-]by): (.*)$/i) {
> Micronits:
> 
>  (1) do you really want to grab a run of any non-blanks?  Don't
>      you want to exclude at least a colon?

It could use [\w_-]+

>  (2) allowing an underscore looks a bit unusual.  

It's for typos.  A relatively high percentage of
these things in at least the kernel were malformed
when I started this 5 years ago.

I don't have an objection to requiring the proper
form using only dashes though.

Maybe that'd help reduce the typo frequency anyway.

> I am aware of the fact that people sometimes write only a name with
> no e-mail address when giving credit to a third-party and we want to
> avoid upsetting the underlying MTA by feeding it a non-address.
> 
> Looking at existing helper subs like extract_valid_address and
> sanitize_address that all addresses we pass to the MTA go through,
> it appears to me that we try to support an addr-spec with only
> local-part without @domain, so this new check might turn out to be
> too strict from that point of view, but on the other hand I suspect
> it won't be a huge issue because the addresses in the footers are
> for public consumption and it may not make much sense to have a
> local-only address there.  I dunno.
> 
> > 
> >  			push @cc, $c;
> >  			printf("(body) Adding cc: %s from line '%s'\n",

me either but I think it doesn't hurt because
as you suggest, these are supposed to be public.

Thanks for the review.

cheers, Joe

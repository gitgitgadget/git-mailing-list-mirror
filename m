Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25BFC20323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbdCPSe5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:34:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:45289 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753546AbdCPSev (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:34:51 -0400
Received: (qmail 20668 invoked by uid 109); 16 Mar 2017 18:34:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:34:48 +0000
Received: (qmail 29962 invoked by uid 111); 16 Mar 2017 18:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:34:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 14:34:45 -0400
Date:   Thu, 16 Mar 2017 14:34:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 4/5] replace snprintf with odb_pack_name()
Message-ID: <20170316183444.t4mjdd7saobn2ut2@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
 <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net>
 <xmqqvar9ax6n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvar9ax6n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 11:33:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	struct strbuf name = STRBUF_INIT;
> >  	int err;
> >  
> >  	if (!from_stdin) {
> > @@ -1402,14 +1402,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
> >  		int keep_fd, keep_msg_len = strlen(keep_msg);
> >  
> >  		if (!keep_name)
> > -			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
> > -				 get_object_directory(), sha1_to_hex(sha1));
> > +			odb_pack_name(&name, sha1, "keep");
> >  
> > -		keep_fd = odb_pack_keep(keep_name ? keep_name : name);
> > +		keep_fd = odb_pack_keep(keep_name ? keep_name : name.buf);
> >  		if (keep_fd < 0) {
> >  			if (errno != EEXIST)
> >  				die_errno(_("cannot write keep file '%s'"),
> > -					  keep_name ? keep_name : name);
> > +					  keep_name ? keep_name : name.buf);
> >  		} else {
> >  			if (keep_msg_len > 0) {
> >  				write_or_die(keep_fd, keep_msg, keep_msg_len);
> > @@ -1417,28 +1416,22 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
> >  			}
> >  			if (close(keep_fd) != 0)
> >  				die_errno(_("cannot close written keep file '%s'"),
> > -					  keep_name ? keep_name : name);
> > +					  keep_name ? keep_name : name.buf);
> >  			report = "keep";
> >  		}
> >  	}
> 
> 
> The patch as-posted is obviously with less damage to the current
> code, but the above makes me wonder if it makes simpler to do
> 
> 	if (keep_name)
> 		strbuf_addstr(&name, keep_name);
> 	else
> 		odb_pack_name(&name, sha1, "keep");
> 
> so that we can always use name.buf without having to do "?:" thing.

See the next patch. :)

-Peff

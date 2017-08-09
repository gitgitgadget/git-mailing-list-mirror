Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F579208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 07:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdHIHnV (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 03:43:21 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:46562 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750879AbdHIHnV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Aug 2017 03:43:21 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dfLeA-0008Rs-Mf; Wed, 09 Aug 2017 08:43:18 +0100
Message-ID: <1502264598.2735.30.camel@hellion.org.uk>
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style
 tags which lack tagger
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 09 Aug 2017 08:43:18 +0100
In-Reply-To: <xmqqzib9ai63.fsf@gitster.mtv.corp.google.com>
References: <1502179560.2735.22.camel@hellion.org.uk>
         <20170808080620.9536-2-ijc@hellion.org.uk>
         <xmqqzib9ai63.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-08-08 at 14:00 -0700, Junio C Hamano wrote:
> > @@ -540,6 +540,9 @@ if [ "$filter_tag_name" ]; then
> > >  			new_sha1=$( ( printf 'object %s\ntype commit\ntag %s\n' \
> > >  						"$new_sha1" "$new_ref"
> > >  				git cat-file tag "$ref" |
> > > > +				awk '/^tagger/	{ tagged=1 }
> > > > > +				     /^$/	{ if (!tagged && !done) { print "tagger Unknown <unknown@example.com> 0 +0000" } ; done=1 }
> > > > +				     //		{ print }' |
> > >  				sed -n \
> > >  				    -e '1,/^$/{
> > >  					  /^object /d
> 
> What the change wants to do makes perfect sense, but piping output
> from awk into sed looks somewhat gross.  Perhaps we'd want to roll
> what the existing sed script is trying to do into this new awk
> script?

I'm far from an awk guru but I think (unit tested in isolation only)
that such script would look something like (I also inverted/renamed
done into header since it seemed clearer):

    BEGIN    	    	    	    	    	    { header=1 }
    /^tagger /    	    	    	    	    { tagged=1 }
    /^$/    	    	    	    	    	    { if (!tagged && header) { print "tagger Unknown <    unknown@example.com    > 0 +0000" } ; header=0 }

    /^-----BEGIN PGP SIGNATURE-----/    	    { exit(0) }

    //    	    	    	    	    	    { if (!header || $0 !~ /^(object|type|tag )/) { print } }

    Ian.

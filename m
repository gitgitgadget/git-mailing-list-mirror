Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77CBC1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 09:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbcIBJLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 05:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37041 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750873AbcIBJLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 05:11:33 -0400
Received: (qmail 11514 invoked by uid 109); 2 Sep 2016 09:11:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 09:11:32 +0000
Received: (qmail 23999 invoked by uid 111); 2 Sep 2016 09:11:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 05:11:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 05:11:31 -0400
Date:   Fri, 2 Sep 2016 05:11:31 -0400
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
Message-ID: <20160902091130.jxckdeomw35eewky@sigill.intra.peff.net>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
 <1472634746.4265.47.camel@kaarsemaker.net>
 <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
 <1472657553.4265.63.camel@kaarsemaker.net>
 <20160902080416.jmrctu3onfmylmeq@sigill.intra.peff.net>
 <1472806914.4680.50.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1472806914.4680.50.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 11:01:54AM +0200, Dennis Kaarsemaker wrote:

> Well, 'git init' is a valid operation to run inside an existing repo to
> reinitialize some bits, so we definitely need to not ignore the config
> once we're sure we're not creating a new repo.

Good point, I hadn't considered re-initializing.

For the follow-up patch I sent, where we check
startup_info->have_repository, I think the right thing would probably be
to call setup_git_directory() after seeing we are in a re-init case.
Probably even the "gently" form, as I think you can "re-init" a
partially corrupted repository.

> > > @@ -500,7 +506,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
> > >  				 * and we know shared_repository should always be 0;
> > >  				 * but just in case we play safe.
> > >  				 */
> > > -				saved = get_shared_repository();
> > >  				set_shared_repository(0);
> > >  				switch (safe_create_leading_directories_const(argv[0])) {
> > >  				case SCLD_OK:
> > I don't know if anybody cares about being able to set core.sharedRepository
> > from ~/.gitconfig. It didn't work until v2.9.0 anyway (when I moved it
> > out of the repository-format check), but it seems like you _should_ be
> > able to set it and have it Just Work.
> > 
> > And in that case, this "we know shared_repository should always be 0" is
> > not true, and we would want to keep doing the save/set-to-0/restore
> > dance here.
> 
> We don't need to save if we throw away the cache below.

Yeah, you're right. Though I somehow lost my train of thought between
the two paragraphs. I was thinking that we would want to actually
respect the ~/.gitconfig setting for sharedrepository. Which would
actually mean _dropping_ the save/zero/restore entirely, and just using
the value we get from the config. But I guess the point here is to avoid
s_c_l_d creating "shared" leading directories that are outside any
repository. I could see an argument either way on whether that is the
right thing to do when core.sharedRepository is set in ~/.gitconfig.

-Peff

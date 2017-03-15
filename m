Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59BD4202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 17:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdCORIt (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 13:08:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:44665 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdCORId (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 13:08:33 -0400
Received: (qmail 17852 invoked by uid 109); 15 Mar 2017 17:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:08:32 +0000
Received: (qmail 19698 invoked by uid 111); 15 Mar 2017 17:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 13:08:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 13:08:29 -0400
Date:   Wed, 15 Mar 2017 13:08:29 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-clone --config order & fetching extra refs during initial
 clone
Message-ID: <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
 <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 01:41:34AM +0100, SZEDER Gábor wrote:

> >>  static struct ref *wanted_peer_refs(const struct ref *refs,
> >> -             struct refspec *refspec)
> >> +             struct refspec *refspec, unsigned int refspec_count)
> >
> > Most of the changes here and elsewhere are just about passing along
> > multiple refspecs instead of a single, which makes sense.
> 
> The new parameter should perhaps be renamed to 'refspec_nr', though,
> as '_nr' suffix seems to be more common in the codebase than '_count'.

Yeah, agreed.

> > Though if I'm bikeshedding, I'd probably have written the whole thing
> > with an argv_array and avoided counting at all.
> 
> Yeah, I did notice that you love argv_array :)  I had to raise an
> eyebrow recently while looking at send-pack and how it uses argv_array
> to read refspecs from stdin into an array.  I think argv_array feels a
> bit out of place in both cases.  Yes, it does exactly what's needed.
> However, it's called *argv*_array, indicating that its contents is
> destined to become the options of some command.  But that's not the
> case in these two cases, we are not dealing with arguments to a
> command, these are just arrays of strings.

In my mind, "argv" is synonymous with "NULL-terminated array of
strings". If the name is the only thing keeping it from wider use, I'd
much prefer us to give it a more generic name. All I really care about
is simplifying memory management. :)

> However, leveraging get_remote() makes it moot anyway.

Even better.

> > I do also notice that right _after_ this parsing, we use remote_get(),
> > which is supposed to give us this config anyway. Which makes me wonder
> > if we could just reorder this to put remote_get() first, and then read
> > the resulting refspecs from remote->fetch.
> 
> Though get_remote() does give us this config, at this point the
> default fetch refspec has not been configured yet, therefore it's not
> included in the resulting remote->fetch array.  The default refspec is
> set in write_refspec_config(), but that's called only about two
> screenfulls later.  So there is a bit of extra work to do in order to
> leverage get_remote()'s parsing.
> 
> I think the simplest way is to keep parsing the default fetch refspec
> manually, and then append it to the remote->fetch array.  Definitely
> shorter and simpler than that parsing in the current patch.
> Alternatively, we could set the default fetch refspec in the
> configuration temporarily, only for the duration of the get_remote()
> call, but it feels a bit too hackish...

Yeah, I think manually combining the two here is fine. Though I won't
complain if you want to look into setting the config earlier. If the
refactoring isn't too bad, it would probably provide the nicest outcome.

> However, the tests should also check that refs matching the default
> fetch refspec are transferred, too, i.e. that the clone has something
> under refs/remotes/origin/ as well.  Case in point is using the result
> of get_remote(): at first I naively set out to use remote->fetch
> as-is, which didn't include the default fetch refspec, hence didn't
> fetch refs/heads/master, but the test succeeded nonetheless.

Good point.

> > If we wanted to be thorough, we could also check that the feature works
> > correctly with "--origin" (I think it does).
> 
> I think it works, but I'm not quite sure what you mean with "works
> correctly with --origin".
> 
> So just to be clear: the behaviour depends on whether the remote name
> given in '-c remote.<name>.fetch=<refspec>' matches the name given to
> the '--origin=<name>'.  If they match, then refs matching the
> additional refspec are transferred, too.  That's good.  However, if
> the two remote names don't match, then refs matching the additional
> refspec are NOT transferred.  I think this is good, too, because only
> the origin remote should be cloned, whatever it is called, and in this
> case that additional refspec belongs to a different remote.

Yes, exactly. Mostly I was suggesting that if you do "--origin=foo",
then we do not fetch items named "remote.origin.fetch" (i.e., that the
code correctly uses the origin variable and not the hard-coded name
"origin").

-Peff

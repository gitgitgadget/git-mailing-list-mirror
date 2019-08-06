Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029CF1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfHFQgq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:36:46 -0400
Received: from elephants.elehost.com ([216.66.27.132]:47064 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFQgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:36:45 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x76GaWbe089533
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 12:36:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <20190806143829.GA515@sigill.intra.peff.net> <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH 0/3] --end-of-options marker
Date:   Tue, 6 Aug 2019 12:36:26 -0400
Message-ID: <000f01d54c75$1a8fe460$4fafad20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIxP74lDdV6XvID81wkSsuwoAdCfwH5VWUSpiaeviA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 6, 2019 12:25 PM, Junio wrote:
> Jeff King <peff@peff.net> writes:
> 
> > It's hard for scripted uses of rev-list, etc, to avoid option
> > injection from untrusted arguments, because revision arguments must
> > come before any "--" separator. I.e.:
> >
> >   git rev-list "$revision" -- "$path"
> >
> > might mistake "$revision" for an option (with rev-list, that would
> > make it an error, but something like git-log would default to HEAD).
> 
> Just to make sure I understand what I just read, let me paraphrase.
> We would want to accept
> 
> 	git rev-list --max-parents=4 \
> 		--end-of-options \
> 		--count -- docs/
> 
> so that '--count' would go thru the usual "as we have -- later, it must be
a rev
> and we do not even disambiguate.  What does get_sha1() say it is?" and
> "docs/" would be taken as a pathspec.
> "git rev-list --max-parents=4 --count -- docs/" would have treated
"--count"
> as an option and would error out due to lack of any starting revision.
> 
> On the other hand, "git log --count -- docs/" would take "--count"
> as an option, but does not complain about lack of any revs.  It just
starts
> digging from HEAD and ends up ignoring the "--count" branch (or is this
> feature meant to support tags?  As far as I recall, we do not allow branch
> names that begin with a dash).
> 
> > This series provides an alternative to "--" to stop option parsing
> > without indicating that further arguments are pathspecs.

Would this offer the opportunity to, in the long term, supply options to
external diff engines, for example?

Something like git diff --end-of-options --diff-opt1 --diff-opt2 -- a b

I'm just noodling here, wondering why otherwise

git rev-list --max-parents=4  -- --count docs/

does not work. I thought -- was pretty specific in terms of turning off
interpretation. So is it not a defect that --count is being interpreted?

I have a fear for all my sub-teams who script with the assumption that --
has a specific meaning of stopping interpretation.

Slightly confused,
Randall

> >
> >   [1/3]: revision: allow --end-of-options to end option parsing
> >   [2/3]: parse-options: allow --end-of-options as a synonym for "--"
> >   [3/3]: gitcli: document --end-of-options
> >
> >  Documentation/gitcli.txt | 6 ++++++
> >  parse-options.c          | 3 ++-
> >  revision.c               | 8 +++++++-
> >  t/t0040-parse-options.sh | 7 +++++++
> >  t/t4202-log.sh           | 7 +++++++
> >  t/t6000-rev-list-misc.sh | 8 ++++++++
> >  6 files changed, 37 insertions(+), 2 deletions(-)


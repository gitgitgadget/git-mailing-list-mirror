Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB821F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHBVNE (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:13:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:40806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726177AbeHBVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:13:04 -0400
Received: (qmail 23601 invoked by uid 109); 2 Aug 2018 19:20:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 19:20:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27177 invoked by uid 111); 2 Aug 2018 19:20:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 15:20:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 15:20:33 -0400
Date:   Thu, 2 Aug 2018 15:20:33 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?B?R3Jhw7Fh?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 04/12] submodule--helper: add a new 'config'
 subcommand
Message-ID: <20180802192032.GA28962@sigill.intra.peff.net>
References: <20180802134634.10300-1-ao2@ao2.it>
 <20180802134634.10300-5-ao2@ao2.it>
 <CAGZ79kY78rgb8VpRn-A2moucy16z1TsDGdz2cjJzVOxsiKiiYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY78rgb8VpRn-A2moucy16z1TsDGdz2cjJzVOxsiKiiYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 11:47:30AM -0700, Stefan Beller wrote:

> > +static int module_config(int argc, const char **argv, const char *prefix)
> > +{
> > +       if (argc < 2 || argc > 3)
> > +               die("submodule--helper config takes 1 or 2 arguments: name [value]");
> > +
> > +       /* Equivalent to ACTION_GET in builtin/config.c */
> > +       if (argc == 2)
> > +               return print_config_from_gitmodules(argv[1]);
> > +
> > +       /* Equivalent to ACTION_SET in builtin/config.c */
> > +       if (argc == 3)
> > +               return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> > +
> > +       return 0;
> 
> Technically we cannot reach this point here?
> Maybe it would be more defensive to
> 
>     BUG("How did we get here?");
> 
> or at least return something !=0 ?

When I find myself reaching for a BUG(), it is often a good time to see
if we can restructure the code so that the logic more naturally falls
out.  Here the issue is that the first if conditional repeats the "else"
for the other two. So I think we could just write:

  if (argc == 2)
	return ...
  if (argc == 3)
	return ...

  die("need 1 or 2 arguments");

-Peff

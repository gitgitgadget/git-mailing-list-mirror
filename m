Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2A31FAFB
	for <e@80x24.org>; Sun,  2 Apr 2017 07:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbdDBHxp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 2 Apr 2017 03:53:45 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:48374 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdDBHxp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 03:53:45 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v327rgbh011955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 Apr 2017 07:53:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v327rgw4019924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 Apr 2017 07:53:42 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v327rglK011848;
        Sun, 2 Apr 2017 07:53:42 GMT
Received: from ori.omang.mine.nu (/80.203.111.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Apr 2017 00:53:41 -0700
Message-ID: <1491119619.5830.19.camel@oracle.com>
Subject: Re: Bug: 'git config --local user.email=<alt.email>' fails silently?
From:   Knut Omang <knut.omang@oracle.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Sun, 02 Apr 2017 09:53:39 +0200
In-Reply-To: <20170402073823.tudnfftbxaa6jdo5@sigill.intra.peff.net>
References: <1491112043.5830.11.camel@oracle.com>
         <20170402073823.tudnfftbxaa6jdo5@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-04-02 at 03:38 -0400, Jeff King wrote:
> On Sun, Apr 02, 2017 at 07:47:23AM +0200, Knut Omang wrote:
> 
> > From the documentation I would have expected 
> > 
> > git config --local user.email=alt.email@alt.domain
> > 
> > to create a section 
> > 
> > [user]
> > 	email=alt.email@alt.domain
> > 
> > in the local .git/config.
> 
> When it sees one argument, git-config treats that argument as a key to
> be retrieved. When given two, the second is a value to be set. E.g.:
> 
>   $ git config foo.bar
>   $ git config foo.bar some-value
>   $ git config foo.bar
>   some-value
> 
> So your command was interpreted as a request to fetch the value, which
> doesn't exist.
> 
> > Instead it returns status 1 with no error message.
> 
> Hopefully that explains the response you saw; we do not emit an error
> message when a key isn't found, which makes it easy for scripts to do
> things like:
> 
>   value=$(git config foo.bar || echo default-value)
> 
> without being unnecessarily noisy.
> 
> Usually we'd catch an error like yours and complain, because the key is
> syntactically invalid ("=" is not generally allowed in key names):
> 
>   $ git config foo.bar=some-value
>   error: invalid key: foo.bar=some-value
> 
> But your argument actually _is_ a syntactically valid key, because of
> the dots. In a three-level key like "one.two.three", the second level
> subsection is allowed to contain any character (including "=" and more
> dots). So your "user.email=alt.email@alt.domain" tries to look up the
> config represented by:
> 
>   [user "email=alt.email@alt"]
>   domain
> 
> Which of course did not exist.
> 
> > Is this intentional?
> 
> Yes, everything is working as intended. The documentation in
> git-config(1) seems to be quite poor at describing the various operating
> modes, though.

Ah - I see! 
Thanks for the quick answer and excellent explanation,
and sorry for the confusion - I should know well that config takes
the write argument after a blank.

I think I'll go and get myself another cup of coffee 
before I ask more questions anywhere...

Regards,
Knut

> 
> -Peff

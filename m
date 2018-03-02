Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68821F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424017AbeCBKqR (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:46:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:44032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1423978AbeCBKqL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:46:11 -0500
Received: (qmail 7400 invoked by uid 109); 2 Mar 2018 10:46:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Mar 2018 10:46:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27177 invoked by uid 111); 2 Mar 2018 10:47:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 05:47:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 05:46:08 -0500
Date:   Fri, 2 Mar 2018 05:46:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180302104608.GB11074@sigill.intra.peff.net>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302070434.GG238112@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302070434.GG238112@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 01, 2018 at 11:04:34PM -0800, Jonathan Nieder wrote:

> > Use of uninitialized value $_ in print at
> > /usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 75.
> [...]
> 
> Strange.  The relevant line, for reference:
> 
> $ dpkg-deb --fsys-tarfile git_2.11.0-3+deb9u2_amd64.deb |
>   tar Oxf - ./usr/lib/git-core/git-add--interactive |
>   sed -n '1370,1372 p'
> 
> 		for (@{$hunk[$ix]{DISPLAY}}) {
> 			print; <---- this one
> 		}
> 
> This is a foreach loop, so it's supposed to have set $_ to each value
> in the list @{$hunk[$ix]{DISPLAY}).  So why is Perl considering it
> uninitialized?

Because the array is full of "undef". See parse_diff(), which does this:

  my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
  ...
  @colored = run_cmd_pipe(@display_cmd);
  ...
  for (my $i = 0; $i < @diff; $i++) {
          ...
          push @{$hunk[-1]{TEXT}}, $diff[$i];
          push @{$hunk[-1]{DISPLAY}},
               (@colored ? $colored[$i] : $diff[$i]);
  }

If the @colored output is shorter than the normal @diff output, we'll
push a bunch of "undef" onto the DISPLAY array (the ternary there is
because sometimes @colored is completely empty if the user did not ask
for color).

-Peff

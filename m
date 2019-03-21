Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA6A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCUT3b (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:29:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:59658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728064AbfCUT3a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:29:30 -0400
Received: (qmail 25310 invoked by uid 109); 21 Mar 2019 19:29:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 19:29:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12322 invoked by uid 111); 21 Mar 2019 19:29:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 15:29:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 15:29:29 -0400
Date:   Thu, 21 Mar 2019 15:29:29 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Strange annotated tag issue
Message-ID: <20190321192928.GA19427@sigill.intra.peff.net>
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 11:59:42AM -0500, Robert Dailey wrote:

> I have a particular tag in my repo that shows 2 annotated
> descriptions, which is very confusing.
> 
> The command I ran:
> 
> ```
> git show --format=fuller 4.2.0.1900
> ```
> 
> And the output:
> 
> ```
> tag 4.2.0/1900
> Tagger:     John Doe <john.doe@domain.com>
> TaggerDate: Fri Jul 18 10:46:30 2014 -0500
> 
> QA/Internal Release for 4.2.0.19
> 
> tag 4.2.0/1900
> Tagger:     John Doe <john.doe@domain.com>
> TaggerDate: Fri Jul 18 10:46:15 2014 -0500
> 
> QA/Internal Release
> 
> commit 2fcfd00ef84572fb88852be55315914f37e91e11 (tag: 4.2.0.1900)

Tags can point to any object, including another tag. It looks like
somebody made an annotated tag of an annotated tag (probably by
mistake, given that they have the same tag-name).

Try this:

  git init
  git commit -m commit --allow-empty
  git tag -m inner mytag HEAD
  git tag -f -m outer mytag mytag

  git show mytag

which produces similar output. You can walk the chain yourself with "git
at-file tag 4.2.0.1900". That will have a "type" and "object" field
which presumably point to the second commit.

My guess is that somebody was trying to amend the tag commit message,
but used the tag name to create the second one, rather than the original
commit. I.e,. any of these would have worked for the second command to
replace the old tag:

  git tag -f -m 'new message' mytag HEAD

  git tag -f -m 'new message' 2fcfd00ef84572fb88852be55315914f37e91e11

  git tag -f -m 'new message' mytag mytag^{commit}

If the original tag isn't signed, you could rewrite it at this point
using one of the above commands, coupled with GIT_COMMITTER_* to munge
the author and date.  But note that fetch doesn't update modified tags
by default, so it may just cause confusion if you have a lot of people
using the repository.

-Peff

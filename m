From: Jeff King <peff@peff.net>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 16:49:13 -0400
Message-ID: <20160316204912.GA1890@sigill.intra.peff.net>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:49:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agINc-0003go-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 21:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbcCPUtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 16:49:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:60988 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751051AbcCPUtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 16:49:16 -0400
Received: (qmail 18753 invoked by uid 102); 16 Mar 2016 20:49:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 16:49:15 -0400
Received: (qmail 19660 invoked by uid 107); 16 Mar 2016 20:49:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 16:49:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 16:49:13 -0400
Content-Disposition: inline
In-Reply-To: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289033>

On Thu, Mar 17, 2016 at 01:21:49AM +0530, Pranit Bauva wrote:

> I noticed that parse-options does not recognize the variable which is
> set to -1 so as to denote the "unspecified" value.

Right. Like all of the stock parse-options handlers, it does not ever
read or understand the value passed to it by the caller. It only
increments or decrements.

> I did the following changes in builtin/commit.c (in master branch not
> the patch I am working on) :
>  - static int verbose = -1
>  - introduced a printf statement after parsing the options to print
> the value of verbose.
> 
> When I ran `git commit` :
>  I get the output that verbose is set to -1.
> 
> When I ran `git commit -v` :
> I get the output that verbose is set to 0.
> 
> When I ran `git commit -v -v` :
> I get the output that verbose is set to 1.
> 
> When I ran `git commit --no-verbose` :
> I get the out that verbose is set to 0.
> [...]
> It seems that parse-options just increments the value without
> considering the -1 flag to denote "unspecified value".
> 
> Is this a bug?

Not in parse-options, though I think setting verbose to "-1" in the
first place is wrong.

In general, parse-options does not know or care about the default values
that callers assign to variables; it just writes to them based on the
option-type specified by the caller. So the behavior for "commit",
"commit -v", and "commit -v -v" you show are perfectly reasonable.

But the one for "--no-verbose" is wrong. Parse-options has to write some
"reset" value, and it does not know what the initial default was. So it
writes 0. This is the same for options like OPT_SET_INT, and similar for
string options (where we set it to NULL).

So I think the caller choosing "-1" here as the "not set" value is the
bug.

-Peff

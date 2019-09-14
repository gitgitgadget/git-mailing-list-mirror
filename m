Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F961F463
	for <e@80x24.org>; Sat, 14 Sep 2019 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfINOaz (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 10:30:55 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54127 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387786AbfINOaz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 10:30:55 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B2488E0007;
        Sat, 14 Sep 2019 14:30:52 +0000 (UTC)
Date:   Sat, 14 Sep 2019 20:00:50 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] gitk: Make web links clickable
Message-ID: <20190914143050.jiax3vhm3ng7glew@yadavpratyush.com>
References: <20190826221444.GB7402@blackberry>
 <20190829012702.GB3297@blackberry>
 <20190829183207.sy66tyxnnzgvjv35@yadavpratyush.com>
 <20190913233307.GA29205@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913233307.GA29205@blackberry>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/19 09:33AM, Paul Mackerras wrote:
> On Fri, Aug 30, 2019 at 12:02:07AM +0530, Pratyush Yadav wrote:
> > On 29/08/19 11:27AM, Paul Mackerras wrote:
> > 
> > I know I suggested searching till the first non-whitespace character, 
> > but thinking more about, there are some problematic cases. Say someone 
> > has a commit message like:
> >   
> >   Foo bar baz (more details at https://example.com/hello)
> > 
> > Or like:
> > 
> >   Check out https://foo.com, https://bar.com
> > 
> > In the first example, the closing parenthesis gets included in the link, 
> > but shouldn't be. In the second, the comma after foo.com would be 
> > included in the link, but shouldn't be. So maybe use a more 
> > sophisticated regex?
> 
> I did think about that, but it seems to be impossible to get it right
> in all cases, so I went for simple and obvious.  In particular I don't
> see how to handle the common case of a '.' immediately following the
> URL, since '.' is a legal character in a URL.
> 
> > A quick Google search gives out the following options [0][1].
> > 
> > [0] gives the following regex:
> > 
> >   https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)
> > 
> > It is kind of ugly to look at, and I'm not even sure if there are any 
> > syntax differences with Tcl's regex library.
> > 
> > [1] lists a bunch of regexes and which URLs they work on and which ones 
> > they don't. The smallest among them I found is:
> > 
> >   @^(https?|ftp)://[^\s/$.?#].[^\s]*$@iS
> > 
> > Again, I'm not sure how well this would work with Tcl's regex library, 
> > or how commonly these URL patterns appear in actual commit messages.  
> > Just something to consider.
> > 
> > [0] https://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url
> > [1] https://mathiasbynens.be/demo/url-regex
> 
> I think I would be inclined to make the regex customizable, since that
> would also allow the user to match ftp or other URLs if they want.
> The only difficulty with that is if there are subexpressions, that
> will change how we have to interpret the list returned by the
> regexp -indices -all -inline command.

That just puts the responsibility of parsing the URL on the user, it 
doesn't solve the problem.

I don't have any numbers, but I think most problematic cases are when 
there are some trailing characters. We aren't dealing with malicious 
actors that want to do something bad or make gitk crash. IMO it is 
reasonable to expect legal URLs in a commit message.

So instead of trying to encompass all possible legal URLs and removing 
all illegal URLs, how about using a simple regex for basic filtering to 
weed out some false positives, and then trimming illegal trailing 
characters. These trailing characters would most likely be comma, 
period, parenthesis, question marks, quotation marks, etc. This way the 
logic stays simple and we tackle more real world problems.

Sounds reasonable?

-- 
Regards,
Pratyush Yadav

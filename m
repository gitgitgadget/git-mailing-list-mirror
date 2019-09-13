Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F3E1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 01:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfINByT (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 21:54:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfINByT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 21:54:19 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 46VbCW6ctPz9sNF; Sat, 14 Sep 2019 11:54:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1568426055; bh=RDSlOVGQlC3Wfc2TtxUFvAjXvu9ZOReo3Piapdyrkyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FB+8WckufP4ZRUMyYdi1kxhbtJMVyx+GH+oFPTbAMNRio+Zakd0q3u1lqTKI4rTeJ
         1UxXilVPuNks3i64xrBmu4MgxA9tOXTQpYH5/S9KN8NZ0GhXydmEsBJvZVX7I6wPeI
         Ok2vBDlP0IW1ESbjBozcGCxqbx4gA3GS8etR46rMnZMpBRZlflkwiZMvRG8oStkMSX
         ubdL7YeeZlAqb/cwDcwqylYGz9GHuHw1CAOwynSvcuTs36iK5Rx91o8s+9nYd2/T95
         cCsAyz0nXnobIS+Ha0SWM2BQ10Oni/Dxno9R5A+A9ubXKSRYv8nmVx3082+Xpcqhck
         VM+qs9V0jvPSw==
Date:   Sat, 14 Sep 2019 09:33:07 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] gitk: Make web links clickable
Message-ID: <20190913233307.GA29205@blackberry>
References: <20190826221444.GB7402@blackberry>
 <20190829012702.GB3297@blackberry>
 <20190829183207.sy66tyxnnzgvjv35@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829183207.sy66tyxnnzgvjv35@yadavpratyush.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 12:02:07AM +0530, Pratyush Yadav wrote:
> On 29/08/19 11:27AM, Paul Mackerras wrote:
> > This makes gitk look for http or https URLs in the commit description
> > and make the URLs clickable.  Clicking on them will invoke an external
> > web browser with the URL.
> > 
> > The web browser command is by default "xdg-open" on Linux, "open" on
> > MacOS, and "cmd /c start" on Windows.  The command can be changed in
> > the preferences window, and it can include parameters as well as the
> > command name.  If it is set to the empty string then URLs will no
> > longer be made clickable.
> > 
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> > v2: Match URLs anywhere, not just after [Bug]Link:.
> > 
> >  gitk | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/gitk b/gitk
> > index a14d7a1..2a0d00c 100755
> > --- a/gitk
> > +++ b/gitk
> > @@ -7016,6 +7016,7 @@ proc commit_descriptor {p} {
> >  
> >  # append some text to the ctext widget, and make any SHA1 ID
> >  # that we know about be a clickable link.
> > +# Also look for URLs of the form "http[s]://..." and make them web links.
> >  proc appendwithlinks {text tags} {
> >      global ctext linknum curview
> >  
> > @@ -7032,6 +7033,18 @@ proc appendwithlinks {text tags} {
> >  	setlink $linkid link$linknum
> >  	incr linknum
> >      }
> > +    set wlinks [regexp -indices -all -inline -line \
> > +		    {https?://[^[:space:]]+} $text]
> 
> I know I suggested searching till the first non-whitespace character, 
> but thinking more about, there are some problematic cases. Say someone 
> has a commit message like:
>   
>   Foo bar baz (more details at https://example.com/hello)
> 
> Or like:
> 
>   Check out https://foo.com, https://bar.com
> 
> In the first example, the closing parenthesis gets included in the link, 
> but shouldn't be. In the second, the comma after foo.com would be 
> included in the link, but shouldn't be. So maybe use a more 
> sophisticated regex?

I did think about that, but it seems to be impossible to get it right
in all cases, so I went for simple and obvious.  In particular I don't
see how to handle the common case of a '.' immediately following the
URL, since '.' is a legal character in a URL.

> A quick Google search gives out the following options [0][1].
> 
> [0] gives the following regex:
> 
>   https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)
> 
> It is kind of ugly to look at, and I'm not even sure if there are any 
> syntax differences with Tcl's regex library.
> 
> [1] lists a bunch of regexes and which URLs they work on and which ones 
> they don't. The smallest among them I found is:
> 
>   @^(https?|ftp)://[^\s/$.?#].[^\s]*$@iS
> 
> Again, I'm not sure how well this would work with Tcl's regex library, 
> or how commonly these URL patterns appear in actual commit messages.  
> Just something to consider.
> 
> [0] https://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url
> [1] https://mathiasbynens.be/demo/url-regex

I think I would be inclined to make the regex customizable, since that
would also allow the user to match ftp or other URLs if they want.
The only difficulty with that is if there are subexpressions, that
will change how we have to interpret the list returned by the
regexp -indices -all -inline command.

Paul.

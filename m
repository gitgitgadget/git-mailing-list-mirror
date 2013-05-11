From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH v3 5/5] do not die when error in config parsing of
 buf occurs
Date: Sat, 11 May 2013 11:59:36 +0200
Message-ID: <20130511095936.GB17326@sigill.intra.peff.net>
References: <20130509154020.GA26423@book-mint>
 <20130509162102.GG3526@book-mint>
 <20130509223936.GC30774@sigill.intra.peff.net>
 <20130511085531.GA3670@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat May 11 11:59:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6ai-0003cV-KN
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 11:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab3EKJ7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 05:59:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:56228 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754035Ab3EKJ7k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 05:59:40 -0400
Received: (qmail 21297 invoked by uid 102); 11 May 2013 10:00:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 05:00:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 11:59:36 +0200
Content-Disposition: inline
In-Reply-To: <20130511085531.GA3670@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223952>

On Sat, May 11, 2013 at 10:55:31AM +0200, Heiko Voigt wrote:

> > > diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
> > > index fdc257e..a4929eb 100755
> > > --- a/t/t1307-config-blob.sh
> > > +++ b/t/t1307-config-blob.sh
> > > @@ -55,12 +55,17 @@ test_expect_success 'editing a blob is an error' '
> > >  test_expect_success 'parse errors in blobs are properly attributed' '
> > >  	cat >config <<-\EOF &&
> > >  	[some]
> > > -		value = "
> > > +		value = 1
> > > +		error = "
> > >  	EOF
> > >  	git add config &&
> > >  	git commit -m broken &&
> > >  
> > > -	test_must_fail git config --blob=HEAD:config some.value 2>err &&
> > > +	test_must_fail git config --blob=HEAD:config some.value 1>out 2>err &&
> > > +
> > > +	# Make sure there is no output of values on stdout
> > > +	touch out.expect &&
> > > +	test_cmp out.expect out &&
> > 
> > I'm not clear on what is being tested here. Were we outputting to stdout
> > before this patch (I would have thought our die() meant we did not.
> 
> We where not outputting to stdout before so the test is correct there as
> well. I extended the test when implementing the non-dying version of
> git_config_with_options() so I could see the test fail. If just
> returning the error it would still output the values read until then. So
> if you think that it belongs into the initial version of this test
> (maybe including some comment why we need an extra parseable value) I
> am happy to move it there.

>From what you wrote above, it sounds like we would expect git-config to
write out some.value before failing on some.error. But that isn't what
the test is checking, is it? It is checking that nothing is output.

I do not think the output matters much either way when git-config has
failed; if it returns a non-zero exit code, then the results of stdout
cannot be trusted (after all, it may have been killed by signal after it
had written out half of the output).

Still slightly puzzled...

-Peff

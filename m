From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 5/5] do not die when error in config parsing of
 buf occurs
Date: Sat, 11 May 2013 10:55:31 +0200
Message-ID: <20130511085531.GA3670@book-mint>
References: <20130509154020.GA26423@book-mint>
 <20130509162102.GG3526@book-mint>
 <20130509223936.GC30774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 10:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub5bD-0005Ch-9U
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab3EKIz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:55:57 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:48949 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab3EKIz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:55:56 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ub5ao-0000e7-8U; Sat, 11 May 2013 10:55:50 +0200
Content-Disposition: inline
In-Reply-To: <20130509223936.GC30774@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223946>

On Fri, May 10, 2013 at 12:39:37AM +0200, Jeff King wrote:
> On Thu, May 09, 2013 at 06:21:02PM +0200, Heiko Voigt wrote:
> 
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 8d01b7a..de32977 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -219,9 +219,11 @@ static int get_value(const char *key_, const char *regex_)
> >  		}
> >  	}
> >  
> > -	git_config_with_options(collect_config, &values,
> > +	ret = git_config_with_options(collect_config, &values,
> >  				given_config_file, given_config_blob,
> >  				respect_includes);
> > +	if (ret < 0)
> > +		goto free_values;
> >  
> >  	ret = !values.nr;
> >  
> > @@ -231,6 +233,7 @@ static int get_value(const char *key_, const char *regex_)
> >  			fwrite(buf->buf, 1, buf->len, stdout);
> >  		strbuf_release(buf);
> >  	}
> > +free_values:
> >  	free(values.items);
> >  
> >  free_strings:
> 
> Hmm. "values" is a strbuf_list. Don't we need to strbuf_release() its
> individual members before freeing it? The writing loop directly above
> your label frees each one after writing. It would probably make sense to
> just split it into two loops, one for writing, and then one for
> free-ing. This is not a critical performance path that we can't iterate
> over the (probably handful of) entries twice.

Thanks for catching that. I missed the strbuf_release in the loop
somehow. Will fix in the next iteration.

> > diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
> > index fdc257e..a4929eb 100755
> > --- a/t/t1307-config-blob.sh
> > +++ b/t/t1307-config-blob.sh
> > @@ -55,12 +55,17 @@ test_expect_success 'editing a blob is an error' '
> >  test_expect_success 'parse errors in blobs are properly attributed' '
> >  	cat >config <<-\EOF &&
> >  	[some]
> > -		value = "
> > +		value = 1
> > +		error = "
> >  	EOF
> >  	git add config &&
> >  	git commit -m broken &&
> >  
> > -	test_must_fail git config --blob=HEAD:config some.value 2>err &&
> > +	test_must_fail git config --blob=HEAD:config some.value 1>out 2>err &&
> > +
> > +	# Make sure there is no output of values on stdout
> > +	touch out.expect &&
> > +	test_cmp out.expect out &&
> 
> I'm not clear on what is being tested here. Were we outputting to stdout
> before this patch (I would have thought our die() meant we did not.

We where not outputting to stdout before so the test is correct there as
well. I extended the test when implementing the non-dying version of
git_config_with_options() so I could see the test fail. If just
returning the error it would still output the values read until then. So
if you think that it belongs into the initial version of this test
(maybe including some comment why we need an extra parseable value) I
am happy to move it there.

Cheers Heiko

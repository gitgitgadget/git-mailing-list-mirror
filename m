From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 4/4] teach config parsing to read from strbuf
Date: Sun, 10 Mar 2013 17:39:34 +0100
Message-ID: <20130310163933.GA26857@sandbox-ub.fritz.box>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226194313.GE22756@sandbox-ub>
 <5138DFA3.8040308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>, Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Mar 10 17:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjI9-0000uO-8J
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 17:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab3CJQjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 12:39:43 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:57464 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab3CJQjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 12:39:42 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjHb-0003jk-8E; Sun, 10 Mar 2013 17:39:35 +0100
Content-Disposition: inline
In-Reply-To: <5138DFA3.8040308@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217810>

Hi,

On Thu, Mar 07, 2013 at 06:42:43PM +0000, Ramsay Jones wrote:
> Heiko Voigt wrote:
> > +int git_config_from_strbuf(config_fn_t fn, struct strbuf *strbuf, void *data)
> > +{
> > +	struct config top;
> > +	struct config_strbuf str;
> > +
> > +	str.strbuf = strbuf;
> > +	str.pos = 0;
> > +
> > +	top.data = &str;
> 
> You will definitely want to initialise 'top.name' here, rather
> than let it take whatever value happens to be at that position
> on the stack. In your editor, search for 'cf->name' and contemplate
> each such occurrence.

Good catch, thanks. The initialization seems to got lost during
refactoring. In the codepaths we call with the new strbuf function it is
only used for error reporting so I think we need to get the name from
the user of this function so the error messages are useful.

I have extended the test to demonstrate how I imagine this name could
look like.

> Does the 'include' facility work from a strbuf? Should it?

No the 'include' facility does not work here. A special handling would
need to be implemented by the caller. For us 'include' values have no
special meaning and are parsed like normal values.

AFAICS when a config file is given to git config we do not currently
respect includes. So we can just do the same behavior here for the
moment. There is no roadblock against adding it later.

> Are you happy with the error handling/reporting?

Good point, while adding the name for strbuf I noticed that we currently
die on some parsing errors. We should probably make these errors
handleable for strbufs. Currently the main usecase is to read submodule
configurations from the database and in case someone commits a broken
configuration we should be able to continue with that. Otherwise the
repository might render into an unuseable state. I will look into that.

> Do the above additions to the test-suite give you confidence
> that the code works as you intend?

Well, I am reusing most of the existing infrastructure which I assume is
tested using config files. So what I want to test here is the
integration of this new function. As you mentioned the name variable I
have now added a test for the parsing error case as well. I have
refactored the test binary to read configs from stdin so its easiert to
implement further tests from the bash part of the testsuite.

I will send out another iteration shortly.

Cheers Heiko

From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] catch asciidoc failures
Date: Fri, 1 Jun 2007 10:55:03 +0200
Message-ID: <2c6b72b30706010155k4a3745b0i3ac2d22fa5a4f534@mail.gmail.com>
References: <11806790373908-git-send-email-slamb@slamb.org>
	 <20070601083621.GB3521@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Scott Lamb" <slamb@slamb.org>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org
To: "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu2uf-0003mz-By
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 10:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbXFAIzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 04:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbXFAIzG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 04:55:06 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:51583 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbXFAIzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 04:55:04 -0400
Received: by nz-out-0506.google.com with SMTP id n1so451262nzf
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 01:55:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CPEJAogS1GhB9sFnjdM1IhJQL+6jdEeSC+3JkkYk6kJdft4oVNb+6xJk/97LdxyfwNpwaVSHyV9w4ThhBwC0G2MRDkyONjHJ2FqjKi7hC9KXvNZkZeiFgPykVjIFm2PcgzhUtK9wzUj4iIRinl8YLOOH8qaEarCpmliol3+8yuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ec/v0l9jRRsKXTjzuEBvKKuB+VgBu2MJE1JediIEtrRuYTPezt9/Zdv/deS3G/k9ijex2RwvpmPxupVAJ/xoRCQl6fJ5hj2YxeX1880Eu80nCRu2vhh7eRslfU7/Yub/J9fTxVmVhzWcSkyQ3h9VJkF4xQ+6EA5nEqmFOhBnH/Y=
Received: by 10.115.90.1 with SMTP id s1mr1597215wal.1180688103176;
        Fri, 01 Jun 2007 01:55:03 -0700 (PDT)
Received: by 10.114.26.20 with HTTP; Fri, 1 Jun 2007 01:55:03 -0700 (PDT)
In-Reply-To: <20070601083621.GB3521@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48854>

On 6/1/07, Martin Waitz <tali@admingilde.org> wrote:
> On Thu, May 31, 2007 at 11:23:57PM -0700, Scott Lamb wrote:
> > If pipefail is available (GNU bash >= 3.00), fail when asciidoc returns
> > error rather than possibly later during XSLT.
>
> perhaps we should simply change the pipe ordering to get asciidoc
> to the end of the pipeline so that all shells respect its exit code?

For tig I also adopted the nice man page headers git has. However, I have
used  asciidoc attributes provided on the command line avoid having to
use sed. I can make a patch later if nobody beats me. The required changes
are outlined below.

> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -111,6 +111,7 @@ clean:
> >
> >  %.html : %.txt
> >       rm -f $@+ $@
> > +     set -o pipefail 2>/dev/null; \
> >       $(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
> >               $(ASCIIDOC_EXTRA) -o - $< | \
> >               sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
>
> something like (untested):
>         sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $< |
>                 $(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
>                         $(ASCIIDOC_EXTRA) -o $@+ -

More untested stuff. Use -a to define git_version attribute:

$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
                         $(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@ $<

Then change the @@GIT_VERSION@@ symbol in asciidoc.conf to {git_version}.

-- 
Jonas Fonseca

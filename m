From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 3/4] use new config API for worktree
 configurations of submodules
Date: Wed, 9 Jul 2014 21:55:47 +0200
Message-ID: <20140709195547.GA3081@sandbox-ub>
References: <20140628095800.GA89729@book.hvoigt.net>
 <20140628100321.GD89729@book.hvoigt.net>
 <xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 21:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4xyG-000051-C6
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 21:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbaGITz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 15:55:59 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:53490 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbaGITz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 15:55:58 -0400
Received: from [37.4.179.65] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1X4xy5-0003Ta-CC; Wed, 09 Jul 2014 21:55:53 +0200
Content-Disposition: inline
In-Reply-To: <xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253144>

On Tue, Jul 08, 2014 at 01:14:20PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 07cf555..03ea20d 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -18,6 +18,7 @@
> >  #include "xdiff-interface.h"
> >  #include "ll-merge.h"
> >  #include "resolve-undo.h"
> > +#include "submodule-config.h"
> >  #include "submodule.h"
> >  #include "argv-array.h"
> >  
> 
> Hmph.  What is this change about?  
> 
> Nobody in checkout.c needs anything new, yet we add a new include?

This is because I moved the parse_submodule_config_option() function
into the submodule-config.c module. This was necessary so all parsed
submodule values are stored in the cache with the null_sha1. We use
static functions from this module to do this and thats thats the reason
for the move. 

> > diff --git a/diff.c b/diff.c
> > index f72769a..f692a3c 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -13,6 +13,7 @@
> >  #include "utf8.h"
> >  #include "userdiff.h"
> >  #include "sigchain.h"
> > +#include "submodule-config.h"
> >  #include "submodule.h"
> >  #include "ll-merge.h"
> >  #include "string-list.h"
> 
> Likewise.

Same as above.

> > It is somewhat unclear to me what real change that improves the life
> of end-users this series brings to us.   The "test-submodule-config"
> test program obviously is new but that does not really count until
> we see real uses.

Do you mean the API improvements? I split this series off from my
recursive fetch series since this infrastructure is also needed by Jens
recursive checkout series.

I am currently working on finishing the recursive fetch series here[1].
So until now we do not have any improvements for the end-user but only
in the API for the developer. With my series it is possible to easily
lookup what configuration for which submodule is in which revision. That
makes is possible to also implement the recursive fetch logic for
renamed submodules[2]. We are also able to decide whether (and from
where) a new submodules repository can possibly be cloned during
recursive fetch.

A clone on recursive fetch for new submodule makes sure we have
everything available, so a recursive checkout later can work without the
need for an extra fetch.

Does that make the improvements in my series clear for you? I would wait
until my recursive fetch series is ready so we have real uses. Since
there are others (namely Jens or submodule support for 'git archive')
that need it I think it makes sense to review and merge this separately
into master so they have a stable API to code against.

Cheers Heiko

[1] https://github.com/hvoigt/git/commits/hv/fetch-submodules-recursive
[2] https://github.com/hvoigt/git/commit/975c370856c3b8f96ab0c5a3ed754e3839f4de45
